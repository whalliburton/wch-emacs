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

(fset 'woman 'helm-man-woman)
(fset 'describe-bindings 'helm-descbinds)

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
