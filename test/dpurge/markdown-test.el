(load (expand-file-name "test-setup.el"
                        (file-name-directory (or load-file-name buffer-file-name))))

(ert-deftest dpurge-markdown-edit-mode-activates-immediately-inside-vocabulary-block ()
  (with-temp-buffer
    (insert "before\n{start-vocabulary lang=heb script=hebr}\nshalom\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (search-forward "shalom")
    (backward-word)
    (run-hooks 'markdown-mode-hook)
    (should dpurge-markdown-edit-mode)
    (should (equal dpurge-markdown-block-type 'vocabulary))
    (should (equal dpurge-markdown-block-lang "heb"))
    (should (equal dpurge-markdown-block-script "hebr"))
    (should (eq (key-binding (kbd "C-c d"))
                #'dpurge-vocabulary-lookup))))

(ert-deftest dpurge-markdown-keybinding-exists-in-markdown-mode ()
  (with-temp-buffer
    (markdown-mode)
    (should (eq (key-binding (kbd "C-c d"))
                #'dpurge-vocabulary-lookup))
    (should (eq (key-binding (kbd "TAB"))
                #'dpurge-markdown-tab))))

(ert-deftest dpurge-markdown-vocabulary-block-detection-works ()
  (with-temp-buffer
    (insert "before\n{start-vocabulary lang=heb script=hebr}\nshalom\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (search-forward "shalom")
    (backward-word)
    (should (equal (dpurge-markdown-current-block)
                   '(:type vocabulary :lang "heb" :script "hebr" :as nil)))))

(ert-deftest dpurge-vocabulary-lookup-uses-only-phrase-field ()
  (let (captured)
    (cl-letf (((symbol-function 'dpurge-dictionary-lookup)
               (lambda (word lang script)
                 (setq captured (list word lang script)))))
      (dpurge-test-with-vocabulary-buffer "שלום {} [šālōm] = peace (note)"
        (search-forward "šālōm")
        (dpurge-vocabulary-lookup)
        (should (equal captured '("שלום" "heb" "hebr")))))))

(ert-deftest dpurge-markdown-ts-edit-mode-activates-immediately-inside-vocabulary-block ()
  (with-temp-buffer
    (insert "before\n{start-vocabulary lang=heb script=hebr}\nshalom\n{end-vocabulary}\n")
    (markdown-ts-mode)
    (goto-char (point-min))
    (search-forward "shalom")
    (backward-word)
    (run-hooks 'markdown-ts-mode-hook)
    (should dpurge-markdown-edit-mode)
    (should (eq (key-binding (kbd "C-c d"))
                #'dpurge-vocabulary-lookup))))

(ert-deftest dpurge-markdown-keybinding-exists-in-markdown-ts-mode ()
  (with-temp-buffer
    (markdown-ts-mode)
    (should (eq (key-binding (kbd "C-c d"))
                #'dpurge-vocabulary-lookup))))

(ert-deftest dpurge-vocabulary-tab-on-end-marker-opens-new-entry-line ()
  (with-temp-buffer
    (insert "{start-vocabulary lang=heb script=hebr}\n{end-vocabulary}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal (buffer-string)
                   "{start-vocabulary lang=heb script=hebr}\n\n{end-vocabulary}\n"))
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'grammar))
    (should (equal (buffer-string)
                   "{start-vocabulary lang=heb script=hebr}\n{}\n{end-vocabulary}\n"))))

(ert-deftest dpurge-vocabulary-tab-on-empty-line-adds-grammar ()
  (dpurge-test-with-vocabulary-buffer ""
    (dpurge-vocabulary-next-field)
    (should (eq dpurge-markdown-current-field-state 'grammar))
    (should (equal (buffer-string)
                   "{start-vocabulary lang=heb script=hebr}\n{}\n{end-vocabulary}\n"))))

(ert-deftest dpurge-vocabulary-tab-after-phrase-inserts-grammar ()
  (dpurge-test-with-vocabulary-buffer "推荐"
    (goto-char (line-end-position))
    (dpurge-vocabulary-next-field)
    (should (eq dpurge-markdown-current-field-state 'grammar))
    (should (equal (buffer-substring-no-properties
                    (line-beginning-position)
                    (line-end-position))
                   "推荐 {}"))
    (should (eq (char-before) ?{))))

(ert-deftest dpurge-vocabulary-tab-on-empty-grammar-removes-it-and-adds-transcription ()
  (dpurge-test-with-vocabulary-buffer "推荐 {}"
    (search-forward "{")
    (dpurge-vocabulary-next-field)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal (buffer-substring-no-properties
                    (line-beginning-position)
                    (line-end-position))
                   "推荐 []"))))

(ert-deftest dpurge-vocabulary-tab-on-empty-line-then-empty-grammar-adds-transcription-without-leading-space ()
  (dpurge-test-with-vocabulary-buffer ""
    (dpurge-vocabulary-next-field)
    (dpurge-vocabulary-next-field)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal (buffer-substring-no-properties
                    (line-beginning-position)
                    (line-end-position))
                   "[]"))))

(ert-deftest dpurge-vocabulary-tab-on-empty-transcription-removes-it-and-adds-translation ()
  (dpurge-test-with-vocabulary-buffer "推荐 [ ]"
    (search-forward "[")
    (forward-char)
    (dpurge-vocabulary-next-field)
    (should (eq dpurge-markdown-current-field-state 'translation))
    (should (equal (buffer-substring-no-properties
                    (line-beginning-position)
                    (line-end-position))
                   "推荐 = "))))

(ert-deftest dpurge-vocabulary-tab-on-empty-line-cycle-adds-translation-without-leading-space ()
  (dpurge-test-with-vocabulary-buffer ""
    (dotimes (_ 3)
      (dpurge-vocabulary-next-field))
    (should (eq dpurge-markdown-current-field-state 'translation))
    (should (equal (buffer-substring-no-properties
                    (line-beginning-position)
                    (line-end-position))
                   "= "))
    (should (eq (char-before) 32))))

(ert-deftest dpurge-vocabulary-tab-in-translation-adds-notes ()
  (dpurge-test-with-vocabulary-buffer "推荐 = polecać"
    (goto-char (line-end-position))
    (dpurge-vocabulary-next-field)
    (should (eq dpurge-markdown-current-field-state 'notes))
    (should (equal (buffer-substring-no-properties
                    (line-beginning-position)
                    (line-end-position))
                   "推荐 = polecać ()"))
    (should (eq (char-before) 40))))

(ert-deftest dpurge-vocabulary-empty-line-cycle-does-not-return-to-grammar-after-translation ()
  (dpurge-test-with-vocabulary-buffer ""
    (dotimes (_ 4)
      (dpurge-vocabulary-next-field))
    (should (eq dpurge-markdown-current-field-state 'notes))
    (should (equal (buffer-substring-no-properties
                    (line-beginning-position)
                    (line-end-position))
                   "= ()"))))

(ert-deftest dpurge-vocabulary-tab-on-empty-notes-removes-them-and-finishes-line ()
  (dpurge-test-with-vocabulary-buffer "推荐 = polecać ()"
    (search-forward "(")
    (dpurge-vocabulary-next-field)
    (should (eq dpurge-markdown-current-field-state 'done))
    (should (= (point) (line-end-position)))
    (should (equal (buffer-substring-no-properties
                    (line-beginning-position)
                    (line-end-position))
                   "推荐 = polecać"))))

(ert-deftest dpurge-model-tab-on-end-marker-opens-new-entry-line ()
  (with-temp-buffer
    (insert "{start-models lang=cmn script=hans}\n{end-models}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal (buffer-string)
                   "{start-models lang=cmn script=hans}\n\n{end-models}\n"))
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal (buffer-string)
                   "{start-models lang=cmn script=hans}\n[]\n{end-models}\n"))))

(ert-deftest dpurge-model-tab-cycle-without-grammar ()
  (with-temp-buffer
    (insert "{start-models lang=cmn script=hans}\n从…转向…\n{end-models}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (goto-char (line-end-position))
    (dpurge-model-next-field)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal (buffer-substring-no-properties
                    (line-beginning-position)
                    (line-end-position))
                   "从…转向… []"))
    (dpurge-model-next-field)
    (should (eq dpurge-markdown-current-field-state 'translation))
    (should (equal (buffer-substring-no-properties
                    (line-beginning-position)
                    (line-end-position))
                   "从…转向… = "))))

(ert-deftest dpurge-questions-tab-on-end-marker-opens-new-entry-line ()
  (with-temp-buffer
    (insert "{start-questions lang=cmn script=hans}\n{end-questions}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal (buffer-string)
                   "{start-questions lang=cmn script=hans}\n\n{end-questions}\n"))
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'question-transcription))
    (should (equal (buffer-string)
                   "{start-questions lang=cmn script=hans}\n[]\n{end-questions}\n"))))

(ert-deftest dpurge-questions-tab-cycle-with-answer-fields ()
  (with-temp-buffer
    (insert "{start-questions lang=cmn script=hans}\n为什么\n{end-questions}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (goto-char (line-end-position))
    (dpurge-questions-next-field)
    (should (eq dpurge-markdown-current-field-state 'question-transcription))
    (should (equal (buffer-substring-no-properties
                    (line-beginning-position)
                    (line-end-position))
                   "为什么 []"))
    (dpurge-questions-next-field)
    (should (eq dpurge-markdown-current-field-state 'answer))
    (should (equal (buffer-substring-no-properties
                    (line-beginning-position)
                    (line-end-position))
                   "为什么 = "))
    (dpurge-questions-next-field)
    (should (eq dpurge-markdown-current-field-state 'answer-transcription))
    (should (equal (buffer-substring-no-properties
                    (line-beginning-position)
                    (line-end-position))
                   "为什么 = []"))))
