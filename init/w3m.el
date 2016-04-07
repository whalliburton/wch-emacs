;; w3m.el

(use-package w3m-util)
(use-package w3m)

(defun scroll-up-one-line ()
  (interactive)
  (scroll-up 1))

(defun scroll-down-one-line ()
  (interactive)
  (scroll-down 1))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

(defun chrome (url &optional new-window)
  (interactive (browse-url-interactive-arg "URL: "))
  (browse-url-generic url new-window))

(defun chrome-here ()
  (interactive)
  (let ((url (browse-url-url-at-point)))
    (if url
        (browse-url-generic url)
      (error "No URL found"))))

(defun firefox-here ()
  (interactive)
  (let ((url (browse-url-url-at-point))
        (browse-url-generic-program "firefox"))
    (if url
        (browse-url-generic url)
      (error "No URL found"))))

(defun w3m-browse-url-other-window (url &optional newwin)
  (interactive (browse-url-interactive-arg "w3m URL: "))
  (unless (get-buffer "*w3m*") (w3m-buffer-setup))
  (switch-to-buffer-other-window "*w3m*")
  (w3m-browse-url url))
