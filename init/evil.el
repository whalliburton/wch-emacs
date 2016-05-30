;; evil.el

(use-package evil)

(use-package evil-leader)
(use-package evil-org)

(defun my-move-key (keymap-from keymap-to key)
  "Moves key binding from one keymap to another, deleting from the old location. "
  (define-key keymap-to key (lookup-key keymap-from key))
  (define-key keymap-from key nil))

(evil-mode 1)

(use-package evil-cleverparens-text-objects)
(use-package evil-cleverparens
  :config (add-hook 'paredit-mode-hook 'evil-cleverparens-mode))


(my-move-key evil-motion-state-map evil-normal-state-map (kbd "RET"))
(my-move-key evil-motion-state-map evil-normal-state-map " ")

(define-key evil-normal-state-map (read-kbd-macro "M-.") 'select-edit-definition)

(add-hook 'evil-insert-state-entry-hook (lambda () (hl-line-mode 1)))
(add-hook 'evil-insert-state-exit-hook (lambda () (hl-line-mode 0)))

;; allow for moving past the last paren in the line
(setq evil-move-cursor-back nil)

(defun select-edit-definition (&optional name where)
   (interactive (list (or (and (not current-prefix-arg)
                              (slime-symbol-at-point))
                          (slime-read-symbol-name "Edit Definition of: "))))
  (cond
   ((or slime-editing-mode slime-mode) (slime-edit-definition name))
   (t (elisp-find-definition name))))

;; only works on X11 terminal
(setq evil-replace-state-cursor '("red" box))

(mapc (lambda (mode) (evil-set-initial-state mode 'insert))
      '(git-commit-mode))

(mapc (lambda (mode) (evil-set-initial-state mode 'emacs))
      '(inferior-emacs-lisp-mode
        comint-mode
        shell-mode
        term-mode
        jabber-roster-mode
        jabber-chat-mode
        cider-repl-mode
        magit-log-edit-mode
        magit-commit-mode
        magit-branch-manager-mode
        elfeed-search-mode
        elfeed-show-mode
        bs-mode
        async-bytecomp-package-mode
        wl-folder-mode
        wl-summary-mode
        slime-popup-buffer-mode  ;; better to just enable the 'q' for quit in normal mode
        ))

(custom-set-faces
 '(hl-line ((t (:background "grey10")))))

;; (defun minibuffer-keyboard-quit ()
;;   "Abort recursive edit.
;; In Delete Selection mode, if the mark is active, just deactivate it;
;; then it takes a second \\[keyboard-quit] to abort the minibuffer."
;;   (interactive)
;;   (if (and delete-selection-mode transient-mark-mode mark-active)
;;       (setq deactivate-mark  t)
;;       (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
;;       (abort-recursive-edit)))

;; (define-key evil-normal-state-map [escape] 'keyboard-quit)
;; (define-key evil-visual-state-map [escape] 'keyboard-quit)
;; (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
;; (global-set-key [escape] 'evil-exit-emacs-state)

(use-package highlight)
(use-package fold-this)

(use-package evil-extra-operator
             :config (global-evil-extra-operator-mode 1)

             )
