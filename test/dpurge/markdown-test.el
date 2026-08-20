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

;; S3: §8.1 Field detection tests

(defmacro dpurge-test-with-parallel-buffer (lang script content &rest body)
  "Run BODY in a parallel block buffer with LANG, SCRIPT, and CONTENT."
  (declare (indent 3))
  `(with-temp-buffer
     (insert (format "{start-parallel lang=%s script=%s}\n%s\n{end-parallel}\n"
                     ,lang ,script ,content))
     (markdown-mode)
     (goto-char (point-min))
     (forward-line 1)
     (run-hooks 'markdown-mode-hook)
     ,@body))

(ert-deftest dpurge-parallel-field-detection-source ()
  (dpurge-test-with-parallel-buffer "ara" "arab" "مرحبا\n---\nhello\n---\nmarhaba"
    (goto-char (point-min))
    (search-forward "مرحبا")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))))

(ert-deftest dpurge-parallel-field-detection-translation ()
  (dpurge-test-with-parallel-buffer "ara" "arab" "مرحبا\n---\nhello\n---\nmarhaba"
    (goto-char (point-min))
    (search-forward "hello")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'translation))))

(ert-deftest dpurge-parallel-field-detection-transcription ()
  (dpurge-test-with-parallel-buffer "ara" "arab" "مرحبا\n---\nhello\n---\nmarhaba"
    (goto-char (point-min))
    (search-forward "marhaba")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))))

(ert-deftest dpurge-parallel-field-detection-fourth-field-absorbed ()
  ;; Three `---' lines; point after the third -> still 'transcription (D4 cap)
  (dpurge-test-with-parallel-buffer "ara" "arab" "source\n---\ntrans\n---\nxscr\n---\nextra"
    (goto-char (point-min))
    (search-forward "extra")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))))

