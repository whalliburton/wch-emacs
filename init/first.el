;; first.el

(message "Loading a full emacs configuration.")

;; Turn off gc for the init.
;;
;; Number of bytes of consing between garbage collections.
;; Garbage collection can happen automatically once this many bytes have been
;; allocated since the last garbage collection.  All data types count.
;;
;; Garbage collection happens automatically only when `eval' is called.
;;
;; By binding this temporarily to a large number, you can effectively
;; prevent garbage collection during a part of the program.

(setq gc-cons-threshold 50000000)


;; Up the limit on max-specpdl-sizei (default 1300).
;;
;; Limit on number of Lisp variable bindings and `unwind-protect's.
;; If Lisp code tries to increase the total number past this amount,
;; an error is signaled.
;; You can safely use a value considerably larger than the default value,
;; if that proves inconveniently small.  However, if you increase it too far,
;; Emacs could run out of memory trying to make the stack bigger.
;; Note that this limit may be silently increased by the debugger

(setq max-specpdl-size 10000)


;; Make available all the packages in site-lisp.
;;
;; Add all subdirectories of `default-directory' to `load-path'.
;; More precisely, this uses only the subdirectories whose names
;; start with letters or digits; it excludes any subdirectory named `RCS'
;; or `CVS', and any subdirectory that contains a file named `.nosearch'.

(let ((default-directory  "~/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))


;; We use USE-PACKAGE for loading.
;;
;; The `use-package' declaration macro allows you to isolate package
;; configuration in your ".emacs" in a way that is performance-oriented and,
;; well, just tidy.

(require 'use-package)


;; Turn off backup files. We use version control nowadays.
(setq make-backup-files nil
      auto-save-dafault nil)


;; Leave all old backups.
;;
;; If t, delete excess backup versions silently.
;; If nil, ask confirmation.  Any other value prevents any trimming.

(setq delete-old-versions 'leave)


;; Enable some disabled, by default, functions.

(put 'erase-buffer 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(use-package bookmark)
(use-package igrep)

(setq dired-listing-switches "-al")

(use-package dired-x)
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode)))
(setq dired-omit-files "^\\.$")
