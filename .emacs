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
                      ghc))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(setq-default read-file-name-completion-ignore-case t)

;(evil-mode 1)
(global-rainbow-delimiters-mode)

;;; ELISP ;;;

(add-hook 'emacs-lisp-mode-hook 'paredit-mode)

;;; CLOJURE ;;;

(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'subword-mode)

;; nrepl settings
(setq nrepl-popup-stacktraces nil)
(add-hook 'nrepl-interaction-mode-hook
	  'nrepl-turn-on-eldoc-mode)

;;; HASKELL ;;;

(add-hook 'haskell-mode-hook 'haskell-indentation-mode)

(require 'ghc)  ;; ghc package
(autoload 'ghc-init "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init) (flymake-mode)))
