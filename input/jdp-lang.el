;; INSTALLATION
;; (require 'jdp-lang)

;; packages
(use-package popup)
(use-package pyim)
(use-package pyim-basedict)

(require 'korean-ipa-romaja)

;; fonts
(require 'jdp-font)

;; input methods
(require 'jdp-indic-postfix)
(require 'jdp-semitic-postfix)

(require 'jdp-ara-buckwalter)
(require 'jdp-greek-polytonic)
(require 'jdp-zho-pinyin)

;;;; OTHER START ;;;;
(require 'jdp-bul)
(require 'jdp-ces)
(require 'jdp-deu)
(require 'jdp-ell)
(require 'jdp-fra)
(require 'jdp-heb)
(require 'jdp-hin)
(require 'jdp-hun)
(require 'jdp-kat)
(require 'jdp-lit)
(require 'jdp-ron)
(require 'jdp-rus)
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
      ;(setq bidi-display-reordering t)
      (setq bidi-paragraph-direction 'right-to-left)
      (setq jdp-ime-phrase 'jdp-ara-buckwalter)
      (setq jdp-ime-transcription 'jdp-semitic-postfix))
    ("deu"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-deu)
      (setq jdp-ime-transcription nil))
    ("ell"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-ell)
      (setq jdp-ime-transcription nil))
    ("fas"
      ;(setq bidi-display-reordering t)
      (setq bidi-paragraph-direction 'right-to-left)
      (setq jdp-ime-phrase 'farsi-transliterate-banan)
      (setq jdp-ime-transcription 'jdp-semitic-postfix))
    ("fra"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-fra)
      (setq jdp-ime-transcription nil))
    ("geo"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (set-input-method 'georgian))
    ("ger"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'german-prefix)
      (setq jdp-ime-transcription nil))
    ("grc"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (set-input-method 'greek-babel))
    ("heb"
      ;(setq bidi-display-reordering t)
      (setq bidi-paragraph-direction 'right-to-left)
      (setq jdp-ime-phrase 'jdp-heb)
      (setq jdp-ime-transcription 'jdp-semitic-postfix))
    ("jpn"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'japanese)
      (setq jdp-ime-transcription nil))
    ("kor"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'korean-ipa-romaja)
      (setq jdp-ime-transcription nil))
    ("rus"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-rus)
      (setq jdp-ime-transcription nil))
    ("spa"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (set-input-method 'spanish-prefix))
    ("vie"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (set-input-method 'jdp-vie))
    ("zho"
      (pyim-basedict-enable)
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'pyim)
      (setq jdp-ime-transcription 'chinese-sisheng))
    (otherwise
      (message "Unknown language code %S" lang-code)))
  
  (setq default-input-method jdp-ime-phrase)
)

;; edit vocabulary
(defun edit-jdp-lang-vocabulary ()
  (interactive)
  (local-set-key (kbd "TAB") 'self-insert-command)
  (setq whitespace-style
    '(tabs newline tab-mark newline-mark))
  (setq whitespace-display-mappings
    '((newline-mark 10 [182 10])
      (tab-mark 9 [9655 9] [92 9])))
  (whitespace-mode)
  (set (make-local-variable 'electric-indent-mode) nil)
)

;; insert vocabulary header
(defun insert-jdp-lang-vocabulary-header ()
  (interactive)
  (beginning-of-buffer)
  (insert "Phrase\tGrammar\tTranscription\tTranslation\tNotes\n")
  (edit-jdp-lang-vocabulary)
)

;; set paragraph direction
(defun set-jdp-lang-paragraph-direction ()
  (interactive)
  (if (eq bidi-paragraph-direction 'right-to-left)
    (setq bidi-paragraph-direction 'left-to-right)
    (setq bidi-paragraph-direction 'right-to-left))
 )

(global-set-key (kbd "<f5>") (lambda () (interactive) (set-input-method jdp-ime-phrase)))
(global-set-key (kbd "<f6>") (lambda () (interactive) (set-input-method jdp-ime-transcription)))
(global-set-key (kbd "<f7>") 'toggle-input-method)
(global-set-key (kbd "<f8>") 'set-jdp-lang-paragraph-direction)

(global-set-key (kbd "<f9>") 'set-jdp-lang)
(global-set-key (kbd "<f10>") 'edit-jdp-lang-vocabulary)
(global-set-key (kbd "<f11>") 'insert-jdp-lang-vocabulary-header)

(provide 'jdp-lang)
