;; utility.el

(defun insert-date ()
  "Insert current date and time."
  (interactive "*")
  (insert (current-time-string)))

(defun unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))
