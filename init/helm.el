;; helm.el

(use-package helm-config)
(use-package helm-slime)
(use-package helm-ls-git)
(use-package helm-misc)
(use-package helm-locate)
(use-package helm-projectile)
(use-package helm-elisp)
(use-package helm-descbinds)
(use-package helm-org)
(use-package helm-mu)

(fset 'woman 'helm-man-woman)
(fset 'describe-bindings 'helm-descbinds)

;;(setq projectile-switch-project-action 'helm-projectile)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-buffer-directory ((t (:background "black" :foreground "color-32" :weight bold))))
 '(helm-ff-directory ((t (:background "black" :foreground "color-32" :weight bold))))
 '(helm-ff-dotted-directory ((t (:background "black" :foreground "color-27" :weight bold))))
 '(helm-ff-dotted-symlink-directory ((t (:background "black" :foreground "DarkOrange"))))
 '(helm-selection ((t (:background "color-236" :distant-foreground "black")))))

(setq helm-source-mu-contacts
  (helm-build-in-buffer-source "Search contacts with mu"
    :data #'helm-mu-contacts-init
    :filtered-candidate-transformer #'helm-mu-contacts-transformer
    :fuzzy-match nil
    :action '(("Copy contact to point" . insert-mu-contact)
              ("Compose email addressed to this contact" . helm-mu-compose-mail)
              ("Get the emails from/to given contacts" . helm-mu-action-get-contact-emails))))

(defun insert-mu-contact (arg)
  (let* ((pos (or (position 9 arg) (position 32 arg))) ; space or tab
         (email (and pos (subseq arg 0 pos)))
         (name (and pos (subseq arg pos))))
    (insert (format "%s <%s>" (string-trim name) (string-trim email)))))
