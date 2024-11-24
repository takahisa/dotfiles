(eval-and-compile
  (defvar emacs26-p (>= emacs-major-version 26))
  (defvar emacs27-p (>= emacs-major-version 27))
  (defvar emacs28-p (>= emacs-major-version 27))
  (defvar darwin-p (eq system-type 'darwin))
  (defvar cygwin-p (eq system-type 'cygwin))
  (defvar windows-p (or (eq system-type 'windows-nt) cygwin-p))

  (customize-set-variable
    'package-archives '(("org"   . "https://orgmode.org/elpa/")
                        ("gnu"   . "https://elpa.gnu.org/packages/")
                        ("melpa" . "https://melpa.org/packages/")))
  (package-initialize)
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
  
  (use-package use-package :no-require t :ensure t :defer t)

  (use-package all-the-icons
    :ensure t
    :demand)
  
  (use-package doom-themes
    :ensure t
    :demand
    :custom
    (doom-themes-enable-italic t)
    (doom-themes-enable-bold t)
    :custom-face
    (default ((t (:background "undefined"))))
    (font-lock-variable-name-face ((t (:foreground ,(doom-color 'base8)))))
    (font-lock-function-name-face ((t (:foreground ,(doom-color 'base8)))))
    (font-lock-type-face ((t (:foreground ,(doom-color 'base8)))))
    :config
    (load-theme 'doom-dracula t))
  
  (use-package doom-modeline
    :ensure t
    :demand
    :custom
    (doom-modeline-buffer-file-name-style 'truncate-with-project)
    (doom-modeline-icon (display-graphic-p))
    (doom-modeline-major-mode-icon (display-graphic-p))
    (doom-modeline-workspace-name t)
    (doom-modeline-project-detection 'project)
    :init (doom-modeline-mode 1))

  (use-package projectile
    :ensure t
    :demand
    :bind (:map projectile-mode-map ("C-c p" . projectile-command-map))
    :init
    (projectile-global-mode t))

  (use-package centaur-tabs
    :ensure t
    :demand
    :custom
    (centaur-tabs-set-close-button nil)
    :bind
    ("C-c [" . centaur-tabs-backward)
    ("C-c ]" . centaur-tabs-forward)
    :init
    (centaur-tabs-mode t))
  
  (use-package neotree
    :ensure t
    :demand
    :custom
    (neo-window-position 'left)
    (neo-window-fixed-size t)
    (neo-show-hidden-files t)
    (neo-smart-open t)
    (projectile-switch-project-action 'neotree-projectile-action)
    :config
    (doom-themes-neotree-config)
    :hook
    ((neo-after-create . (lambda (&rest _) (display-line-numbers-mode -1))))
    :bind
    ("C-x ^" . 'neotree-toggle))

  (use-package company
    :ensure t
    :custom
    (company-transformers '(company-sort-by-backend-importance))
    (company-idle-delay 0)
    (company-minimum-prefix-length 3)
    (company-selection-wrap-around t)
    (completion-ignore-case t)
    (company-dabbrev-downcase nil)
    :bind
    (:map company-active-map
      ("C-n" . company-select-next)
      ("C-p" . company-select-previous)
      ("C-s" . company-filter-candidates)
      ("C-i" . company-complete-selection)
     :map company-search-map
      ("C-n" . company-select-next)
      ("C-p" . company-select-previous))
    :init
    (global-company-mode))

  (use-package counsel
    :ensure t
    :bind
    ("M-x"     . 'counsel-M-x)
    ("C-x C-f" . 'counsel-find-file)
    ("C-c C-g" . 'counsel-git)
    ("C-c C-j" . 'counsel-git-grep)
    ("C-c RET" . 'ivy-immediate-done)
    :init
    (counsel-mode t)
    (ivy-mode t))

  (use-package lsp-mode
    :ensure t
    :custom
    (lsp-inhibit-message t)
    (lsp-message-project-root-warning t)
    :hook
    ((json-mode . lsp-deferred)
     (yaml-mode . lsp-deferred)
     (lsp-mode  . lsp-enable-which-key-integration))
    :commands
    (lsp lsp-deferred))
     
  (use-package lsp-ui
    :ensure t
    :hook
    ((lsp-mode . lsp-ui-mode)))

  (use-package yaml-mode :ensure t :commands yaml-mode)
  (use-package toml-mode :ensure t :commands toml-mode)
  (use-package json-mode :ensure t :commands json-mode)
  (use-package jsonnet-mode :ensure t :commands jsonnet-mode)

  (use-package go-mode
    :ensure t
    :custom
    (gofmt-command "goimports")
    :hook
    ((go-mode . lsp-deferred))
    :commands go-mode)

  (use-package python-mode
    :ensure t
    :hook
    ((python-mode . lsp-deferred))
    :commands python-mode)

  (use-package ruby-mode
    :ensure t
    :hook
    ((ruby-mode . lsp-deferred))
    :commands ruby-mode)
  
  (use-package web-mode
    :ensure t
    :mode
    (("\\.js\\'"  . web-mode)
     ("\\.jsx\\'" . web-mode)
     ("\\.ts\\'"  . web-mode)
     ("\\.tsx\\'" . web-mode))
    :custom
     (web-mode-attr-indent-offset nil)
     (web-mode-enable-auto-closing t)
     (web-mode-enable-auto-pairing t)
     (web-mode-auto-close-style 2)
     (web-mode-tag-auto-close-style 2)
     (web-mode-markup-indent-offset 2)
     (web-mode-css-indent-offset 2)
    (web-mode-code-indent-offset 2)
    :commands web-mode)

  (defvar opam-p (executable-find "opam"))

  (when opam-p
    (ignore-errors
      (dolist (var (car (read-from-string (shell-command-to-string "opam config env --sexp"))))
	    (setenv (car var) (cadr var)))))
  (setq opam-share
    (ignore-errors (car (process-lines "opam" "var" "share"))))
  (setq opam-share-site-lisp
    (concat opam-share "/emacs/site-lisp/"))

  (use-package ocp-indent :if opam-p :load-path opam-share-site-lisp)
  (use-package ocp-index  :if opam-p :load-path opam-share-site-lisp)

  (use-package tuareg
    :ensure t
    :mode (("\\.ml[il]?\\'" . tuareg-mode)
           ("\\.mly\\'"     . tuareg-menhir-mode))
    :custom-face
    (tuareg-font-lock-governing-face ((t (:foreground ,(doom-color 'base9)))))
    :hook
    ((tuareg-mode . (lambda() (setq mode-name "🐫")))
     (tuareg-mode . lsp-deferred)
     (before-save . lsp-format-buffer))
    :commands tuareg-mode)

  (use-package merlin
    :after (tuareg)
    :ensure t
    :custom
    (merlin-completion-with-doc t)
    (merlin-use-auto-complete-mode t)
    (merlin-error-check-then-move nil)
    (merlin-command 'opam)
    (merlin-error-after-save t)
    (merlin-locate-preference 'mli)
    (merlin-debug nil)
    :custom-face
    (merlin-type-face ((t (:inherit (highlight)))))
    :hook
    ((tuareg-mode . merlin-mode)))

  (use-package merlin-eldoc
    :after (tuareg merlin)
    :ensure t
    :custom
    (eldoc-echo-area-use-multiline-p t)
    (merlin-eldoc-max-lines 8)
    :hook
    ((tuareg-mode . merlin-eldoc-setup)))

  (use-package dune-flymake :if opam-p :load-path opam-share-site-lisp)
  (use-package dune         :if opam-p :load-path opam-share-site-lisp
    :mode
    (("^dune$"           . dune-mode)
     ("^dune-project$"   . dune-mode)
      ("^dune-workspace$" . dune-mode)))
  
  (use-package ocamlformat
    :commands (ocamlformat ocamlformat-before-save))

  (use-package markdown-mode
    :ensure t
    :custom
    (markdown-command "multimarkdown")
    :mode
    (("README\\.md\\'" . gfm-mode)
     ("\\.md\\'"       . markdown-mode)
     ("\\.mkd\\'"      . markdown-mode)
     ("\\.markdown\\'" . markdown-mode))
    :commands (markdown-mode gfm-mode))

  (use-package editorconfig
    :ensure t
    :init
    (editorconfig-mode 1))

  (use-package which-key
    :ensure t
    :init
    (which-key-mode))

  (fset 'yes-or-no-p 'y-or-n-p)
  (setq line-spacing 2)
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  (setq auto-save-default nil)
  (setq make-backup-files nil)
  (setq history-length 1000)
  (setq message-log-max nil)
  (setq read-file-name-completion-ignore-case t)
  (setq completion-ignore-case t)
  (setq delete-auto-save-files t)
  (setq bidi-display-reordering nil)
  (setq inhibit-splash-screen t)
  (setq initial-scratch-message "")
  (setq ring-bell-function 'ignore)
  (global-display-line-numbers-mode)
  (savehist-mode 0)
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (show-paren-mode t)

  (xterm-mouse-mode t)
  (global-set-key "\C-h" 'delete-backward-char)
  (global-set-key "\C-^" 'set-mark-command)
  (global-set-key [mouse-4] '(lambda () (interactive) (scroll-down 3)))
  (global-set-key [mouse-5] '(lambda () (interactive) (scroll-up 3)))

  (define-key global-map [?\M-¥] "\\")

  (when darwin-p
    (setq ns-command-modifier 'meta))

  (when (display-graphic-p)
    (when (member "Hack" (font-family-list))
      (add-to-list 'default-frame-alist '(font . "Hack-18")))
    (when (member "Hack Nerd Font Mono" (font-family-list))
      (add-to-list 'default-frame-alist '(font . "Hack Nerd Font Mono-18")))
    (scroll-bar-mode 0))
  
  (setq custom-file (locate-user-emacs-file "custom.el"))
  (unless (file-exists-p custom-file)
    (write-region "" nil custom-file))
  (load custom-file))
