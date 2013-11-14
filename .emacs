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
                      yaml-mode
                      markdown-mode+
                      
                      zenburn-theme
                      ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Those won't be loaded elsewise:
(load-library "evil-paredit")
(load-library "ttl-mode")
(load-library "omn-mode")

;; COSMETICS

(load-theme 'zenburn t)

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

;; (add-hook 'paredit-mode-hook 'evil-paredit-mode)
(global-set-key (kbd "C-*") 'evil-search-symbol-forward)


;;; GENERAL LISP ;;;

(global-rainbow-delimiters-mode)

(global-set-key (kbd "M-RET") 'completion-at-point)
(global-set-key (kbd "C-c C-e") 'eval-last-sexp)

(define-key paredit-mode-map (kbd "M-f") 'paredit-forward)
(define-key paredit-mode-map (kbd "M-b") 'paredit-backward)
(define-key paredit-mode-map (kbd "M-u") 'paredit-backward-up)
(define-key paredit-mode-map (kbd "M-d") 'paredit-forward-down)
(define-key paredit-mode-map (kbd "M-n") 'paredit-forward-up)
(define-key paredit-mode-map (kbd "M-p") 'paredit-backward-down)
(define-key paredit-mode-map (kbd "M-k") 'kill-sexp)
(define-key paredit-mode-map (kbd "C-M-k") 'backward-kill-sexp)
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("e3897e34374bb23eac6c77e5ab0eba99b875f281a3b3b099ca0dc46aab25bbd5" "4c9ba94db23a0a3dea88ee80f41d9478c151b07cb6640b33bfc38be7c2415cc4" "d63e19a84fef5fa0341fa68814200749408ad4a321b6d9f30efc117aeaf68a2e" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
