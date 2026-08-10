;;; dpurge-markdown.el --- Markdown extension editing -*- lexical-binding: t; -*-

(defvar-local dpurge-markdown-block-type nil
  "Type of the special Markdown block at point.")

(defvar-local dpurge-markdown-block-lang nil
  "Language of the current Markdown block.")

(defvar-local dpurge-markdown-block-script nil
  "Script of the current Markdown block.")

(defvar dpurge-markdown-edit-mode-map
  (let ((map (make-sparse-keymap)))
    ;; Example commands:
    ;; (define-key map (kbd "C-c C-l") #'dpurge-markdown-something)
    map)
  "Keymap for `dpurge-markdown-edit-mode`.")

(define-minor-mode dpurge-markdown-edit-mode
  "Minor mode active while editing a Markdown extension block."
  :lighter " Vocab"
  :keymap dpurge-markdown-edit-mode-map)


(defun dpurge-markdown-current-block ()
  "Return information about the special block containing point.

Returns a plist, or nil when point is outside a block."
  (save-excursion
    (let ((pos (point))
          start
          type
          attributes)

      ;; Find the nearest start line before point.
      (goto-char pos)
      (when (re-search-backward
             "^{start-\\([[:alnum:]_-]+\\)\\(.*\\)}$"
             nil t)

        (setq start (point))
        (setq type (match-string-no-properties 1))
        (setq attributes (match-string-no-properties 2))

        ;; Make sure an end line hasn't occurred between the
        ;; start line and point.
        (goto-char pos)
        (unless (re-search-backward
                 (format "^{end-%s}$" (regexp-quote type))
                 start t)

          (list
           :type (intern type)
           :lang
           (when (string-match
                  "\\blang=\\([^[:space:]}]+\\)"
                  attributes)
             (match-string 1 attributes))
           :script
           (when (string-match
                  "\\bscript=\\([^[:space:]}]+\\)"
                  attributes)
             (match-string 1 attributes))))))))


(defun dpurge-markdown-update-block-mode ()
  "Update the Markdown block editing mode according to point position."
  (when (derived-mode-p 'markdown-mode)
    (let ((block (dpurge-markdown-current-block)))
      (pcase block
        (`(:type vocabulary :lang ,lang :script ,script)
         ;; We are inside a vocabulary block.
         (setq-local dpurge-markdown-block-type 'vocabulary)
         (setq-local dpurge-markdown-block-lang lang)
         (setq-local dpurge-markdown-block-script script)

         (unless dpurge-markdown-edit-mode
           (dpurge-markdown-edit-mode 1)))

        (`nil
         ;; We are outside a special block.
         (when dpurge-markdown-edit-mode
           (dpurge-markdown-edit-mode -1))

         (setq-local dpurge-markdown-block-type nil)
         (setq-local dpurge-markdown-block-lang nil)
         (setq-local dpurge-markdown-block-script nil))

        (_
         ;; We are inside another kind of Markdown block.
         (when dpurge-markdown-edit-mode
           (dpurge-markdown-edit-mode -1))

         (setq-local dpurge-markdown-block-type
                     (plist-get block :type))
         (setq-local dpurge-markdown-block-lang
                     (plist-get block :lang))
         (setq-local dpurge-markdown-block-script
                     (plist-get block :script)))))))


(defun dpurge-markdown-blocks-setup ()
  "Enable special Markdown block detection."
  (add-hook 'post-command-hook
            #'dpurge-markdown-update-block-mode
            nil
            t))


(add-hook 'markdown-mode-hook #'dpurge-markdown-blocks-setup)


(defun dpurge-vocabulary-lookup ()
  "Look up the word at point using the current vocabulary language."
  (interactive)
  (unless dpurge-markdown-edit-mode
    (user-error "Not inside a vocabulary block"))

  (let ((word (thing-at-point 'word t)))
    (unless word
      (user-error "No word at point"))

    (dpurge-dictionary-lookup
      word
      dpurge-markdown-block-lang
      dpurge-markdown-block-script)))


(provide 'dpurge-markdown)

;;; dpurge-markdown.el ends here