(ert-deftest dpurge-parallel-field-detection-second-record ()
  ;; Two `===' separated records; point in second record's source -> 'phrase
  (with-temp-buffer
    (insert "{start-parallel lang=ara script=arab}\nfirst\n---\nfirst-tr\n===\nsecond\n---\nsecond-tr\n{end-parallel}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (goto-char (point-min))
    (search-forward "second")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))))

(ert-deftest dpurge-parallel-field-detection-empty-translation ()
  ;; source / --- / (blank) / --- / xscr
  ;; point on blank line -> 'translation; point on xscr -> 'transcription
  (with-temp-buffer
    (insert "{start-parallel lang=ara script=arab}\nsource\n---\n\n---\nxscr\n{end-parallel}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    ;; point on the blank translation line (4th line of buffer = line 4 from start)
    (goto-char (point-min))
    (forward-line 3)  ; moves to the blank line after "---"
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'translation))
    ;; point on xscr -> 'transcription
    (goto-char (point-min))
    (search-forward "xscr")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))))

(ert-deftest dpurge-parallel-field-detection-ignores-fuzzy-breaks ()
  ;; `***' and `----' between source and translation are NOT boundaries;
  ;; only lone `---' counts (SR-1 exact-match).
  (with-temp-buffer
    (insert "{start-parallel lang=ara script=arab}\nsource\n***\n----\n---\ntranslation\n{end-parallel}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (goto-char (point-min))
    (search-forward "translation")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    ;; Only one real `---', so this is field index 1 -> 'translation
    (should (eq dpurge-markdown-current-field-state 'translation))))

;; S2: §8.4 Structured-block registration

(ert-deftest dpurge-markdown-structured-block-p-includes-parallel ()
  (should (dpurge-markdown-structured-block-p 'parallel))
  (should-not (dpurge-markdown-structured-block-p 'text))
  (should-not (dpurge-markdown-structured-block-p 'dialog)))

(ert-deftest dpurge-parallel-edit-mode-activates-inside-block ()
  (with-temp-buffer
    (insert "{start-parallel lang=ara script=arab}\nمرحبا\n{end-parallel}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (should dpurge-markdown-edit-mode)
    (should (eq dpurge-markdown-block-type 'parallel))
    (should (equal dpurge-markdown-block-lang "ara"))
    (should (equal dpurge-markdown-block-script "arab"))))

;; S5: §8.3 TAB tests

(ert-deftest dpurge-parallel-tab-source-inserts-separator-and-enters-translation ()
  (dpurge-test-with-parallel-buffer "ara" "arab" "مرحبا"
    (goto-char (line-end-position))
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'translation))
    (should (equal (buffer-string)
                   "{start-parallel lang=ara script=arab}\nمرحبا\n---\n\n{end-parallel}\n"))))

(ert-deftest dpurge-parallel-tab-translation-inserts-separator-and-enters-transcription ()
  (dpurge-test-with-parallel-buffer "ara" "arab" "مرحبا\n---\nhello"
    (goto-char (point-min))
    (search-forward "hello")
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal (buffer-string)
                   "{start-parallel lang=ara script=arab}\nمرحبا\n---\nhello\n---\n\n{end-parallel}\n"))))

(ert-deftest dpurge-parallel-tab-transcription-finishes ()
  (dpurge-test-with-parallel-buffer "ara" "arab" "مرحبا\n---\nhello\n---\nmarhaba"
    (goto-char (point-min))
    (search-forward "marhaba")
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'done))
    ;; No separator inserted; buffer is unchanged
    (should (equal (buffer-string)
                   "{start-parallel lang=ara script=arab}\nمرحبا\n---\nhello\n---\nmarhaba\n{end-parallel}\n"))))

(ert-deftest dpurge-parallel-tab-mid-field-does-not-split-content ()
  ;; Regression test (code-review): point on FIRST line of a 2-line source field.
  ;; TAB must insert `---' AFTER the SECOND line, not between them.
  (dpurge-test-with-parallel-buffer "ara" "arab" "first line\nsecond line"
    ;; point is already at beginning of "first line" after setup
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'translation))
    ;; Both source lines must stay in the source field; separator after "second line"
    (should (equal (buffer-string)
                   "{start-parallel lang=ara script=arab}\nfirst line\nsecond line\n---\n\n{end-parallel}\n"))))

(ert-deftest dpurge-parallel-tab-finishes-multiline-transcription-at-real-end ()
  ;; Code-review addition: `dpurge-markdown-finish-field-editing' is shared
  ;; with vocabulary/models/questions and only moves to (line-end-position)
  ;; of point's own line -- correct for their single-line fields, wrong for
  ;; a multi-line transcription. TAB pressed on the FIRST line of a 2-line
  ;; transcription must still finish with point at the END of the SECOND
  ;; (real last) line, not mid-field, and must not insert anything.
  (dpurge-test-with-parallel-buffer "ara" "arab"
      "مرحبا\n---\nhello\n---\ntranscription line one\ntranscription line two"
    (goto-char (point-min))
    (search-forward "transcription line one")
    (beginning-of-line)
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'done))
    (should (looking-at-p "\n{end-parallel}"))
    (should (equal (buffer-string)
                   (concat "{start-parallel lang=ara script=arab}\n"
                           "مرحبا\n---\nhello\n---\n"
                           "transcription line one\ntranscription line two"
                           "\n{end-parallel}\n")))))

;; S6b: §8.3 end-marker opens first record

(ert-deftest dpurge-parallel-tab-on-end-marker-opens-first-record ()
  ;; TAB on `{end-parallel}' in an empty block opens a blank source line, field 'phrase.
  (with-temp-buffer
    (insert "{start-parallel lang=ara script=arab}\n{end-parallel}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal (buffer-string)
                   "{start-parallel lang=ara script=arab}\n\n{end-parallel}\n"))))

(ert-deftest dpurge-parallel-tab-on-end-marker-with-existing-record-inserts-separator ()
  ;; Code-review addition: SPEC §6.4's SECOND behavior (only the empty-block
  ;; case above was covered before). TAB on `{end-parallel}' when a record
  ;; already exists must insert a `===' separator before opening the new
  ;; blank line, so records stay delimited -- not just open a blank line
  ;; directly after the existing record's last content line.
  (with-temp-buffer
    (insert "{start-parallel lang=ara script=arab}\nمرحبا\n{end-parallel}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 2)
    (run-hooks 'markdown-mode-hook)
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal (buffer-string)
                   "{start-parallel lang=ara script=arab}\nمرحبا\n===\n\n{end-parallel}\n"))))

;; S6a: §8.3 new-record + M-RET dispatcher tests

(ert-deftest dpurge-parallel-new-record-inserts-record-separator ()
  ;; From translation field, M-RET inserts `===' and enters 'phrase
  ;; (a 2-field record closed without transcription).
  (dpurge-test-with-parallel-buffer "ara" "arab" "مرحبا\n---\nhello"
    (goto-char (point-min))
    (search-forward "hello")
    (dpurge-markdown-update-block-mode)
    (dpurge-parallel-new-record)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal (buffer-string)
                   "{start-parallel lang=ara script=arab}\nمرحبا\n---\nhello\n\n===\n\n\n{end-parallel}\n"))))

(ert-deftest dpurge-parallel-meta-ret-dispatches-to-new-record-in-parallel-block ()
  ;; Code-review addition (Phase 10): the companion of
  ;; `dpurge-parallel-meta-ret-noop-in-vocabulary' below -- that test proves
  ;; the dispatcher's ELSE branch (fallthrough) actually fires for
  ;; non-parallel blocks; THIS test proves the IF branch actually fires for
  ;; parallel blocks, by calling `dpurge-markdown-meta-ret' itself (not
  ;; `dpurge-parallel-new-record' directly, which every other record test
  ;; does). A regression that inverted or removed the dispatcher's `if'
  ;; would make M-RET a no-op on parallel blocks and this test would catch
  ;; it, even though `dpurge-parallel-new-record-inserts-record-separator'
  ;; above would still pass (it bypasses the dispatcher entirely).
  (dpurge-test-with-parallel-buffer "ara" "arab" "مرحبا\n---\nhello"
    (goto-char (point-min))
    (search-forward "hello")
    (dpurge-markdown-update-block-mode)
    (dpurge-markdown-meta-ret)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal (buffer-string)
                   "{start-parallel lang=ara script=arab}\nمرحبا\n---\nhello\n\n===\n\n\n{end-parallel}\n"))))

;; S7: §8.x parallel-dialog shares parallel's block grammar/behavior exactly
;; (same row/field separators, same TAB/M-RET/field-detection code paths --
;; see dpurge-markdown-block-type memq widenings). Low-level parsing edge
;; cases (fuzzy-break rejection, 4th-field absorption, mid-field TAB, etc.)
;; are exercised once by the `parallel' suite above against the SAME shared
;; functions (`dpurge-parallel-current-field'/`-field-start'/`-field-end');
;; this section instead covers every call site that had to widen its type
;; check from `parallel' to `(parallel parallel-dialog)'.

(defmacro dpurge-test-with-parallel-dialog-buffer (lang script content &rest body)
  "Run BODY in a parallel-dialog block buffer with LANG, SCRIPT, and CONTENT."
  (declare (indent 3))
  `(with-temp-buffer
     (insert (format "{start-parallel-dialog lang=%s script=%s}\n%s\n{end-parallel-dialog}\n"
                     ,lang ,script ,content))
     (markdown-mode)
     (goto-char (point-min))
     (forward-line 1)
     (run-hooks 'markdown-mode-hook)
     ,@body))

(ert-deftest dpurge-parallel-dialog-field-detection-source ()
  (dpurge-test-with-parallel-dialog-buffer "ara" "arab" "مرحبا\n---\nhello\n---\nmarhaba"
    (goto-char (point-min))
    (search-forward "مرحبا")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))))

(ert-deftest dpurge-parallel-dialog-field-detection-translation ()
  (dpurge-test-with-parallel-dialog-buffer "ara" "arab" "مرحبا\n---\nhello\n---\nmarhaba"
    (goto-char (point-min))
    (search-forward "hello")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'translation))))

(ert-deftest dpurge-parallel-dialog-field-detection-transcription ()
  (dpurge-test-with-parallel-dialog-buffer "ara" "arab" "مرحبا\n---\nhello\n---\nmarhaba"
    (goto-char (point-min))
    (search-forward "marhaba")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'transcription))))

(ert-deftest dpurge-parallel-dialog-field-detection-second-record ()
  ;; Proves the shared `===' boundary regex still resolves record
  ;; boundaries correctly under the `{start-parallel-dialog...}' opener.
  (with-temp-buffer
    (insert "{start-parallel-dialog lang=ara script=arab}\nfirst\n---\nfirst-tr\n===\nsecond\n---\nsecond-tr\n{end-parallel-dialog}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (goto-char (point-min))
    (search-forward "second")
    (backward-char)
    (dpurge-markdown-update-block-mode)
    (should (eq dpurge-markdown-current-field-state 'phrase))))

(ert-deftest dpurge-markdown-structured-block-p-includes-parallel-dialog ()
  (should (dpurge-markdown-structured-block-p 'parallel-dialog)))

(ert-deftest dpurge-parallel-dialog-edit-mode-activates-inside-block ()
  (with-temp-buffer
    (insert "{start-parallel-dialog lang=ara script=arab}\nمرحبا\n{end-parallel-dialog}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (should dpurge-markdown-edit-mode)
    (should (eq dpurge-markdown-block-type 'parallel-dialog))
    (should (equal dpurge-markdown-block-lang "ara"))
    (should (equal dpurge-markdown-block-script "arab"))))

(ert-deftest dpurge-parallel-dialog-tab-source-inserts-separator-and-enters-translation ()
  (dpurge-test-with-parallel-dialog-buffer "ara" "arab" "مرحبا"
    (goto-char (line-end-position))
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'translation))
    (should (equal (buffer-string)
                   "{start-parallel-dialog lang=ara script=arab}\nمرحبا\n---\n\n{end-parallel-dialog}\n"))))

(ert-deftest dpurge-parallel-dialog-tab-translation-inserts-separator-and-enters-transcription ()
  (dpurge-test-with-parallel-dialog-buffer "ara" "arab" "مرحبا\n---\nhello"
    (goto-char (point-min))
    (search-forward "hello")
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'transcription))
    (should (equal (buffer-string)
                   "{start-parallel-dialog lang=ara script=arab}\nمرحبا\n---\nhello\n---\n\n{end-parallel-dialog}\n"))))

(ert-deftest dpurge-parallel-dialog-tab-transcription-finishes ()
  (dpurge-test-with-parallel-dialog-buffer "ara" "arab" "مرحبا\n---\nhello\n---\nmarhaba"
    (goto-char (point-min))
    (search-forward "marhaba")
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'done))
    (should (equal (buffer-string)
                   "{start-parallel-dialog lang=ara script=arab}\nمرحبا\n---\nhello\n---\nmarhaba\n{end-parallel-dialog}\n"))))

(ert-deftest dpurge-parallel-dialog-tab-on-end-marker-opens-first-record ()
  ;; Proves `dpurge-markdown-end-marker-line-p' recognizes
  ;; `{end-parallel-dialog}' (it did not before this change).
  (with-temp-buffer
    (insert "{start-parallel-dialog lang=ara script=arab}\n{end-parallel-dialog}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 1)
    (run-hooks 'markdown-mode-hook)
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal (buffer-string)
                   "{start-parallel-dialog lang=ara script=arab}\n\n{end-parallel-dialog}\n"))))

(ert-deftest dpurge-parallel-dialog-tab-on-end-marker-with-existing-record-inserts-separator ()
  (with-temp-buffer
    (insert "{start-parallel-dialog lang=ara script=arab}\nمرحبا\n{end-parallel-dialog}\n")
    (markdown-mode)
    (goto-char (point-min))
    (forward-line 2)
    (run-hooks 'markdown-mode-hook)
    (call-interactively #'dpurge-markdown-tab)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal (buffer-string)
                   "{start-parallel-dialog lang=ara script=arab}\nمرحبا\n===\n\n{end-parallel-dialog}\n"))))

(ert-deftest dpurge-parallel-dialog-new-record-inserts-record-separator ()
  (dpurge-test-with-parallel-dialog-buffer "ara" "arab" "مرحبا\n---\nhello"
    (goto-char (point-min))
    (search-forward "hello")
    (dpurge-markdown-update-block-mode)
    (dpurge-parallel-new-record)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal (buffer-string)
                   "{start-parallel-dialog lang=ara script=arab}\nمرحبا\n---\nhello\n\n===\n\n\n{end-parallel-dialog}\n"))))

(ert-deftest dpurge-parallel-dialog-meta-ret-dispatches-to-new-record ()
  ;; Companion of `dpurge-parallel-meta-ret-dispatches-to-new-record-in-parallel-block':
  ;; proves the M-RET dispatcher's IF branch also fires for parallel-dialog
  ;; blocks, not just plain parallel ones.
  (dpurge-test-with-parallel-dialog-buffer "ara" "arab" "مرحبا\n---\nhello"
    (goto-char (point-min))
    (search-forward "hello")
    (dpurge-markdown-update-block-mode)
    (dpurge-markdown-meta-ret)
    (should (eq dpurge-markdown-current-field-state 'phrase))
    (should (equal (buffer-string)
                   "{start-parallel-dialog lang=ara script=arab}\nمرحبا\n---\nhello\n\n===\n\n\n{end-parallel-dialog}\n"))))

(ert-deftest dpurge-parallel-dialog-next-field-name-uses-own-schema ()
  ;; Proves `dpurge-parallel-next-field' looks up the schema for the ACTUAL
  ;; block type instead of the hardcoded `parallel' symbol (regression guard
  ;; for the fix that made this generic).
  (should (eq (dpurge-markdown-next-field-name 'parallel-dialog 'phrase) 'translation))
  (should (eq (dpurge-markdown-next-field-name 'parallel-dialog 'translation) 'transcription))
  (should (eq (dpurge-markdown-next-field-name 'parallel-dialog 'transcription) 'done)))

(ert-deftest dpurge-parallel-meta-ret-noop-in-vocabulary ()
  ;; Genuine SR-7 proof: in a vocabulary block, `dpurge-markdown-meta-ret'
  ;; must actually FALL THROUGH to markdown-mode's own M-RET, not just fail
  ;; to insert `==='. (Code-review fix: the original version of this test
  ;; only checked that `dpurge-parallel-new-record' errors on its own
  ;; type guard when called directly -- it never invoked the dispatcher, so
  ;; a dispatcher regression, e.g. removing the `if' and always calling
  ;; `dpurge-parallel-new-record', would still have passed.)
  ;;
  ;; The batch test harness's fake `markdown-mode' (test-setup.el) has no
  ;; real M-RET binding, since the real markdown-mode.el package isn't
  ;; loaded in batch -- `(key-binding (kbd "M-RET"))' is nil there, and
  ;; `call-interactively' on nil would error. So we temporarily bind a
  ;; marker command to `markdown-mode-map' to observe the fallthrough
  ;; branch actually firing, restoring the prior binding afterward.
  (dpurge-test-with-vocabulary-buffer "שלום"
    (let ((buf-before (buffer-string))
          (marker-ran nil)
          (had-binding (lookup-key markdown-mode-map (kbd "M-RET"))))
      (unwind-protect
          (progn
            (define-key markdown-mode-map (kbd "M-RET")
              (lambda () (interactive) (setq marker-ran t)))
            (dpurge-markdown-meta-ret)
            (should marker-ran)
            (should (equal (buffer-string) buf-before))
            (should (eq dpurge-markdown-block-type 'vocabulary)))
        (if (integerp had-binding)
            (define-key markdown-mode-map (kbd "M-RET") nil)
          (define-key markdown-mode-map (kbd "M-RET") had-binding))))))
