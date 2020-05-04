;; ==================================================
;; Core

;; Don't make backup files.
(setq make-backup-files nil)

;; Don't make autosave files.
(setq auto-save-default nil)

;; Don't make lockfiles.
(setq create-lockfiles nil)

;; Load file changes automatically each second
(setq auto-revert-interval 1)
(global-auto-revert-mode t)

;; Automatically close grouping characters
(electric-pair-mode 1)

;; Highlight matching parenthesis
(show-paren-mode 1)

;; Add new line at the end of the file
(setq require-final-newline t)

;; Remove trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Always replace the region when you start typing
(delete-selection-mode 1)

;; Elimitate the delay for isearch
(setq isearch-lazy-highlight-initial-delay 0)

;; Never use tabs!
(setq-default indent-tabs-mode nil)

;; Paragraph filling for text modes, keep the width of lines shorter
(setq-default fill-column 80)
(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'pollen-mode-hook 'auto-fill-mode)

;; ==================================================
;; User interface

;; Hide menu bar
(menu-bar-mode -1)

;; Don't show a startup creen
(setq inhibit-startup-screen t)

;; Show the character number in the mode line
(column-number-mode t)

;; Ask for Y or N instead of Yes or No
(defalias 'yes-or-no-p 'y-or-n-p)

;; ==================================================
;; Functions

(defun metaverso-open-init ()
  "Open the Emacs settings file"
  (interactive)
  (find-file user-init-file))

