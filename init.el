;; INSTALLATION
;; cd %APPDATA%\.emacs.d\
;; mklink /D input D:\src\github.com\dpurge\lang-emacs\input
;; mklink /D public D:\src\github.com\dpurge\lang-emacs\public
;; mklink jdp-custom.el D:\src\github.com\dpurge\lang-emacs\jdp-custom.el
;; mklink init.el D:\src\github.com\dpurge\lang-emacs\init.el

;; Custom init file
(setq custom-file (expand-file-name "jdp-custom.el" user-emacs-directory))
(when (file-exists-p custom-file) (load custom-file))
