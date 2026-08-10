(require 'ert)
(require 'derived)
(require 'cl-lib)

(unless (fboundp 'markdown-mode)
  (define-derived-mode markdown-mode text-mode "Markdown")
  (provide 'markdown-mode))

(unless (fboundp 'markdown-ts-mode)
  (define-derived-mode markdown-ts-mode text-mode "Markdown[TS]"))

(add-to-list 'load-path
             (expand-file-name "../../src/dpurge"
                               (file-name-directory (or load-file-name buffer-file-name))))
(add-to-list 'load-path
             (expand-file-name "../../src/dpurge/ime"
                               (file-name-directory (or load-file-name buffer-file-name))))

(require 'dpurge-lang)

(defconst dpurge-test-directory
  (file-name-directory (or load-file-name buffer-file-name default-directory))
  "Directory containing the dpurge test files.")

(defmacro dpurge-test-with-vocabulary-buffer (content &rest body)
  (declare (indent 1))
  `(with-temp-buffer
     (insert (concat "{start-vocabulary lang=heb script=hebr}\n"
                     ,content
                     "\n{end-vocabulary}\n"))
     (markdown-mode)
     (goto-char (point-min))
     (forward-line 1)
     (run-hooks 'markdown-mode-hook)
     ,@body))
