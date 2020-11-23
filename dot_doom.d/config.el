;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Enable mouse integration
(require 'mouse)
(xterm-mouse-mode t)
(setq mouse-sel-mode t)

;; Disable tabs indentation
(setq-default indent-tabs-mode nil)

;; Auto completion
(setq lsp-gopls-staticcheck t)
(setq lsp-eldoc-render-all t)
(setq lsp-gopls-complete-unimported t)

;; Editor settings
(setq
 doom-font (font-spec :family "JetBrains Mono" :size 16)
 projectile-project-search-path '("~/code" "~/go/src")
 )

;; Define keys
(require 'expand-region)
(evil-define-key '(normal visual emacs) 'global (kbd "C-S-<right>") 'er/expand-region)
(evil-define-key '(normal visual emacs) 'global (kbd "C-S-<left>") 'er/contract-region)

(global-set-key (kbd "C-i") 'better-jumper-jump-forward)
(global-set-key (kbd "C-o") 'better-jumper-jump-backward)

(global-set-key (kbd "C--") 'undo-fu-only-undo)
(global-set-key (kbd "M--") 'undo-fu-only-redo)

(evil-global-set-key 'emacs (kbd "C-k C-l") 'mc/mark-all-like-this)
(evil-global-set-key 'emacs (kbd "C-d") 'mc/mark-next-like-this)
(evil-global-set-key 'emacs (kbd "C-k C-d") 'mc/skip-to-next-like-this)
(evil-global-set-key 'emacs (kbd "C-M-d") 'mc/mark-previous-like-this)
(evil-global-set-key 'emacs (kbd "C-M-k C-M-d") 'mc/skip-to-previous-like-this)

(evil-global-set-key 'visual (kbd "M-/") 'comment-or-uncomment-region)
(evil-define-key '(normal insert emacs) 'global (kbd "M-/") '(lambda () (interactive) (comment-line 1)))
