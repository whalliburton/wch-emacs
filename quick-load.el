;; this is a startup file for use for quick edits from the command line

(setq visible-bell nil)

(column-number-mode 1)
(line-number-mode 1)
(menu-bar-mode 0)

(setq inhibit-splash-screen t)

(fset 'yes-or-no-p 'y-or-n-p)

(add-to-list 'load-path "~/emacs/site-lisp/evil")
(require 'evil)
(evil-mode 1)
