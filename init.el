;; INSTALLATION
;; cd %APPDATA%\.emacs.d\
;; mklink /D input D:\src\gitea\emacs\input
;; mklink init.el D:\src\gitea\emacs\init.el


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
(require 'jdp-lang)

(global-set-key (kbd "<f2>") 'set-jdp-lang) ; F2
