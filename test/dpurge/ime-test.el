(load (expand-file-name "test-setup.el"
                        (file-name-directory (or load-file-name buffer-file-name))))

(ert-deftest dpurge-urd-ime-contains-core-mappings ()
  (let ((source (buffer-string)))
    (with-temp-buffer
      (insert-file-contents (expand-file-name "../../src/dpurge/ime/urd.el"
                                              dpurge-test-directory))
      (setq source (buffer-string)))
    (should (string-match-p (regexp-quote "\"dpurge-urd\"") source))
    (should (string-match-p (regexp-quote "(\"bh\" \"بھ\")") source))
    (should (string-match-p (regexp-quote "(\"R\" \"ڑ\")") source))
    (should (string-match-p (regexp-quote "(\"w`\" \"ؤ\")") source))
    (should (string-match-p (regexp-quote "(\"ii\" \"ً\")") source))))

(ert-deftest dpurge-vocabulary-arabic-phrase-field-configures-ime-and-direction ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=ara script=arab}\nسلام {} [salām] = peace\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "سلام")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "dpurge-ara"))
    (should (equal bidi-paragraph-direction 'right-to-left))))

(ert-deftest dpurge-vocabulary-arabic-transcription-field-configures-ime ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=ara script=arab}\nسلام {} [salām] = peace\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "salām")
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal dpurge-markdown-current-input-method
                   "dpurge-semitic-postfix"))))

(ert-deftest dpurge-vocabulary-armenian-phrase-field-configures-ime ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=hye script=armn}\nաբգ {} [abg] = abc\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "աբգ")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "dpurge-hye"))))

(ert-deftest dpurge-vocabulary-georgian-phrase-field-configures-ime ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=kat script=geor}\nაბგ {} [abg] = abc\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "აბგ")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "dpurge-kat"))))

(ert-deftest dpurge-vocabulary-hebrew-phrase-field-configures-ime-and-direction ()
  (dpurge-test-with-vocabulary-buffer "שלום {} [šālōm] = peace"
    (search-forward "שלום")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "dpurge-heb"))
    (should (equal bidi-paragraph-direction 'right-to-left))))

(ert-deftest dpurge-vocabulary-hebrew-transcription-field-configures-ime ()
  (dpurge-test-with-vocabulary-buffer "שלום {} [šālōm] = peace"
    (search-forward "šālōm")
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal dpurge-markdown-current-input-method
                   "dpurge-semitic-postfix"))))

(ert-deftest dpurge-vocabulary-hebrew-translation-field-clears-ime ()
  (dpurge-test-with-vocabulary-buffer "שלום {} [šālōm] = peace"
    (search-forward "peace")
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'translation))
    (should (equal dpurge-markdown-current-input-method nil))))

(ert-deftest dpurge-vocabulary-hindi-phrase-field-configures-ime ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=hin script=deva}\nनमस्ते {} [namaste] = hello\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "नमस्ते")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "dpurge-hin"))))

(ert-deftest dpurge-vocabulary-hindi-transcription-field-configures-ime ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=hin script=deva}\nनमस्ते {} [namaste] = hello\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "namaste")
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal dpurge-markdown-current-input-method
                   "dpurge-indic-postfix"))))

(ert-deftest dpurge-vocabulary-manchu-phrase-field-configures-ime ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=mnc script=mong}\nᠮᠠ {} [ma] = horse\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "ᠮᠠ")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "dpurge-mnc"))))

(ert-deftest dpurge-vocabulary-japanese-phrase-field-configures-ime ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=jpn script=jpan}\n日本語 {} [nihongo] = Japanese\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "日本語")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "japanese"))))

