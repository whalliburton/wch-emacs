;; dired.el

(defun ora-terminal ()
    "Switch to terminal. Launch if nonexistent."
    (interactive)
    (if (get-buffer "*ansi-term*")
        (switch-to-buffer "*ansi-term*")
        (ansi-term "/bin/bash"))
    (get-buffer-process "*ansi-term*"))

(defun ora-dired-open-term ()
  "Open an `ansi-term' that corresponds to current directory."
  (interactive)
  (let ((current-dir (dired-current-directory)))
    (term-send-string
     (ora-terminal)
     (if (file-remote-p current-dir)
         (let ((v (tramp-dissect-file-name current-dir t)))
           (format "ssh %s@%s\n"
                   (aref v 1) (aref v 2)))
         (format "cd '%s'\n" current-dir)))
    (setq default-directory current-dir)))

(define-key dired-mode-map (kbd "`") 'ora-dired-open-term)
