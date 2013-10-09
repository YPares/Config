(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
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
                      nrepl

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

(setq-default read-file-name-completion-ignore-case t)

(global-rainbow-delimiters-mode)

;;; EVIL ;;;

(add-hook 'paredit-mode-hook 'evil-paredit-mode)


;;; ELISP ;;;

(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

;;; CLOJURE ;;;

(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'subword-mode)
(add-hook 'nrepl-mode-hook 'paredit-mode)
(add-hook 'nrepl-mode-hook 'subword-mode)

;; nrepl settings
(setq nrepl-popup-stacktraces nil)
(add-hook 'nrepl-interaction-mode-hook
	  'nrepl-turn-on-eldoc-mode)

;;; HASKELL ;;;

(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

(require 'ghc)  ;; ghc package
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))

;;; Automodes for file types ;;;

(add-to-list 'auto-mode-alist
             '("\\.ttl" . ttl-mode))

(recentf-mode)

;; ORG-mode

(setq org-log-done t)

