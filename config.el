(setq inhibit-startup-message t)

(menu-bar-mode -1)     ;no menu bar
(tool-bar-mode -1)     ;no tools bar
(scroll-bar-mode -1)   ;no scroll bars
(tooltip-mode -1)      ;no tooltips
(set-fringe-mode 10)   ;frame edges set to 10px
(column-number-mode 1) ;modeline shows column number
(save-place-mode 1)    ;remember cursor position
(recentf-mode 1)       ;remember recent files
(savehist-mode 1)      ;remember history saving

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative) 
(global-display-line-numbers-mode)
(dolist (hook '(org-mode-hook
                vterm-mode-hook
                term-mode-hook
                shell-mode-hook
                eshell-mode-hook)) 
  (add-hook hook (lambda () (display-line-numbers-mode -1))))

(setq-default indent-tabs-mode nil)

(setq mouse-wheel-scroll-amount '(2 ((shift) . 1))
      mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse 't
      scroll-step 1)

(delete-selection-mode t)

(global-hl-line-mode 1)

(global-visual-line-mode t)

(global-auto-revert-mode t)

(fset 'yes-or-no-p 'y-or-n-p)  ; Aks y/n instead of tes/no

(electric-pair-mode 1)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;;(global-unset-key (kbd "C-z")) ;;Pode influenciar no evilmode

