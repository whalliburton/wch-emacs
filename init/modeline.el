;; modeline.el

(use-package evil-mode-line)

(setq
 evil-mode-line-color
 '((normal . "black")
   (insert . "#242424")
   (replace . "#575735")
   (operator . "DarkSeaGreen4")
   (visual . "SteelBlue4")
   (emacs . "#6c3333")))

(defun short-system-name ()
  (let* ((name (system-name))
         (hit (position ?. name)))
    (or (and hit (subseq name 0 hit)) name)))

(use-package smart-mode-line
  :init
  (setq sml/theme 'dark
        sml/no-confirm-load-theme t
        sml/shorten-directory t
        sml/shorten-modes t
        rm-blacklist '(" ElDoc" " Paredit"))
  :config
  (sml/setup))

(setq display-time-day-and-date t
      display-time-mail-string "")
(display-time)
(display-battery-mode 1)
(column-number-mode 1)
(line-number-mode 1)