(defun metaverso-beginning-of-line ()
  "Toggle between the first non-whitespace character and the beginning of the line"
  (interactive)

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(defun metaverso-reset-window ()
  "Resets window's position, display margins, fringe widths, and scrollbar settings"
  (interactive)
  (set-window-buffer nil (current-buffer)))

;; ==================================================
;; Packages

;; Set up the "Straight" package manager
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Customize Emacs mode lighters
(use-package blackout
  :straight (blackout :host github :repo "raxod502/blackout")
  :config
  (blackout 'emacs-lisp-mode "eLisp")
  (blackout 'eldoc-mode))

;; Theme
(use-package doom-themes
  :config
  (load-theme 'doom-one t))

(use-package doom-modeline
  :init (doom-modeline-init)
  :config
  (setq doom-modeline-icon nil))

;; Highlight known Emacs Lisp symbols
(use-package highlight-defined
  :init
  (add-hook 'emacs-lisp-mode-hook 'highlight-defined-mode))

;; Highlight Lisp quotes
(use-package highlight-quoted
  :straight (highlight-quoted :host github :repo "Fanael/highlight-quoted")
  :config (add-hook 'emacs-lisp-mode-hook 'highlight-quoted-mode))

;; Highlight numbers in all programming modes
(use-package highlight-numbers
  :config (add-hook 'prog-mode-hook 'highlight-numbers-mode))

;; Magit is the defacto Git client for Emacs
(use-package magit)

;; Indicate where the cursor is after a change of view
(use-package beacon
  :config
  (beacon-mode t)
  :blackout t)

;; Allow descriptions in keybinding definitions—also shows suggestions
(use-package which-key
  :init
  (setq which-key-enable-extended-define-key t)
  :config
  (which-key-mode)
  :blackout t)

;; Display the undo tree
(use-package undo-tree
  :config
  (global-undo-tree-mode)
  :blackout t)

;; Be smart about pairing characters
(use-package smartparens
  :config
  (require 'smartparens-config)
  (smartparens-mode)
  :blackout t)

;; Guess indentation settings for each file
(use-package dtrt-indent
  :config
  (dtrt-indent-mode)
  :blackout t)

;; Emacs becomes aware of projects
(use-package projectile
  :config
  (projectile-mode t)
  (setq projectile-completion-system 'helm))

;; Allows increasing the selected region by semantic units
(use-package expand-region)

;; Jump easily to any part of the buffer
(use-package ace-jump-mode)

;; Improve help buffer with more information
(use-package helpful)

;; Allow HTTP communication for Rest services
(use-package restclient)

;; Incremental completion and selection narrowing
(use-package helm
  :blackout t
  :config
  (helm-mode 1)
  (helm-autoresize-mode t))

;; Remember that you have things to do
(use-package hl-todo
  :config
  (global-hl-todo-mode))

;; Autocomplete things
(use-package company
  :blackout t
  :init
  (global-company-mode t)
  (setq company-tooltip-align-annotations t))

;; Put the autocomplete suggestions on top depending on usage
(use-package company-statistics
  :after company
  :config
  (company-statistics-mode))

;; Allow syntax checking, but keep it deactivated
(use-package flycheck
  :blackout t
  :config
  (setq flycheck-indication-mode 'right-fringe))

;; Dim parentheses for Lisps
(use-package paren-face
  :config
  (global-paren-face-mode))

;; Tree-style Dired view
(use-package dired-subtree
  :bind (:map dired-mode-map
             ("i" . dired-subtree-insert)
             (";" . dired-subtree-remove)))

;; Improved regular file management for Dired
(use-package dired-ranger
  :bind (:map dired-mode-map
              ("W" . dired-ranger-copy)
              ("X" . dired-ranger-move)
              ("Y" . dired-ranger-paste)))

;; ==================================================
;; Language support

;; Standard ML
(use-package sml-mode
  :init
  (setq sml-indent-level 2))

;; Racket
(use-package racket-mode)

;; Markdown
(use-package markdown-mode)

;; Pollen
(use-package pollen-mode)
(use-package company-pollen
  :after pollen-mode company)

;; JavaScript
(use-package js2-mode
  :blackout "JavaScript"
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (setq js2-basic-offset 2))

;; Typescript
(use-package tide
  :config
  (defun setup-tide-mode ()
    (interactive)
    (tide-setup)
    (flycheck-mode +1)
    (setq flycheck-check-syntax-automatically '(save mode-enabled))
    (eldoc-mode +1)
    (tide-hl-identifier-mode +1)
    (company-mode +1))
  (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'typescript-mode-hook #'setup-tide-mode))

;; Syntax highlighting for Dockerfiles
(use-package dockerfile-mode)

;; Syntax highlighting for .gitignore files
(use-package gitignore-mode)

(use-package pug-mode
  :config
  (setq pug-tab-width 2))

;; ==================================================
;; Keybindings

;; Metaverso Keybindings
(define-key global-map (kbd "M-m") '("Metaverso"))

;; -> File operations
(define-key global-map (kbd "M-m f") '("Files"))
(define-key global-map (kbd "M-m fe") '("Open settings" . metaverso-open-init))

;; -> Git operations
(define-key global-map (kbd "M-m g") '("Git"))
(define-key global-map (kbd "M-m gs") '("Status" . magit-status))

;; -> Editor operations
(define-key global-map (kbd "M-m e") '("Editor"))
(define-key global-map (kbd "M-m ee") '("Expand region" . er/expand-region))
(define-key global-map (kbd "M-m ej") '("Jump to…" . ace-jump-mode))
(define-key global-map (kbd "M-m ey") '("Kill-Ring" . helm-show-kill-ring))

;; -> Project operations
(define-key global-map (kbd "M-m p") '("Project" . projectile-command-map))

;; -> Misc operations
(define-key global-map (kbd "M-m m") '("Misc"))
(define-key global-map (kbd "M-m mr") '("Reset window" . metaverso-reset-window))
(define-key global-map (kbd "M-m mp") '("Previous TODO" . hl-todo-previous))
(define-key global-map (kbd "M-m mn") '("Next TODO" . hl-todo-next))

;; Redefine core keybindings
(define-key global-map (kbd "C-a") '("Go to beginning of line" . metaverso-beginning-of-line))
(define-key global-map (kbd "C-h f") '("Describe callable" . helpful-callable))
(define-key global-map (kbd "C-h v") '("Describe variable" . helpful-variable))
(define-key global-map (kbd "C-h k") '("Describe key" . helpful-key))
(define-key global-map (kbd "C-h p") '("Describe point" . helpful-at-point))
(define-key global-map (kbd "M-x") '("Helm commands" . helm-M-x))
(define-key global-map (kbd "C-x C-f") '("Find file" . helm-find-files))
(define-key global-map (kbd "C-x C-b") '("List buffers" . helm-buffers-list))
