{
  pkgs,
  ...
}:
{
  programs.emacs = {
    enable = true;
    extraConfig = ''
(set-language-environment "UTF-8")
(add-to-list 'default-frame-alist '(menu-bar-lines . 0))
(add-to-list 'initial-frame-alist '(menu-bar-lines . 0))
(add-to-list 'initial-frame-alist '(tool-bar-lines . 0))
(add-to-list 'default-frame-alist '(tool-bar-lines . 0))
(add-to-list 'initial-frame-alist '(vertical-scroll-bars))
(add-to-list 'default-frame-alist '(vertical-scroll-bars))
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'initial-frame-alist
			 '(font . "Iosevka Nerd Font Mono-8"))
(add-to-list 'default-frame-alist
			 '(font . "Iosevka Nerd Font Mono-8"))
(setq user-mail-address "alexforsale@yahoo.com"
	  user-full-name "Kristian Alexander P")
(cond ((file-directory-p (expand-file-name "Sync/org" (getenv "HOME")))
	   (customize-set-variable '+config/org-directory (expand-file-name "Sync/org" (getenv "HOME"))))
	  ((string-match-p "microsoft" (shell-command-to-string "uname -a"))
	   (if (file-directory-p "/mnt/c/Users/SyncthingServiceAcct/Default Folder/org")
		   (customize-set-variable '+config/org-directory "/mnt/c/Users/SyncthingServiceAcct/Default Folder/org"))))

(use-package which-key
  :ensure t
  :custom
  (which-key-lighter "")
  (which-key-sort-order #'which-key-key-order-alpha)
  (which-key-sort-uppercase-first nil)
  (which-key-add-column-padding 1)
  (which-key-max-display-columns nil)
  (which-key-min-display-lines 6)
  (which-key-compute-remaps t)
  (which-key-side-window-slot -10)
  (which-key-separator " → ")
  (which-key-allow-evil-operators nil)
  (which-key-use-C-h-commands t)
  (which-key-show-remaining-keys t)
  (which-key-show-prefix 'bottom)
  (which-key-show-operator-state-maps nil)
  :config
  (which-key-mode)
  (which-key-setup-side-window-bottom)
  (which-key-setup-minibuffer)
  (define-key which-key-mode-map (kbd "C-x <f5>") 'which-key-C-h-dispatch))

(use-package evil
  :hook
  (after-change-major-mode . (lambda ()
                               (setq evil-shift-width tab-width)))
  :preface
  (customize-set-variable 'evil-want-keybinding nil)
  (customize-set-variable 'evil-want-integration t)
  (customize-set-variable 'evil-undo-system 'undo-redo)
  (customize-set-variable 'evil-want-C-i-jump nil) ;; fix TAB in terminal org-mode
  (customize-set-variable 'evil-want-C-u-scroll t) ;; move universal arg to <leader> u
  (customize-set-variable 'evil-want-C-u-delete t) ;; delete back to indentation in insert state
  (customize-set-variable 'evil-want-C-g-bindings t)
  :custom
  (evil-undo-system #'undo-redo)
  (evil-search-module 'evil-search)
  (evil-ex-search-vim-style-regexp t)
  (evil-ex-interactive-search-highlight 'selected-window)
  (evil-kbd-macro-suppress-motion-error t)
  (evil-visual-update-x-selection-p nil)
  :config
  (unless noninteractive
    (setq save-silently t))
  (setq evil-normal-state-cursor 'box
        evil-insert-state-cursor 'bar
        evil-visual-state-cursor 'hollow)
  (evil-select-search-module 'evil-search-module 'isearch)
  (evil-mode 1)
  (with-eval-after-load 'eldoc
    (eldoc-add-command 'evil-normal-state
					   'evil-insert
					   'evil-change
					   'evil-delete
					   'evil-replace))
  ;; from doom
  (defun +evil/window-split-and-follow ()
    "Split current window horizontally, then focus new window.
          If `evil-split-window-below' is non-nil, the new window isn't focused."
    (interactive)
    (let ((evil-split-window-below (not evil-split-window-below)))
      (call-interactively #'evil-window-split)))
  (defun +evil/window-vsplit-and-follow ()
    "Split current window vertically, then focus new window.
          If `evil-vsplit-window-right' is non-nil, the new window isn't focused."
    (interactive)
    (let ((evil-vsplit-window-right (not evil-vsplit-window-right)))
      (call-interactively #'evil-window-vsplit))))

(use-package evil-collection
  :after evil
  :ensure t
  :init
  (evil-collection-init)
  :config
  (with-eval-after-load 'dired
    (evil-collection-dired-setup))
  (with-eval-after-load 'calendar
    (evil-collection-calendar-setup))
  :custom
  (evil-collection-setup-minibuffer t)
  (evil-collection-calendar-want-org-bindings t))

(use-package emacs
  :ensure nil
  :custom
  (read-buffer-completion-ignore-case t)
  (tab-always-indent nil)
  (visible-bell nil)
  (use-short-answers t)
  (use-dialog-box nil)
  (window-resize-pixelwise nil)
  (frame-resize-pixelwise t)
  (ring-bell-function #'ignore)
  (scroll-preserve-screen-position t)
  (scroll-conservatively 101)
  (fast-but-imprecise-scrolling t)
  (truncate-partial-width-windows nil)
  (tab-width 4)
  (fill-column 80)
  (enable-recursive-minibuffers t)
  (use-file-dialog nil)
  (create-lockfiles nil)
  (delete-by-moving-to-trash t)
  (inhibit-startup-screen t)
  :config
  (when (bound-and-true-p tooltip-mode)
    (tooltip-mode -1))
  (setq completion-ignore-case t
        read-file-name-completion-ignore-case t
        read-buffer-completion-ignore-case t
        load-prefer-newer t
        auto-window-vscroll nil
        inhibit-compacting-font-caches t
        redisplay-skip-fontification-on-input t)
  (set-default 'indicate-empty-lines nil)
  (setq-default truncate-lines t)
  (setq-default x-stretch-cursor nil))

(use-package files
  :ensure nil
  :config
  (nconc
   auto-mode-alist
   '(("/LICENSE\\'" . text-mode)
     ("\\.log\\'" . text-mode)
     ("rc\\'" . conf-mode)
     ("\\.\\(?:hex\\|nes\\)\\'" . hexl-mode)))
  :hook
  ((prog-mode text-mode) . auto-save-visited-mode)
  :custom
  (auto-save-visited-interval 10)
  (find-file-suppress-same-file-warnings t)
  ;;(confirm-kill-emacs #'yes-or-no-p) ; confirm when exiting
  (confirm-kill-processes nil) ; don't confirm killing processes
  (revert-without-query (list "."))
  (find-file-visit-truename t) ; `find-file' will visit the actual file
  (make-backup-files nil)
  (version-control t)
  (backup-by-copying t)
  (delete-old-versions t)
  (kept-new-versions 6)
  (kept-old-versions 2)
  (auto-save-include-big-deletions t)
  (auto-save-list-file-prefix (expand-file-name ".autosave/" user-emacs-directory))
  (backup-directory-alist `(("." . ,(expand-file-name ".backup" user-emacs-directory))))
  (auto-mode-case-fold nil)
  (require-final-newline t))

(use-package saveplace
  :init
  (save-place-mode 1)
  :custom
  (save-place-file (expand-file-name "places" user-emacs-directory)))

(use-package autorevert
  :hook (focus-in . doom-auto-revert-buffers-h)
  :hook (after-save . doom-auto-revert-buffers-h)
  :hook (prog-mode . doom-auto-revert-buffer-h)
  :custom
  (auto-revert-interval 60)
  (auto-revert-use-notify nil)
  (global-auto-revert-non-file-buffers t)
  (auto-revert-verbose t)
  (auto-revert-stop-on-user-input nil)
  (revert-without-query (list "."))
  :config
  (defun doom-visible-buffer-p (buf)
    "Return non-nil if BUF is visible."
    "Return non-nil if BUF is not visible."
    (not (doom-visible-buffer-p buf)))
  (defun doom-visible-buffers (&optional buffer-list all-frames)
    "Return a list of visible buffers (i.e. not buried)."
    (let ((buffers
           (delete-dups
            (cl-loop for frame in (if all-frames (visible-frame-list) (list (selected-frame)))
					 if (window-list frame)
					 nconc (mapcar #'window-buffer it)))))
      (if buffer-list
          (cl-delete-if (lambda (b) (memq b buffer-list))
						buffers)
        (delete-dups buffers))))
  (defun doom-auto-revert-buffer-h ()
    "Auto revert current buffer, if necessary."
    (unless (or auto-revert-mode (active-minibuffer-window))
      (let ((auto-revert-mode t))
        (auto-revert-handler))))
  (defun doom-auto-revert-buffers-h ()
    "Auto revert stale buffers in visible windows, if necessary."
    (dolist (buf (doom-visible-buffers))
      (with-current-buffer buf
        (doom-auto-revert-buffer-h)))))

(use-package savehist
  :init
  (savehist-mode 1)
  :custom
  (savehist-file (expand-file-name "history" user-emacs-directory))
  (savehist-save-minibuffer-history t)
  (savehist-autosave-interval nil)
  (savehist-coding-system 'utf-8)
  (savehist-additional-variables
   '(evil-jumps-history
     command-history
     kill-ring
     register-alist
     mark-ring
     global-mark-ring
     search-ring
     regexp-search-ring)))

(use-package recentf
  :bind ("C-c f" . recentf)
  :commands recentf-open-files
  :hook (dired-mode . doom--recentf-add-dired-directory-h)
  :init
  (recentf-mode 1)
  :custom
  (recentf-auto-cleanup t)
  (recentf-max-saved-items 250)
  (recentf-max-menu-items 300)
  (recentf-exclude
   `("/elpa/" ;; ignore all files in elpa directory
     "recentf" ;; remove the recentf load file
     ".*?autoloads.el$"
     "treemacs-persist"
     "company-statistics-cache.el" ;; ignore company cache file
     "/intero/" ;; ignore script files generated by intero
     "/journal/" ;; ignore daily journal files
     ".gitignore" ;; ignore `.gitignore' files in projects
     "/tmp/" ;; ignore temporary files
     "NEWS" ;; don't include the NEWS file for recentf
     "bookmarks"  "bmk-bmenu" ;; ignore bookmarks file in .emacs.d
     "loaddefs.el"
     "^/\\(?:ssh\\|su\\|sudo\\)?:" ;; ignore tramp/ssh files
     (concat "^" (regexp-quote (or (getenv "XDG_RUNTIME_DIR")
                                   "/run")))))
  :config
  (defun doom--recentf-file-truename-fn (file)
    (if (or (not (file-remote-p file))
            (equal "sudo" (file-remote-p file 'method)))
        (abbreviate-file-name (file-truename (tramp-file-name-localname file)))
      file))
  ;; Resolve symlinks, strip out the /sudo:X@ prefix in local tramp paths, and
  ;; abbreviate $HOME -> ~ in filepaths (more portable, more readable, & saves
  ;; space)
  (add-to-list 'recentf-filename-handlers #'doom--recentf-file-truename-fn)
  ;; Text properties inflate the size of recentf's files, and there is
  ;; no purpose in persisting them (Must be first in the list!)
  (add-to-list 'recentf-filename-handlers #'substring-no-properties)
  (defun doom--recentf-add-dired-directory-h ()
    "Add dired directories to recentf file list."
    (recentf-add-file default-directory))
  ;; The most sensible time to clean up your recent files list is when you quit
  ;; Emacs (unless this is a long-running daemon session).
  (setq recentf-auto-cleanup (if (daemonp) 300))
  (add-hook 'kill-emacs-hook #'recentf-cleanup))

(use-package emacs
  :ensure nil
  :hook ((prog-mode text-mode conf-mode) . display-line-numbers-mode)
  :config
  (setq hscroll-margin 2
        hscroll-step 1
        ;; Emacs spends too much effort recentering the screen if you scroll the
        ;; cursor more than N lines past window edges (where N is the settings of
        ;; `scroll-conservatively'). This is especially slow in larger files
        ;; during large-scale scrolling commands. If kept over 100, the window is
        ;; never automatically recentered. The default (0) triggers this too
        ;; aggressively, so I've set it to 10 to recenter if scrolling too far
        ;; off-screen.
        scroll-conservatively 10
        scroll-margin 0
        scroll-preserve-screen-position t
        ;; Reduce cursor lag by a tiny bit by not auto-adjusting `window-vscroll'
        ;; for tall lines.
        auto-window-vscroll nil
        ;; mouse
        mouse-wheel-scroll-amount '(2 ((shift) . hscroll))
        mouse-wheel-scroll-amount-horizontal 2)
  ;; Show current key-sequence in minibuffer ala 'set showcmd' in vim. Any
  ;; feedback after typing is better UX than no feedback at all.
  (setq echo-keystrokes 0.02)
  ;; Expand the minibuffer to fit multi-line text displayed in the echo-area. This
  ;; doesn't look too great with direnv, however...
  (setq resize-mini-windows 'grow-only)
  ;; Try to keep the cursor out of the read-only portions of the minibuffer.
  (setq minibuffer-prompt-properties '(read-only t intangible t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
  ;; Show absolute line numbers for narrowed regions to make it easier to tell the
  ;; buffer is narrowed, and where you are, exactly.
  (setq-default display-line-numbers-widen t))

(use-package frame
  :ensure nil
  :hook (after-init . window-divider-mode)
  :config
  (blink-cursor-mode 1)
  (setq window-divider-default-places t
        window-divider-default-bottom-width 1
        window-divider-default-right-width 1))

(use-package window
  :ensure nil
  :config
  (setq split-width-threshold 160
        split-height-threshold nil))

(use-package comint
  :ensure nil
  :config
  (setq comint-prompt-read-only t
        comint-buffer-maximum-size 2048)
  (with-eval-after-load 'evil
    (evil-define-key* '(normal visual) comint-mode-map "q" '(lambda () (interactive) (kill-buffer nil)))))

(use-package winner
  :ensure nil
  :init
  (winner-mode +1)
  :config
  (setq winner-boring-buffers '("*Completions*" "*Compile-Log*" "*inferior-lisp*" "*Fuzzy Completions*"
                                "*Apropos*" "*Help*" "*cvs*" "*Buffer List*" "*Ibuffer*"
                                "*esh command on file*")))

(use-package font-core
  :ensure nil
  :init
  (global-font-lock-mode t))

(use-package hideshow
  :hook (prog-mode . hs-minor-mode))

(use-package mouse
  :ensure nil
  :config
  (setq mouse-yank-at-point t))

(use-package paren
  :ensure nil
  :hook (prog-mode . show-paren-local-mode)
  :config
  (show-paren-mode 1)
  :custom
  (show-paren-style 'parenthesis)
  (show-paren-delay 0.4)
  (show-paren-context-when-offscreen 'overlay)
  (show-paren-when-point-inside-paren nil)
  (show-paren-when-point-in-periphery nil))

(use-package repeat
  :ensure nil
  :init
  (repeat-mode +1))

(use-package eshell
  :ensure nil
  :custom
  (eshell-history-size 10000)
  (eshell-hist-ignore-dups t)
  (eshell-buffer-maximum-lines 10000)
  (eshell-scroll-to-bottom-on-input t)
  (eshell-destroy-buffer-when-process-dies t)
  (eshell-prompt-regexp "^[^\)]*[\)] "))

(use-package sh-script
  :ensure nil
  :mode ("\\.bats\\'" . sh-mode)
  :mode ("\\.\\(?:zunit\\|env\\)\\'" . sh-mode)
  :mode ("/bspwmrc\\'" . sh-mode)
  :mode ("PKGBUILD" . sh-mode)
  :hook ((bash-ts-mode sh-mode) . lsp-deferred)
  :hook (sh-mode . rainbow-delimiters-mode)
  :config
  (setq sh-indent-after-continuation 'always))

(use-package select
  :ensure nil
  :custom
  (select-enable-clipboard t))

(transient-mark-mode 1)

(delete-selection-mode 1)

(use-package subword
  :ensure nil
  :init
  (global-subword-mode 1))

(use-package text-mode
  :ensure nil
  :hook ((text-mode . visual-line-mode)
         (prog-mode . (lambda () (setq-local sentence-end-double-space t))))
  :config
  (setq-default sentence-end-double-space nil)
  (setq sentence-end-without-period nil)
  (setq colon-double-space nil)
  (setq use-hard-newlines t)
  (setq adaptive-fill-mode t))

(use-package whitespace
  :ensure nil
  :config
  (setq whitespace-line-column nil
        whitespace-style
        '(face indentation tabs tab-mark spaces space-mark newline
			   trailing lines-tail)
        whitespace-display-mappings
        '((tab-mark ?\t [?› ?\t])
          (newline-mark ?\n [?¬ ?\n])
          (space-mark ?\  [?·] [?.]))))

(use-package eldoc
  :hook ((emacs-lisp-mode
          lisp-interaction-mode
          ielm-mode) . eldoc-mode))

(use-package executable
  :ensure nil
  :hook
  (after-save . executable-make-buffer-file-executable-if-script-p))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :init
  (setq dired-dwim-target t ; guess a default target directory
        dired-hide-details-hide-symlink-targets nil ; don't hide symbolic link targets
        dired-auto-revert-buffer #'dired-buffer-stale-p ; revert stale only
        dired-recursive-copies 'always ; always copy recursively
        dired-recursive-deletes 'top ; ask only for top-level
        dired-create-destination-dirs 'ask
        dired-listing-switches "-AGFhl --group-directories-first --time-style=long-iso"
        dired-clean-confirm-killing-deleted-buffers nil)
  :config
  (setq dired-mouse-drag-files t)
  (with-eval-after-load 'evil-collection
    (evil-collection-dired-setup)))

(use-package image-dired
  :ensure nil
  :config
  (setq image-dired-thumb-size 150
        image-dired-thumbnail-storage 'standard
        image-dired-external-viewer "xdg-open"))

(use-package dired-x
  :ensure nil
  :hook (dired-mode . dired-omit-mode)
  :config
  (setq dired-omit-files
        (concat dired-omit-files
				"\\|^\\.DS_Store\\'"
				"\\|^\\.project\\(?:ile\\)?\\'"
				"\\|^\\.\\(?:svn\\|git\\)\\'"
				"\\|^\\.ccls-cache\\'"
				"\\|\\(?:\\.js\\)?\\.meta\\'"
				"\\|\\.\\(?:elc\\|o\\|pyo\\|swp\\|class\\)\\'"))
  ;; Disable the prompt about whether I want to kill the Dired buffer for a
  ;; deleted directory. Of course I do!
  (setq dired-clean-confirm-killing-deleted-buffers nil)
  (let ((cmd "xdg-open"))
    (setq dired-guess-shell-alist-user
          `(("\\.\\(?:docx\\|pdf\\|djvu\\|eps\\)\\'" ,cmd)
			("\\.\\(?:jpe?g\\|png\\|gif\\|xpm\\)\\'" ,cmd)
			("\\.\\(?:xcf\\)\\'" ,cmd)
			("\\.csv\\'" ,cmd)
			("\\.tex\\'" ,cmd)
			("\\.\\(?:mp4\\|mkv\\|avi\\|flv\\|rm\\|rmvb\\|ogv\\)\\(?:\\.part\\)?\\'" ,cmd)
			("\\.\\(?:mp3\\|flac\\)\\'" ,cmd)
			("\\.html?\\'" ,cmd)
			("\\.md\\'" ,cmd)))))

(use-package dired-aux
  :ensure nil
  :config
  (setq dired-create-destination-dirs 'ask
        dired-vc-rename-file t
        dired-isearch-filenames 'dwim
        dired-create-destination-dirs-on-trailing-dirsep t))

(require 'tramp-sh)
(setq tramp-remote-path
      (append tramp-remote-path
			  '(tramp-own-remote-path)))

(if (not +config/org-directory)
    (cond
     ((file-directory-p
       (expand-file-name "Dropbox/org" (getenv "HOME")))
      (setq org-directory (expand-file-name "Dropbox/org" (getenv "HOME"))))
     ((file-directory-p
       (expand-file-name "Sync/org" (getenv "HOME")))
      (setq org-directory (expand-file-name "Sync/org" (getenv "HOME"))))
     ((file-directory-p
       (expand-file-name "Documents/google-drive/org" (getenv "HOME")))
      (setq org-directory (expand-file-name "Documents/google-drive/org" (getenv "HOME")))))
  (customize-set-variable 'org-directory +config/org-directory))

(use-package org
  :demand t
  :commands org-tempo
  :hook (org-mode . flyspell-mode)
  :hook ((org-mode . org-indent-mode)
         (org-mode . +config/org-prettify-symbols)
         (org-mode . variable-pitch-mode))
  :config
  (with-eval-after-load 'evil-collection
    (evil-collection-org-setup))
  (global-set-key (kbd "C-c l") #'org-store-link)
  (global-set-key (kbd "C-c a") #'org-agenda)
  (global-set-key (kbd "C-c c") #'org-capture)
  (cond ((file-directory-p (expand-file-name "braindump/org" org-directory))
         (customize-set-variable '+config/org-roam-directory
								 (expand-file-name "braindump/org" org-directory)))
        ((file-directory-p (expand-file-name "Projects/personal/braindump/org" (getenv "HOME")))
         (customize-set-variable '+config/org-roam-directory
								 (expand-file-name "Projects/personal/braindump/org" (getenv "HOME")))))
  (cond ((file-directory-p (expand-file-name "alexforsale.github.io" org-directory))
         (customize-set-variable '+config/blog-directory
								 (expand-file-name "alexforsale.github.io" org-directory)))
        ((file-directory-p (expand-file-name "Projects/personal/alexforsale.github.io" (getenv "HOME")))
         (customize-set-variable '+config/blog-directory
								 (expand-file-name "Projects/personal/alexforsale.github.io" (getenv "HOME")))))
  (modify-syntax-entry ?= "$" org-mode-syntax-table)
  (modify-syntax-entry ?~ "$" org-mode-syntax-table)
  (modify-syntax-entry ?_ "$" org-mode-syntax-table)
  (modify-syntax-entry ?+ "$" org-mode-syntax-table)
  (modify-syntax-entry ?/ "$" org-mode-syntax-table)
  (modify-syntax-entry ?* "$" org-mode-syntax-table)
  (add-to-list 'org-modules 'org-tempo t)
  (add-to-list 'org-structure-template-alist '("sh" . "src sh"))
  (add-to-list 'org-structure-template-alist '("co" . "src conf"))
  (add-to-list 'org-structure-template-alist '("lisp" . "src lisp"))
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
  (add-to-list 'org-structure-template-alist '("sc" . "src scheme"))
  (add-to-list 'org-structure-template-alist '("ts" . "src typescript"))
  (add-to-list 'org-structure-template-alist '("py" . "src python"))
  (add-to-list 'org-structure-template-alist '("go" . "src go"))
  (add-to-list 'org-structure-template-alist '("yaml" . "src yaml"))
  (add-to-list 'org-structure-template-alist '("js" . "src js"))
  (add-to-list 'org-structure-template-alist '("json" . "src json"))
  (add-to-list 'org-structure-template-alist '("n" . "note"))
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (awk . t)
     (C . t)
     (css . t)
     (calc . t)
     (ditaa . t) ; needs the `ditaa' package
     (dot . t ) ; `graphviz'
     (screen . t)
     (haskell . t)
     (java . t)
     (js . t)
     (latex . t)
     (lisp . t)
     (lua . t)
     (org . t)
     (perl . t)
     (plantuml . t)
     (python .t)
     (ruby . t)
     (shell . t)
     (sed . t)
     (scheme . t)
     (sql . t)
     (sqlite . t)))
  (setq-default org-use-sub-superscripts '{})
  (add-to-list 'org-babel-tangle-lang-exts '("js" . "js"))
  (defun +config/org-prettify-symbols ()
    (push '("[ ]" . "☐") prettify-symbols-alist)
    (push '("[X]" . "☑") prettify-symbols-alist)
    (prettify-symbols-mode))
  (require 'org-tempo)
  :custom
  (org-highlight-latex-and-related '(native script entities))
  (org-replace-disputed-keys t)
  (org-indirect-buffer-display 'current-window)
  (org-enforce-todo-dependencies t)
  (org-fontify-whole-heading-line t)
  (org-return-follows-link t)
  (org-mouse-1-follows-link t)
  (org-image-actual-width nil)
  (org-adapt-indentation nil)
  (org-startup-indented t)
  (org-link-descriptive nil)
  (org-log-done 'time)
  (org-log-refile 'time)
  (org-log-redeadline 'time)
  (org-log-reschedule 'time)
  (org-log-into-drawer t)
  (org-clone-delete-id t)
  (org-default-notes-file (expand-file-name "notes.org" org-directory))
  (org-insert-heading-respect-content nil)
  (org-pretty-entities t)
  (org-use-property-inheritance t)
  (org-priority-highest ?A)
  (org-priority-lowest ?D)
  (org-priority-default ?B)
  (org-todo-keywords
   '((sequence
      "TODO(t!)"  ; A task that needs doing & is ready to do
      "NEXT(n!)"  ; Tasks that can be delayed
      "PROG(p!)"  ; A task that is in progress
      "WAIT(w!)"  ; Something external is holding up this task
      "HOLD(h!)"  ; This task is paused/on hold because of me
      "|"
      "DONE(d!)"  ; Task successfully completed
      "DELEGATED(l!)" ; Task is delegated
      "NOTES(o!)" ; set as notes
      "KILL(k!)") ; Task was cancelled, aborted or is no longer applicable
   ))
  (org-todo-keyword-faces
   '(("PROG" . (:foreground "#268bd2" :weight bold))
     ("WAIT" . (:foreground "#b58900" :weight bold))
     ("HOLD" . (:foreground "#859900" :weight bold))
     ("NEXT" . (:foreground "#2aa198" :weight bold))
     ("NOTES" . "#6c7c80")
     ("DELEGATED" . "#d33682")
     ("KILL" . "#a3be8c"))))

(use-package org-entities
  :ensure nil
  :config
  (setq org-entities-user
        '(("flat"  "\\flat" nil "" "" "266D" "♭")
          ("sharp" "\\sharp" nil "" "" "266F" "♯"))))

(use-package org-contrib)

(use-package org-faces
  :ensure nil
  :custom
  (org-fontify-quote-and-verse-blocks t))

(use-package org-archive
  :ensure nil
  :after org
  :custom
  (org-archive-tag "archive")
  (org-archive-subtree-save-file-p t)
  (org-archive-mark-done t)
  (org-archive-reversed-order t)
  (org-archive-location (concat (expand-file-name "archives.org" org-directory) "::datetree/* Archived Tasks")))

(use-package org-capture
  :after org
  :ensure nil
  :demand t
  :config
  (org-capture-put :kill-buffer t)
  (setq org-capture-templates ;; this is the default from `doom'.
        `(("i" "Inbox - Goes Here first!" entry
           (file+headline ,(expand-file-name "inbox.org" org-directory) "Inbox")
           "** %?\n%i\n%a" :prepend t)
          ;; ("r" "Request" entry (file+headline ,(expand-file-name "inbox.org" org-directory) "Request")
          ;;  (file ,(expand-file-name "request.template" org-directory)))
          ("l" "Links" entry
           (file+headline ,(expand-file-name "links.org" org-directory) "Links")))))

(use-package org-refile
  :ensure nil
  :after org
  :hook (org-after-refile-insert . save-buffer)
  :custom
  (org-refile-targets
   `((,(expand-file-name "projects.org" org-directory) :maxlevel . 1)
     (,(expand-file-name "notes.org" org-directory) :maxlevel . 1)
     (,(expand-file-name "routines.org" org-directory) :maxlevel . 3)
     (,(expand-file-name "personal.org" org-directory) :maxlevel . 1)))
  (org-refile-use-outline-path 't)
  (org-outline-path-complete-in-steps nil))

(use-package org-fold
  :ensure nil
  :after org org-contrib
  :custom
  (org-catch-invisible-edits 'smart))

(use-package org-id
  :ensure nil
  :after org
  :custom
  (org-id-locations-file-relative t)
  (org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id))

(use-package org-num
  :ensure nil
  :after org
  :custom
  (org-num-face '(:inherit org-special-keyword :underline nil :weight bold))
  (org-num-skip-tags '("noexport" "nonum")))

(use-package org-crypt
  :ensure nil
  :after org
  :commands org-encrypt-entries org-encrypt-entry org-decrypt-entries org-decrypt-entry
  ;;:hook (org-reveal-start . org-decrypt-entry)
  :preface
  ;; org-crypt falls back to CRYPTKEY property then `epa-file-encrypt-to', which
  ;; is a better default than the empty string `org-crypt-key' defaults to.
  (defvar org-crypt-key nil)
  (with-eval-after-load 'org
    (add-to-list 'org-tags-exclude-from-inheritance "crypt"))
  :config
  (setopt epa-file-encrypt-to "alexforsale@yahoo.com"))

(use-package org-attach
  :ensure nil
  :after org
  :commands (org-attach-new
			 org-attach-open
			 org-attach-open-in-emacs
			 org-attach-reveal-in-emacs
			 org-attach-url
			 org-attach-set-directory
			 org-attach-sync)
  :config
  (unless org-attach-id-dir
    (setq-default org-attach-id-dir (expand-file-name ".attach/" org-directory)))
  (with-eval-after-load 'projectile
    (add-to-list 'projectile-globally-ignored-directories org-attach-id-dir))
  :custom
  (org-attach-auto-tag nil))

(use-package org-agenda
  :ensure nil
  :after org
  :custom
  (org-agenda-breadcrumbs-separator " → ")
  (org-agenda-files (list (concat org-directory "/")))
  (org-agenda-file-regexp "\\`[^.].*\\.org\\|[0-9]+$\\'")
  (org-agenda-include-inactive-timestamps t)
  (org-agenda-window-setup 'only-window)
  (org-stuck-projects '("+{project*}-killed-Archives/-DONE-KILL-DELEGATED"
                        ("TODO" "NEXT" "IDEA" "PROG")
                        nil ""))
  :config
  (with-eval-after-load 'evil
    (evil-set-initial-state #'org-agenda-mode 'normal)
    (evil-define-key 'normal org-agenda-mode-map "q" 'org-agenda-quit))
  (setq org-agenda-custom-commands
        `(("w" "Work Agenda and all TODOs"
           ((agenda ""
					((org-agenda-span 1)
					 (org-agenda-start-on-weekday t)
					 (org-agenda-block-separator nil)
					 (org-agenda-use-time-grid t)
					 (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
					 (org-agenda-format-date "%A %-e %B %Y")
					 (org-agenda-overriding-header "\nToday\n")))
            (tags-todo "TODO=\"TODO\"|\"NEXT\""
					   ((org-agenda-block-separator nil)
						(org-agenda-skip-function '(org-agenda-skip-if-todo 'nottodo 'done))
						(org-agenda-use-time-grid nil)
						(org-agenda-overriding-header "\nIncomplete\n")))
            (agenda ""
					((org-agenda-span 7)
					 (org-agenda-start-on-weekday 1)
					 (org-agenda-block-separator nil)
					 (org-agenda-use-time-grid nil)
					 (org-agenda-overriding-header "\nWeekly\n"))))
           ((org-agenda-tag-filter-preset '("-personal" "-home"))))
          ("h" "Home Agenda and all personal TODOs"
           ((agenda ""
					((org-agenda-span 1)
					 (org-agenda-start-on-weekday t)
					 (org-agenda-block-separator nil)
					 (org-agenda-use-time-grid t)
					 (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
					 (org-agenda-format-date "%A %-e %B %Y")
					 (org-agenda-overriding-header "\nToday\n")))
			(tags-todo "TODO=\"TODO\"|\"NEXT\""
					   ((org-agenda-block-separator nil)
						(org-agenda-skip-function '(org-agenda-skip-if-todo 'nottodo 'done))
						(org-agenda-use-time-grid nil)
						(org-agenda-overriding-header "\nIncomplete\n")))
			(agenda ""
					((org-agenda-span 7)
					 (org-agenda-start-on-weekday 1)
					 (org-agenda-block-separator nil)
					 (org-agenda-use-time-grid nil)
					 (org-agenda-overriding-header "\nWeekly\n"))))
           ;; ((org-agenda-tag-filter-preset '("+personal")))
          ))))

(use-package org-clock
  :ensure nil
  :after org
  :commands org-clock-save
  :hook (kill-emacs . org-clock-save)
  :custom
  (org-persist 'history)
  (org-clock-in-resume t)
  (org-clock-out-remove-zero-time-clocks t)
  (org-clock-history-length 20)
  (org-show-notification-handler "notify-send")
  (org-agenda-skip-scheduled-if-deadline-is-shown t)
  :config
  (org-clock-persistence-insinuate))

(use-package org-timer
  :ensure nil
  :config
  (setq org-timer-format "Timer :: %s"))

(use-package org-eldoc
  :ensure nil
  :after org org-contrib
  :config
  (puthash "org" #'ignore org-eldoc-local-functions-cache)
  ;;(puthash "plantuml" #'ignore org-eldoc-local-functions-cache)
  (puthash "python" #'python-eldoc-function org-eldoc-local-functions-cache)
  :custom
  (org-eldoc-breadcrumb-separator " → "))

(use-package org-superstar
  :hook (org-mode . org-superstar-mode)
  :custom
  (org-superstar-leading-bullet ?\s)
  (org-superstar-leading-fallback ?\s)
  (org-hide-leading-stars nil)
  (org-indent-mode-turns-on-hiding-stars nil)
  (org-superstar-todo-bullet-alist
   '(("TODO" . 9744)
     ("[ ]"  . 9744)
     ("DONE" . 9745)
     ("[X]"  . 9745)))
  :config
  (org-superstar-configure-like-org-bullets))

(use-package org-fancy-priorities ; priority icons
  :defer t
  :hook (org-mode . org-fancy-priorities-mode)
  :hook (org-agenda-mode . org-fancy-priorities-mode)
  :custom
  (org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")))

(use-package org-modern
  :demand t
  :config
  (set-face-attribute 'org-modern-symbol nil :family "Iosevka Nerd Font")
  (setq
   ;; Edit settings
   org-auto-align-tags nil
   org-tags-column 0
   org-fold-catch-invisible-edits 'show-and-error
   org-special-ctrl-a/e t
   org-insert-heading-respect-content t
   ;; Org styling, hide markup etc.
   org-hide-emphasis-markers nil ; set to nil for easier editing
   org-ellipsis "…"
   ;; Agenda styling
   org-agenda-tags-column 0
   org-agenda-block-separator ?─
   org-agenda-time-grid
   '((daily today require-timed)
     (800 1000 1200 1400 1600 1800 2000)
     " ┄┄┄┄┄ " "┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄")
   org-agenda-current-time-string
   "◀── now ─────────────────────────────────────────────────")
  (global-org-modern-mode))

(use-package org-download
  :after org
  :commands
  org-download-dnd
  org-download-yank
  org-download-screenshot
  org-download-clipboard
  org-download-dnd-base64
  :config
  (unless org-download-image-dir
    (setq org-download-image-dir org-attach-id-dir))
  (setq org-download-method 'attach
        org-download-timestamp "_%Y%m%d_%H%M%S"
        org-download-screenshot-method
        (cond ((featurep :system 'macos) "screencapture -i %s")
			  ((featurep :system 'linux)
			   (cond ((executable-find "maim")  "maim -s %s")
					 ((executable-find "scrot") "scrot -s %s")
					 ((executable-find "gnome-screenshot") "gnome-screenshot -a -f %s"))))
        org-download-heading-lvl nil
        org-download-link-format "[[download:%s]]\n"
        org-download-annotate-function (lambda (_link) "")
        org-download-link-format-function
        (lambda (filename)
          (if (eq org-download-method 'attach)
			  (format "[[attachment:%s]]\n"
					  (org-link-escape
					   (file-relative-name filename (org-attach-dir))))
			;; Handle non-image files a little differently. Images should be
			;; inserted as normal with previews. Other files, like pdfs or zips,
			;; should be linked to, with an icon indicating the type of file.
			(format (concat (unless (image-type-from-file-name filename)
                              (concat (+org-attach-icon-for filename)
									  " "))
							org-download-link-format)
					(org-link-escape
					 (funcall org-download-abbreviate-filename-function filename)))))
        org-download-abbreviate-filename-function
        (lambda (path)
          (if (file-in-directory-p path org-download-image-dir)
			  (file-relative-name path org-download-image-dir)
			path))))

(use-package org-roam
  :if (not (equal 'windows-nt system-type))
  :demand t
  :after org
  :custom
  (org-roam-directory +config/org-roam-directory)
  (org-roam-complete-everywhere t)
  (org-roam-capture-templates
   '(("d" "default" plain
      "#+author: %n\n#+date: %t\n#+description: \n#+hugo_base_dir: ..\n#+hugo_section: posts\n#+hugo_categories: other\n#+property: header-args :exports both\n#+hugo_tags: \n%?"
      :if-new (file+head "%<%Y-%m-%d_%H-%M-%S>-''${slug}.org" "#+title: ''${title}\n")
      :unnarrowed t)
     ("p" "programming" plain
      "#+author: %n\n#+date: %t\n#+description: \n#+hugo_base_dir: ..\n#+hugo_section: posts\n#+hugo_categories: programming\n#+property: header-args :exports both\n#+hugo_tags: \n%?"
      :if-new (file+head "%<%Y-%m-%d_%H-%M-%S>-''${slug}.org" "#+title: ''${title}\n")
      :unnarrowed t)
     ("t" "tech" plain
      "#+author: %n\n#+date: %t\n#+description: \n#+hugo_base_dir: ..\n#+hugo_section: posts\n#+hugo_categories: tech\n#+property: header-args :exports both\n#+hugo_tags: \n%?"
      :if-new (file+head "%<%Y-%m-%d_%H-%M-%S>-''${slug}.org" "#+title: ''${title}\n")
      :unnarrowed t)))
  (org-roam-capture-ref-templates
   '(("r" "ref" plain "#+author: %n\n#+date: %t\n#+description: \n#+hugo_base_dir: ..\n#+hugo_section: posts\n#+hugo_categories: reference\n#+property: header-args :exports both\n#+hugo_tags: \n%?\n* Links\n- %l" :target (file+head "''${slug}.org" "#+title: ''${title}")
      :unnarrowed t)))
  :config
  (org-roam-setup)
  (org-roam-db-autosync-mode)
  (require 'org-roam-protocol)
  (with-eval-after-load 'evil-collection
    (evil-collection-org-roam-setup)))

(use-package org-roam-ui
  :after org-roam ;; or :after org
  ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
  ;;         a hookable mode anymore, you're advised to pick something yourself
  ;;         if you don't care about startup time, use
  ;;  :hook (after-init . org-roam-ui-mode)
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start t))

(use-package make-mode
  :ensure nil
  :config
  (add-hook 'makefile-mode-hook 'indent-tabs-mode))

(use-package editorconfig)

(use-package executable
  :ensure nil
  :hook
  (after-save . executable-make-buffer-file-executable-if-script-p))

(use-package magit
  :demand t
  :hook (with-editor-mode . evil-insert-state)
  :config
  (with-eval-after-load 'evil-collection
    (evil-collection-magit-repos-setup)
    (evil-collection-magit-section-setup)
    (evil-collection-magit-setup))
  :custom
  (magit-revision-show-gravatars '("^Author:     " . "^Commit:     "))
  (magit-diff-refine-hunk 'all)
  (magit-log-arguments '("-n100" "--graph" "--decorate")))

(use-package elfeed
  :demand t
  :config
  (with-eval-after-load 'evil-collection
    (evil-collection-elfeed-setup)))

(use-package elfeed-org
  :after elfeed
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list (expand-file-name "elfeed.org" org-directory))))

(use-package elfeed-goodies
  :after elfeed
  :config
  (elfeed-goodies/setup))

(use-package ox-hugo
  :if (executable-find "hugo")
  :after ox)

(defun my/create-blog-capture-file ()
  "Create a subdirectory and `org-mode' file under `+config/blog-directory'."
  (interactive)
  (let* ((name (read-string "slug: "))
         (content-dir (expand-file-name "content-org/" +config/blog-directory)))
    (unless (file-directory-p (expand-file-name name content-dir))
      (make-directory (expand-file-name name content-dir)))
    (expand-file-name (concat name ".org") (expand-file-name name content-dir))))

(add-to-list 'org-capture-templates
			 '("h" "Hugo Post" plain
			   (file my/create-blog-capture-file)
			   "#+options: ':nil -:nil ^:nil num:nil toc:nil
#+author: %n
#+title: %^{Title}
#+description:
#+date: %t
#+hugo_categories: %^{Categories|misc|desktop|emacs|learning}
#+hugo_tags: %^{Tags}
#+hugo_auto_set_lastmod: t
#+hugo_section: posts
#+hugo_base_dir: ../../
#+language: en
#+startup: inlineimages

         * %?" :jump-to-captured t))

(use-package password-store
  :demand t
  :config
  (setq password-store-password-length 12)
  (setq auth-sources '(password-store "~/.authinfo.gpg" "~/.netrc")))

(use-package password-store-otp
  :defer t
  :after password-store)

(use-package pass
  :defer t
  :config
  (with-eval-after-load 'evil-collection
    (evil-collection-pass-setup)))

(use-package auth-source-pass
  :ensure nil
  :init
  (auth-source-pass-enable))

(use-package pinentry
  :defer t
  :config
  (pinentry-start))

(use-package fzf
  :if (executable-find "fzf")
  :config
  (setq fzf/args "-x --color dark --print-query --margin=1,0 --no-hscroll"
        fzf/executable "fzf"
        fzf/git-grep-args "-i --line-number %s"
        ;; command used for `fzf-grep-*` functions
        ;; example usage for ripgrep:
        ;; fzf/grep-command "rg --no-heading -nH"
        fzf/grep-command "rg --no-heading -nH"
        ;; If nil, the fzf buffer will appear at the top of the window
        fzf/position-bottom t
        fzf/window-height 15))

(use-package rg
  :if (executable-find "rg")
  :defer t
  :config
  (with-eval-after-load 'evil-collection
    (evil-collection-rg-setup)))

(use-package vertico
  :hook
  (rfn-eshadow-update-overlay . vertico-directory-tidy)
  :custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  (vertico-count 15) ;; Show more candidates
  (vertico-resize nil) ;; Grow and shrink the Vertico minibuffer
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :config
  (advice-add #'tmm-add-prompt :after #'minibuffer-hide-completions)
  (keymap-set vertico-map "?" #'minibuffer-completion-help)
  :init
  (vertico-mode))

(use-package emacs
  :custom
  ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
  ;; to switch display modes.
  (context-menu-mode t)
  ;; Support opening new minibuffers from inside existing minibuffers.
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.  Vertico
  ;; commands are hidden in normal buffers. This setting is useful beyond
  ;; Vertico.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt)))

(use-package vertico-directory
  :after vertico
  :ensure nil
  ;; More convenient directory navigation commands
  :bind (:map vertico-map
			  ("RET" . vertico-directory-enter)
			  ("DEL" . vertico-directory-delete-char)
			  ("M-DEL" . vertico-directory-delete-word))
  ;; Tidy shadowed file names
  :hook (rfn-eshadow-update-overlay . vertico-directory-tidy))

(use-package vertico-quick
  :after vertico
  :ensure nil
  :bind (:map vertico-map
			  ("M-q" . vertico-quick-insert)
			  ("C-q" . vertico-quick-exit)))

(use-package vertico-multiform
  :ensure nil
  :init
  (vertico-multiform-mode)
  :config
  (setq vertico-multiform-commands
        `((describe-symbol (vertico-sort-function . vertico-sort-alpha))
          (consult-outline buffer ,(lambda (_) (text-scale-set -1)))
          (org-ctrl-c-ctrl-c flat)))
  (defun sort-directories-first (files)
    (setq files (vertico-sort-history-length-alpha files))
    (nconc (seq-filter (lambda (x) (string-suffix-p "/" x)) files)
           (seq-remove (lambda (x) (string-suffix-p "/" x)) files)))
  (setq vertico-multiform-categories
        '((symbol (vertico-sort-function . vertico-sort-alpha))
          (file (vertico-sort-function . sort-directories-first)))))

(use-package consult
  :demand t
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  (advice-add #'register-preview :override #'consult-register-window)
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.4 any))
  (setq consult-narrow-key "<") ;; "C-+"
  (with-eval-after-load 'projectile
    (autoload 'projectile-project-root "projectile")
    (setq consult-project-function (lambda (_) (projectile-project-root))))
  (setq consult-line-numbers-widen t
        consult-async-min-input 2
        consult-async-refresh-delay  0.15
        consult-async-input-throttle 0.2
        consult-async-input-debounce 0.1)

  (keymap-set isearch-mode-map "M-e" #'consult-isearch-history)
  (keymap-set isearch-mode-map "M-l" #'consult-line)
  (keymap-set isearch-mode-map "M-L" #'consult-line-multi)

  (keymap-set minibuffer-local-map "M-s" #'consult-history)
  (keymap-set minibuffer-local-map "M-r" #'consult-history)

  (global-set-key [remap Info-search] 'consult-info)
  (global-set-key [remap yank-pop] 'consult-yank-pop)
  (global-set-key [remap bookmark-jump] 'consult-bookmark)
  (global-set-key [remap evil-show-marks] 'consult-mark)
  (global-set-key [remap evil-show-registers] 'consult-register)
  (global-set-key [remap goto-line] 'consult-goto-line)
  (global-set-key [remap imenu] 'consult-imenu)
  (global-set-key [remap locate] 'consult-locate)
  (global-set-key [remap load-theme] 'consult-theme)
  (global-set-key [remap man] 'consult-man)
  (global-set-key [remap recentf-open-files] 'consult-recent-file)
  (global-set-key [remap switch-to-buffer] 'consult-buffer)
  (global-set-key [remap switch-to-buffer-other-frame] 'consult-buffer-other-frame)
  (global-set-key [remap switch-to-buffer-other-window] 'consult-buffer-other-window))

(use-package consult-dir
  :bind (:map vertico-map
			  ("C-x C-d" . consult-dir)
			  ("C-x C-j" . consult-dir-jump-file)))

(use-package embark
  :defer t
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  (with-eval-after-load 'evil-collection
    (evil-collection-embark-setup))
  (setq which-key-use-C-h-commands nil
        prefix-help-command #'embark-prefix-help-command)
  (with-eval-after-load 'evil
    (evil-define-key* '(normal visual insert) 'global (kbd "C-.") 'embark-act))
  (add-to-list 'display-buffer-alist
			   '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
				 nil
				 (window-parameters (mode-line-format . none)))))

(use-package embark-consult
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package corfu
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-delay 0.18)
  (corfu-auto-prefix 2)
  (corfu-quit-no-match 'separator)
  (corfu-preselect 'prompt)
  (corfu-count 16)
  (corfu-max-width 120)
  (corfu-on-exact-match nil)
  (corfu-quit-no-match corfu-quit-at-boundary)
  (completion-cycle-threshold 3)
  (text-mode-ispell-word-completion nil)
  :init
  (defun my/orderless-dispatch-flex-first (_pattern index _total)
    (and (eq index 0) 'orderless-flex))
  :config
  ;;(add-to-list 'completion-category-overrides `(lsp-capf (styles ,@completion-styles)))
  (add-hook 'evil-insert-state-exit-hook #'corfu-quit)
  (with-eval-after-load 'exwm
    (advice-add #'corfu--make-frame :around
				(defun +corfu--make-frame-a (oldfun &rest args)
				  (cl-letf (((symbol-function #'frame-parent)
							 (lambda (frame)
							   (or (frame-parameter frame 'parent-frame)
								   exwm-workspace--current))))
					(apply oldfun args))
				  (when exwm--connection
					(set-frame-parameter corfu--frame 'parent-frame nil))))
    (advice-add #'corfu--popup-redirect-focus :override
				(defun +corfu--popup-redirect-focus-a ()
				  (redirect-frame-focus corfu--frame
										(or (frame-parent corfu--frame)
											exwm-workspace--current)))))
  (defun corfu-enable-always-in-minibuffer ()
    "Enable Corfu in the minibuffer if Vertico/Mct are not active."
    (unless (or (bound-and-true-p mct--active)
                (bound-and-true-p vertico--input)
                (eq (current-local-map) read-passwd-map))
      (setq-local corfu-echo-delay nil ;; Disable automatic echo and popup
				  corfu-popupinfo-delay nil)
      (corfu-mode 1)))
  (add-hook 'minibuffer-setup-hook #'corfu-enable-always-in-minibuffer 1)
  :init
  (global-corfu-mode))

(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic substring partial-completion)
        completion-category-defaults nil
        completion-category-overrides '((file (styles orderless partial-completion)))
        orderless-component-separator #'orderless-escapable-split-on-space)
  (set-face-attribute 'completions-first-difference nil :inherit nil))

(use-package corfu-history
  :ensure nil
  :hook ((corfu-mode . corfu-history-mode))
  :config
  (with-eval-after-load 'savehist
    (add-to-list 'savehist-additional-variables 'corfu-history)))

(use-package corfu-popupinfo
  :ensure nil
  :hook ((corfu-mode . corfu-popupinfo-mode))
  :config
  (setq corfu-popupinfo-delay '(0.5 . 1.0))
  (setq corfu-popupinfo-hide nil))

(use-package cape
  :bind (("C-c p p" . completion-at-point) ;; capf
         ("C-c p t" . complete-tag)        ;; etags
         ("C-c p d" . cape-dabbrev))       ;; or dabbrev-completion
  :hook
  (prog-mode . +corfu-add-cape-file-h)
  ((org-mode markdown-mode) . +corfu-add-cape-elisp-block-h)
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
  :config
  (setq cape-dabbrev-check-other-buffers t)
  (defun +corfu-add-cape-file-h ()
    (add-hook 'completion-at-point-functions #'cape-file -10 t))
  (defun +corfu-add-cape-elisp-block-h ()
    (add-hook 'completion-at-point-functions #'cape-elisp-block 0 t))
  (with-eval-after-load 'lsp-mode
    (advice-add #'lsp-completion-at-point :around #'cape-wrap-noninterruptible)
    (advice-add #'lsp-completion-at-point :around #'cape-wrap-nonexclusive))
  (advice-add #'comint-completion-at-point :around #'cape-wrap-nonexclusive)
  (with-eval-after-load 'eglot
    (advice-add #'eglot-completion-at-point :around #'cape-wrap-nonexclusive))
  (advice-add #'pcomplete-completions-at-point :around #'cape-wrap-nonexclusive)
  ;; From the `cape' readme. Without this, Eshell autocompletion is broken on
  ;; Emacs28.
  (when (< emacs-major-version 29)
    (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-silent)
    (advice-add 'pcomplete-completions-at-point :around #'cape-wrap-purify)))

(use-package kind-icon
  :if (display-graphic-p)
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package marginalia
  :bind (:map minibuffer-local-map
			  ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package nix-mode 
  :hook (nix-mode . lsp-deferred)
  :mode "\\.nix\\'")

(when (not (display-graphic-p))
  (load-theme 'base16-nord-light))

(when (file-exists-p (expand-file-name "staging.el" user-emacs-directory))
  (load-file (expand-file-name "staging.el" user-emacs-directory)))

(use-package projectile
  :demand t
  :commands (projectile-project-root
             projectile-project-name
             projectile-project-p
             projectile-locate-dominating-file
             projectile-relevant-known-projects)
  :bind (([remap evil-jump-to-tag] . projectile-find-tag)
         ([remap find-tag] . projectile-find-tag))
  :hook (dired-before-readin . projectile-track-known-projects-find-file-hook)
  :custom
  (projectile-cache-file (expand-file-name ".projects" user-emacs-directory))
  (projectile-auto-discover nil)
  (projectile-enable-caching (not noninteractive))
  (projectile-globally-ignored-files '("DS_Store" "TAGS"))
  (projectile-globally-ignored-file-suffixes '(".elc" ".pyc" ".o"))
  (projectile-kill-buffers-filter 'kill-only-files)
  (projectile-known-projects-file (expand-file-name ".projectile_projects.eld" user-emacs-directory))
  (projectile-ignored-projects '("~/"))
  (projectile-project-search-path `(,(expand-file-name "Projects" (getenv "HOME"))))
  (projectile-project-root-files-bottom-up
   (append '(".projectile" ".project" ".git")
           (when (executable-find "hg")
             '(".hg"))
           (when (executable-find "bzr")
             '(".bzr"))))
  (projectile-project-root-files-top-down-recurring '("Makefile"))
  (compilation-buffer-name-function #'projectile-compilation-buffer-name)
  (compilation-save-buffers-predicate #'projectile-current-project-buffer-p)
  (projectile-git-submodule-command nil)
  (projectile-indexing-method 'hybrid)
  :config
  (global-set-key [remap evil-jump-to-tag] #'projectile-find-tag)
  (global-set-key [remap find-tag]         #'projectile-find-tag)
  (projectile-mode +1)
  (put 'projectile-git-submodule-command 'initial-value projectile-git-submodule-command))

(use-package perspective
  :demand t
  :config
  (setq persp-initial-frame-name "Main"
        persp-suppress-no-prefix-key-warning t)
  (if (featurep 'no-littering)
      (setq persp-state-default-file (expand-file-name ".perspective-state" no-littering-var-directory))
    (setq persp-state-default-file (expand-file-name ".perspective-state" user-emacs-directory)))
  (global-set-key [remap switch-to-buffer] #'persp-switch-to-buffer*)
  (when (featurep 'consult)
    (require 'consult)
    (unless (boundp 'persp-consult-source)
      (defvar persp-consult-source
        (list :name     "Perspective"
              :narrow   ?s
              :category 'buffer
              :state    #'consult--buffer-state
              :history  'buffer-name-history
              :default  t
              :items
              #'(lambda () (consult--buffer-query :sort 'visibility
                                             :predicate '(lambda (buf) (persp-is-current-buffer buf t))
                                             :as #'buffer-name)))))
    (consult-customize consult--source-buffer :hidden t :default nil)
    (add-to-list 'consult-buffer-sources persp-consult-source))
  (with-eval-after-load 'evil
    (evil-define-key* '(normal visual) 'global
      (kbd "<leader>TAB") (cons "Perspective" perspective-map))
    (evil-define-key* nil perspective-map
      (kbd "TAB") '("swich to last used perspective" . persp-switch-last)
      "P" '("switch project" . projectile-persp-switch-project)))
  :init
  (customize-set-variable 'persp-mode-prefix-key (kbd "C-c TAB"))
  (unless (equal persp-mode t)
    (persp-mode 1))
  :bind (([remap switch-to-buffer] . persp-switch-to-buffer*)
         ([remap kill-buffer] . persp-kill-buffer*))
  :hook (kill-emacs . persp-state-save))

(use-package persp-projectile
  :after perspective
  :commands projectile-persp-switch-project)

(use-package yasnippet
  :config
  (yas-global-mode)
  (define-key yas-keymap [tab] 'yas-next-field)
  (setq yas-snippets-dir
        (list (expand-file-name "snippets" user-emacs-directory)
              (expand-file-name "straight/build/yasnippet-snippets/snippets" user-emacs-directory))))

(use-package consult-yasnippet)

(use-package yasnippet-snippets)

(use-package yasnippet-capf
  :after cape
  :config
  (add-to-list 'completion-at-point-functions #'yasnippet-capf))

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package smartparens
  :hook (text-mode markdown-mode prog-mode)
  :config
  (require 'smartparens-config))

(use-package js
  :ensure nil
  :mode ("\\.[mc]?js\\'" . js-mode)
  :mode ("\\.es6\\'" . js-mode)
  :mode ("\\.pac\\'" . js-mode)
  :config
  (with-eval-after-load 'smartparens
      (sp-local-pair 'js-mode "<" nil :actions :rem)
      (sp-local-pair 'js-ts-mode "<" nil :actions :rem))
  (setopt js-chain-indent t))

(use-package typescript-mode
  :interpreter "ts-node")

(use-package rjsx-mode)

(use-package kdl-mode)

(use-package markdown-mode
  :defer t
  :mode
  ("README\\.md\\'" . gfm-mode)
  :init
  (when (executable-find "markdown")
    (setq markdown-command "markdown"))
  (when (executable-find "multimarkdown")
    (setq markdown-command "multimarkdown"))
  :config
  (with-eval-after-load 'evil-collection
    (evil-collection-markdown-mode-setup))
  (with-eval-after-load 'lsp-mode
    (add-hook 'markdown-mode-hook #'lsp-deferred))
  (setq markdown-fontify-code-blocks-natively t))

(use-package poly-markdown
  :init
  :mode
  (("README\\.md\\'" . gfm-mode)
   ("\\.md$" . markdown-mode)
   ("\\.markdown$" . markdown-mode)))

(use-package edit-indirect
  :after markdown-mode)

(use-package python
  :ensure nil
  :mode ("[./]flake8\\'" . conf-mode)
  :mode ("/Pipfile\\'" . conf-mode)
  :hook ((python-mode python-ts-mode) . lsp-deferred)
  :config
  (with-eval-after-load 'evil-collection
    (evil-collection-python-setup))
  (with-eval-after-load 'lsp-mode
    (add-hook 'python-mode-hook #'lsp-deferred)
    (add-hook 'python-mode-hook #'lsp-ui-mode)
    (add-hook 'python-mode-hook #'lsp-ui-doc-mode)
    (add-hook 'python-mode-local-vars-hook '(lambda () (lsp-deferred))))
  (if (executable-find "ipython")
      (setq python-interpreter (executable-find "ipython"))
    (setq python-interpreter (executable-find "python3")))
  (when (featurep 'projectile)
    (add-to-list 'projectile-globally-ignored-directories "^\\.venv$"))
  (let ((directories `("/usr/bin/" "/usr/local/bin/" "/opt/bin" ,(expand-file-name ".local/bin/" (getenv "HOME")))))
    (dolist (directory directories) (when (file-directory-p directory) (add-to-list 'python-shell-exec-path directory))))
  (setq python-indent-guess-indent-offset nil
        python-shell-completion-native-enable nil
        python-shell-exec-path (list "/usr/bin/" "/usr/local/bin" (expand-file-name ".local/bin/" (getenv "HOME")))
        python-indent-guess-indent-offset-verbose nil)
  (when (featurep 'lsp-mode)
    (setq lsp-pylsp-plugins-rope-completion-enabled t ; needs python-rope package
          lsp-pylsp-plugins-mccabe-enabled t ; needs python-mccabe package
          lsp-ruff-lsp-python-path (executable-find "python3"))
    (when (executable-find "black")
      (setq lsp-pylsp-plugins-black-enabled t))
    (when (executable-find "autopep8")
      (setq lsp-pylsp-plugins-autopep8-enabled t))
    (when (executable-find "flake8")
      (setq lsp-pylsp-plugins-flake8-enabled t))
    (when (executable-find "pycodestyle")
      (setq lsp-pylsp-plugins-pycodestyle-enabled t))
    (when (executable-find "pydocstyle")
      (setq lsp-pylsp-plugins-pydocstyle-enabled t))
    (when (executable-find "pylint")
      (setq lsp-pylsp-plugins-pylint-enabled t))
    (when (executable-find "pyflakes")
      (setq lsp-pylsp-plugins-pyflakes-enabled t))
    (when (executable-find "yapf")
      (setq lsp-pylsp-plugins-yapf-enabled t)))
  (when (featurep 'flycheck)
    (setq flycheck-python-mypy-executable (executable-find "mypy")
          flycheck-python-flake8-executable (executable-find "flake8")
          flycheck-python-pylint-executable (executable-find "pylint")
          flycheck-python-pyright-executable (executable-find "pyright")))
  (with-eval-after-load 'tree-sitter
    (add-hook 'python-mode-local-vars-hook #'tree-sitter! 'append))

  (defun +python-executable-find (exe)
    "Resolve the path to the EXE executable.
  Tries to be aware of your active conda/pipenv/virtualenv environment, before
  falling back on searching your PATH."
    (if (file-name-absolute-p exe)
        (and (file-executable-p exe)
             exe)
      (let ((exe-root (format "bin/%s" exe)))
        (cond ((when python-shell-virtualenv-root
                 (let ((bin (expand-file-name exe-root python-shell-virtualenv-root)))
                   (if (file-exists-p bin) bin))))
              ((when (require 'conda nil t)
                 (let ((bin (expand-file-name (concat conda-env-current-name "/" exe-root)
                                              (conda-env-default-location))))
                   (if (file-executable-p bin) bin))))
              ((when-let (bin (projectile-locate-dominating-file default-directory "bin/python"))
                 (setq-local doom-modeline-python-executable (expand-file-name "bin/python" bin))))
              ((executable-find exe))))))

  (defun +python/open-repl ()
    "Open the Python REPL."
    (interactive)
    (require 'python)
    (unless python-shell-interpreter
      (user-error "`python-shell-interpreter' isn't set"))
    (pop-to-buffer
     (process-buffer
      (let ((dedicated (bound-and-true-p python-shell-dedicated)))
        (if-let* ((pipenv (+python-executable-find "pipenv"))
                  (pipenv-project (pipenv-project-p)))
            (let ((default-directory pipenv-project)
                  (python-shell-interpreter-args
                   (format "run %s %s"
                           python-shell-interpreter
                           python-shell-interpreter-args))
                  (python-shell-interpreter pipenv))
              (run-python nil dedicated t))
          (run-python nil dedicated t))))))

  (defun +python/open-ipython-repl ()
    "Open an IPython REPL."
    (interactive)
    (require 'python)
    (let ((python-shell-interpreter
           (or (+python-executable-find (car +python-ipython-command))
               "ipython"))
          (python-shell-interpreter-args
           (string-join (cdr +python-ipython-command) " ")))
      (+python/open-repl)))

  (defun +python/open-jupyter-repl ()
    "Open a Jupyter console."
    (interactive)
    (require 'python)
    (add-to-list 'python-shell-completion-native-disabled-interpreters "jupyter")
    (let ((python-shell-interpreter
           (or (+python-executable-find (car +python-jupyter-command))
               "jupyter"))
          (python-shell-interpreter-args
           (string-join (cdr +python-jupyter-command) " ")))
      (+python/open-repl)))

  (defun +python/optimize-imports ()
    "organize imports"
    (interactive)
    (pyimport-remove-unused)
    (py-isort-buffer))

  (defun +python-use-correct-flycheck-executables-h ()
    "Use the correct Python executables for Flycheck."
    (let ((executable python-shell-interpreter))
      (save-excursion
        (goto-char (point-min))
        (save-match-data
          (when (or (looking-at "#!/usr/bin/env \\(python[^ \n]+\\)")
                    (looking-at "#!\\([^ \n]+/python[^ \n]+\\)"))
            (setq executable (substring-no-properties (match-string 1))))))
      ;; Try to compile using the appropriate version of Python for
      ;; the file.
      (setq-local flycheck-python-pycompile-executable executable)
      ;; We might be running inside a virtualenv, in which case the
      ;; modules won't be available. But calling the executables
      ;; directly will work.
      (setq-local flycheck-python-pylint-executable "pylint")
      (setq-local flycheck-python-flake8-executable "flake8")))

  (defun +python-pyenv-mode-set-auto-h ()
    "Set pyenv-mode version from buffer-local variable."
    (when (eq major-mode 'python-mode)
      (when (not (local-variable-p '+pyenv--version))
        (make-local-variable '+pyenv--version)
        (setq +pyenv--version (+python-pyenv-read-version-from-file)))
      (if +pyenv--version
          (pyenv-mode-set +pyenv--version)
        (pyenv-mode-unset))))

  (defun +python-pyenv-read-version-from-file ()
    "Read pyenv version from .python-version file."
    (when-let (root-path (projectile-locate-dominating-file default-directory ".python-version"))
      (let* ((file-path (expand-file-name ".python-version" root-path))
             (version
              (with-temp-buffer
                (insert-file-contents-literally file-path)
                (string-trim (buffer-string)))))
        (if (member version (pyenv-mode-versions))
            version  ;; return.
          (message "pyenv: version `%s' is not installed (set by `%s')."
                   version file-path))))))

(use-package rust-mode)

(use-package rustic
  :after rust-mode
  :init
  (with-eval-after-load 'rustic-flycheck
    (remove-hook 'rustic-mode-hook #'flycheck-mode)
    (remove-hook 'rustic-mode-hook #'flymake-mode)
    (remove-hook 'rustic-mode-hook #'flymake-mode-off)
    (remove-hook 'flycheck-mode-hook #'rustic-flycheck-setup))
  (with-eval-after-load 'org-src
    (add-to-list 'org-src-lang-modes '("rust" . rustic)))
  :config
  (setopt lsp-rust-analyzer-store-path (expand-file-name ".cargo/bin/rust-analyzer" (getenv "HOME")))
  (setq rustic-format-on-save nil)
  ;;(when (executable-find "rustup")
  ;;  (setq rustic-analyzer-command
  ;;        `(,(executable-find "rustup")
  ;;          "run"
  ;;          "stable"
  ;;          "rust-analyzer")))
  (setq rustic-indent-method-chain t)
  (setq rustic-babel-format-src-block nil
        rustic-format-trigger nil)
  :custom
  ;;(rustic-analyzer-command '("rustup" "run" "stable" "rust-analyzer"))
  (rustic-cargo-use-last-stored-arguments t))

(use-package toml-mode
  :demand t
  :hook ((toml-mode toml-ts-mode) . lsp-deferred)
  :mode
  ("\\.toml\\'" . toml-mode)
  :config
  (with-eval-after-load 'lsp-mode
    (add-hook 'toml-mode-hook #'lsp-deferred)
    (setq lsp-toml-command (executable-find "taplo"))
    (add-to-list 'lsp-language-id-configuration '("\\.toml$" . "toml"))))

(use-package emmet-mode
  :hook (sgml-mode css-mode html-mode web-mode haml-mode nxml-mode rjsx-mode reason-mode)
  :config
  (setopt emmet-move-cursor-between-quotes t
                emmet-self-closing-tag-style " /")
  (when (require 'yasnippet nil t)
      (add-hook 'emmet-mode-hook #'yas-minor-mode-on))
  (with-eval-after-load 'evil
      (evil-define-key 'visual emmet-mode-keymap
        (kbd "<tab>") 'emmet-wrap-with-markup)
      (evil-define-key '(normal insert emacs) emmet-mode-keymap
        (kbd "<tab>") 'emmet-expand-line)))

(use-package web-mode
  :mode "\\.[px]?html?\\'"
  :mode "\\.\\(?:tpl\\|blade\\)\\(?:\\.php\\)?\\'"
  :mode "\\.erb\\'"
  :mode "\\.[lh]?eex\\'"
  :mode "\\.jsp\\'"
  :mode "\\.as[cp]x\\'"
  :mode "\\.ejs\\'"
  :mode "\\.hbs\\'"
  :mode "\\.mustache\\'"
  :mode "\\.svelte\\'"
  :mode "\\.twig\\'"
  :mode "\\.jinja2?\\'"
  :mode "\\.eco\\'"
  :mode "wp-content/themes/.+/.+\\.php\\'"
  :mode "templates/.+\\.php\\'"
  :init
  (add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode) 'append)
  :mode "\\.vue\\'"
  :hook (web-mode . eglot-ensure)
  :config
  (setopt web-mode-enable-html-entities-fontification t
                web-mode-auto-close-style 1)
  (with-eval-after-load 'smartparens
      (defun +web-is-auto-close-style-3 (_id action _context)
        (and (eq action 'insert)
                 (eq web-mode-auto-close-style 3)))
      (sp-local-pair 'web-mode "<" ">" :unless '(:add +web-is-auto-close-style-3))
      (setopt web-mode-enable-auto-quoting nil
                      web-mode-enable-auto-pairing t)
      (dolist (alist web-mode-engines-auto-pairs)
        (setcdr alist
                        (cl-loop for pair in (cdr alist)
                                         unless (string-match-p "^[a-z-]" (cdr pair))
                                         collect (cons (car pair)
                                                                       (string-trim-right (cdr pair)
                                                                                                              "\\(?:>\\|]\\|}\\)+\\'")))))
      (cl-callf2 delq nil web-mode-engines-auto-pairs))
  (add-to-list 'web-mode-engines-alist '("elixir" . "\\.eex\\'"))
  (add-to-list 'web-mode-engines-alist '("phoenix" . "\\.[lh]eex\\'"))
  (setf (alist-get "javascript" web-mode-comment-formats nil nil #'equal)
              "//"))

(use-package css-mode
  :ensure nil
  :hook (css-mode . rainbow-mode)
  :hook (css-mode . eglot-ensure))

(use-package scss-mode
  :mode "\\.scss\\'"
  :hook (scss-mode . rainbow-mode)
  :hook (scss-mode . eglot-ensure)
  :init
  (with-eval-after-load 'flymake
      (require 'flymake-proc nil t)))

(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
  (setq tab-width 2)
  :hook
  ((yaml-mode . (lambda ()
                  (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
   (yaml-mode . (lambda ()
                  (run-hooks 'prog-mode-hook))))
  :hook ((yaml-mode yaml-ts-mode) . lsp-deferred))

(use-package yuck-mode)

(use-package avy
  :config
  (setq avy-background t)
  (setq avy-timeout-seconds 0.5)
  (evil-define-key* '(normal visual) 'global
      "gJ" 'evil-avy-goto-line-below
      "gK" 'evil-avy-goto-line-above))

(use-package rainbow-mode
  :hook (prog-mode . rainbow-mode)
  :config
  (setq rainbow-html-colors-major-mode-list
        '(prog-mode conf-mode html-mode css-mode php-mode nxml-mode xml-mode)
        rainbow-html-colors t))

(use-package rainbow-identifiers
  :hook (prog-mode . rainbow-identifiers-mode))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode)
  :config
  (setq rainbow-delimiters-max-face-count 4))

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(orderless))
    (add-hook 'orderless-style-dispatchers #'my/orderless-dispatch-flex-first nil 'local)
    (setq-local completion-at-point-functions (list (cape-capf-buster #'lsp-completion-at-point))))
  :commands (lsp lsp-deferred)
  :hook (lsp-completion-mode . my/lsp-mode-setup-completion)
  :custom
  (lsp-completion-provider :none))

(use-package lsp-ui :commands lsp-ui-mode)

(use-package flycheck)
(use-package consult-lsp)
(use-package consult-flycheck)
(use-package nerd-icons)
    '';
    extraPackages = epkgs: with epkgs; [ 
      org-contrib
      org-superstar
      org-fancy-priorities
      org-modern
      org-download
      org-roam
      org-roam-ui
      editorconfig
      magit 
      elfeed
      elfeed-org
      elfeed-goodies
      ox-hugo
      password-store
      password-store-otp
      pass
      pinentry
      fzf
      rg
      vertico
      orderless
      consult
      consult-dir
      embark
      embark-consult
      cape
      corfu
      marginalia
      kind-icon
      nix-mode
      evil
      evil-collection
      projectile
      perspective
      persp-projectile
      yasnippet
      consult-yasnippet
      yasnippet-snippets
      yasnippet-capf
      treesit-auto
      smartparens
      typescript-mode
      rjsx-mode
      kdl-mode
      markdown-mode
      poly-markdown
      edit-indirect
      rust-mode
      rustic
      toml-mode
      emmet-mode
      web-mode
      scss-mode
      yaml-mode
      yuck-mode
      avy
      rainbow-mode
      rainbow-delimiters
      rainbow-identifiers
      lsp-mode
      lsp-ui
      flycheck
      consult-lsp
      consult-flycheck
      nerd-icons
    ];
  };

  home.packages = with pkgs; [
    hugo
    multimarkdown
    python313Packages.python
    python313Packages.black
    python313Packages.autopep8
    python313Packages.flake8
    python313Packages.pycodestyle
    python313Packages.pydocstyle
    python313Packages.pylint
    python313Packages.pyflakes
    python313Packages.yapf
    python313Packages.mypy
    python313Packages.python-lsp-server
    pyright
    bash-language-server
    taplo
  ];
}