(global-set-key (kbd "C-=") 'text-scale-increase)  
(global-set-key (kbd "C--") 'text-scale-decrease)

(set-face-attribute 'font-lock-comment-face nil :slant 'italic)

(setq backup-directory-alist '((".*" . "~/.local/share/Trash/files")))

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror 'nomessage)

(set-face-attribute 'default nil :font "FiraCode Nerd Font 12") 
(set-face-attribute 'variable-pitch nil :font "FiraCode Nerd Font 12")
(set-face-attribute 'fixed-pitch nil :font "FiraCode Nerd Font 12")

(defun blau/reaload-settings ()
  (interactive)
  (load-file "~/.config/emacs/init.el"))

(defun blau/open-emacs-config ()
  (interactive)
  (find-file "~/.config/emacs/config.org"))

(defun blau/emacs-personal-files ()
  (interactive)
  (let ((default-directory "~/.config/emacs/"))
    (call-interactively 'find-file)))

(defun fn/openFileConfig()
  (interactive)
  (let ((default-directory "/mnt/3C0CEC910CEC478A/Emacs/Linux_Installation.org"))
    (call-interactively 'find-file)))

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package evil
    :init
    (setq evil-want-integration t
          evil-want-keybinding nil
          evil-vsplit-windows-right t
          evil-undo-system 'undo-redo)
    (evil-mode))

(use-package evil-collection
  :after evil
  :config
  (add-to-list 'evil-collection-mode-list 'help) ;; evilify help mode
  (evil-collection-init))

(use-package keycast
  :init
  (add-to-list 'global-mode-string '("" mode-line-keycast)))

(use-package vertico
  :bind (:map vertico-map
              ("C-j" . vertico-next)
              ("C-k" . vertico-previous)
              ("C-f" . vertico-exit)
              :map minibuffer-local-map
              ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-ligh nil))
  :init
  (marginalia-mode))

(use-package orderless
  :config
  (setq completion-styles '(orderless basic)))

(use-package consult)

(use-package which-key
  :init
    (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
	  which-key-sort-order #'which-key-key-order-alpha
	  which-key-allow-imprecise-window-fit nil
	  which-key-sort-uppercase-first nil
	  which-key-add-column-padding 1
	  which-key-max-display-columns nil
	  which-key-min-display-lines 6
	  which-key-side-window-slot -10
	  which-key-side-window-max-height 0.25
	  which-key-idle-delay 0.8
	  which-key-max-description-length 25
	  which-key-allow-imprecise-window-fit nil
	  which-key-separator " → " ))

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  ;; Sets the default theme to load!!! 
  (load-theme 'doom-moonlight t)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package doom-modeline
  :ensure t
  :hook
  (after-init . doom-modeline-mode)
  :custom
  (set-face-attribute 'mode-line nil :font "FiraCode Nerd Font" :height 110) 
  (set-face-attribute 'mode-line-inactive nil :font "FiraCode Nerd Font" :height 110) 
  :config
  (setq doom-modeline-enable-word-count t))

;;(use-package dashboard
;;  :init
;;  (progn
;;    (setq dashboard-items '((recents . 5)
;;                            (projects . 5)))
;;    (setq dashboard-show-shortcuts t)
;;    (setq dashboard-center-content t)
;;    (setq dashboard-set-file-icons t)
;;    (setq dashboard-set-heading-icons t)
;;    (setq dashboard-startup-banner "~/pic/emacs-typo-03.png"))
;;  :config
;;  (dashboard-setup-startup-hook))

(use-package company
  :defer 2
  :diminish
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t)) 

(use-package company-box
  :after company
  :diminish
  :hook (company-mode . company-box-mode))

(use-package general
  :config
  (general-evil-setup)
  ;; set up 'SPC' as the global leader key
  (general-create-definer fn/leader-keys
    :states '(normal insert visual emacs)
    :keymaps 'override
    :prefix "SPC" ;; set leader
    :global-prefix "M-SPC") ;; access leader in insert mode

  (fn/leader-keys
    "TAB TAB" '(comment-line :wk "Comment lines")) 

  ;; Buffer/bookmarks
  (fn/leader-keys
    "b" '(:ignore t :wk "Buffers/Bookmarks")
    "b b" '(switch-to-buffer :wk "Switch to buffer")
    "b i" '(ibuffer :wk "Ibuffer")
    "b k" '(kill-current-buffer :wk "Kill current buffer")
    "b s" '(basic-save-buffer :wk "Save buffer")
    "b l" '(list-bookmarks :wk "List bookmarks")
    "b m" '(bookmark-set :wk "Set bookmark")
    "q q" '(save-buffers-kill-terminal :wk "Quit emacs"))

  ;; Files
  (fn/leader-keys
    "f" '(:ignore t :wk "Files")
    "." '(find-file :wk "Find file")
    "f f" '(find-file :wk "Find file")
    "f p" '(blau/emacs-personal-files :wk "Open personal config files")
    "f c" '(blau/open-emacs-config :wk "Open emacs config.org")
    "g p" '(fn/openFileConfig :wk "Open File Config"))

  ;; Helpers
  (fn/leader-keys
    "h" '(:ignore t :wk "Helpers")
    "h r r" '(blau/reaload-settings :wk "Reload emacs settings")))

(use-package rainbow-delimiters
  :hook ((prog-mode . rainbow-delimiters-mode)
         (emacs-lisp-mode . rainbow-delimiters-mode)
         (clojure-mode . rainbow-delimiters-mode)))

(use-package rainbow-mode
  :diminish
  :hook org-mode prog-mode)

(use-package flycheck
  :hook (prog-mode-hook . flycheck-mode))

(use-package projectile
  :diminish projectile-mode
  :config
  (projectile-mode))

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc"))

;(require 'lsp-mode)
;(add-hook 'go-mode-hook #'lsp-deferred)

;; Set up before-save hooks to format buffer and add/delete imports.
;; Make sure you don't have other gofmt/goimports hooks enabled.
;(defun lsp-go-install-save-hooks ()
;  (add-hook 'before-save-hook #'lsp-format-buffer t t)
;  (add-hook 'before-save-hook #'lsp-organize-imports t t))
;(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

(use-package magit)

(use-package treemacs
  :bind
  (:map global-map
        ("M-\\" . treemacs))
  :config
  (setq treemacs-no-png-images t
        treemacs-is-never-other-window nil))

(add-hook 'org-mode-hook (lambda ()
           (setq-local electric-pair-inhibit-predicate
                   `(lambda (c)
                  (if (char-equal c ?<) t (,electric-pair-inhibit-predicate c))))))

(setq org-edit-src-content-indentation 0) ; Zera a margem dos blocos
(electric-indent-mode -1)                 ; Desliga a indentação automática

(require 'org-tempo)

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets
:custom
(org-bullets-bullet-list '("▶" "▷" "◆" "◇" "▪" "▪" "▪"))) 
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(use-package visual-fill-column
  ;; Descomentar se quiser iniciar sempre com org mode centralizado.
  ;; :hook (org-mode . visual-fill-column-mode)
  :config
  (setq visual-fill-column-width 90)
  (setq-default visual-fill-column-center-text t))

(require 'sh-script)
(setq org-src-fintify-natively t)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)))

;;(require 'ob-go)
;;(setq org-src-fintify-natively t)
;;(org-babel-do-load-languages
;; 'org-babel-load-languages
;; '((go . t)))

;;(use-package vterm
;;:config
;;(setq shell-file-name "/bin/zsh"
;;      vterm-max-scrollback 5000))

;(use-package vterm-toggle
;  :after vterm
;  :config
;  (evil-define-key 'normal vterm-mode-map (kbd "<escape>") 'vterm--self-insert)
;  (setq vterm-toggle-fullscreen-p nil)
;  (setq vterm-toggle-scope 'project)
;  (add-to-list 'display-buffer-alist
;               '((lambda (buffer-or-name _)
;                   (let ((buffer (get-buffer buffer-or-name)))
;                     (with-current-buffer buffer
;                       (or (equal major-mode 'vterm-mode)
;                           (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
;                 (display-buffer-reuse-window display-buffer-at-bottom)
;                 (reusable-frames . visible)
;                 (window-height . 0.3))))
