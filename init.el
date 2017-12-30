;; INSTALLATION
;; cd %APPDATA%\.emacs.d\
;; mklink /D input D:\src\gitea\emacs\input
;; mklink init.el D:\src\gitea\emacs\init.el

(set-face-attribute 'default nil :height 160)
;(setq-default bidi-display-reordering t)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/input"))

(require 'jdp-indic-postfix)
(require 'jdp-semitic-postfix)