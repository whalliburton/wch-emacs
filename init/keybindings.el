;; keybindings.el

(use-package keys)

(defvar elisp-extra-keys
  '(((kbd "C-c d") 'elisp-disassemble)
    ((kbd "C-c m") 'elisp-macroexpand)
    ((kbd "C-c M") 'elisp-macroexpand-all)
    ((kbd "C-c C-c") 'compile-defun)
    ((kbd "C-c C-k") 'elisp-bytecompile-and-load)
    ((kbd "C-c C-l") 'load-file)
    ((kbd "C-c p") 'pp-eval-last-sexp)
    ((kbd "M-.") 'elisp-find-definition)
    ((kbd "M-,") 'elisp-pop-found-function)))

(dolist (binding elisp-extra-keys)
  (let ((key (eval (car binding))) (val (eval (cadr binding))))
    (define-key emacs-lisp-mode-map key val)
    (define-key lisp-interaction-mode-map key val)))

(mapc (lambda (key) (global-unset-key (read-kbd-macro key)))
       `("C-x v"   ; vc - magit for life!
         "C-x C-d" ; list-directory - dired is better
         "C-x C-z" ; suspend-frame - what! leave emacs!
  ))

(mapcar (lambda (el)
        (destructuring-bind (key command) el
          (let ((key (if (listp key)
                         (if (eq window-system 'x)
                             (first key)
                           (second key))
                       key)))
            (global-set-key (read-kbd-macro key) command))))
      `(
        ;; remove suspend-frame
        ("C-z" ,nil)

        ;; movement
        ;; ("<home>" beginning-of-buffer)
        ;; ("<end>" end-of-buffer)
        ("C-c C-o" beginning-of-buffer)
        ("C-c C-g" end-of-buffer)
        (("<C-left>"  "M-[ d") backward-word)
        (("<C-right>" "M-[ c") forward-word)
;;        (("<C-up>"    "M-[ A") backward-paragraph)
;;        (("<C-down>"  "M-[ B") forward-paragraph)
        ("C-c C-l" goto-line)
        ("C-c p" ,(lambda () (interactive) (scroll-up 10)))
        ("C-c n" ,(lambda () (interactive) (scroll-down 10)))
        ("C-x C-\\" goto-last-change)

        ;; grep
        ("C-c C-v" lisp-grep-next)
        ("C-c g" grep)

        ;; search
        ("C-s" isearch-forward-regexp)
        ("C-r" isearch-backward-regexp)

        ;; replace
        ("C-c r" query-replace-regexp)

        ;; web
        ("C-c c" chrome-here)

        ;; magit
        ("C-c i" magit-status)

        ("M-/" hippie-expand)

        ;; bookmarks
        ("C-c 7" bm-toggle)
        ("C-c 8" bm-previous)
        ("C-c 9" bm-next)

        ;; entire buffer
        ("C-x C-v" revert-buffer)
        ("C-c 5" hide-old-text)
        ("C-c 6" show-old-text)

        ;; lisp
        ("C-c C-a" switch-to-repl)
        ("C-c a" switch-to-dribble-file)
        ("C-c m" slime-macroexpand-1-inplace-downcase)
        ("C-c f" lisp-grep)
        ("C-c C-f" lisp-find-file)
        ("C-c ," slime-selector)
        ("C-c C-q" slime-eval-print-last-expression)
        ("C-x C-a" copy-symbol)
        ("C-x C-h" hyperspec-lookup)
        ("C-x C-j" info-lookup-symbol)

        ("C-c k" comment-region)
        ("C-c K" uncomment-region)

        ("C-c D" dictionary-lookup-definition)

        ;; work stack
        ("C-c x" push-work-stack)
        ("C-c w" show-work-stack)

        ;; blog
        ("C-c b" find-file-blog)

        ;; paredit
        (("<M-left>" "ESC <left>") paredit-forward-barf-sexp)
        (("<M-right>" "ESC <right>") paredit-forward-slurp-sexp)
        ("C-c (" paredit-mode)

        ;; erc
        ("C-c {" erc-track-switch-buffer)

        ;; speach
        ;;        ("C-c s w" festival-say-word)
        ;;        ("C-c s r" festival-say-region)

        ;; fonts
        ("C-c C-=" increase-font-size)
        ("C-c C--" decrease-font-size)
        ("C-c C-0" reset-font-size)

        ;; imenu
        ("C-c TAB" imenu) ;; really C-c C-i

        ;; whitespace
        ("M-SPC" fixup-whitespace)

        ;; w3m
        ("C-x g" w3m-bookmark-view)

        ("C-x k" safe-kill-this-buffer)

        ("C-c s" ispell-buffer)

        ;; redshank
;;        ("C-x C-g" redshank-align-forms-as-columns)

        ("C-x C-d" insert-date)

        ("C-x t" translate)

        ("C-x j" journal)

        ("C-x w" wiki)

        ("C-c RET" emms)

        ;; marker-visit
        ("C-c z" marker-visit-next)
        ("C-c y" marker-visit-prev)

        ;; ace jump mode
        ("C-c SPC" ace-jump-mode)

        ("C-x C-b" bs-show)

        ("C-c l" org-store-link)
        ("C-c t" org-capture)
        ("C-c d" org-agenda)
;;        ("C-c d" org-iswitchb)
        ("C-c A" switch-to-open-agenda)

        ("C-x C-g" toggle-truncate-lines)

        ("C-x p" lisp-work)

        ("C-x x" helm-browse-project)

        ("C-c h" helm-command-prefix)))
(defun clear-keys-from-map (map keys)
  (dolist (key keys)
    (define-key map (read-kbd-macro key) nil)))

(clear-keys-from-map paredit-mode-map '("<C-left>" "<C-right>"))



;(global-set-key "\C-cp" 'planner-create-task-from-buffer)
;(global-set-key "\C-cr" 'remember)

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

;; (define-key anything-map (kbd "M-O a") 'anything-previous-page)
;; (define-key anything-map (kbd "M-O b") 'anything-next-page)

;; (global-set-key "\C-ca" 'anything)

;; (add-hook 'dired-mode-hook
;;           (lambda ()
;;             (local-set-key "\C-c\C-zf" 'browse-url-of-dired-file))))
