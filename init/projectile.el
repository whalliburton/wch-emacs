;; projectile.el

(use-package projectile)

(projectile-global-mode)

(setq projectile-completion-system 'helm)

(helm-projectile-on)

(setq projectile-find-dir-includes-top-level nil)



