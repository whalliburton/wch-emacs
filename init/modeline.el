;; modeline.el

(setq default-mode-line-format
      '("%e"
        "-"
        mode-line-mule-info
        mode-line-modified
        "  "
        mode-line-buffer-identification
        "   "
        (:eval (system-name))
        "   "
        mode-line-position
        (vc-mode vc-mode)
        "  "
        mode-line-modes
        (which-func-mode
         ("" which-func-format
          "--"))
        global-mode-string
        "-%-"))

(display-time)

(column-number-mode 1)

(line-number-mode 1)
