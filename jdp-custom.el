;; define and initialise package repositories
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; use-package to simplify the config file
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure 't)

;; Keyboard-centric user interface
(setq inhibit-startup-message t)
(tool-bar-mode -1)
;(menu-bar-mode -1)
;(scroll-bar-mode -1)
;(defalias 'yes-or-no-p 'y-or-n-p)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/input"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/public"))

(require 'jdp-lang)

;; dictionary tests
;; https://github.com/myrkr/dictionary-el



(setopt
  dictionary-search-interface 'help
  dictionary-default-strategy "prefix"
  dictionary-default-dictionary "fd-eng-hin"
  dictionary-server "dict.org")

(keymap-global-set "M-\\" #'dictionary-search)
;(global-set-key (kbd "C-c l") #'dictionary-lookup-definition)

;(setq dictionary-server "dict.org")
;(setq dictionary-use-single-buffer t)
;(setq dictionary-default-dictionary "fd-eng-ara")

;(add-hook 'text-mode-hook 'dictionary-tooltip-mode)
;(setq switch-to-buffer-obey-display-actions t)
;(add-to-list 'display-buffer-alist
;   '("^\\*Dictionary\\*" display-buffer-in-side-window
;     (side . right)
;     (window-width . 40)))

;(setq dictionary-tooltip-dictionary "fd-eng-ara")
;(global-dictionary-tooltip-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(pyim-basedict pyim popup use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
