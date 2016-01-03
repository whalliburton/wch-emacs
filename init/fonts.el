;; fonts.el

; -fndry-fmly-wght-slant-sWdth-adstyl-pxlsz-ptSz-resx-resy-spc-avgWdth-rgstry-encdng

(defvar *font-point-sizes* '(12 14 20 22 24 28 32))
(defvar *font-pattern* "-xos4-terminus-medium-r-normal--%s-*-72-72-c-*-iso8859-1")
(defvar *default-font-size* 24)
(defvar *current-font-size* 24)

(defun set-font-size (size)
  (unless (member size *font-point-sizes*)
    (error "Font point size %s is invalid." size))
  (set-frame-font (format *font-pattern* size))
  (setf *current-font-size* size))

(defun increase-font-size ()
  (interactive)
  (let ((sizes (member *current-font-size* *font-point-sizes*)))
    (if (second sizes)
        (set-font-size (second sizes))
      (message "Already at the maximum font size."))))

(defun decrease-font-size ()
  (interactive)
  (let ((pos (position *current-font-size* *font-point-sizes*)))
    (if (< 0 pos)
        (set-font-size (nth (1- pos) *font-point-sizes*))
      (message "Already at the minimium font size."))))

(defun reset-font-size ()
  (interactive)
  (set-font-size *default-font-size*))



