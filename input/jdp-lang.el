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

;(require 'jdp-greek-polytonic)
(require 'jdp-zho-pinyin)

;;;; OTHER START ;;;;
(require 'jdp-ara)
(require 'jdp-aze)
(require 'jdp-bul)
(require 'jdp-ces)
(require 'jdp-crh)
(require 'jdp-dan)
(require 'jdp-deu)
(require 'jdp-ell)
(require 'jdp-epo)
(require 'jdp-fas)
(require 'jdp-fin)
(require 'jdp-fra)
(require 'jdp-grc)
(require 'jdp-heb)
(require 'jdp-hin)
(require 'jdp-hun)
(require 'jdp-ita)
(require 'jdp-kat)
(require 'jdp-kaz)
(require 'jdp-kir)
(require 'jdp-lav)
(require 'jdp-lit)
(require 'jdp-mnc)
(require 'jdp-ron)
(require 'jdp-rus)
(require 'jdp-srp)
(require 'jdp-swe)
(require 'jdp-tat)
(require 'jdp-tur)
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
      (setq jdp-ime-phrase 'jdp-ara)
      (setq jdp-ime-transcription 'jdp-semitic-postfix))
    ("aze"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-aze)
      (setq jdp-ime-transcription nil))
    ("crh"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-crh)
      (setq jdp-ime-transcription nil))
    ("dan"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-dan)
      (setq jdp-ime-transcription nil))
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
    ("epo"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-epo)
      (setq jdp-ime-transcription nil))
    ("fas"
      ;(setq bidi-display-reordering t)
      (setq bidi-paragraph-direction 'right-to-left)
      ;(setq jdp-ime-phrase 'farsi-transliterate-banan)
	  (setq jdp-ime-phrase 'jdp-fas)
      (setq jdp-ime-transcription 'jdp-semitic-postfix))
    ("fin"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-fin)
      (setq jdp-ime-transcription nil))
    ("fra"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-fra)
      (setq jdp-ime-transcription nil))
    ("ger"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'german-prefix)
      (setq jdp-ime-transcription nil))
    ("grc"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-grc)
      (setq jdp-ime-transcription nil))
    ("heb"
      ;(setq bidi-display-reordering t)
      (setq bidi-paragraph-direction 'right-to-left)
      (setq jdp-ime-phrase 'jdp-heb)
      (setq jdp-ime-transcription 'jdp-semitic-postfix))
    ("hun"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-hun)
      (setq jdp-ime-transcription nil))
    ("ita"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-ita)
      (setq jdp-ime-transcription nil))
    ("jpn"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'japanese)
      (setq jdp-ime-transcription nil))
    ("kat"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-kat)
      (setq jdp-ime-transcription nil))
    ("kaz"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-kaz)
      (setq jdp-ime-transcription nil))
    ("kir"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-kir)
      (setq jdp-ime-transcription nil))
    ("kor"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'korean-ipa-romaja)
      (setq jdp-ime-transcription nil))
    ("lav"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-lav)
      (setq jdp-ime-transcription nil))
    ("lit"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-lit)
      (setq jdp-ime-transcription nil))
    ("mnc"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-mnc)
      (setq jdp-ime-transcription nil))
    ("ron"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-ron)
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
    ("swe"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-swe)
      (setq jdp-ime-transcription nil))
    ("tat"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-tat)
      (setq jdp-ime-transcription nil))
    ("tgk"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-tgk)
      (setq jdp-ime-transcription nil))
    ("tur"
      ;(setq bidi-display-reordering nil)
      (setq bidi-paragraph-direction 'left-to-right)
      (setq jdp-ime-phrase 'jdp-tur)
      (setq jdp-ime-transcription nil))
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
