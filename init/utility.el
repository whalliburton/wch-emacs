;; utility.el

(defun insert-date ()
  "Insert current date and time."
  (interactive "*")
  (insert (current-time-string)))

