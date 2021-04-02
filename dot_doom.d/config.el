;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Al Ol"
      user-mail-address "aovlllo@hey.com"
      ;; Editor settings
      doom-font (font-spec :family "JetBrains Mono" :size 16)
      projectile-project-search-path '("~/code" "~/go/src")
      ;; doom-theme 'doom-old-hope
      doom-theme 'doom-monokai-spectrum
      display-line-numbers-type 'relative)


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

;; Org mode configuration
(use-package! md-roam ; load immediately, before org-roam
  :config
  (setq md-roam-file-extension-single "md"
        md-roam-use-org-extract-ref nil
        md-roam-use-org-file-links nil
        md-roam-use-markdown-file-links t))

(add-to-list 'load-path "/Users/aolshanskii/.emacs.d/.local/straight/repos/org-mode/contrib/lisp")

(after! org
  (setq org-superstar-headline-bullets-list '("⠪")
        org-directory "~/org-roam/"
        org-agenda-files '("~/org-roam/")))

(after! org-roam
  (setq org-roam-directory "~/org-roam/"))

(after! md-roam
  (setq org-roam-file-extensions '("org" "md")
        org-roam-title-sources '((mdtitle title mdheadline headline) (mdalias alias))
        org-roam-tag-sources '(md-frontmatter)
        org-roam-tag-sources '(prop md-frontmatter)))

;; Define keys
(map! "C-i" 'better-jumper-jump-forward
      "C-o" 'better-jumper-jump-backward

      "C--" 'undo-fu-only-undo
      "M--" 'undo-fu-only-redo

      :nve "C-S-<right>" 'er/expand-region
      :nve "C-S-<left>" 'er/contract-region

      :e "C-k C-l" 'mc/mark-all-like-this
      :e "C-d" 'mc/mark-next-like-this
      :e "C-k C-d" 'mc/skip-to-next-like-this
      :e "C-M-d" 'mc/mark-previous-like-this
      :e "C-M-k C-M-d" 'mc/skip-to-previous-like-this

      :v "S" 'evil-surround-region
      :v "D" 'evil-surround-delete

      :v "M-/" 'comment-or-uncomment-region
      :nie "M-/" '(lambda () (interactive) (comment-line 1)))

(map! :leader
      (:prefix "g"
       :desc "Magit diff range" :n "d" 'magit-diff-range)
      (:prefix "n"
       :desc "Find file in org-roam" :n "f" 'org-roam-find-file-immediate))

(after! evil-magit
  (evil-define-key 'normal magit-mode-map
    "gw" 'magit-diff-visit-file-other-window
    "gW" 'magit-diff-visit-file-other-frame))
