;; elfeed.el

(use-package elfeed)
(use-package elfeed-org
  :config (setq rmh-elfeed-org-files '("~/life/elfeed.org")))

;; (use-package elfeed-web)

(elfeed-org)

(defun my-elfeed-store-link ()
  "Store a link to an elfeed search or entry buffer."
  (cond ((derived-mode-p 'elfeed-search-mode)
         (org-store-link-props
          :type "elfeed"
          :link (format "elfeed:%s" elfeed-search-filter)
          :description elfeed-search-filter))
        ((derived-mode-p 'elfeed-show-mode)
         (org-store-link-props
          :type "elfeed"
          :link (format "elfeed:%s#%s"
                        (car (elfeed-entry-id elfeed-show-entry))
                        (cdr (elfeed-entry-id elfeed-show-entry)))
          :description (elfeed-entry-title elfeed-show-entry)))))

(defun my-elfeed-open (filter-or-id)
  "Jump to an elfeed entry or search, depending on what FILTER-OR-ID looks like."
  (message "filter-or-id: %s" filter-or-id)
  (if (string-match "\\([^#]+\\)#\\(.+\\)" filter-or-id)
      (elfeed-show-entry (elfeed-db-get-entry (cons (match-string 1 filter-or-id)
                                                    (match-string 2 filter-or-id))))
    (switch-to-buffer (elfeed-search-buffer))
    (unless (eq major-mode 'elfeed-search-mode)
      (elfeed-search-mode))
    (elfeed-search-set-filter filter-or-id)))

(org-add-link-type "elfeed" #'my-elfeed-open)
(add-hook 'org-store-link-functions #'my-elfeed-store-link)

(defun elfeed-possibly-shorten-feed-title (name)
  (cond
   ((string-starts-with name "missoulian") "The Missoulian")
   ((string-starts-with name "MissoulaEvents") "Missoula Events")
   ((string-starts-with name "Missoula Independent") "Missoula Independent")
   (t name)))
