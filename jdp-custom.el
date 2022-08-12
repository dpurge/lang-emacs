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
;(tool-bar-mode -1)
;(menu-bar-mode -1)
;(scroll-bar-mode -1)
(defalias 'yes-or-no-p 'y-or-n-p)

;; dark theme
(use-package exotica-theme
  :config (load-theme 'exotica t))

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/input"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/public"))

;; font size
(set-face-attribute 'default nil :height 160)

(when (member "SimSun" (font-family-list))
  (set-fontset-font "fontset-default" 'han (font-spec :family "SimSun" :size 26))
  (set-fontset-font "fontset-default" 'cjk-misc (font-spec :family "SimSun" :size 26)))

(when (member "MS Gothic" (font-family-list))
  (set-fontset-font "fontset-default" 'kana (font-spec :family "MS Gothic" :size 26)))

(when (member "Malgun Gothic" (font-family-list))
  (set-fontset-font "fontset-default" 'hangul (font-spec :family "Malgun Gothic" :size 26)))

(when (member "Leelawadee UI" (font-family-list))
  (set-fontset-font "fontset-default" 'khmer (font-spec :family "Leelawadee UI" :size 26))
  (set-fontset-font "fontset-default" 'lao (font-spec :family "Leelawadee UI" :size 26))
  (set-fontset-font "fontset-default" 'thai (font-spec :family "Leelawadee UI" :size 26)))

(when (member "Myanmar Text" (font-family-list))
  (set-fontset-font "fontset-default" 'burmese (font-spec :family "Myanmar Text" :size 26)))

(when (member "Ebrima" (font-family-list))
  (set-fontset-font "fontset-default" 'ethiopic (font-spec :family "Ebrima" :size 26)))

(when (member "Tahoma" (font-family-list))
  (set-fontset-font "fontset-default" 'hebrew (font-spec :family "Tahoma" :size 26)))

(when (member "Calibri" (font-family-list))
  (set-fontset-font "fontset-default" 'arabic (font-spec :family "Calibri" :size 26)))

(when (member "Nirmala UI" (font-family-list))
  (set-fontset-font "fontset-default" 'gujarati (font-spec :family "Nirmala UI" :size 26))
  (set-fontset-font "fontset-default" 'devanagari (font-spec :family "Nirmala UI" :size 26))
  (set-fontset-font "fontset-default" 'kannada (font-spec :family "Nirmala UI" :size 26))
  (set-fontset-font "fontset-default" 'malayalam (font-spec :family "Nirmala UI" :size 26))
  (set-fontset-font "fontset-default" 'oriya (font-spec :family "Nirmala UI" :size 26))
  (set-fontset-font "fontset-default" 'sinhala (font-spec :family "Nirmala UI" :size 26))
  (set-fontset-font "fontset-default" 'tamil (font-spec :family "Nirmala UI" :size 26))
  (set-fontset-font "fontset-default" 'telugu (font-spec :family "Nirmala UI" :size 26)))

(when (member "Microsoft Himalaya" (font-family-list))
  (set-fontset-font "fontset-default" 'tibetan (font-spec :family "Microsoft Himalaya" :size 32)))

(when (member "Times New Roman" (font-family-list))
  (set-fontset-font "fontset-default" 'greek (font-spec :family "Times New Roman" :size 26))
  (set-fontset-font "fontset-default" 'cyrillic (font-spec :family "Times New Roman" :size 26)))

;; Use MyPrivateFont for the Unicode private use area.
;(set-fontset-font "fontset-default"  '(#xe000 . #xf8ff) "MyPrivateFont")