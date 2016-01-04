;; helm.el

(use-package helm)
(use-package helm-config)
(use-package helm-ls-git)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-unset-key (kbd "C-x c"))
