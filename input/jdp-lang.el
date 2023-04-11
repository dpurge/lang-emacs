;; INSTALLATION
;; (require 'jdp-lang)
;; (global-set-key (kbd "<f9>") 'set-jdp-lang)

;; packages
(use-package popup)
(use-package pyim)
(use-package pyim-basedict)

;; fonts
(require 'jdp-font)

;; input methods
(require 'jdp-indic-postfix)
(require 'jdp-semitic-postfix)

(require 'jdp-ara-buckwalter)
(require 'jdp-greek)
(require 'jdp-greek-polytonic)
(require 'jdp-hebrew)
(require 'jdp-zho-pinyin)

;;;; OTHER START ;;;;
(require 'jdp-bul)
(require 'jdp-ces)
(require 'jdp-hin)
(require 'jdp-hun)
(require 'jdp-kat)
(require 'jdp-lit)
(require 'jdp-ron)
(require 'jdp-srp)
(require 'jdp-tgk)
(require 'jdp-vie)
(require 'jdp-yid)
;;;; OTHER END ;;;;

;; select language
(defun set-jdp-lang (lang-code)
  "Set up buffer for Arabic editing."
  (interactive "sChoose language: ")
  (pcase lang-code
    ("ara"
      (setq bidi-display-reordering t)
      (setq bidi-paragraph-direction 'right-to-left)
      (setq jdp-ime-phrase 'jdp-ara-buckwalter)
      (setq jdp-ime-transcription 'jdp-semitic-postfix))
    ("fas"
      (setq bidi-display-reordering t)
      (setq bidi-paragraph-direction 'right-to-left)
      (setq jdp-ime-phrase 'farsi-transliterate-banan)
      (setq jdp-ime-transcription 'jdp-semitic-postfix))
    ("geo"
      (setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (set-input-method 'georgian))
    ("ger"
      (setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'german-prefix)
      (setq jdp-ime-transcription nil))
    ("grc"
      (setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (set-input-method 'greek-babel))
    ("heb"
      (setq bidi-display-reordering t)
      (setq bidi-paragraph-direction 'right-to-left)
      (setq jdp-ime-phrase 'jdp-hebrew)
      (setq jdp-ime-transcription 'jdp-semitic-postfix))
    ("rus"
      (setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (set-input-method 'cyrillic-translit))
    ("spa"
      (setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (set-input-method 'spanish-prefix))
    ("vie"
      (setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (set-input-method 'jdp-vie))
    ("zho"
      (pyim-basedict-enable)
      (setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'pyim)
      (setq jdp-ime-transcription 'chinese-sisheng))
    ("zho-t"
      (setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (set-input-method 'chinese-sisheng))
    (otherwise
      (message "Unknown language code %S" lang-code)))
  
  (setq default-input-method jdp-ime-phrase)
)

;; edit vocabulary
(defun start-jdp-lang-vocabulary ()
  (interactive)
  (beginning-of-buffer)
  (insert "Phrase\tGrammar\tTranscription\tTranslation\tNotes\n")
  (local-set-key (kbd "TAB") 'self-insert-command)
  (setq whitespace-style
    '(tabs newline tab-mark newline-mark))
  (setq whitespace-display-mappings
    '((newline-mark 10 [182 10])
      (tab-mark 9 [9655 9] [92 9])))
  (whitespace-mode)
  ;(csv-align-fields)
)

(global-set-key (kbd "<f5>") (lambda () (interactive) (set-input-method jdp-ime-phrase)))
(global-set-key (kbd "<f6>") (lambda () (interactive) (set-input-method jdp-ime-transcription)))

(global-set-key (kbd "<f9>") 'set-jdp-lang)
(global-set-key (kbd "<f10>") 'toggle-input-method)
(global-set-key (kbd "<f11>") 'start-jdp-lang-vocabulary)

(provide 'jdp-lang)
