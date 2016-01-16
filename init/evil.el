;; evil.el

(use-package evil)
(use-package evil-paredit
  :config (add-hook 'paredit-mode-hook 'evil-paredit-mode))

(use-package evil-org)

(defun my-move-key (keymap-from keymap-to key)
  "Moves key binding from one keymap to another, deleting from the old location. "
  (define-key keymap-to key (lookup-key keymap-from key))
  (define-key keymap-from key nil))

(evil-mode 1)

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

(push 'global-git-commit-mode evil-insert-state-modes)
(push 'git-commit-mode evil-insert-state-modes)
(push 'elfeed-search-mode evil-emacs-state-modes)
(push 'elfeed-show-mode evil-emacs-state-modes)
(push 'bs-mode evil-emacs-state-modes)
(push 'async-bytecomp-package-mode evil-emacs-state-modes)
(push 'wl-folder-mode evil-emacs-state-modes)
(push 'wl-summary-mode evil-emacs-state-modes)
;; (use-package evil-surround :config (global-evil-surround-mode 1))

(custom-set-faces
 '(hl-line ((t (:background "grey10")))))
