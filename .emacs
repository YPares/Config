(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; (add-to-list 'package-archives
;; 	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(defvar my-packages '(;starter-kit
                      ;starter-kit-lisp
                      ;starter-kit-bindings
		      ;starter-kit-eshell
		      better-defaults
		      smex
		      ido-ubiquitous
		      magit
                      anzu ;; anzu-mode shows number of matches when using C-s

                      paredit
                      flycheck
                      
                      evil
                      evil-paredit

                      nlinum
                      rainbow-delimiters

                      clojure-mode
                      ;clojure-test-mode
                      cider

                      company
                      intero
                      haskell-mode
                      ghc
                      ;shm

                      nix-mode
                      
                      inf-ruby

                      ess  ;; R and other statistics tools.

                      ttl-mode
                      omn-mode ;; A mode for OWL Manchester Notation
                      yaml-mode
                      markdown-mode
                      pandoc-mode

                      swiper

		      elpy
                      
                                        ;zenburn-theme

                      ;rcirc-alertify
                      ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(add-to-list 'load-path "~/.emacs.d/vendor")

;; Those won't be loaded elsewise:
(load-library "evil-paredit")
(load-library "ttl-mode")
(load-library "omn-mode")
;(load-library "flora")  ;; Not available through packages!

;; COSMETICS

;(load-theme 'zenburn t)

(set-face-attribute 'default nil :height 130)

;;; MOVEMENT (buffers & windows)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings)) ; if available, move between windows
                                        ; with Shift+arrow keys

;;; Opening files ;;;

(add-to-list 'auto-mode-alist '("\\.ttl" . ttl-mode))
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mkd" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.ck" . c-mode))
(setq-default read-file-name-completion-ignore-case t)
(recentf-mode)

;;; IDO/SMEX ;;;

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; ESHELL ;;;

(global-set-key (kbd "C-x RET") 'eshell)

;;; TEXT EDIT ;;;

(setq-default fill-column 80)

(global-unset-key [(control z)])
(global-unset-key [(control x)(control z)])

(global-set-key [(control z)] 'undo)

;;; MARKDOWN ;;;

(setq markdown-enable-math t)

;;; GIT ;;;

(global-set-key (kbd "C-c g") 'magit-status)

;;; EVIL ;;;

;; (add-hook 'paredit-mode-hook 'evil-paredit-mode)
(global-set-key (kbd "C-*") 'evil-search-symbol-forward)

;;; SEARCH ;;;

(global-unset-key (kbd "C-s"))

(global-set-key (kbd "C-s C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-s s") 'swiper)
(global-set-key (kbd "C-s a") 'swiper-all)
(global-set-key (kbd "C-s b") 'swiper-multi)

(global-set-key (kbd "C-s r") 'recentf-open-files)

;;; GENERAL LISP ;;;

;(global-rainbow-delimiters-mode)

(global-set-key (kbd "M-RET") 'completion-at-point)
(global-set-key (kbd "M-k") 'kill-sexp)
(global-set-key (kbd "M-K") 'backward-kill-sexp)
(global-set-key (kbd "C-M-k") 'kill-sentence)

(define-key paredit-mode-map (kbd "M-f") 'paredit-forward)
(define-key paredit-mode-map (kbd "M-b") 'paredit-backward)
(define-key paredit-mode-map (kbd "M-u") 'paredit-backward-up)
(define-key paredit-mode-map (kbd "M-d") 'paredit-forward-down)
(define-key paredit-mode-map (kbd "M-n") 'paredit-forward-up)
(define-key paredit-mode-map (kbd "M-p") 'paredit-backward-down)
(define-key paredit-mode-map (kbd "M-t") 'transpose-sexps)
(define-key paredit-mode-map (kbd "M-}") 'paredit-forward-barf-sexp)
(define-key paredit-mode-map (kbd "M-{") 'paredit-backward-barf-sexp)

;;; ELISP ;;;

(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

;;; CLOJURE ;;;

(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'subword-mode)
;(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq cider-repl-popup-stacktraces t)

(eval-after-load "cider-mode"
  '(progn
     (define-key cider-mode-map (kbd "C-c C-n") 'cider-repl-set-ns)
     (define-key cider-mode-map (kbd "C-c M-n") 'cider-eval-ns-form)
     (define-key cider-repl-mode-map (kbd "M-c") 'cider-repl-clear-buffer)))

;;; HASKELL ;;;

(let ((my-cabal-path (expand-file-name "~/.cabal/bin"))
      (my-local-bin-path (expand-file-name "~/.local/bin")))
  (setenv "PATH" (concat my-cabal-path ":" (getenv "PATH")))
  (setenv "PATH" (concat my-local-bin-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path)
  (add-to-list 'exec-path my-local-bin-path))

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;(add-hook 'haskell-mode-hook 'structured-haskell-mode)

;(autoload 'ghc-init "ghc" nil t)
;(autoload 'ghc-debug "ghc" nil t)
;; (add-hook 'haskell-mode-hook
;;           (lambda () (ghc-init) ;(flymake-mode)
;;             ))

(eval-after-load "haskell-mode"
  '(progn
;    (define-key haskell-mode-map (kbd "C-x C-d") nil)
;    (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
;    (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
;    (define-key haskell-mode-map (kbd "C-c C-b") 'haskell-interactive-switch)
;    (define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
;    (define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
    ;; ghc-mod does it better
;    (define-key haskell-mode-map (kbd "C-c M-.") nil)
;    (define-key haskell-mode-map (kbd "C-c C-d") nil)
    ))

;;;;;; STACK-IDE ;;;

;(add-to-list 'load-path (expand-file-name "~/stack-ide/stack-mode"))
;(require 'stack-mode)
;(add-hook 'haskell-mode-hook 'stack-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(cider-repl-history-file "_cider_repl.hist")
 '(cider-repl-use-pretty-printing t)
 '(custom-enabled-themes (quote (adwaita)))
 '(ess-tab-complete-in-script 1)
 '(haskell-process-type (quote stack-ghci))
 '(menu-bar-mode nil)
 '(nxml-sexp-element-flag t)
 '(package-selected-packages
   (quote
    (dockerfile-mode docker elpy bazel-mode smart-shift highlight-indent-guides frame-cmds swiper pandoc-mode markdown-mode yaml-mode omn-mode ttl-mode ess inf-ruby nix-mode ghc intero company cider clojure-mode rainbow-delimiters nlinum evil-paredit evil flycheck paredit anzu magit ido-ubiquitous smex better-defaults)))
 '(safe-local-variable-values (quote ((scroll-step . 1) (c-indentation-style . "K&R"))))
 '(tags-case-fold-search nil)
 '(tool-bar-mode nil))

;;; PYTHON ;;;

(elpy-enable)

;;; RUBY ;;;

(add-hook 'ruby-mode-hook (lambda () (local-set-key "\r" 'newline-and-indent)))

;;; ORG-mode ;;;

(setq org-log-done t)

(org-babel-do-load-languages
  'org-babel-load-languages
  '((dot . t)
    (emacs-lisp . nil)
    ))

;;; FLORA-2 mode ;;;

(add-to-list 'auto-mode-alist '("\\.flr$" . flora-mode))
(autoload 'flora-mode "flora" "Major mode for editing Flora programs." t)


;;; IRC ;;;

(setq alert-default-style 'libnotify)
;(rcirc-alertify-enable)

;;;;;;;;


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
