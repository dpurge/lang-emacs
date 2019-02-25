(require 'json)
(require 'url)

;(require 'subr-x) ; string-trim
(require 'jdp-ara-buckwalter)
(require 'jdp-zho-pinyin)

(require 'chinese-fonts-setup)
;(chinese-fonts-setup-enable)
(autoload 'eim-use-package "eim" "Another emacs input method")
(setq eim-use-tooltip nil)
;(register-input-method "eim-wb" "utf-8"
;  'eim-use-package "五笔" "汉字五笔输入法" "wb.txt")
(register-input-method "eim-py" "utf-8"
  'eim-use-package "拼音" "汉字拼音输入法" "py.txt")

;;; options

;;; constants
(defconst jdp-lang-mode-name "JdpLang" "Mode name for `jdp-lang-mode'.")
(defconst jdp-lang-mode-data-record-format ",
    {
      \"phrase\": \"\",
      \"transcription\": \"\",
      \"category\": {
        \"lexical\": \"\"
      },
      \"translation\": {
        \"eng\": \"\",
        \"pol\": \"\"
      }
    }")
(defconst jdp-lang-mode-data-record-format-simple ",
    {
      \"phrase\": \"\",
      \"category\": {
        \"lexical\": \"\"
      },
      \"translation\": {
        \"eng\": \"\",
        \"pol\": \"\"
      }
    }")

;;; variables
(defvar jdp-lang-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "RET") #'jdp-lang-mode-add-record)
    ;(define-key map (kbd "M-RET") #'jdp-lang-mode-add-record)
    (define-key map (kbd "<tab>") #'jdp-lang-mode-next-field)
    ;(define-key map (kbd "M-RET") #'jdp-lang-mode-upload-anki)
    map)
  "Keymap for `jdp-lang-mode'.")

;;; autoload
(define-derived-mode jdp-lang-mode js-mode jdp-lang-mode-name
  "A simple mode for JDP language data editing."
    (jdp-lang-mode-read-meta)
  )

;;; code

(defun jdp-lang-mode-read-meta ()
  "Set up language for the current file based on meta configuration."
  (interactive)
  
  (condition-case nil
      (json-pretty-print-buffer)
    (error (user-error "Invalid JSON")))
  (goto-char (point-min))
  (set-buffer-modified-p nil)
  
  (re-search-forward "\"meta\" *: *")

  (let*
    (
      (json-object-type 'hash-table)
      ;(json-array-type 'list)
      (json-key-type 'string)
      (jdp-lang-mode-meta (json-read-object))
    )
    (make-local-variable 'jdp-lang-mode-meta)
  )
  (jdp-lang-mode-configure-ime)
  (re-search-forward "\"data\" *:")
  (jdp-lang-mode-next-field)
)

(defun jdp-lang-mode-configure-ime ()
  (let*
    (
      (language (gethash "language" jdp-lang-mode-meta))
      (jdp-lang-mode-ime (make-hash-table :test 'equal))
    )
    (pcase language
      ("arb"
        (puthash "phrase" 'jdp-ara-buckwalter jdp-lang-mode-ime)
        (puthash "transcription" 'jdp-semitic-postfix jdp-lang-mode-ime))
      ("cmn"
        (puthash "phrase" 'eim-py jdp-lang-mode-ime)
        (puthash "transcription" 'jdp-zho-pinyin jdp-lang-mode-ime))
      ("deu"
        (puthash "phrase" 'latin-alt-postfix jdp-lang-mode-ime)
        (puthash "transcription" 'nil jdp-lang-mode-ime))
      ("ell"
        (puthash "phrase" 'greek-babel jdp-lang-mode-ime)
        (puthash "transcription" 'nil jdp-lang-mode-ime))
      ("fra"
        (puthash "phrase" 'latin-alt-postfix jdp-lang-mode-ime)
        (puthash "transcription" 'nil jdp-lang-mode-ime))
      ("geo"
        (puthash "phrase" 'georgian jdp-lang-mode-ime)
        (puthash "transcription" 'nil jdp-lang-mode-ime))
      ("heb"
        (puthash "phrase" 'jdp-hebrew jdp-lang-mode-ime)
        (puthash "transcription" 'jdp-semitic-postfix jdp-lang-mode-ime))
      ("hin"
        (puthash "phrase" 'devanagari-itrans jdp-lang-mode-ime)
        (puthash "transcription" 'nil jdp-lang-mode-ime))
      ("rus"
        (puthash "phrase" 'cyrillic-translit jdp-lang-mode-ime)
        (puthash "transcription" 'nil jdp-lang-mode-ime))
      ("spa"
        (puthash "phrase" 'latin-alt-postfix jdp-lang-mode-ime)
        (puthash "transcription" 'nil jdp-lang-mode-ime))
      ("tur"
        (puthash "phrase" 'turkish-alt-postfix jdp-lang-mode-ime)
        (puthash "transcription" 'nil jdp-lang-mode-ime))
      (otherwise
        (message "Unsupported IME language: %s" language))
    )
    (make-local-variable 'jdp-lang-mode-ime)
  )
)

(defun jdp-lang-mode-add-record ()
  (interactive)
  (goto-char (point-max))
  (re-search-backward "]")
  (re-search-backward "}")
  (forward-char)
  (if (member (gethash "language" jdp-lang-mode-meta) '("arb" "cmn"))
    (insert jdp-lang-mode-data-record-format)
    (insert jdp-lang-mode-data-record-format-simple))
  (re-search-backward "\"phrase\" *:")
  (re-search-backward "{")
  (jdp-lang-mode-next-field)
)

(defun jdp-lang-mode-set-field-ime (field-name)
  (set-input-method
    (gethash field-name jdp-lang-mode-ime nil))
)

(defun jdp-lang-mode-next-field ()
  "Jump to next json data field"
  (interactive)
  (re-search-forward "\"\\([a-z]+\\)\" *: *\"")
  (jdp-lang-mode-set-field-ime (match-string 1))
  )

(defun jdp-lang-mode-prev-field ()
  "Jump to previous json data field"
  (interactive)
  (re-search-backward "\"\\([a-z]+\\)\" *: *\"")
  (message "Field name: %s" (match-string 1))
  (re-search-forward "\" *: *\"")
  )
  
;(defun jdp-lang-mode-upload-anki ()
;  (interactive)
;  (goto-char (point-min))
;  (set-buffer-modified-p nil)
;  
;  (re-search-forward "\"data\" *: *")
;
;  (let*
;    (
;      (json-object-type 'hash-table)
;      (json-array-type 'list)
;      (json-key-type 'string)
;      (jdp-lang-mode-data (json-read-array));
;      
;      (anki-url "http://127.0.0.1:8765/")
;	  (anki-deck (format "%s::%s"
;	    (gethash "language" jdp-lang-mode-meta)
;	    (gethash "format" jdp-lang-mode-meta)))
;	  (anki-model (format "%s-%s"
;	    (gethash "language" jdp-lang-mode-meta)
;	    (gethash "format" jdp-lang-mode-meta)))
;	  (anki-tags (json-encode (gethash "tags" jdp-lang-mode-meta)))
;	  
;      (url-request-method "POST")
;      (url-request-extra-headers '(("Content-Type" . "application/json")))
;    )
;	
;	(let (
;	  (url-request-data (encode-coding-string (concatenate 'string
;		    "{"
;			  "\"action\":\"createDeck\","
;			  "\"version\":6,"
;			  "\"params\":{"
;			    (format "\"deck\":\"%s\"" anki-deck)
;			  "}"
;			"}") 'utf-8)
;		  )
;	)
;	(message "Adding deck: %s" anki-deck)
;	(url-retrieve anki-url (lambda (status) (kill-buffer (current-buffer)) ))
;	)
;
;    (dolist (item jdp-lang-mode-data)
;      (let*
;	    (
;		  (phrase (gethash "phrase" item))
;		  (transcription (gethash "transcription" item))
;		  (grammar (gethash "grammar" item))
;		  (translation (gethash "translation" item))
;		  (image (gethash "image" item))
;		  (audio (gethash "audio" item))
;		  (video (gethash "video" item))
;		  (note (gethash "note" item))
;		  
;		  (url-request-data (encode-coding-string (concatenate 'string
;		    "{"
;			  "\"action\":\"addNote\","
;			  "\"version\":6,"
;			  "\"params\":{"
;			    "\"note\":{"
;				  (format "\"deckName\":\"%s\"," anki-deck)
;				  (format "\"modelName\":\"%s\"," anki-model)
;				  "\"fields\":{"
;				    (format "\"phrase\":\"%s\"," phrase)
;				    (format "\"transcription\":\"%s\"," transcription)
;				    (format "\"grammar\":\"%s\"," grammar)
;				    (format "\"translation\":\"%s\"," translation)
;				    (format "\"image\":\"%s\"," image)
;				    (format "\"audio\":\"%s\"," audio)
;				    (format "\"video\":\"%s\"," video)
;				    (format "\"note\":\"%s\"" note)
;				  "},"
;				  "\"options\":{"
;				    "\"allowDuplicate\": false"
;				  "},"
;				  (format "\"tags\":%s" anki-tags)
;				"}"
;			  "}"
;			"}") 'utf-8)
;		  )
;		)
;        (message "Adding: %s" phrase)
;        (url-retrieve anki-url (lambda (status)
;		  ;(switch-to-buffer (current-buffer))
;		  (kill-buffer (current-buffer))
;		))
;	  )
;	)
;  )
;)

(add-to-list 'auto-mode-alist '("\\.jdp-lang\\.json\\'" . jdp-lang-mode))
(provide 'jdp-lang-mode)