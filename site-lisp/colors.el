;; source: https://www.masteringemacs.org/article/find-nearest-colors-emacs-24

(defun find-nearest-color (color &optional use-hsv)
    "Finds the nearest color by RGB distance to `color'.

If called with a universal argument (or if `use-hsv' is set) use HSV instead of RGB.
Runs \\[list-colors-display] after setting `list-colors-sort'"
    (interactive "sColor: \nP")
    (let ((list-colors-sort `(,(if (or use-hsv current-prefix-arg)
                                   'hsv-dist
                                 'rgb-dist) . ,color)))
      (if (color-defined-p color)
          (list-colors-display)
        (error "The color \"%s\" does not exist." color))))

(defun find-nearest-color-at-point (pt)
    "Finds the nearest color at point `pt'.

If called interactively, `pt' is the value immediately under `point'."
    (interactive "d")
    (find-nearest-color (with-syntax-table (copy-syntax-table (syntax-table))
                          ;; turn `#' into a word constituent to help
                          ;; `thing-at-point' find HTML color codes.
                          (modify-syntax-entry ?# "w")
                                                  (thing-at-point 'word))))
