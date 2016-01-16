;; elfeed.el

(use-package elfeed)
(use-package elfeed-org
  :config (setq rmh-elfeed-org-files '("~/life/elfeed.org")))

(elfeed-org)
