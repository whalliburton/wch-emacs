;; ledger.el

(autoload 'ledger-mode "ledger-mode" "A major mode for Ledger" t)
(add-to-list 'load-path (expand-file-name "~/emacs/site-lisp/ledger/"))
(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))
