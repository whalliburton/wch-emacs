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


;; We prefer to get right to work. You can view the spash page with
;; (display-spash-screen)

(setq inhibit-splash-screen t)

;; Save numeric backup files.
;;
;; Control use of version numbers for backup files.
;; When t, make numeric backup versions unconditionally.
;; When nil, make them for files that have some already.
;; The value `never' means do not make them.

(setq version-control t)

;; Save backup files in the ".~" subdirectory.
;;
;; Alist of filename patterns and backup directory names.
;; Each element looks like (REGEXP . DIRECTORY).  Backups of files with
;; names matching REGEXP will be made in DIRECTORY.  DIRECTORY may be
;; relative or absolute.  If it is absolute, so that all matching files
;; are backed up into the same directory, the file names in this
;; directory will be the full name of the file backed up with all
;; directory separators changed to `!' to prevent clashes.  This will not
;; work correctly if your filesystem truncates the resulting name.

;; For the common case of all backups going into one directory, the alist
;; should contain a single element pairing "." with the appropriate
;; directory name.

;; If this variable is nil, or it fails to match a filename, the backup
;; is made in the original file's directory.

(setq backup-directory-alist '(("." . ".~")))


;; Leave all old backups.
;;
;; If t, delete excess backup versions silently.
;; If nil, ask confirmation.  Any other value prevents any trimming.

(setq delete-old-versions 'leave)






















(view-buffer "*Messages*")
