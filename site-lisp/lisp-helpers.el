; lisp-helpers.el
; William Halliburton <whalliburton@gmail.com>

(provide 'lisp-helpers)

(defun thing-at-point-no-properties (thing)
  "Like THING-AT-POINT but does not capture buffer properties."
  (if (get thing 'thing-at-point)
      (funcall (get thing 'thing-at-point))
    (let ((bounds (bounds-of-thing-at-point thing)))
      (if bounds
	  (buffer-substring-no-properties (car bounds) (cdr bounds))))))

(defun lisp-reindent-file ()
  (interactive)
  (beginning-of-buffer)
  (while (beginning-of-defun -1)
    (slime-reindent-defun))
  (save-buffer))

(defun lisp-apply-system (fn)
  (loop for file in (slime-eval `(helpers:asdf-system-files ,*lisp-project-name*))
        do (progn
             (find-file file)
             (funcall fn))))

(defun lisp-reindent-system ()
  (interactive)
  (lisp-apply-system (lambda () (lisp-reindent-file))))

(defun lisp-delete-trailing-whitespace-system ()
  (interactive)
  (lisp-apply-system (lambda () (safe-delete-trailing-whitespace))))

(defun lisp-untablify-system ()
  (interactive)
  (lisp-apply-system (lambda () (untabify (point-min) (point-max)))))

;; we dont want to delete trailing commas in clojure
(defun safe-delete-trailing-whitespace ()
  (interactive "*")
  (save-match-data
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "\\s-$" nil t)
	(skip-syntax-backward "-" (save-excursion (forward-line 0) (point)))
	;; Don't delete formfeeds, even if they are considered whitespace.
	(save-match-data
	  (if (looking-at ".*\f")
	      (goto-char (match-end 0))))
	;; Don't delete formfeeds, even if they are considered whitespace.
	(save-match-data
	  (if (looking-at ".*,")
	      (goto-char (match-end 0))))
	(delete-region (point) (match-end 0))))))

(defun clean-buffer ()
  (interactive)
  (untabify (point-min) (point-max))
  (safe-delete-trailing-whitespace))

(defun lisp-correct-system ()
  (interactive)
  (lisp-apply-system
   (lambda ()
     (lisp-reindent-file)
     (clean-buffer))))

;; http://www.splode.com/~friedman/software/emacs-lisp/src/motion-fns.el
(defun goto-longest-line ()
  "Go to longest line in buffer."
  (interactive)
  (let ((longest-line 0)
        (line 0)
        (length 0))
    (save-excursion
      (goto-char (point-min))
      (end-of-line)
      (setq length (current-column))
      (setq longest-line 0)
      (while (zerop (forward-line 1))
        (setq line (1+ line))
        (end-of-line)
        (cond ((> (current-column) length)
               (setq length (current-column))
               (setq longest-line line)))))
    (goto-line (1+ longest-line))))

(defun lisp-goto-longest-lines ()
  (interactive)
  (lisp-apply-system (lambda () (goto-longest-line))))

(defun lisp-shell (&optional command directory)
  (interactive)
  (let ((default-directory (or directory "~")))
    (shell "*shell*"))
  (with-current-buffer "*shell*"
    (push 'lisp-shell-watcher after-change-functions)
    (when command
      (sleep-for 0.5)
      (insert command)
      (comint-send-input)))
  (delete-other-windows))

(defun lisp-shell-launch ()
  (interactive)
  (lisp-shell "~/quicklisp/local-projects/launch/start"))

(defvar *lisp-shell-watcher-finished* nil)

(defun lisp-shell-watcher (start end old-len)
  (unless *lisp-shell-watcher-finished*
    (let ((str (buffer-substring-no-properties start end)))
      (when (or (string-match "Swank started at port: \\(.*\\)\\." str)
                (string-match "swank started at port: \\(.*\\)" str)
                (string-match "Connection opened on local port  \\(.*\\)" str))
        (let ((connection (slime-connect "127.0.0.1" (match-string-no-properties 1 str))))
          (message "connection: %s" connection))
        (setf *lisp-shell-watcher-finished* t)))))

(defun lisp-insert-macroexpand-1 (&optional repeatedly)
  (interactive "P")
  (save-excursion
    (insert (slime-eval `(cl:progn
                          (cl:setf cl:*gensym-counter* 1)
                          (,(if repeatedly
                                'swank:swank-macroexpand
                              'swank:swank-macroexpand-1)
                           ,(car (slime-sexp-at-point-for-macroexpansion))))))
    (insert "\n\n")))

(defvar *repl-buffer* nil)

(defun switch-to-repl ()
  (interactive)
  (if *repl-buffer*
      (switch-to-buffer-other-window *repl-buffer*)
    (slime-switch-to-output-buffer)))

(defun repl ()
  (interactive)
  (switch-to-repl))

(defun set-repl ()
  (interactive)
  (setq *repl-buffer* (current-buffer)))

(defun unset-repl ()
  (interactive)
  (setq *repl-buffer* nil))

(defun slime-macroexpand-1-inplace-downcase ()
  (interactive)
  (slime-eval-macroexpand-inplace 'helpers::swank-macroexpand-1-downcase))

(defun lisp-apply-files (files fn)
  (loop for file in files
        do (progn
             (find-file file)
             (funcall fn))))

;; (lisp-apply-files (directory-files "/mnt/projects/backend/src" t "clj") 'clean-buffer)

(defun copy-symbol ()
  (interactive)
  (kill-new (thing-at-point 'symbol)))

(defun hide-old-text ()
  (interactive)
  (if (local-variable-p 'hide-overlay)
      (move-overlay hide-overlay (point-min) (point-max))
    (progn
      (make-local-variable 'hide-overlay)
      (setq hide-overlay (make-overlay (point-min) (point-max)))
      (overlay-put hide-overlay 'invisible t))))

(defun show-old-text ()
  (interactive)
  (when (local-variable-p 'hide-overlay)
    (delete-overlay hide-overlay)))

(defun switch-to-dribble-file ()
  (interactive)
  (unless (boundp 'dribble-buffer)
    (setq dribble-buffer (get-buffer "*shell*")))
  (if (not (buffer-name dribble-buffer))
      (progn (find-file-other-window dribble-file)
             (view-mode)
             (auto-revert-tail-mode)
             (setq dribble-buffer (current-buffer)))
    (switch-to-buffer-other-window dribble-buffer))
  (end-of-buffer))

(defvar *protected-buffers* ())

(defun safe-kill-this-buffer ()
  (interactive)
  (if (member (current-buffer) *protected-buffers*)
      (bury-buffer)
    (kill-buffer (current-buffer))))

(defun protect-this-buffer ()
  (interactive)
  (pushnew (current-buffer) *protected-buffers*))

(defun insert-into-repl (string)
  (with-current-buffer
      (slime-output-buffer)
    (end-of-buffer)
    (insert string)
    (slime-repl-return)))
