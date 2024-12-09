(defvar emacs28-p (>= emacs-major-version 28))
(defvar emacs28-p (>= emacs-major-version 29))
(defvar darwin-p (eq system-type 'darwin))
(defvar cygwin-p (eq system-type 'cygwin))

(customize-set-variable
  'package-archives '(("org"   . "https://orgmode.org/elpa/")
                      ("gnu"   . "https://elpa.gnu.org/packages/")
                      ("melpa" . "https://melpa.org/packages/")))

(eval-and-compile
  (package-initialize))

(eval-and-compile
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package)))

(use-package nerd-icons
  :ensure t
  :demand t
  :config
  (add-to-list 'nerd-icons-regexp-icon-alist '("^Makefile$" nerd-icons-devicon "nf-dev-terminal" :face nerd-icons-lblue))
  (add-to-list 'nerd-icons-regexp-icon-alist '("^Brewfile$" nerd-icons-devicon "nf-dev-terminal" :face nerd-icons-lblue)))

(use-package all-the-icons
  :ensure t)

(use-package all-the-icons-nerd-fonts
  :ensure t
  :demand t
  :after all-the-icons
  :init
  (all-the-icons-nerd-fonts-prefer))

(use-package doom-themes
  :ensure t
  :demand
  :custom
  (doom-themes-enable-italic t)
  (doom-themes-enable-bold t)
  :custom-face
  (default ((t (:background "unspecified-bg"))))
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
  (neo-theme 'nerd-icons)
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
  :bind (:map company-active-map
          ("C-n" . company-select-next)
          ("C-p" . company-select-previous)
          ("C-s" . company-filter-candidates)
          ("C-i" . company-complete-selection))
  :bind (:map company-search-map
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
  (lsp-message-project-root-warning t)
  (lsp-inhibit-message t)
  :hook
  ((lsp-mode . lsp-enable-which-key-integration))
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

(defvar opam-p (executable-find "opam"))

(when opam-p
  (ignore-errors
    (dolist (var (car (read-from-string (shell-command-to-string "opam config env --sexp"))))
	    (setenv (car var) (cadr var)))))
(setq opam-share
  (ignore-errors (car (process-lines "opam" "var" "share"))))
(setq opam-share-site-lisp
  (ignore-errors (concat opam-share "/emacs/site-lisp/")))

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

(use-package editorconfig
  :ensure t
  :init
  (editorconfig-mode 1))

(use-package which-key
  :ensure t
  :init
  (which-key-mode))

(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default line-spacing 2)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(setq-default delete-auto-save-files t)
(setq-default auto-save-default nil)
(setq-default make-backup-files nil)
(setq-default history-length 1000)
(setq-default read-file-name-completion-ignore-case t)
(setq-default completion-ignore-case t)
(setq-default inhibit-splash-screen t)
(setq-default initial-scratch-message "")
(setq-default ring-bell-function 'ignore)
(global-display-line-numbers-mode t)
(savehist-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(show-paren-mode t)
(xterm-mouse-mode t)

(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "C-^") 'set-mark-command)
(global-set-key [mouse-4] (lambda () (interactive) (scroll-down 3)))
(global-set-key [mouse-5] (lambda () (interactive) (scroll-up 3)))

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
(load custom-file)
