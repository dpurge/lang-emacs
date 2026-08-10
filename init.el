;; INSTALLATION
;; cd %APPDATA%\.emacs.d\
;; mklink /D input D:\src\github.com\dpurge\lang-emacs\input
;; mklink /D public D:\src\github.com\dpurge\lang-emacs\public
;; mklink /D dpurge C:\jdp\src\github.com\dpurge\lang-emacs\dpurge
;; mklink dpurge.el C:\jdp\src\github.com\dpurge\lang-emacs\dpurge.el
;; mklink jdp-custom.el D:\src\github.com\dpurge\lang-emacs\jdp-custom.el
;; mklink init.el D:\src\github.com\dpurge\lang-emacs\init.el

;; Custom init file
(setq custom-file (expand-file-name "dpurge.el" user-emacs-directory))
(when (file-exists-p custom-file) (load custom-file))
