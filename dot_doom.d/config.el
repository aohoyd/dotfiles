;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Al Ol"
      user-mail-address "im@avlllo.me"
      ;; Editor settings
      doom-font (font-spec :family "JetBrains Mono" :size 16)
      projectile-project-search-path '("~/code" "~/go/src")
      ;; doom-theme 'doom-old-hope
      doom-theme 'doom-dark+
      doom-themes-treemacs-theme "doom-colors"
      display-line-numbers-type 'relative)
(doom-themes-treemacs-config)

(setq-default indent-tabs-mode nil
              major-mode 'org-roam-mode)

;; Enable mouse integration
(require 'mouse)
(xterm-mouse-mode t)
(setq mouse-sel-mode t)

;; Auto completion
(setq lsp-gopls-staticcheck t
      lsp-eldoc-render-all t
      lsp-gopls-complete-unimported t)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(setq company-backends (append company-backends '(company-files)))

;; Org settings
(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-table nil))

(after! org
  (setq org-directory "~/org/"
        org-agenda-files '("~/org/")))

(after! org-roam
  (setq org-roam-directory "~/org/"))

(after! evil
  (require 'evil-mc))

;; Aux
(defun personal/word-find-and-goto-match (direction)
  (when (and (not (use-region-p)) (not (evil-mc-has-pattern-p)))
    (let ((b (bounds-of-thing-at-point 'word)))
      (evil-visual-select (car b) (cdr b))))
  (evil-mc-find-and-goto-match direction t))

(defun personal/word-make-and-goto-next-match ()
  (interactive)
  (personal/word-find-and-goto-match 'forward))

(defun personal/word-make-and-goto-prev-match ()
  (interactive)
  (personal/word-find-and-goto-match 'backward))

;; Define keys
(map! "C-i" 'better-jumper-jump-forward
      "C-o" 'better-jumper-jump-backward

      "C--" 'undo-fu-only-undo
      "M--" 'undo-fu-only-redo

      :nve "C-S-<right>" 'er/expand-region
      :nve "C-S-<left>" 'er/contract-region

      :n  "M-C-j" 'evil-mc-make-cursor-move-next-line
      :n  "M-C-k" 'evil-mc-make-cursor-move-prev-line
      :nv "s-d" 'personal/word-make-and-goto-next-match
      :nv "s-g" 'personal/word-make-and-goto-prev-match
      :nv "s-k s-d" 'evil-mc-skip-and-goto-next-match
      :nv "s-k s-g" 'evil-mc-skip-and-goto-prev-match
      :nv "s-L" 'evil-mc-make-all-cursors

      :v "S" 'evil-surround-region
      :v "D" 'evil-surround-delete

      :v "M-/" 'comment-or-uncomment-region
      :nie "M-/" '(lambda () (interactive) (comment-line 1))

      (:after evil-easymotion
       :map evilem-map
       "l" #'evil-avy-goto-line))

(map! :leader
      (:prefix "g"
       :desc "Magit diff range" :n "d" 'magit-diff-range)
      (:prefix "n"
       :desc "Find file in org-roam" :n "f" 'org-roam-find-file-immediate))
