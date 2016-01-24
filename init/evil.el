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
   (slime-mode (slime-edit-definition name))
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
