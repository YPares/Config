(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)
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
                      shm

                      inf-ruby

                      ttl-mode
                      omn-mode ;; A mode for OWL Manchester Notation
                      yaml-mode
                      markdown-mode
                      
                      zenburn-theme

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
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq cider-repl-popup-stacktraces t)

(eval-after-load "cider-mode"
  '(progn
     (define-key cider-mode-map (kbd "C-c C-n") 'cider-repl-set-ns)
     (define-key cider-mode-map (kbd "C-c M-n") 'cider-eval-ns-form)))

;;; HASKELL ;;;

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;(add-hook 'haskell-mode-hook 'structured-haskell-mode)

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

;;; RUBY ;;;

(add-hook 'ruby-mode-hook (lambda () (local-set-key "\r" 'newline-and-indent)))

;;; ORG-mode ;;;

(setq org-log-done t)

;;; FLORA-2 mode ;;;

(add-to-list 'auto-mode-alist '("\\.flr$" . flora-mode))
(autoload 'flora-mode "flora" "Major mode for editing Flora programs." t)


;;; IRC ;;;

(setq alert-default-style 'libnotify)
;(rcirc-alertify-enable)

;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(custom-safe-themes (quote ("5bee853b49605401494a6574d1c5a991a0d75e86fedf5ad9a1577de6cbba7691" "9370aeac615012366188359cb05011aea721c73e1cb194798bc18576025cabeb" "d070fa185078bf753dcfd873ec63be19fa36a55a0c97dc66848a6d20c5fffdad" "e3897e34374bb23eac6c77e5ab0eba99b875f281a3b3b099ca0dc46aab25bbd5" "4c9ba94db23a0a3dea88ee80f41d9478c151b07cb6640b33bfc38be7c2415cc4" "d63e19a84fef5fa0341fa68814200749408ad4a321b6d9f30efc117aeaf68a2e" default)))
 '(fci-rule-color "#383838")
 '(haskell-process-check-cabal-config-on-load t)
 '(haskell-process-type (quote cabal-repl))
 '(rcirc-auto-authenticate-flag t)
 '(rcirc-default-nick "Ywen")
 '(rcirc-server-alist (quote (("irc.freenode.net" :channels ("#haskell-game" "#clojure" "#haskell-fr" "#haskell")))))
 '(rcirc-track-minor-mode t)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map (quote ((20 . "#BC8383") (40 . "#CC9393") (60 . "#DFAF8F") (80 . "#D0BF8F") (100 . "#E0CF9F") (120 . "#F0DFAF") (140 . "#5F7F5F") (160 . "#7F9F7F") (180 . "#8FB28F") (200 . "#9FC59F") (220 . "#AFD8AF") (240 . "#BFEBBF") (260 . "#93E0E3") (280 . "#6CA0A3") (300 . "#7CB8BB") (320 . "#8CD0D3") (340 . "#94BFF3") (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
