(require 'jdp-indic-postfix)
(require 'jdp-semitic-postfix)

(require 'jdp-ara-buckwalter)
(require 'jdp-greek)
(require 'jdp-hebrew)

(defun set-jdp-lang (lang-code)
  "Set up buffer for Arabic editing."
  (interactive "sChoose language: ")
  (pcase lang-code
    ("ara"
      (setq bidi-display-reordering t)
      (setq bidi-paragraph-direction 'right-to-left)
      (set-frame-font "Times New Roman")
      (set-input-method 'jdp-ara-buckwalter))
    ("grc"
      (setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (set-frame-font "Times New Roman")
      (set-input-method 'jdp-greek))
    ("heb"
      (setq bidi-display-reordering t)
      (setq bidi-paragraph-direction 'right-to-left)
      (set-frame-font "Times New Roman")
      (set-input-method 'jdp-hebrew))
    ("zho"
      (setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      ;(set-frame-font "Times New Roman")
      (set-input-method 'eim-py))
    (otherwise
      (message "Unknown language code %S" lang-code)))
)

(provide 'jdp-lang)

;; (set-language-environment "Latin-1")
;; (setq bidi-display-reordering t)
;; (setq bidi-display-reordering nil)
;; (setq bidi-paragraph-direction 'right-to-left)
;; (setq bidi-paragraph-direction 'left-to-right)
;;(setq-default bidi-display-reordering t)

;;; Activation:

;; * If the variable bidi-display-reordering is nil, either:
;;   Enter `M-: (setq bidi-display-reordering t)' to turn on bidi
;;   support for a single buffer.
;;   OR
;;   Enter `M-: (setq-default bidi-display-reordering t)' to turn on
;;   bidi support for all buffers.
;;   
;; * Enter `C-x <RET> C-\ hebrewzc' to activate this input method.
;;
;; * Enter `M-: (inactivate-input-method)' to deactivate this input
;;   method or `C-\' to toggle between Hebrew and your default input
;;   method.

;; * Enter `M-x describe-input-method <RET> hebrew-zc' to see the
;;   keyboard layout.

;; (setq-default bidi-display-reordering t)
;; (setq-default bidi-paragraph-direction 'right-to-left)
;; (set-frame-font "Amiri" nil t)

;(require 'ido)
;(setq jdp-lang-codes '("ara" "eng" "pol" "vie"))
;(setq lang-code (ido-completing-read "Select language:" jdp-lang-codes ))



;(require 'eww)
;(setq xah-lookup-browser-function 'browse-url)
;(setq xah-lookup-browser-function 'eww) ; must come before loading xah-lookup
(require 'xah-lookup)

;(global-set-key (kbd "<f2>") 'xah-lookup-wikipedia) ; F2

(require 'chinese-fonts-setup)
;(chinese-fonts-setup-enable)
(autoload 'eim-use-package "eim" "Another emacs input method")
(setq eim-use-tooltip nil)
(register-input-method "eim-wb" "utf-8"
  'eim-use-package "五笔" "汉字五笔输入法" "wb.txt")
(register-input-method "eim-py" "utf-8"
  'eim-use-package "拼音" "汉字拼音输入法" "py.txt")


(autoload 'ispell-get-word "ispell")
(defun lookup-word (word)
  (interactive (list (save-excursion (car (ispell-get-word nil)))))
  (browse-url (format "http://en.wiktionary.org/wiki/%s" word)))
(global-set-key (kbd "M-#") 'lookup-word)

(defun get-selected-text (start end)
  (interactive "r")
    (if (use-region-p)
        (let ((regionp (buffer-substring start end)))
            ;(message regionp)
            (browse-url (format "http://en.wiktionary.org/wiki/%s" regionp)))))
(global-set-key (kbd "M-=") 'get-selected-text)