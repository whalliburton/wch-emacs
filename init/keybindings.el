;; keybindings.el

(use-package keys)

;; A simple way to manage personal keybindings
;; Use (describe-personal-keybindings) to view settings.
(use-package bind-key)

(defvar elisp-extra-keys
  '(;("C-c d" elisp-disassemble)
    ("C-c m" elisp-macroexpand)
    ("C-c M" elisp-macroexpand-all)
    ("C-c C-c" compile-defun)
    ("C-c C-k" elisp-bytecompile-and-load)
    ("C-c C-l" load-file)
    ("C-c p" pp-eval-last-sexp)))

(use-package elisp-slime-nav
  :config
  (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
    (add-hook hook 'elisp-slime-nav-mode)))

(dolist (binding elisp-extra-keys)
  (let ((key (car binding)) (val (cadr binding)))
    (bind-key key val emacs-lisp-mode-map)
    (bind-key key val lisp-interaction-mode-map)))

(mapc (lambda (key) (unbind-key key))
       `("C-x v"   ; vc - magit for life!
         "C-x C-d" ; list-directory - dired is better
         "C-x C-z" ; suspend-frame - what! leave emacs!
         "C-z"
         "C-x c" ; helm
  ))


(bind-key "DEL" 'paredit-backward-delete slime-repl-mode-map)
;; (bind-key "TAB" 'helm-slime-complete slime-repl-mode-map)
;; (bind-key "TAB" 'helm-slime-complete slime-mode-map)

(bind-key "j" 'evil-next-line org-agenda-mode-map)
(bind-key "k" 'evil-previous-line org-agenda-mode-map)
(bind-key "C-k" 'paredit-kill evil-insert-state-map)

(bind-key "SPC" 'ace-jump-mode evil-normal-state-map)
(bind-key "TAB" 'indent-for-tab-command evil-normal-state-map)

(mapcar (lambda (el)
        (destructuring-bind (key command) el
          (let ((key (if (listp key)
                         (if (eq window-system 'x)
                             (first key)
                           (second key))
                       key)))
            (bind-key key command))))
      `(
        ("C-c C-g" end-of-buffer)

        ;; grep
        ("C-c g" igrep)

        ;; web
        ("C-c b" chrome-here)

        ;; magit
        ("C-c i" ,(lambda () (interactive) (magit-status) (delete-other-windows)))

        ;; bookmarks
        ("C-c 7" bm-toggle)
        ("C-c 8" bm-previous)
        ("C-c 9" bm-next)

        ;; entire buffer
        ("C-x C-v" revert-buffer)
        ("C-c 5" hide-old-text)
        ("C-c 6" show-old-text)

        ;; lisp
        ("C-c r" switch-to-repl)
        ("C-c R" switch-to-dribble-file)
        ("C-c m" slime-macroexpand-1-inplace-downcase)
        ("C-c ," slime-selector)
        ("C-c C-q" slime-eval-print-last-expression)
        ("C-x C-a" copy-symbol)
        ("C-x C-h" hyperspec-lookup)
        ("C-x C-j" info-lookup-symbol)

        ("C-c k" comment-region)
        ("C-c K" uncomment-region)

        ("C-c D" dictionary-lookup-definition)

        ;; paredit
        ("M-h" paredit-forward-barf-sexp)
        (("<M-left>" "ESC <left>") paredit-forward-barf-sexp)
        ("M-l" paredit-forward-slurp-sexp)
        (("<M-right>" "ESC <right>" "M-h") paredit-forward-slurp-sexp)
        ("C-c (" paredit-mode)

        ;; erc
        ("C-c {" erc-track-switch-buffer)

        ;; fonts
        ("C-c C-=" increase-font-size)
        ("C-c C--" decrease-font-size)
        ("C-c C-0" reset-font-size)

        ("M-SPC" sr-speedbar-toggle)

        ;; w3m
        ("C-x g" w3m-bookmark-view)

        ("C-x k" safe-kill-this-buffer)

        ("C-c s" ispell-buffer)

        ;; redshank
;;        ("C-x C-g" redshank-align-forms-as-columns)

        ("C-x C-d" insert-date)

        ("C-x t" translate)

        ;; ace jump mode
        ("C-c SPC" ace-jump-mode)
        ("C-x SPC" ace-jump-mode-pop-mark)

        ("C-c l" org-store-link)
        ("C-c t" org-capture)
        ("C-c d" org-agenda)
;;        ("C-c d" org-iswitchb)
        ("C-c A" switch-to-open-agenda)
        ("C-c n" org-clock-goto)

        ("C-c c" calendar)

        ("C-x C-g" toggle-truncate-lines)

        ("C-x x" helm-browse-project)
        ("C-c h" helm-command-prefix)

        ("M-x" helm-M-x)
        ("C-x C-f" helm-find-files)
        ("C-x b" helm-mini)
        ("<backtab>" helm-lisp-completion-at-point)
        ("M-y" helm-show-kill-ring)
        ("C-c h x" helm-register)
        ("C-c h g" helm-google-suggest)
        ("C-c h o" helm-org-agenda-files-headings)

        ("C-c f" helm-projectile-grep)

        ("C-x w" elfeed)
        ))

(defun clear-keys-from-map (map keys)
  (dolist (key keys)
    (define-key map (read-kbd-macro key) nil)))

(clear-keys-from-map paredit-mode-map '("<C-left>" "<C-right>"))

(use-package operate-on-number)
(use-package smartrep)
(smartrep-define-key global-map "C-c ."
  '(("+" . apply-operation-to-number-at-point)
    ("-" . apply-operation-to-number-at-point)
    ("*" . apply-operation-to-number-at-point)
    ("/" . apply-operation-to-number-at-point)
    ("\\" . apply-operation-to-number-at-point)
    ("^" . apply-operation-to-number-at-point)
    ("<" . apply-operation-to-number-at-point)
    (">" . apply-operation-to-number-at-point)
    ("#" . apply-operation-to-number-at-point)
    ("%" . apply-operation-to-number-at-point)
    ("'" . operate-on-number-at-point)))


;; (global-set-key "\C-cp" 'planner-create-task-from-buffer)
;; (global-set-key "\C-cr" 'remember)

;; (global-set-key "\C-ca" 'agrep)

;; (global-set-key "\C-c\C-z." 'browse-url-at-point)
;; (global-set-key "\C-c\C-zb" 'browse-url-of-buffer)
;; (global-set-key "\C-c\C-zr" 'browse-url-of-region)
;; (global-set-key "\C-c\C-zu" 'browse-url)
;; (global-set-key "\C-c\C-zv" 'browse-url-of-file)

;; (global-set-key "\C-c=" 'hs-toggle-hiding)

;; (define-key w3m-mode-map "z" 'w3m-previous-buffer)
;; (define-key w3m-mode-map "x" 'w3m-next-buffer)

;; (define-key w3m-mode-map "\M-[a" 'scroll-down-one-line)
;; (define-key w3m-mode-map "\M-[b" 'scroll-up-one-line)

;; (add-hook 'dired-mode-hook
;;           (lambda ()
;;             (local-set-key "\C-c\C-zf" 'browse-url-of-dired-file))))


;; mu4e evil bindings

(evil-set-initial-state 'mu4e-view-mode 'normal)
(evil-set-initial-state 'mu4e-main-mode 'normal)
(evil-set-initial-state 'mu4e-headers-mode 'normal)

;; use the standard bindings as a base
(evil-make-overriding-map mu4e-view-mode-map 'normal t)
(evil-make-overriding-map mu4e-main-mode-map 'normal t)
(evil-make-overriding-map mu4e-headers-mode-map 'normal t)

(evil-add-hjkl-bindings mu4e-view-mode-map 'normal
  "j" 'mu4e-view-headers-next
  "k" 'mu4e-view-headers-prev
                                        ;"j" 'evil-next-line
  "C" 'mu4e-compose-new
  "o" 'mu4e-view-message
  "Q" 'mu4e-raw-view-quit-buffer)

;; (evil-add-hjkl-bindings mu4e-view-raw-mode-map 'normal
;;   "J" 'mu4e-jump-to-maildir
;;   "j" 'evil-next-line
;;   "C" 'mu4e-compose-new
;;   "q" 'mu4e-raw-view-quit-buffer)

(evil-add-hjkl-bindings mu4e-headers-mode-map 'normal
  "J" 'mu4e~headers-jump-to-maildir
  "j" 'evil-next-line
  "C" 'mu4e-compose-new
  "o" 'mu4e-view-message)

(evil-add-hjkl-bindings mu4e-main-mode-map 'normal
  "J" 'mu4e~headers-jump-to-maildir
  "j" 'evil-next-line
  "RET" 'mu4e-view-message)
