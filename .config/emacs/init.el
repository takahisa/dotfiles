(eval-and-compile
  (defvar emacs26-p (>= emacs-major-version 26))
  (defvar emacs27-p (>= emacs-major-version 27))
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

   (use-package all-the-icons :ensure t)

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
     (load-theme 'doom-dracula t)
     (doom-themes-neotree-config))

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

   (use-package centaur-tabs
     :ensure t
     :demand
     :config
     (setq centaur-tabs-set-close-button nil)
     (centaur-tabs-mode t)
     :bind
     ("C-c [" . centaur-tabs-backward)
     ("C-c ]" . centaur-tabs-forward))

   (use-package neotree
     :ensure t
     :demand
     :config
     (setq neo-smart-open t)
     (setq neo-show-hidden-files t)
     (setq projectile-switch-project-action 'neotree-projectile-action)
     :bind
     ("C-x ^" . 'neotree-toggle))

   (use-package projectile
     :ensure t
     :init
     (projectile-mode t)
     :bind (:map projectile-mode-map ("C-c p" . projectile-command-map)))

   (use-package company
     :ensure t
     :config
     (setq company-transformers '(company-sort-by-backend-importance))
     (setq company-idle-delay 0)
     (setq company-minimum-prefix-length 3)
     (setq company-selection-wrap-around t)
     (setq completion-ignore-case t)
     (setq company-dabbrev-downcase nil)
     (define-key company-active-map (kbd "C-n") 'company-select-next)
     (define-key company-active-map (kbd "C-p") 'company-select-previous)
     (define-key company-search-map (kbd "C-n") 'company-select-next)
     (define-key company-search-map (kbd "C-p") 'company-select-previous)
     (define-key company-active-map (kbd "C-s") 'company-filter-candidates)
     (define-key company-active-map (kbd "C-i") 'company-complete-selection)
     (define-key company-active-map [tab] 'company-complete-selection)
     (define-key company-active-map (kbd "C-f") 'company-complete-selection)
     (global-company-mode))

   (use-package counsel
     :ensure t
     :config
     (counsel-mode t)
     (ivy-mode t)
     :bind
     ("M-x"     . 'counsel-M-x)
     ("C-x C-f" . 'counsel-find-file)
     ("C-c C-g" . 'counsel-git)
     ("C-c C-j" . 'counsel-git-grep)
     ("C-c RET" . 'ivy-immediate-done))

   (use-package lsp-mode
     :ensure t
     :commands (lsp lsp-deferred)
     :custom
     ((lsp-inhibit-message t)
      (lsp-message-project-root-warning t))
     :hook
     ((json-mode . lsp-deferred)
      (yaml-mode . lsp-deferred)
      (lsp-mode  . lsp-enable-which-key-integration)))

   (use-package lsp-ui
     :ensure t
     :commands lsp-ui-mode)

   (use-package yaml-mode :ensure t :commands yaml-mode)
   (use-package json-mode :ensure t :commands json-mode)

   (use-package go-mode
     :ensure t
     :config
     (setq gofmt-command "goimports")
     (add-hook 'go-mode-hook #'lsp-deferred)
     (add-hook 'go-mode-hook
       (lambda ()
         (add-hook 'before-save-hook 'gofmt-before-save)))
     :commands go-mode)

   (use-package python-mode
     :ensure t
     :config
     (add-hook 'python-mode-hook #'lsp-deferred)
     (add-hook 'before-save-hook #'lsp-format-buffer)
     :commands python-mode)

   (use-package lisp-mode
     :ensure nil
     :config
     (setq indent-tabs-mode nil))

   (use-package web-mode
     :ensure t
     :init
     (add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
     (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
     (add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
     (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
     :config
     (setq web-mode-attr-indent-offset nil)
     (setq web-mode-enable-auto-closing t)
     (setq web-mode-enable-auto-pairing t)
     (setq web-mode-auto-close-style 2)
     (setq web-mode-tag-auto-close-style 2)
     (setq web-mode-markup-indent-offset 2)
     (setq web-mode-css-indent-offset 2)
     (setq web-mode-code-indent-offset 2)
     (setq indent-tabs-mode nil)
     (setq tab-width 2))

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
     :config
     (face-spec-set
      'tuareg-font-lock-governing-face
      '((((class color) (background light)) (:foreground "orange"))
        (((class color) (background dark))  (:foreground "orange"))))
     (add-hook 'tuareg-mode-hook #'(lambda() (setq mode-name "🐫")))
     (add-hook 'tuareg-mode-hook #'lsp-deferred)
     :mode (("\\.ml[il]?\\'"    . tuareg-mode)
            ("\\.mly\\'"        . tuareg-menhir-mode)
            ("^dune$"           . dune-mode)
            ("^dune-project$"   . dune-mode)
            ("^dune-workspace$" . dune-mode))
     :commands tuareg-mode)

   (use-package merlin
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
     :hook (tuareg-mode . merlin-mode))

   (use-package merlin-eldoc
     :ensure t
     :custom
     (eldoc-echo-area-use-multiline-p t)
     (merlin-eldoc-max-lines 8)
     :hook (tuareg-mode . merlin-eldoc-setup))

   (use-package dune-flymake :if opam-p :load-path opam-share-site-lisp)
   (use-package dune         :if opam-p :load-path opam-share-site-lisp)
   (use-package ocamlformat
     :commands (ocamlformat ocamlformat-before-save))

   (use-package markdown-mode
     :ensure t
     :init (setq markdown-command "multimarkdown")
     :mode (("README\\.md\\'" . gfm-mode)
            ("\\.md\\'"       . markdown-mode)
            ("\\.mkd\\'"      . markdown-mode)
            ("\\.markdown\\'" . markdown-mode))
     :commands (markdown-mode gfm-mode))

   (use-package editorconfig
     :ensure t
     :custom
     (editorconfig-mode 1))

   (use-package which-key
     :ensure t
     :config
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
   (savehist-mode t)
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
       (add-to-list 'default-frame-alist '(font . "Hack Nerd Font Mono-18"))))

   (when (display-graphic-p)
     (scroll-bar-mode 0))

   (setq custom-file (locate-user-emacs-file "custom.el"))
   (unless (file-exists-p custom-file)
     (write-region "" nil custom-file))
   (load custom-file))
