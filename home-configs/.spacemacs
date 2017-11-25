;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;;
   dotspacemacs-distribution 'spacemacs
   ;;
   dotspacemacs-enable-lazy-installation 'unused
   ;;
   dotspacemacs-ask-for-lazy-installation t
   ;;
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     vimscript
     vimscriptgit
     html
     helm
     yaml
     github
     python
     markdown
     shell-scripts
     colors
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     emacs-lisp
     evil-commentary
     auto-completion
     better-defaults
     syntax-checking
     version-control
     themes-megapack
     )
   ;;
   dotspacemacs-additional-packages '()
   ;;
   dotspacemacs-frozen-packages '()
   ;;
   dotspacemacs-excluded-packages '()
   ;;
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."

  (setq-default
   ;;
   dotspacemacs-elpa-https t
   ;;
   dotspacemacs-elpa-timeout 5
   ;;
   dotspacemacs-check-for-update nil
   ;;
   dotspacemacs-elpa-subdirectory nil
   ;;
   dotspacemacs-editing-style 'vim
   ;;
   dotspacemacs-verbose-loading nil
   ;;
   dotspacemacs-startup-banner 'official
   ;;
   dotspacemacs-startup-lists '((recents . 7)
                                (projects . 7))
   ;;
   dotspacemacs-startup-buffer-responsive t
   ;;
   dotspacemacs-scratch-mode 'text-mode
   ;;
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   ;;
   dotspacemacs-colorize-cursor-according-to-state t
   ;;
   dotspacemacs-default-font '("xos4 Terminus"
                               :size 14
                               :weight normal
                               :width normal
                               :powerline-scale 1.4)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;;
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text t
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;;
   dotspacemacs-default-layout-name "Default"
   ;;
   dotspacemacs-display-default-layout nil
   ;;
   dotspacemacs-auto-resume-layouts t
   ;;
   dotspacemacs-large-file-size 1
   ;;
   dotspacemacs-auto-save-file-location 'original
   ;;
   dotspacemacs-max-rollback-slots 5
   ;;
   dotspacemacs-helm-resize nil
   ;;
   dotspacemacs-helm-no-header nil
   ;;
   dotspacemacs-helm-position 'bottom
   ;;
   dotspacemacs-helm-use-fuzzy 'always
   ;;
   dotspacemacs-enable-paste-transient-state nil
   ;;
   dotspacemacs-which-key-delay 0.4
   ;;
   dotspacemacs-which-key-position 'bottom
   ;;
   dotspacemacs-loading-progress-bar nil
   ;;
   dotspacemacs-fullscreen-at-startup nil
   ;;
   dotspacemacs-fullscreen-use-non-native nil
   ;;
   dotspacemacs-maximized-at-startup nil
   ;;
   dotspacemacs-active-transparency 90
   ;;
   dotspacemacs-inactive-transparency 90
   ;;
   dotspacemacs-show-transient-state-title t
   ;;
   dotspacemacs-show-transient-state-color-guide t
   ;;
   dotspacemacs-mode-line-unicode-symbols t
   ;;
   dotspacemacs-smooth-scrolling t
   ;;
   dotspacemacs-line-numbers '(:relative nil
                               :disabled-for-modes dired-mode
                                                   doc-view-mode
                                                   markdown-mode
                                                   org-mode
                                                   pdf-view-mode
                                                   text-mode
                               :size-limit-kb 1000)
   ;;
   dotspacemacs-folding-method 'evil
   ;;
   dotspacemacs-smartparens-strict-mode nil
   ;;
   dotspacemacs-smart-closing-parenthesis nil
   ;;
   dotspacemacs-highlight-delimiters 'all
   ;;
   dotspacemacs-persistent-server nil
   ;;
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;;
   dotspacemacs-default-package-repository nil
   ;;
   dotspacemacs-whitespace-cleanup 'trailing
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(custom-safe-themes
   (quote
    ("15348febfa2266c4def59a08ef2846f6032c0797f001d7b9148f30ace0d08bcf" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
 '(electric-pair-mode t)
 '(evil-want-Y-yank-to-eol nil)
 '(package-selected-packages
   (quote
    (zenburn-theme zen-and-art-theme underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme toxi-theme tao-theme tangotango-theme tango-plus-theme tango-2-theme sunny-day-theme sublime-themes subatomic256-theme subatomic-theme spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme seti-theme reverse-theme railscasts-theme purple-haze-theme professional-theme planet-theme phoenix-dark-pink-theme phoenix-dark-mono-theme organic-green-theme omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme noctilux-theme naquadah-theme mustang-theme monokai-theme monochrome-theme molokai-theme moe-theme minimal-theme material-theme majapahit-theme madhat2r-theme lush-theme light-soap-theme jbeans-theme jazz-theme ir-black-theme inkpot-theme heroku-theme hemisu-theme hc-zenburn-theme gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme gandalf-theme flatui-theme flatland-theme farmhouse-theme espresso-theme dracula-theme django-theme darktooth-theme autothemer darkokai-theme darkmine-theme darkburn-theme dakrone-theme cyberpunk-theme color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized clues-theme cherry-blossom-theme busybee-theme bubbleberry-theme birds-of-paradise-plus-theme badwolf-theme apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes afternoon-theme markdown-mode dash-functional haml-mode magit magit-popup fringe-helper git-gutter+ git-commit with-editor git-gutter gh marshal logito pcache ht pos-tip flycheck web-completion-data company yasnippet anaconda-mode pythonic auto-complete vimrc-mode dactyl-mode yapfify yaml-mode xterm-color ws-butler winum which-key web-mode volatile-highlights vi-tilde-fringe uuidgen use-package unfill toc-org tagedit spaceline smeargle slim-mode shell-pop scss-mode sass-mode restart-emacs rainbow-mode rainbow-identifiers rainbow-delimiters pyvenv pytest pyenv-mode py-isort pug-mode popwin pip-requirements persp-mode pcre2el paradox orgit org-bullets open-junk-file neotree mwim multi-term move-text mmm-mode markdown-toc magit-gitflow magit-gh-pulls macrostep lorem-ipsum live-py-mode linum-relative link-hint less-css-mode insert-shebang info+ indent-guide hy-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-pydoc helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag google-translate golden-ratio github-search github-clone github-browse-file gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gist gh-md fuzzy flycheck-pos-tip flx-ido fish-mode fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-commentary evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help emmet-mode elisp-slime-nav dumb-jump diff-hl define-word cython-mode company-web company-statistics company-shell company-anaconda column-enforce-mode color-identifiers-mode clean-aindent-mode auto-yasnippet auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell)))
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tool-bar-position (quote top)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((((class color) (min-colors 4096)) (:foreground "#5f5f5f" :background "#fdfde7")) (((class color) (min-colors 256)) (:foreground "#5f5f5f" :background "#fdfde7")) (((class color) (min-colors 89)) (:foreground "#5f5f5f" :background "#fdfde7")))))
