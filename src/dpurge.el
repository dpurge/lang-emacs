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

(unless (package-installed-p 'markdown-mode)
  (package-refresh-contents)
  (package-install 'markdown-mode))
(unless (package-installed-p 'pyim)
  (package-refresh-contents)
  (package-install 'pyim))
(unless (package-installed-p 'pyim-basedict)
  (package-refresh-contents)
  (package-install 'pyim-basedict))
(require 'markdown-mode)
(require 'pyim nil t)
(require 'pyim-basedict nil t)

;; Keyboard-centric user interface
(setq inhibit-startup-message t)
(tool-bar-mode -1)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(defconst dpurge-base-font-height 160
  "Default UI font height in 1/10pt units.")

(defun dpurge-apply-base-font-size (&optional frame)
  "Apply the configured default font size to FRAME or the current frame."
  (set-face-attribute 'default frame :height dpurge-base-font-height))

(dpurge-apply-base-font-size)
(add-hook 'after-make-frame-functions #'dpurge-apply-base-font-size)

(autoload 'markdown-mode "markdown-mode" "Major mode for Markdown files." t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/dpurge"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/dpurge/ime"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/public"))

(require 'dpurge-lang)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
