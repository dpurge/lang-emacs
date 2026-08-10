(require 'markdown-mode)
(require 'dpurge-dictionary)
(require 'dpurge-markdown)

(add-to-list 'auto-mode-alist
    '("\\.md\\'" . markdown-mode))

;; (global-set-key (kbd "C-c d") 'dpurge-dictionary-lookup-at-point)
(define-key dpurge-markdown-edit-mode-map
  (kbd "C-c d")
  #'dpurge-vocabulary-lookup)

(provide 'dpurge-lang)