(ert-deftest dpurge-vocabulary-korean-phrase-field-configures-ime ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=kor script=kore}\n한국어 {} [hangugeo] = Korean\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "한국어")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "korean-ipa-romaja"))
    (should (equal dpurge-markdown-current-font '(:height 192)))))

(ert-deftest dpurge-script-font-overrides-cover-configured-scripts ()
  (dolist (script '("hans" "hant" "jpan" "kore" "arab" "hebr" "thai" "deva"))
    (should (equal (dpurge-markdown-script-font script)
                   '(:height 192)))))

(ert-deftest dpurge-markdown-applies-large-script-overlays-in-markdown-buffers ()
  (with-temp-buffer
    (insert "abc 你好 שלום नमस्ते")
    (markdown-mode)
    (run-hooks 'markdown-mode-hook)
    (dpurge-markdown-fontify-scripts (point-min) (point-max))
    (goto-char (point-min))
    (search-forward "你")
    (should (cl-some (lambda (overlay)
                        (eq (overlay-get overlay 'face)
                            'dpurge-markdown-large-script-face))
                      (overlays-at (1- (point)))))
    (goto-char (point-min))
    (search-forward "a")
    (should-not (cl-some (lambda (overlay)
                           (eq (overlay-get overlay 'face)
                               'dpurge-markdown-large-script-face))
                         (overlays-at (1- (point)))))))

(ert-deftest dpurge-vocabulary-mandarin-config-entry-is-correct ()
  (dolist (script '("hans" "hant"))
    (let ((phrase (dpurge-markdown-field-settings "cmn" script 'phrase))
          (transcription (dpurge-markdown-field-settings "cmn" script 'transcription))
          (config (dpurge-markdown-language-settings "cmn" script)))
      (should (equal (plist-get config :direction) 'left-to-right))
      (should (equal (plist-get phrase :input-method) "pyim"))
      (should (eq (plist-get phrase :setup-function)
                  'dpurge-vocabulary-setup-cmn-phrase))
      (should (equal (plist-get transcription :input-method)
                     "dpurge-zho-pinyin"))
      (should (equal (plist-get transcription :input-method-file)
                     "zho-pinyin")))))

(ert-deftest dpurge-vocabulary-mandarin-phrase-field-configures-shuangpin ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=cmn script=hans}\n推荐 {} [tuījiàn] = recommend\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "推荐")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "pyim"))
    (should (equal dpurge-markdown-current-font '(:height 192)))
    (should (eq dpurge-markdown-current-setup-function
                'dpurge-vocabulary-setup-cmn-phrase))))

(ert-deftest dpurge-vocabulary-mandarin-transcription-field-configures-pinyin ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=cmn script=hans}\n推荐 {} [tuījiàn] = recommend\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "tuījiàn")
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal dpurge-markdown-current-input-method
                   "dpurge-zho-pinyin"))))

(ert-deftest dpurge-vocabulary-traditional-mandarin-phrase-field-configures-shuangpin ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=cmn script=hant}\n推薦 {} [tuījiàn] = recommend\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "推薦")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "pyim"))
    (should (equal dpurge-markdown-current-font '(:height 192)))
    (should (eq dpurge-markdown-current-setup-function
                'dpurge-vocabulary-setup-cmn-phrase))))

(ert-deftest dpurge-vocabulary-traditional-mandarin-transcription-field-configures-pinyin ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=cmn script=hant}\n推薦 {} [tuījiàn] = recommend\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "tuījiàn")
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal dpurge-markdown-current-input-method
                   "dpurge-zho-pinyin"))))

(ert-deftest dpurge-vocabulary-mandarin-translation-field-clears-ime ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=cmn script=hans}\n推荐 {} [tuījiàn] = recommend\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "recommend")
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'translation))
    (should (equal dpurge-markdown-current-input-method nil))))

(ert-deftest dpurge-vocabulary-persian-phrase-field-configures-ime-and-direction ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=fas script=arab}\nسلام {} [salām] = peace\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "سلام")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "dpurge-fas"))
    (should (equal dpurge-markdown-current-font '(:height 192)))
    (should (equal bidi-paragraph-direction 'right-to-left))))

(ert-deftest dpurge-vocabulary-persian-transcription-field-configures-ime ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=fas script=arab}\nسلام {} [salām] = peace\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "salām")
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal dpurge-markdown-current-input-method
                   "dpurge-semitic-postfix"))))

(ert-deftest dpurge-vocabulary-ported-ime-configs-have-nil-transcription ()
  (dolist (entry '(("aze" "latn" "dpurge-aze" "aze")
                   ("bul" "cyrl" "dpurge-bul" "bul")
                   ("ces" "latn" "dpurge-ces" "ces")
                   ("chu" "cyrl" "dpurge-chu" "chu")
                   ("cop" "copt" "dpurge-cop" "cop")
                   ("crh" "latn" "dpurge-crh" "crh")
                   ("dan" "latn" "dpurge-dan" "dan")
                   ("deu" "latn" "dpurge-deu" "deu")
                   ("ell" "grek" "dpurge-ell" "ell")
                   ("epo" "latn" "dpurge-epo" "epo")
                   ("fin" "latn" "dpurge-fin" "fin")
                   ("fra" "latn" "dpurge-fra" "fra")
                   ("grc" "grek" "dpurge-grc" "grc")
                   ("greek-polytonic" "grek" "dpurge-greek-polytonic" "greek-polytonic")
                   ("hye" "armn" "dpurge-hye" "hye")
                   ("hun" "latn" "dpurge-hun" "hun")
                   ("ita" "latn" "dpurge-ita" "ita")
                   ("kaz" "cyrl" "dpurge-kaz" "kaz")
                   ("kat" "geor" "dpurge-kat" "kat")
                   ("kir" "cyrl" "dpurge-kir" "kir")
                   ("lav" "latn" "dpurge-lav" "lav")
                   ("lit" "latn" "dpurge-lit" "lit")
                   ("mnc" "mong" "dpurge-mnc" "mnc")
                   ("ron" "latn" "dpurge-ron" "ron")
                   ("rus" "cyrl" "dpurge-rus" "rus")
                   ("srp" "cyrl" "dpurge-srp" "srp")
                   ("swe" "latn" "dpurge-swe" "swe")
                   ("tat" "cyrl" "dpurge-tat" "tat")
                   ("tgk" "cyrl" "dpurge-tgk" "tgk")
                   ("tur" "latn" "dpurge-tur" "tur")
                   ("vie" "latn" "dpurge-vie" "vie")
                   ("yid" "hebr" "dpurge-yid" "yid")))
    (pcase-let ((`(,lang ,script ,phrase-ime ,file) entry))
      (let ((phrase (dpurge-markdown-field-settings lang script 'phrase))
            (transcription (dpurge-markdown-field-settings lang script 'transcription)))
        (should (equal (plist-get phrase :input-method) phrase-ime))
        (should (equal (plist-get phrase :input-method-file) file))
        (should (equal (plist-get transcription :input-method) nil))))))

(ert-deftest dpurge-vocabulary-ported-ime-files-exist ()
  (dolist (file '("aze" "bul" "ces" "chu" "cop" "crh" "dan" "deu"
                  "ell" "epo" "fin" "fra" "grc" "greek-polytonic"
                  "hun" "hye" "ita" "kaz" "kat" "kir" "lav" "lit"
                  "mnc" "ron" "rus" "srp" "sux" "sux-transcription"
                  "swe" "tat" "tgk" "tur" "urd" "vie" "yid"))
    (should (file-exists-p
             (expand-file-name
              (concat "../../src/dpurge/ime/" file ".el")
              dpurge-test-directory)))))

(ert-deftest dpurge-ime-config-has-no-duplicate-lang-script-keys ()
  (let ((seen nil))
    (dolist (entry dpurge-vocabulary-language-config)
      (let ((key (car entry)))
        (should (not (member key seen)))
        (push key seen)))))

(ert-deftest dpurge-ime-config-references-existing-ime-files ()
  (dolist (entry dpurge-vocabulary-language-config)
    (let* ((fields (plist-get (cdr entry) :fields)))
      (dolist (field-entry fields)
        (let ((file (plist-get (cdr field-entry) :input-method-file)))
          (when file
            (should (file-exists-p
                     (expand-file-name
                      (concat "../../src/dpurge/ime/" file ".el")
                      dpurge-test-directory)))))))))

(ert-deftest dpurge-vocabulary-sumerian-phrase-field-configures-ime ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=sux script=xsux}\n𒀭 {} [diŋir] = god\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "𒀭")
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "dpurge-sux"))))

(ert-deftest dpurge-vocabulary-sumerian-transcription-field-configures-ime ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=sux script=xsux}\n𒀭 {} [diŋir] = god\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "diŋir")
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal dpurge-markdown-current-input-method
                   "dpurge-sux-transcription"))))

(ert-deftest dpurge-vocabulary-urdu-phrase-field-configures-ime-and-direction ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=urd script=arab}\nسلام {} [salām] = peace\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "سلام")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "dpurge-urd"))
    (should (equal bidi-paragraph-direction 'right-to-left))))

(ert-deftest dpurge-vocabulary-urdu-transcription-field-configures-ime ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=urd script=arab}\nسلام {} [salām] = peace\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "salām")
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal dpurge-markdown-current-input-method
                   "dpurge-indic-postfix"))))

(ert-deftest dpurge-text-source-block-uses-phrase-ime ()
  (with-temp-buffer
    (insert "{start-text as=source lang=cmn script=hans}\n你好\n{end-text}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "pyim"))))

(ert-deftest dpurge-text-transcription-block-uses-transcription-ime ()
  (with-temp-buffer
    (insert "{start-text as=transcription lang=cmn script=hans}\nNǐ hǎo\n{end-text}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal dpurge-markdown-current-input-method "dpurge-zho-pinyin"))))

(ert-deftest dpurge-text-translation-and-grammar-blocks-clear-ime ()
  (dolist (as '("translation" "grammar"))
    (with-temp-buffer
      (insert (format "{start-text as=%s lang=cmn script=hans}\nabc\n{end-text}\n" as))
      (markdown-mode)
      (goto-char (point-min))
      (forward-line 1)
      (run-hooks 'markdown-mode-hook)
      (dpurge-markdown-update-block-mode)
      (should (equal dpurge-markdown-current-input-method nil)))))

(ert-deftest dpurge-dialog-source-block-uses-phrase-ime ()
  (with-temp-buffer
    (insert "{start-dialog as=source lang=cmn script=hans}\n@A:\n  你好\n{end-dialog}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 2)
    (run-hooks 'markdown-mode-hook)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "pyim"))))

(ert-deftest dpurge-dialog-transcription-block-uses-transcription-ime ()
  (with-temp-buffer
    (insert "{start-dialog as=transcription lang=cmn script=hans}\n@A:\n  Nǐ hǎo\n{end-dialog}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 2)
    (run-hooks 'markdown-mode-hook)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal dpurge-markdown-current-input-method "dpurge-zho-pinyin"))))

(ert-deftest dpurge-dialog-translation-and-grammar-blocks-clear-ime ()
  (dolist (as '("translation" "grammar"))
    (with-temp-buffer
      (insert (format "{start-dialog as=%s lang=cmn script=hans}\n@A:\n  abc\n{end-dialog}\n" as))
      (markdown-mode)
      (goto-char (point-min))
      (forward-line 2)
      (run-hooks 'markdown-mode-hook)
      (dpurge-markdown-update-block-mode)
      (should (equal dpurge-markdown-current-input-method nil)))))

(ert-deftest dpurge-models-cmn-hans-switch-imes-by-field ()
  (with-temp-buffer
    (insert "{start-models lang=cmn script=hans}\n越…越… [yuè… yuè…] = im bardziej…\n{end-models}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "越…越…")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "pyim"))
    (search-forward "yuè… yuè…")
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal dpurge-markdown-current-input-method "dpurge-zho-pinyin"))
    (search-forward "im bardziej")
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'translation))
    (should (equal dpurge-markdown-current-input-method nil))))

(ert-deftest dpurge-questions-cmn-hans-switch-imes-by-field ()
  (with-temp-buffer
    (insert "{start-questions lang=cmn script=hans}\n为什么 [wèishénme] = 因为 [yīnwèi]\n{end-questions}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "为什么")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'question))
    (should (equal dpurge-markdown-current-input-method "pyim"))
    (search-forward "wèishénme")
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'question-transcription))
    (should (equal dpurge-markdown-current-input-method "dpurge-zho-pinyin"))
    (search-forward "因为")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'answer))
    (should (equal dpurge-markdown-current-input-method "pyim"))
    (search-forward "yīnwèi")
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'answer-transcription))
    (should (equal dpurge-markdown-current-input-method "dpurge-zho-pinyin"))))

;; S4: §8.2 Direction / IME tests for parallel blocks

(defmacro dpurge-test-with-parallel-ime-buffer (lang script content &rest body)
  "Run BODY in a parallel block with LANG, SCRIPT, and CONTENT at line 1."
  (declare (indent 3))
  `(with-temp-buffer
     (insert (format "{start-parallel lang=%s script=%s}\n%s\n{end-parallel}\n"
                     ,lang ,script ,content))
     (markdown-mode)
     (goto-char (point-min))
     (forward-line 1)
     (run-hooks 'markdown-mode-hook)
     ,@body))

(ert-deftest dpurge-parallel-arabic-source-field-is-rtl ()
  (dpurge-test-with-parallel-ime-buffer "ara" "arab" "مرحبا\n---\nhello\n---\nmarhaba"
    (goto-char (point-min))
    (search-forward "مرحبا")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "dpurge-ara"))
    (should (equal bidi-paragraph-direction 'right-to-left))))

(ert-deftest dpurge-parallel-arabic-transcription-field-is-forced-ltr ()
  (dpurge-test-with-parallel-ime-buffer "ara" "arab" "مرحبا\n---\nhello\n---\nmarhaba"
    (goto-char (point-min))
    (search-forward "marhaba")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal dpurge-markdown-current-input-method "dpurge-semitic-postfix"))
    (should (equal bidi-paragraph-direction 'left-to-right))))

(ert-deftest dpurge-parallel-hebrew-transcription-field-is-forced-ltr ()
  (dpurge-test-with-parallel-ime-buffer "heb" "hebr" "שלום\n---\nhello\n---\nshalom"
    (goto-char (point-min))
    (search-forward "shalom")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal bidi-paragraph-direction 'left-to-right))))

(ert-deftest dpurge-parallel-latin-source-field-is-ltr ()
  (dpurge-test-with-parallel-ime-buffer "fra" "latn" "bonjour\n---\nhello\n---\nbonzhur"
    (goto-char (point-min))
    (search-forward "bonjour")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal bidi-paragraph-direction 'left-to-right))
    ;; Code-review addition (Phase 10): the RTL source tests (ara/heb below)
    ;; all assert the configured input-method too; this test previously
    ;; only checked field-state/direction, leaving a Latin-source IME
    ;; activation regression uncaught here specifically.
    (should (equal dpurge-markdown-current-input-method "dpurge-fra"))))

(ert-deftest dpurge-parallel-translation-field-clears-ime ()
  ;; In an RTL-source parallel block, translation -> IME nil AND direction LTR (D5)
  (dpurge-test-with-parallel-ime-buffer "ara" "arab" "مرحبا\n---\nhello\n---\nmarhaba"
    (goto-char (point-min))
    (search-forward "hello")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'translation))
    (should (equal dpurge-markdown-current-input-method nil))
    (should (equal bidi-paragraph-direction 'left-to-right))))

;; S4b: §8.2 parallel-dialog shares parallel's :field-directions schema
;; entry (dpurge-schema-config.el), so the same forced-LTR/RTL-source
;; behavior must hold under `{start-parallel-dialog}'.

(defmacro dpurge-test-with-parallel-dialog-ime-buffer (lang script content &rest body)
  "Run BODY in a parallel-dialog block with LANG, SCRIPT, and CONTENT at line 1."
  (declare (indent 3))
  `(with-temp-buffer
     (insert (format "{start-parallel-dialog lang=%s script=%s}\n%s\n{end-parallel-dialog}\n"
                     ,lang ,script ,content))
     (markdown-mode)
     (goto-char (point-min))
     (forward-line 1)
     (run-hooks 'markdown-mode-hook)
     ,@body))

(ert-deftest dpurge-parallel-dialog-arabic-source-field-is-rtl ()
  (dpurge-test-with-parallel-dialog-ime-buffer "ara" "arab" "مرحبا\n---\nhello\n---\nmarhaba"
    (goto-char (point-min))
    (search-forward "مرحبا")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal dpurge-markdown-current-input-method "dpurge-ara"))
    (should (equal bidi-paragraph-direction 'right-to-left))))

(ert-deftest dpurge-parallel-dialog-arabic-transcription-field-is-forced-ltr ()
  (dpurge-test-with-parallel-dialog-ime-buffer "ara" "arab" "مرحبا\n---\nhello\n---\nmarhaba"
    (goto-char (point-min))
    (search-forward "marhaba")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal bidi-paragraph-direction 'left-to-right))))

(ert-deftest dpurge-parallel-dialog-translation-field-clears-ime ()
  (dpurge-test-with-parallel-dialog-ime-buffer "ara" "arab" "مرحبا\n---\nhello\n---\nmarhaba"
    (goto-char (point-min))
    (search-forward "hello")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'translation))
    (should (equal dpurge-markdown-current-input-method nil))
    (should (equal bidi-paragraph-direction 'left-to-right))))

(ert-deftest dpurge-vocabulary-transcription-still-inherits-block-direction ()
  ;; Hebrew VOCABULARY transcription still yields right-to-left (SR-2/SR-7 non-regression:
  ;; the :field-directions override is parallel-only).
  (with-temp-buffer
    (insert "{start-vocabulary lang=heb script=hebr}\nשלום {} [šālōm] = peace\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "šālōm")
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal bidi-paragraph-direction 'right-to-left))))

(ert-deftest dpurge-models-transcription-still-inherits-block-direction ()
  ;; Code-review addition (Phase 10): SR-7 claims non-regression for
  ;; vocabulary/models/questions/text/dialog, but only vocabulary had an
  ;; explicit RTL-direction test. Hebrew MODELS transcription still yields
  ;; right-to-left -- the :field-directions override added for parallel
  ;; must be a structural no-op here too (models' schema entry has no
  ;; :field-directions key at all).
  (with-temp-buffer
    (insert "{start-models lang=heb script=hebr}\nשלום [šālōm] = peace\n{end-models}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (search-forward "šālōm")
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal bidi-paragraph-direction 'right-to-left))))
