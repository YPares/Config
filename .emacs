(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell

                      evil
                      evil-paredit

                      nlinum
                      rainbow-delimiters

                      clojure-mode
                      clojure-test-mode
                      cider

                      haskell-mode
                      ghc

                      ttl-mode
                      omn-mode ;; A mode for OWL Manchester Notation
                      ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Those won't be loaded elsewise:
(load-library "evil-paredit")
(load-library "ttl-mode")
(load-library "omn-mode")

;;; MOVEMENT (buffers & windows)

(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings)) ; if available, move between windows
                                        ; with Shift+arrow keys

;;; Opening files ;;;

(add-to-list 'auto-mode-alist
             '("\\.ttl" . ttl-mode))
(setq-default read-file-name-completion-ignore-case t)
(recentf-mode)

;;; EVIL ;;;

(add-hook 'paredit-mode-hook 'evil-paredit-mode)

;;; GENERAL LISP ;;;

(global-rainbow-delimiters-mode)

;;; ELISP ;;;

(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

;;; CLOJURE ;;;

(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq cider-repl-popup-stacktraces t)

;;; HASKELL ;;;

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook
          (lambda () (ghc-init) (flymake-mode)))

(eval-after-load "haskell-mode"
  '(progn
    (define-key haskell-mode-map (kbd "C-x C-d") nil)
    (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
    (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-file)
    (define-key haskell-mode-map (kbd "C-c C-b") 'haskell-interactive-switch)
    ;(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
    ;(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
    ;; ghc-mod does it better
    (define-key haskell-mode-map (kbd "C-c M-.") nil)
    (define-key haskell-mode-map (kbd "C-c C-d") nil)))

;; ORG-mode

(setq org-log-done t)
