;;; dpurge-markdown.el --- Markdown extension editing -*- lexical-binding: t; -*-

(require 'subr-x)
(require 'dpurge-ime-config)
(require 'dpurge-schema-config)

(defconst dpurge-markdown-directory
  (file-name-directory (or load-file-name buffer-file-name default-directory))
  "Directory containing `dpurge-markdown.el'.")

(defvar-local dpurge-markdown-block-type nil
  "Type of the special Markdown block at point.")
(defvar-local dpurge-markdown-block-lang nil
  "Language of the current Markdown block.")
(defvar-local dpurge-markdown-block-script nil
  "Script of the current Markdown block.")
(defvar-local dpurge-markdown-block-as nil
  "Value of the `as' attribute of the current Markdown block.")
(defvar-local dpurge-markdown-current-field-state nil
  "Current structured field at point.")
(defvar-local dpurge-markdown-current-input-method nil
  "Configured input method name for the current field.")
(defvar-local dpurge-markdown-current-font nil
  "Configured font descriptor for the current field.")
(defvar-local dpurge-markdown-current-setup-function nil
  "Configured setup function for the current field.")
(defvar-local dpurge-questions-current-field nil
  "Current questions field at point.")

(defvar dpurge-markdown-edit-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "TAB") #'dpurge-markdown-tab)
    (define-key map (kbd "M-RET") #'dpurge-markdown-meta-ret)
    map)
  "Keymap for `dpurge-markdown-edit-mode'.")

(define-minor-mode dpurge-markdown-edit-mode
  "Minor mode active while editing a Markdown extension block."
  :lighter " Vocab"
  :keymap dpurge-markdown-edit-mode-map)

(defun dpurge-markdown-current-block ()
  "Return information about the special block containing point.

Returns a plist, or nil when point is outside a block."
  (save-excursion
    (let ((pos (point)) start type attributes)
      (goto-char pos)
      (when (re-search-backward
             "^{start-\\([[:alnum:]_-]+\\)\\(.*\\)}$"
             nil t)
        (setq start (point)
              type (match-string-no-properties 1)
              attributes (match-string-no-properties 2))
        (goto-char pos)
        (unless (re-search-backward
                 (format "^{end-%s}$" (regexp-quote type))
                 start t)
          (list
           :type (intern type)
           :lang (when (string-match "\\blang=\\([^[:space:]}]+\\)" attributes)
                   (match-string 1 attributes))
           :script (when (string-match "\\bscript=\\([^[:space:]}]+\\)" attributes)
                     (match-string 1 attributes))
           :as (when (string-match "\\bas=\\([^[:space:]}]+\\)" attributes)
                 (match-string 1 attributes))))))))

(defun dpurge-markdown-supported-mode-p ()
  "Return non-nil when current buffer is a supported Markdown mode."
  (or (derived-mode-p 'markdown-mode)
      (derived-mode-p 'markdown-ts-mode)))

(defun dpurge-markdown-language-settings (lang script)
  "Return config for LANG and SCRIPT."
  (cdr (assoc (list lang script) dpurge-vocabulary-language-config)))

(defconst dpurge-markdown-script-font-overrides
  '(("hans" :height 192)
    ("hant" :height 192)
    ("jpan" :height 192)
    ("kore" :height 192)
    ("arab" :height 192)
    ("hebr" :height 192)
    ("thai" :height 192)
    ("deva" :height 192))
  "Per-script font overrides for larger non-Latin source text.")

(defconst dpurge-markdown-large-char-scripts
  '(han kana hangul arabic hebrew thai devanagari)
  "Unicode script classes displayed with a larger face in Markdown buffers.")

(defface dpurge-markdown-large-script-face
  '((t :height 1.2))
  "Face used to enlarge selected non-Latin scripts in Markdown buffers.")

(defun dpurge-markdown-script-font (script)
  "Return the configured font override plist for SCRIPT."
  (cdr (assoc script dpurge-markdown-script-font-overrides)))

(defun dpurge-markdown-large-script-char-p (char)
  "Return non-nil when CHAR should use the larger script face."
  (memq (aref char-script-table char) dpurge-markdown-large-char-scripts))

(defun dpurge-markdown-clear-script-font-overlays (beg end)
  "Remove DPurge script font overlays between BEG and END."
  (remove-overlays beg end 'dpurge-script-font-overlay t))

(defun dpurge-markdown-apply-script-font-overlays (beg end)
  "Apply larger font overlays for selected scripts between BEG and END."
  (save-excursion
    (goto-char beg)
    (dpurge-markdown-clear-script-font-overlays beg end)
    (while (< (point) end)
      (let ((char (char-after)))
        (if (and char (dpurge-markdown-large-script-char-p char))
            (let ((start (point)))
              (while (and (< (point) end)
                          (setq char (char-after))
                          (dpurge-markdown-large-script-char-p char))
                (forward-char 1))
              (let ((overlay (make-overlay start (point) nil t nil)))
                (overlay-put overlay 'dpurge-script-font-overlay t)
                (overlay-put overlay 'evaporate t)
                (overlay-put overlay 'face 'dpurge-markdown-large-script-face)))
          (forward-char 1))))))

(defun dpurge-markdown-fontify-scripts (beg end)
  "JIT fontify larger script overlays between BEG and END."
  (when (dpurge-markdown-supported-mode-p)
    (dpurge-markdown-apply-script-font-overlays beg end)))

(defun dpurge-markdown-field-settings (lang script field)
  "Return field settings for FIELD under LANG and SCRIPT."
  (let* ((config (dpurge-markdown-language-settings lang script))
         (fields (plist-get config :fields)))
    (cdr (assoc field fields))))

(defun dpurge-markdown-effective-field (field)
  "Map FIELD to config field used for IME setup."
  (pcase field
    ((or 'answer 'question) 'phrase)
    ((or 'answer-transcription 'question-transcription) 'transcription)
    (_ field)))

(defun dpurge-vocabulary-load-input-method (file)
  "Load input method implementation FILE from the local ime directory."
  (when file
    (load (expand-file-name (concat "ime/" file ".el") dpurge-markdown-directory)
          nil t)))

(defun dpurge-vocabulary-setup-cmn-phrase ()
  "Configure shuangpin support for Mandarin phrase editing."
  (when (featurep 'pyim)
    (when (fboundp 'pyim-basedict-enable)
      (pyim-basedict-enable))
    (when (boundp 'pyim-default-scheme)
      (setq-local pyim-default-scheme 'microsoft-shuangpin))))

(defalias 'dpurge-vocabulary-setup-cmn-hans-phrase
  #'dpurge-vocabulary-setup-cmn-phrase)

(defun dpurge-vocabulary-activate-input-method (input-method)
  "Activate INPUT-METHOD if available, ignoring unsupported methods."
  (condition-case nil
      (set-input-method input-method)
    (error nil)))

(defun dpurge-vocabulary-apply-field-settings (field)
  "Apply configured editing settings for FIELD."
  (let* ((lang dpurge-markdown-block-lang)
         (script dpurge-markdown-block-script)
         (effective-field (dpurge-markdown-effective-field field))
         (config (dpurge-markdown-language-settings lang script))
         (field-config (dpurge-markdown-field-settings
                        lang script effective-field))
         (field-directions (plist-get (dpurge-markdown-block-schema
                                       dpurge-markdown-block-type)
                                      :field-directions))
         (override-dir (alist-get effective-field field-directions))
         (direction (or override-dir (plist-get config :direction)))
         (input-method (plist-get field-config :input-method))
         (input-method-file (plist-get field-config :input-method-file))
         (font (or (plist-get field-config :font)
                   (and (eq effective-field 'phrase)
                        (dpurge-markdown-script-font script))))
         (setup-function (plist-get field-config :setup-function)))
    (when direction
      (setq-local bidi-paragraph-direction direction))
    (when input-method-file
      (dpurge-vocabulary-load-input-method input-method-file))
    (when (functionp setup-function)
      (funcall setup-function))
    (setq-local dpurge-markdown-current-input-method input-method)
    (setq-local dpurge-markdown-current-font font)
    (setq-local dpurge-markdown-current-setup-function setup-function)
    (if input-method
        (dpurge-vocabulary-activate-input-method input-method)
      (cond
       ((fboundp 'deactivate-input-method) (deactivate-input-method))
       ((fboundp 'inactivate-input-method) (inactivate-input-method))
       (t (setq current-input-method nil))))))

(defun dpurge-vocabulary-setup-field-editing (field)
  "Apply editing setup for FIELD."
  (setq-local dpurge-markdown-current-field-state field)
  (setq-local dpurge-questions-current-field field)
  (when (and (memq dpurge-markdown-block-type '(vocabulary models questions text dialog parallel parallel-dialog))
             field
             (not (eq field 'done)))
    (dpurge-vocabulary-apply-field-settings field)))

(defun dpurge-markdown-text-field-for-as (as)
  "Return the logical field for text block variant AS."
  (cond
   ((equal as "source") 'phrase)
   ((equal as "transcription") 'transcription)
   ((equal as "translation") 'translation)
   ((equal as "grammar") 'grammar)
   (t nil)))


(defun dpurge-parallel-current-field ()
  "Return the current field within a parallel/parallel-dialog block by
scanning backward.

Counts lone `---' separator lines above point's line since the
nearest record start (`===' line or `{start-parallel...}' opener --
the `[^}]*' wildcard also matches `{start-parallel-dialog...}', so
this covers both block types with no separate regex).  Returns
`phrase', `translation', or `transcription'."
  (save-excursion
    (let* ((line-start (line-beginning-position))
           (boundary
            (progn
              (goto-char line-start)
              (if (re-search-backward
                   "^===$\\|^{start-parallel[^}]*}$"
                   nil t)
                  (line-beginning-position 2)
                (point-min))))
           (count 0))
      (save-excursion
        (goto-char boundary)
        (while (< (point) line-start)
          (when (looking-at "^---$")
            (setq count (1+ count)))
          (forward-line 1)))
      (pcase (min count 2)
        (0 'phrase)
        (1 'translation)
        (_ 'transcription)))))

(defun dpurge-markdown-current-field ()
  "Return the current editable field based on block type and point."
  (cond
   ((eq dpurge-markdown-block-type 'vocabulary)
    (dpurge-vocabulary-point-field (dpurge-vocabulary-line-info)))
   ((eq dpurge-markdown-block-type 'models)
    (dpurge-model-point-field (dpurge-model-line-info)))
   ((eq dpurge-markdown-block-type 'questions)
    (dpurge-questions-point-field (dpurge-questions-line-info)))
   ((memq dpurge-markdown-block-type '(text dialog))
    (dpurge-markdown-text-field-for-as dpurge-markdown-block-as))
   ((memq dpurge-markdown-block-type '(parallel parallel-dialog))
    (dpurge-parallel-current-field))
   (t nil)))

(defun dpurge-markdown-clear-structured-state ()
  "Clear block and field editing state for the current buffer."
  (setq-local dpurge-markdown-block-type nil)
  (setq-local dpurge-markdown-block-lang nil)
  (setq-local dpurge-markdown-block-script nil)
  (setq-local dpurge-markdown-block-as nil)
  (setq-local dpurge-markdown-current-field-state nil)
  (setq-local dpurge-markdown-current-input-method nil)
  (setq-local dpurge-markdown-current-font nil)
  (setq-local dpurge-markdown-current-setup-function nil)
  (setq-local dpurge-questions-current-field nil))


(defun dpurge-markdown-structured-block-p (type)
  "Return non-nil when TYPE supports structured field navigation."
  (memq type '(vocabulary models questions parallel parallel-dialog)))


(defun dpurge-markdown-apply-current-block (block)
  "Apply BLOCK metadata and field setup to the current buffer."
  (let ((type (plist-get block :type))
        (lang (plist-get block :lang))
        (script (plist-get block :script))
        (as (plist-get block :as)))
    (setq-local dpurge-markdown-block-type type)
    (setq-local dpurge-markdown-block-lang lang)
    (setq-local dpurge-markdown-block-script script)
    (setq-local dpurge-markdown-block-as as)
    (if (dpurge-markdown-structured-block-p type)
        (unless dpurge-markdown-edit-mode
          (dpurge-markdown-edit-mode 1))
      (when dpurge-markdown-edit-mode
        (dpurge-markdown-edit-mode -1)))
    (let ((field (dpurge-markdown-current-field)))
      (unless (eq field dpurge-markdown-current-field-state)
        (dpurge-vocabulary-setup-field-editing field)))))


(defun dpurge-markdown-update-block-mode ()
  "Update the Markdown block editing mode according to point position."
  (when (dpurge-markdown-supported-mode-p)
    (let ((block (dpurge-markdown-current-block)))
      (if block
          (dpurge-markdown-apply-current-block block)
        (when dpurge-markdown-edit-mode
          (dpurge-markdown-edit-mode -1))
        (dpurge-markdown-clear-structured-state)))))

(defun dpurge-markdown-blocks-setup ()
  "Enable special Markdown block detection."
  (add-hook 'post-command-hook #'dpurge-markdown-update-block-mode nil t)
  (jit-lock-register #'dpurge-markdown-fontify-scripts t)
  (dpurge-markdown-fontify-scripts (point-min) (point-max))
  (dpurge-markdown-update-block-mode))

(add-hook 'markdown-mode-hook #'dpurge-markdown-blocks-setup)
(add-hook 'markdown-ts-mode-hook #'dpurge-markdown-blocks-setup)

(defun dpurge-vocabulary-region-empty-p (start end)
  "Return non-nil when buffer text between START and END is only whitespace."
  (string-empty-p (string-trim (buffer-substring-no-properties start end))))

(defun dpurge-vocabulary-line-info ()
  "Return parsed field positions for the current vocabulary line."
  (save-excursion
    (let* ((line-start (line-beginning-position))
           (line-end (line-end-position))
           (content-end (save-excursion
                          (goto-char line-end)
                          (skip-chars-backward " \t" line-start)
                          (point)))
           (pos line-start)
           phrase grammar transcription translation notes)
      (goto-char line-start)
      (skip-chars-forward " \t" content-end)
      (setq pos (point))
      (let ((phrase-end pos))
        (while (and (< phrase-end content-end)
                    (not (memq (char-after phrase-end) '(123 91 61 40))))
          (setq phrase-end (1+ phrase-end)))
        (when (> phrase-end pos)
          (setq phrase (cons pos phrase-end)))
        (setq pos phrase-end))
      (goto-char pos)
      (skip-chars-forward " \t" content-end)
      (setq pos (point))
      (when (eq (char-after pos) 123)
        (let ((close (save-excursion
                       (goto-char (1+ pos))
                       (search-forward "}" line-end t))))
          (when close
            (setq grammar (cons (1+ pos) (1- close)))
            (setq pos close))))
      (goto-char pos)
      (skip-chars-forward " \t" content-end)
      (setq pos (point))
      (when (eq (char-after pos) 91)
        (let ((close (save-excursion
                       (goto-char (1+ pos))
                       (search-forward "]" line-end t))))
          (when close
            (setq transcription (cons (1+ pos) (1- close)))
            (setq pos close))))
      (goto-char pos)
      (skip-chars-forward " \t" content-end)
      (setq pos (point))
      (when (eq (char-after pos) 61)
        (let* ((translation-start (progn
                                    (goto-char (1+ pos))
                                    (skip-chars-forward " \t" content-end)
                                    (point)))
               (notes-open (save-excursion
                             (goto-char translation-start)
                             (when (search-forward "(" line-end t)
                               (1- (point)))))
               (notes-close (and notes-open
                                 (save-excursion
                                   (goto-char (1+ notes-open))
                                   (search-forward ")" line-end t)))))
          (setq translation (cons translation-start
                                  (or (and notes-open (1- notes-open)) content-end)))
          (when notes-close
            (setq notes (cons notes-open notes-close)))))
      (list :line-start line-start :line-end line-end :content-end content-end
            'phrase phrase 'grammar grammar 'transcription transcription
            'translation translation 'notes notes))))

(defun dpurge-vocabulary-point-field (info)
  "Return the vocabulary field at point using INFO."
  (let ((pt (point))
        (phrase (plist-get info 'phrase))
        (grammar (plist-get info 'grammar))
        (transcription (plist-get info 'transcription))
        (translation (plist-get info 'translation))
        (notes (plist-get info 'notes))
        (content-end (plist-get info :content-end)))
    (cond
     ((<= content-end (line-beginning-position)) 'phrase)
     ((and notes (<= (car notes) pt) (<= pt (cdr notes))) 'notes)
     ((and translation (<= (car translation) pt)
           (<= pt (if notes (car notes) (line-end-position)))) 'translation)
     ((and grammar (<= (1- (car grammar)) pt) (<= pt (1+ (cdr grammar)))) 'grammar)
     ((and transcription (<= (1- (car transcription)) pt)
           (<= pt (1+ (cdr transcription)))) 'transcription)
     ((and phrase (<= (car phrase) pt) (<= pt (cdr phrase))) 'phrase)
     ((and grammar (< pt (1- (car grammar)))) 'phrase)
     ((and transcription (< pt (1- (car transcription)))) 'grammar)
     ((and translation (< pt (car translation))) 'transcription)
     ((and notes (< pt (car notes))) 'translation)
     (t 'phrase))))

(defun dpurge-questions-line-info ()
  "Return parsed field positions for the current questions line."
  (save-excursion
    (let* ((line-start (line-beginning-position))
           (line-end (line-end-position))
           (content-end (save-excursion
                          (goto-char line-end)
                          (skip-chars-backward " \t" line-start)
                          (point)))
           (pos line-start)
           question question-transcription answer answer-transcription)
      (goto-char line-start)
      (skip-chars-forward " \t" content-end)
      (setq pos (point))
      (let ((question-end pos))
        (while (and (< question-end content-end)
                    (not (memq (char-after question-end) '(91 61))))
          (setq question-end (1+ question-end)))
        (when (> question-end pos)
          (setq question (cons pos question-end)))
        (setq pos question-end))
      (goto-char pos)
      (skip-chars-forward " \t" content-end)
      (setq pos (point))
      (when (eq (char-after pos) 91)
        (let ((close (save-excursion
                       (goto-char (1+ pos))
                       (search-forward "]" line-end t))))
          (when close
            (setq question-transcription (cons (1+ pos) (1- close)))
            (setq pos close))))
      (goto-char pos)
      (skip-chars-forward " \t" content-end)
      (setq pos (point))
      (when (eq (char-after pos) 61)
        (let ((answer-start (progn
                              (goto-char (1+ pos))
                              (skip-chars-forward " \t" content-end)
                              (point))))
          (setq pos answer-start)
          (let ((answer-end pos))
            (while (and (< answer-end content-end)
                        (not (eq (char-after answer-end) 91)))
              (setq answer-end (1+ answer-end)))
            (setq answer (cons pos answer-end))
            (setq pos answer-end))))
      (goto-char pos)
      (skip-chars-forward " \t" content-end)
      (setq pos (point))
      (when (eq (char-after pos) 91)
        (let ((close (save-excursion
                       (goto-char (1+ pos))
                       (search-forward "]" line-end t))))
          (when close
            (setq answer-transcription (cons (1+ pos) (1- close))))))
      (list :line-start line-start :line-end line-end :content-end content-end
            'question question 'question-transcription question-transcription
            'answer answer 'answer-transcription answer-transcription))))

(defun dpurge-questions-point-field (info)
  "Return the questions field at point using INFO."
  (let ((pt (point))
        (question (plist-get info 'question))
        (question-transcription (plist-get info 'question-transcription))
        (answer (plist-get info 'answer))
        (answer-transcription (plist-get info 'answer-transcription))
        (content-end (plist-get info :content-end)))
    (cond
     ((<= content-end (line-beginning-position)) 'question)
     ((and answer-transcription (<= (1- (car answer-transcription)) pt)
           (<= pt (1+ (cdr answer-transcription)))) 'answer-transcription)
     ((and answer (<= (car answer) pt)
           (<= pt (if answer-transcription (1- (car answer-transcription)) (line-end-position)))) 'answer)
     ((and question-transcription (<= (1- (car question-transcription)) pt)
           (<= pt (1+ (cdr question-transcription)))) 'question-transcription)
     ((and question (<= (car question) pt) (<= pt (cdr question))) 'question)
     ((and question-transcription (< pt (1- (car question-transcription)))) 'question)
     ((and answer (< pt (car answer))) 'question-transcription)
     ((and answer-transcription (< pt (1- (car answer-transcription)))) 'answer)
     (t 'question))))

(defun dpurge-model-line-info ()
  "Return parsed field positions for the current models line."
  (save-excursion
    (let* ((line-start (line-beginning-position))
           (line-end (line-end-position))
           (content-end (save-excursion
                          (goto-char line-end)
                          (skip-chars-backward " \t" line-start)
                          (point)))
           (pos line-start)
           phrase transcription translation notes)
      (goto-char line-start)
      (skip-chars-forward " \t" content-end)
      (setq pos (point))
      (let ((phrase-end pos))
        (while (and (< phrase-end content-end)
                    (not (memq (char-after phrase-end) '(91 61 40))))
          (setq phrase-end (1+ phrase-end)))
        (when (> phrase-end pos)
          (setq phrase (cons pos phrase-end)))
        (setq pos phrase-end))
      (goto-char pos)
      (skip-chars-forward " \t" content-end)
      (setq pos (point))
      (when (eq (char-after pos) 91)
        (let ((close (save-excursion
                       (goto-char (1+ pos))
                       (search-forward "]" line-end t))))
          (when close
            (setq transcription (cons (1+ pos) (1- close)))
            (setq pos close))))
      (goto-char pos)
      (skip-chars-forward " \t" content-end)
      (setq pos (point))
      (when (eq (char-after pos) 61)
        (let* ((translation-start (progn
                                    (goto-char (1+ pos))
                                    (skip-chars-forward " \t" content-end)
                                    (point)))
               (notes-open (save-excursion
                             (goto-char translation-start)
                             (when (search-forward "(" line-end t)
                               (1- (point)))))
               (notes-close (and notes-open
                                 (save-excursion
                                   (goto-char (1+ notes-open))
                                   (search-forward ")" line-end t)))))
          (setq translation (cons translation-start
                                  (or (and notes-open (1- notes-open)) content-end)))
          (when notes-close
            (setq notes (cons notes-open notes-close)))))
      (list :line-start line-start :line-end line-end :content-end content-end
            'phrase phrase 'transcription transcription
            'translation translation 'notes notes))))

(defun dpurge-model-point-field (info)
  "Return the models field at point using INFO."
  (let ((pt (point))
        (phrase (plist-get info 'phrase))
        (transcription (plist-get info 'transcription))
        (translation (plist-get info 'translation))
        (notes (plist-get info 'notes))
        (content-end (plist-get info :content-end)))
    (cond
     ((<= content-end (line-beginning-position)) 'phrase)
     ((and notes (<= (car notes) pt) (<= pt (cdr notes))) 'notes)
     ((and translation (<= (car translation) pt)
           (<= pt (if notes (car notes) (line-end-position)))) 'translation)
     ((and transcription (<= (1- (car transcription)) pt)
           (<= pt (1+ (cdr transcription)))) 'transcription)
     ((and phrase (<= (car phrase) pt) (<= pt (cdr phrase))) 'phrase)
     ((and transcription (< pt (1- (car transcription)))) 'phrase)
     ((and translation (< pt (car translation))) 'transcription)
     ((and notes (< pt (car notes))) 'translation)
     (t 'phrase))))

(defun dpurge-markdown-block-schema (type)
  "Return structured editing schema for block TYPE."
  (alist-get type dpurge-markdown-block-schemas))

(defun dpurge-markdown-next-field-name (type field)
  "Return next field after FIELD for block TYPE."
  (alist-get field (plist-get (dpurge-markdown-block-schema type) :transitions)))

(defun dpurge-markdown-field-template (type field)
  "Return insertion template metadata for FIELD in block TYPE."
  (alist-get field (plist-get (dpurge-markdown-block-schema type) :insert-templates)))

(defun dpurge-markdown-move-to-existing-field (info field)
  "Move point into existing FIELD using INFO and set editing context."
  (let ((region (plist-get info field)))
    (goto-char
     (pcase field
       ('phrase (if region (car region) (plist-get info :line-start)))
       ('notes (1+ (car region)))
       (_ (car region)))))
  (dpurge-vocabulary-setup-field-editing field))

(defun dpurge-markdown-insert-missing-field (type info field)
  "Insert missing FIELD for block TYPE using INFO and enter it."
  (delete-region (plist-get info :content-end) (plist-get info :line-end))
  (goto-char (plist-get info :content-end))
  (pcase-let* ((`(,with-prefix ,without-prefix ,with-offset ,without-offset)
                (dpurge-markdown-field-template type field))
               (text (if (or (plist-get info 'phrase)
                             (plist-get info 'question))
                         with-prefix
                       without-prefix))
               (offset (if (string-prefix-p " " text)
                           (or with-offset (length text))
                         (or without-offset (length text)))))
    (dpurge-vocabulary-insert-and-enter text offset field)))

(defun dpurge-vocabulary-field-empty-p (field info)
  "Return non-nil when FIELD in INFO is present and empty."
  (pcase field
    ('grammar
     (let ((region (plist-get info 'grammar)))
       (and region (dpurge-vocabulary-region-empty-p (car region) (cdr region)))))
    ((or 'transcription 'question-transcription 'answer-transcription)
     (let ((region (plist-get info field)))
       (and region (dpurge-vocabulary-region-empty-p (car region) (cdr region)))))
    ('notes
     (let ((region (plist-get info 'notes)))
       (and region (dpurge-vocabulary-region-empty-p (1+ (car region)) (1- (cdr region))))))
    (_ nil)))

(defun dpurge-vocabulary-delete-empty-field (field info)
  "Delete FIELD from current line when it is empty according to INFO."
  (pcase field
    ('grammar
     (let ((region (plist-get info 'grammar)))
       (when region
         (save-excursion
           (goto-char (1- (car region)))
           (skip-chars-backward " \t" (plist-get info :line-start))
           (delete-region (point) (1+ (cdr region)))))))
    ('transcription
     (let ((region (plist-get info 'transcription)))
       (when region
         (save-excursion
           (goto-char (1- (car region)))
           (skip-chars-backward " \t" (plist-get info :line-start))
           (delete-region (point) (1+ (cdr region)))))))
    ('question-transcription
     (let ((region (plist-get info 'question-transcription)))
       (when region
         (save-excursion
           (goto-char (1- (car region)))
           (skip-chars-backward " \t" (plist-get info :line-start))
           (delete-region (point) (1+ (cdr region)))))))
    ('answer-transcription
     (let ((region (plist-get info 'answer-transcription)))
       (when region
         (save-excursion
           (goto-char (1- (car region)))
           (skip-chars-backward " \t" (plist-get info :line-start))
           (delete-region (point) (1+ (cdr region)))))))
    ('notes
     (let ((region (plist-get info 'notes)))
       (when region
         (save-excursion
           (goto-char (car region))
           (skip-chars-backward " \t" (plist-get info :line-start))
           (delete-region (point) (cdr region))))))))

(defun dpurge-vocabulary-insert-and-enter (text offset field)
  "Insert TEXT, move to OFFSET within it, and set FIELD editing context."
  (let ((start (point)))
    (insert text)
    (goto-char (+ start offset))
    (dpurge-vocabulary-setup-field-editing field)))

(defun dpurge-vocabulary-insert-missing-field (field info)
  "Insert missing FIELD using INFO and enter it."
  (delete-region (plist-get info :content-end) (plist-get info :line-end))
  (goto-char (plist-get info :content-end))
  (pcase field
    ('grammar
     (let ((text (if (plist-get info 'phrase) " {}" "{}")))
       (dpurge-vocabulary-insert-and-enter text (if (string-prefix-p " " text) 2 1) 'grammar)))
    ('transcription
     (let ((text (if (or (plist-get info 'phrase) (plist-get info 'grammar)) " []" "[]")))
       (dpurge-vocabulary-insert-and-enter text (if (string-prefix-p " " text) 2 1) 'transcription)))
    ('translation
     (let ((text (if (or (plist-get info 'phrase) (plist-get info 'grammar) (plist-get info 'transcription)) " = " "= ")))
       (dpurge-vocabulary-insert-and-enter text (length text) 'translation)))
    ('notes
     (let ((text (if (> (plist-get info :content-end) (plist-get info :line-start)) " ()" "()")))
       (dpurge-vocabulary-insert-and-enter text (if (string-prefix-p " " text) 2 1) 'notes)))))

(defun dpurge-vocabulary-move-to-existing (field info)
  "Move point into existing FIELD using INFO and set editing context."
  (pcase field
    ('phrase (let ((region (plist-get info 'phrase)))
               (goto-char (if region (car region) (plist-get info :line-start)))))
    ('grammar (goto-char (car (plist-get info 'grammar))))
    ('transcription (goto-char (car (plist-get info 'transcription))))
    ('translation (goto-char (car (plist-get info 'translation))))
    ('notes (goto-char (1+ (car (plist-get info 'notes))))))
  (dpurge-vocabulary-setup-field-editing field))

(defun dpurge-parallel-new-record ()
  "Finish the current parallel record and start a new one.

Inserts a lone `===' separator at the end of the current field
(regardless of where point sits within the field) and enters the
new source field (`phrase').  Guards on block type so it is safe
to call from the M-RET dispatcher.  Shared by `parallel' and
`parallel-dialog', which use the identical row/field grammar."
  (unless (memq dpurge-markdown-block-type '(parallel parallel-dialog))
    (user-error "Not inside a parallel block"))
  (let* ((fstart (dpurge-parallel-field-start))
         (fend (dpurge-parallel-field-end fstart)))
    (goto-char fend)
    (insert "\n\n===\n\n")
    (dpurge-vocabulary-setup-field-editing 'phrase)))

(defun dpurge-markdown-meta-ret ()
  "M-RET dispatcher: new record in parallel blocks, fallthrough elsewhere."
  (interactive)
  (if (memq dpurge-markdown-block-type '(parallel parallel-dialog))
      (dpurge-parallel-new-record)
    (let ((dpurge-markdown-edit-mode nil))
      (call-interactively (key-binding (kbd "M-RET"))))))

(defun dpurge-parallel-field-end (field-start)
  "Return the position at the end of the parallel field that begins at FIELD-START.

Scans forward from FIELD-START to just before the next lone `---',
`===' separator, or `{end-parallel}'/`{end-parallel-dialog}' line.  The
returned position is the end of the last content line of the current
field, regardless of where point currently sits within the field."
  (save-excursion
    (goto-char field-start)
    (let ((result field-start))
      (while (and (not (eobp))
                  (not (looking-at "^---$"))
                  (not (looking-at "^===$"))
                  (not (looking-at "^{end-parallel}$\\|^{end-parallel-dialog}$")))
        (setq result (line-end-position))
        (forward-line 1))
      result)))

(defun dpurge-parallel-field-start ()
  "Return the start of the current parallel field.

Scans backward to the nearest record start or block opener, then
forward past the `---' separators already crossed, landing on the
first line of the current field."
  (save-excursion
    (let* ((line-start (line-beginning-position))
           (boundary
            (progn
              (goto-char line-start)
              (if (re-search-backward
                   "^===$\\|^{start-parallel[^}]*}$"
                   nil t)
                  (line-beginning-position 2)
                (point-min))))
           (count 0)
           (pos boundary))
      (save-excursion
        (goto-char boundary)
        (while (< (point) line-start)
          (when (looking-at "^---$")
            (setq count (1+ count)))
          (forward-line 1)))
      (setq count (min count 2))
      ;; Now walk forward from boundary past `count' separators to find field start
      (goto-char pos)
      (let ((remaining count))
        (while (and (> remaining 0) (not (eobp)))
          (when (looking-at "^---$")
            (setq remaining (1- remaining))
            (forward-line 1)
            (setq pos (point)))
          (unless (looking-at "^---$")
            (forward-line 1))))
      pos)))

(defun dpurge-parallel-next-field ()
  "Advance to the next field in a parallel block, inserting `---' as needed."
  (unless (memq dpurge-markdown-block-type '(parallel parallel-dialog))
    (user-error "Not inside a parallel block"))
  (let* ((field (dpurge-parallel-current-field))
         (next (dpurge-markdown-next-field-name dpurge-markdown-block-type field))
         (fstart (dpurge-parallel-field-start))
         (fend (dpurge-parallel-field-end fstart)))
    (if (eq next 'done)
        ;; Code-review fix: `dpurge-markdown-finish-field-editing' is SHARED
        ;; with vocabulary/models/questions and moves to (line-end-position)
        ;; of point's OWN line -- correct for those single-line fields, but
        ;; wrong for parallel's (possibly multi-line) transcription: it would
        ;; leave point mid-field instead of at the field's real end. Move to
        ;; the real field end first (no shared-function behavior change).
        (progn
          (goto-char fend)
          (dpurge-vocabulary-setup-field-editing 'done))
      (progn
        (goto-char fend)
        (insert "\n---\n")
        (dpurge-vocabulary-setup-field-editing next)))))

(defun dpurge-markdown-end-marker-line-p ()
  "Return non-nil when point is on a supported block end marker line."
  (save-excursion
    (beginning-of-line)
    (or (looking-at-p "^{end-vocabulary}$")
        (looking-at-p "^{end-models}$")
        (looking-at-p "^{end-questions}$")
        (looking-at-p "^{end-parallel}$")
        (looking-at-p "^{end-parallel-dialog}$"))))

(defun dpurge-markdown-open-entry-line ()
  "Create a new empty entry line before a supported block end marker."
  (if (memq dpurge-markdown-block-type '(parallel parallel-dialog))
      (dpurge-markdown-open-parallel-entry-line)
    (beginning-of-line)
    (open-line 1)
    (dpurge-markdown-update-block-mode)
    (dpurge-vocabulary-setup-field-editing 'phrase)))

(defun dpurge-markdown-open-parallel-entry-line ()
  "Open a new source line before the block's end marker, inserting `===' if
needed.  Shared by `parallel' and `parallel-dialog' end markers."
  (beginning-of-line)
  ;; Check if the block already has record content above the end marker.
  (let ((prev-non-blank
         (save-excursion
           (forward-line -1)
           (while (and (not (bobp))
                       (looking-at "^[[:space:]]*$"))
             (forward-line -1))
           (buffer-substring-no-properties
            (line-beginning-position)
            (line-end-position)))))
    (if (or (string-match-p "^{start-parallel" prev-non-blank)
            (string= prev-non-blank ""))
        ;; Empty block: just open a blank line before {end-parallel}
        (progn
          (open-line 1)
          (dpurge-markdown-update-block-mode)
          (dpurge-vocabulary-setup-field-editing 'phrase))
      ;; Non-empty block: insert `===' separator + blank line unless already ===
      (unless (string= prev-non-blank "===")
        (insert "===\n"))
      (open-line 1)
      (dpurge-markdown-update-block-mode)
      (dpurge-vocabulary-setup-field-editing 'phrase))))

(defun dpurge-markdown-tab ()
  "Handle TAB in Markdown buffers, including structured block editing."
  (interactive)
  (cond
   ((dpurge-markdown-end-marker-line-p) (dpurge-markdown-open-entry-line))
   ((eq dpurge-markdown-block-type 'vocabulary) (dpurge-vocabulary-next-field))
   ((eq dpurge-markdown-block-type 'models) (dpurge-model-next-field))
   ((eq dpurge-markdown-block-type 'questions) (dpurge-questions-next-field))
   ((memq dpurge-markdown-block-type '(parallel parallel-dialog)) (dpurge-parallel-next-field))
   ((and (derived-mode-p 'markdown-mode) (commandp dpurge-markdown-tab-fallback))
    (call-interactively dpurge-markdown-tab-fallback))
   ((and (derived-mode-p 'markdown-ts-mode) (commandp dpurge-markdown-ts-tab-fallback))
    (call-interactively dpurge-markdown-ts-tab-fallback))
   (t (indent-for-tab-command))))


(defun dpurge-markdown-finish-field-editing ()
  "Move to end of line and mark structured field editing as done."
  (goto-char (line-end-position))
  (dpurge-vocabulary-setup-field-editing 'done))

(defun dpurge-vocabulary-next-field ()
  "Move to the next vocabulary field, inserting syntax as needed."
  (interactive)
  (unless (eq dpurge-markdown-block-type 'vocabulary)
    (user-error "Not inside a vocabulary block"))
  (let* ((info (dpurge-vocabulary-line-info))
         (field (dpurge-vocabulary-point-field info)))
    (when (dpurge-vocabulary-field-empty-p field info)
      (pcase field
        ((or 'grammar 'transcription)
         (dpurge-vocabulary-delete-empty-field field info)
         (setq info (dpurge-vocabulary-line-info))
         (let ((next (dpurge-markdown-next-field-name 'vocabulary field)))
           (if (plist-get info next)
               (dpurge-vocabulary-move-to-existing next info)
             (dpurge-vocabulary-insert-missing-field next info)))
         (setq field nil))
        ('notes
         (dpurge-vocabulary-delete-empty-field 'notes info)
         (dpurge-markdown-finish-field-editing)
         (setq field nil))))
    (when field
      (let ((next (dpurge-markdown-next-field-name 'vocabulary field)))
        (if (eq next 'done)
            (dpurge-markdown-finish-field-editing)
          (if (plist-get info next)
              (dpurge-vocabulary-move-to-existing next info)
            (dpurge-vocabulary-insert-missing-field next info)))))))

(defun dpurge-model-next-field ()
  "Move to the next models field, inserting syntax as needed."
  (interactive)
  (unless (eq dpurge-markdown-block-type 'models)
    (user-error "Not inside a models block"))
  (let* ((info (dpurge-model-line-info))
         (field (dpurge-model-point-field info)))
    (when (dpurge-vocabulary-field-empty-p field info)
      (pcase field
        ('transcription
         (dpurge-vocabulary-delete-empty-field 'transcription info)
         (setq info (dpurge-model-line-info))
         (let ((next (dpurge-markdown-next-field-name 'models field)))
           (if (plist-get info next)
               (dpurge-markdown-move-to-existing-field info next)
             (dpurge-markdown-insert-missing-field 'models info next)))
         (setq field nil))
        ('notes
         (dpurge-vocabulary-delete-empty-field 'notes info)
         (dpurge-markdown-finish-field-editing)
         (setq field nil))))
    (when field
      (let ((next (dpurge-markdown-next-field-name 'models field)))
        (if (eq next 'done)
            (dpurge-markdown-finish-field-editing)
          (if (plist-get info next)
              (dpurge-markdown-move-to-existing-field info next)
            (dpurge-markdown-insert-missing-field 'models info next)))))))

(defun dpurge-questions-next-field ()
  "Move to the next questions field, inserting syntax as needed."
  (interactive)
  (unless (eq dpurge-markdown-block-type 'questions)
    (user-error "Not inside a questions block"))
  (let* ((info (dpurge-questions-line-info))
         (field (dpurge-questions-point-field info)))
    (when (dpurge-vocabulary-field-empty-p field info)
      (pcase field
        ('question-transcription
         (dpurge-vocabulary-delete-empty-field 'question-transcription info)
         (setq info (dpurge-questions-line-info))
         (let ((next (dpurge-markdown-next-field-name 'questions field)))
           (if (plist-get info next)
               (dpurge-markdown-move-to-existing-field info next)
             (dpurge-markdown-insert-missing-field 'questions info next)))
         (setq field nil))
        ('answer-transcription
         (dpurge-vocabulary-delete-empty-field 'answer-transcription info)
         (dpurge-markdown-finish-field-editing)
         (setq field nil))))
    (when field
      (let ((next (dpurge-markdown-next-field-name 'questions field)))
        (if (eq next 'done)
            (dpurge-markdown-finish-field-editing)
          (if (plist-get info next)
              (dpurge-markdown-move-to-existing-field info next)
            (dpurge-markdown-insert-missing-field 'questions info next)))))))

(defun dpurge-vocabulary-lookup ()
  "Look up the phrase from the current vocabulary entry line."
  (interactive)
  (unless dpurge-markdown-edit-mode
    (user-error "Not inside a vocabulary block"))
  (let* ((info (dpurge-vocabulary-line-info))
         (phrase-region (plist-get info 'phrase))
         (phrase (and phrase-region
                      (string-trim
                       (buffer-substring-no-properties
                        (car phrase-region)
                        (cdr phrase-region))))))
    (unless (and phrase (not (string-empty-p phrase)))
      (user-error "No phrase on current vocabulary line"))
    (dpurge-dictionary-lookup phrase
                              dpurge-markdown-block-lang
                              dpurge-markdown-block-script)))

(provide 'dpurge-markdown)

;;; dpurge-markdown.el ends here
