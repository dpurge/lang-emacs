;; INSTALLATION
;; cd %APPDATA%\.emacs.d\
;; mklink /D input D:\src\github.com\dpurge\lang-emacs\input
;; mklink /D public D:\src\github.com\dpurge\lang-emacs\public
;; mklink init.el D:\src\github.com\dpurge\lang-emacs\init.el


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(set-face-attribute 'default nil :height 160)
;(set-face-attribute 'mode-line nil :height 160)

(setq inhibit-splash-screen t)
(cua-mode 1)
(transient-mark-mode 1)
(setq cua-keep-region-after-copy t)
(recentf-mode)

(global-set-key [C-tab] 'other-window)
(global-set-key [M-f4] 'save-buffers-kill-emacs)
(global-set-key "\C-a" 'mark-whole-buffer)
(global-set-key "\C-f" 'isearch-forward)
(global-set-key "\C-o" 'find-file)
(global-set-key "\C-s" 'save-buffer)
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)

(global-set-key (vector (list 'control mouse-wheel-down-event)) 'text-scale-increase)
(global-set-key (vector (list 'control mouse-wheel-up-event))   'text-scale-decrease)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/input"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/public"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/public/eim"))

(require 'jdp-lang)
;(require 'jdp-json)
(require 'jdp-lang-mode)
(require 'jdp-util)

(global-set-key (kbd "<f2>") 'set-jdp-lang) ; F2

;; testing

(global-set-key (kbd "M-#") 'lookup-word)
(global-set-key (kbd "M-=") 'get-selected-text)
(global-set-key (kbd "<f4>") 'jdp-apply-json-format)
(global-set-key (kbd "<f5>") 'jdp-set-json-format-pattern)
(global-set-key (kbd "<f6>") 'lookup-word)
(global-set-key (kbd "<f9>") 'wrap-region-anki-closure)


;(add-hook 'jdp-lang-mode-hook
;  '(lambda ()
;    (define-key jdp-lang-mode-map "\C-m" 'newline-and-indent)
;    (define-key jdp-lang-mode-map "\M-\r" 'jdp-lang-add-record)
;    (define-key jdp-lang-mode-map (kbd "C-<tab>") 'jdp-lang-next-field)
;    (define-key jdp-lang-mode-map (kbd "C-S-<tab>") 'jdp-lang-prev-field)
;  ))


