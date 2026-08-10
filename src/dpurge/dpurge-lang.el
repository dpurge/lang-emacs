(require 'markdown-mode)
(require 'dpurge-dictionary)
(require 'dpurge-markdown)

(add-to-list 'auto-mode-alist
    '("\\.md\\'" . markdown-mode))

(defvar dpurge-markdown-tab-fallback
  (lookup-key markdown-mode-map (kbd "TAB")))

(defvar dpurge-markdown-ts-tab-fallback
  (and (boundp 'markdown-ts-mode-map)
       (lookup-key markdown-ts-mode-map (kbd "TAB"))))

;; (global-set-key (kbd "C-c d") 'dpurge-dictionary-lookup-at-point)
(define-key dpurge-markdown-edit-mode-map
  (kbd "C-c d")
  #'dpurge-vocabulary-lookup)
(define-key markdown-mode-map
  (kbd "C-c d")
  #'dpurge-vocabulary-lookup)
(define-key markdown-mode-map
  (kbd "TAB")
  #'dpurge-markdown-tab)
(define-key markdown-mode-map
  (kbd "<tab>")
  #'dpurge-markdown-tab)
(when (boundp 'markdown-ts-mode-map)
  (define-key markdown-ts-mode-map
    (kbd "C-c d")
    #'dpurge-vocabulary-lookup)
  (define-key markdown-ts-mode-map
    (kbd "TAB")
    #'dpurge-markdown-tab)
  (define-key markdown-ts-mode-map
    (kbd "<tab>")
    #'dpurge-markdown-tab))

(provide 'dpurge-lang)