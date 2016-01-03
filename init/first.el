;; first.el

;; Turn off gc for the init
(setq gc-cons-threshold 50000000)

;; Limit on number of Lisp variable bindings and `unwind-protect's.
(setq max-specpdl-size 10000)

(add-to-list 'load-path "~/emacs/site-lisp/use-package")
(require 'use-package)

