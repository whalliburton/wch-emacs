; mail.el

(use-package mu4e
  :config (setq mu4e-use-fancy-chars nil
                mu4e-headers-full-search nil
                mu4e-view-show-addresses t
                mu4e-attachment-dir "~/attach"))


(use-package mu4e-contrib)

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu

(require 'smtpmail)

(setq message-send-mail-function 'smtpmail-send-it
      starttls-use-gnutls t
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)


(setq mu4e-maildir "~/Mail/")

;; something about ourselves
(setq
 user-mail-address "will@blueskystewardship.org"
 user-full-name  "William Halliburton"
 smtpmail-smtp-user "will@blueskystewardship.org"
 mu4e-sent-folder   "/will/sent"
 mu4e-drafts-folder "/will/drafts"
 mu4e-trash-folder  "/will/trash")

(defvar *impersonate-sig* nil)

(defun impersonate ()
  (interactive)
  (setf *impersonate-sig*
        (if *impersonate-sig*
            nil
            (concat
             "William Halliburton\n"
             "Blue Sky Stewardship\n"
             "120 Hickory St. Missoula, MT 59801\n"
             "www.blueskystewardship.org\n")))
  (message (if *impersonate-sig* "Impersonating." "Yourself!")))

(defun random-sig ()
  (let ((sigs
          '("H/-\\(/</-\\TH0/\\/!"
            "|-| /\\ ( /< /\\ ~|~ |-| () |\\|"
            "48 61 63 6B 61 74 68 6F 6E 21"
            "|-|/-\\(|</-\\\"|\"|-|()|\\|!"
            "|-|4ck4th0n!"
            ".... .- -.-. -.- .- - .... --- -. .-.-.-"
            "Unpxnguba!"
            "][-][ //-\\ << ][< //-\\ `][` ][-][ [[]] ][\\][ !!1"

            "H/-\\PPY H/-\\(/<1/\\/6!"
            "|-|/-\\|'|'`/ |-|/-\\(|<||\\|[,!"
            "48 61 70 70 79  48 61 63 6B 69 6E 67 21"
            "|-|4ppy |-|4ck!ngi"
            ".... .- .--. .--. -.--    .... .- -.-. -.- .. -. --. .-.-.-"
            "Unccl Unpxvat!"
            "][-][ //-\\ ]]P ]]P ``//   ][-][ //-\\ << ][< ]][ ][\\][ ((6 !!1"
            "|-| /\\ |^ |^ `/   |-| /\\ ( /< | |\\| (_,")))
    (or *impersonate-sig* (nth (random (length sigs)) sigs))))

(defvar my-mu4e-account-alist
  '(
    ("will"
     (user-mail-address  "will@blueskystewardship.org")
     (user-full-name     "William Halliburton")
     (mu4e-sent-folder   "/will/sent")
     (mu4e-drafts-folder "/will/drafts")
     (mu4e-trash-folder  "/will/trash")
     (smtpmail-smtp-user "will@blueskystewardship.org")
     (mu4e-compose-signature random-sig))
    ("whalliburton"
     (user-mail-address  "whalliburton@gmail.com")
     (user-full-name     "William Halliburton")
     (mu4e-sent-folder   "/whalliburton/sent")
     (mu4e-drafts-folder "/whalliburton/drafts")
     (mu4e-trash-folder  "/whalliburton/trash")
     (smtpmail-smtp-user "whalliburton")
     (mu4e-compose-signature
      (concat
       "William Halliburton\n"
       "406-830-5031\n")))
    ("info"
     (user-mail-address  "info@blueskystewardship.org")
     (user-full-name     "Blue Sky Stewardship")
     (mu4e-sent-folder   "/info/sent")
     (mu4e-drafts-folder "/info/drafts")
     (mu4e-trash-folder  "/info/trash")
     (smtpmail-smtp-user "info@blueskystewardship.org")
     (mu4e-compose-signature
      (concat
       "William Halliburton\n"
       "Blue Sky Stewardship\n"
       "120 Hickory St. Missoula, MT 59801\n"
       "www.blueskystewardship.org\n")))))


(setq mu4e-refile-folder
      (lambda (msg)
        (cond
         ((mu4e-message-contact-field-matches msg :to "will@blueskystewardship.org") "/will/all")
         ((mu4e-message-contact-field-matches msg :to "whalliburton@gmail.com") "/whalliburton/all")
         ((mu4e-message-contact-field-matches msg :to "info@blueskystewardship.org") "/info/all")
         ;; everything else goes to /all
         ;; important to have a catch-all at the end!
         (t  "/will/all"))))
(setq mu4e-user-mail-address-list
      (mapcar (lambda (account) (cadr (assq 'user-mail-address account)))
                            my-mu4e-account-alist))

(defvar *default-mail-account* "will")

(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
          (or *default-mail-account*
              (if mu4e-compose-parent-message
                  (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                    (string-match "/\\(.*?\\)/" maildir)
                    (match-string 1 maildir))
                (completing-read (format "Compose with account: (%s) "
                                         (mapconcat #'(lambda (var) (car var))
                                                    my-mu4e-account-alist "/"))
                                 (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                                 nil t nil nil (caar my-mu4e-account-alist)))))
         (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
        (mapc #'(lambda (var)
                  (set (car var)
                       (progn
                         (message "%S" var)
                         (cadr var))))
              account-vars)
      (error "No email account found"))))

;; ask for account when composing mail
(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; (See the documentation for `mu4e-sent-messages-behavior' if you have
;; additional non-Gmail addresses and want assign them different
;; behavior.)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
      '( ("/will/all"    . ?a)
         ("/will/sent"   . ?s)
         ("/will/trash"  . ?t)
         ("/will/drafts" . ?d)))

(add-to-list 'mu4e-bookmarks '("flag:flagged"       "starred"     ?s))
;;(add-to-list 'mu4e-bookmarks '("size:5M..500M"       "Big messages"     ?b))
;; (add-to-list 'mu4e-bookmarks '("mime:application/pdf" "Messages with PDFs" ?d))

;; allow for updating mail using 'U' in the main view:
(setq mu4e-get-mail-command "offlineimap")

;; alternatively, for emacs-24 you can use:
;;(setq message-send-mail-function 'smtpmail-send-it
;;     smtpmail-stream-type 'starttls
;;     smtpmail-default-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-server "smtp.gmail.com"
;;     smtpmail-smtp-service 587)

;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)


(setq mu4e-html2text-command "html2text -utf8 -nobs -width 72")
;(setq mu4e-html2text-command 'mu4e-shr2text)

(setq mu4e-headers-skip-duplicates t)


(add-to-list 'mu4e-view-actions
              '("ViewInBrowser" . mu4e-action-view-in-browser) t)

(add-to-list 'mu4e-header-info-custom
             '(:recipnum .
                         (:name "Number of recipients"  ;; long name, as seen in the message-view
                                :shortname "R#"           ;; short name, as seen in the headers view
                                :help "Number of recipients for this message" ;; tooltip
                                :function
                                (lambda (msg)
                                  (format "%d"
                                          (+ (length (mu4e-message-field msg :to))
                                              (length (mu4e-message-field msg :cc))))))))

(add-to-list 'mu4e-header-info-custom
             '(:recipinitials .
                              (:name "Initials of recipients"  ;; long name, as seen in the message-view
                                     :shortname "Recipients"           ;; short name, as seen in the headers view
                                     :help "Initials recipients for this message" ;; tooltip
                                     :function
                                     (lambda (msg)
                                       (let* ((all (append (mu4e-message-field msg :to) (mu4e-message-field msg :cc)))
                                              (count (length all))
                                              (initials
                                               (remove-duplicates
                                                (mapcar
                                                 (lambda (el)
                                                   (when (car el)
                                                     (mapconcat
                                                      (lambda (word)
                                                        (format "%c" (aref word 0)))
                                                      (split-string (car el))
                                                      "")))
                                                 (subseq all 0 (min 4 count))))))
                                         (format
                                          "%s%s"
                                          (mapconcat 'identity initials ", ")
                                          (if (> count 4)
                                              (format " (%s)" count)
                                            "")))))))


(setq mu4e-headers-fields
      '((:human-date . 12)
        (:flags . 6)
        (:mailing-list . 10)
        (:from-or-to . 22)
        (:recipinitials . 20)
        (:subject)))


;; (setq mu4e-html2text-command "w3m -T text/html")

;; mu4e evil bindings

(evil-set-initial-state 'mu4e-view-mode 'normal)
(evil-set-initial-state 'mu4e-main-mode 'normal)
(evil-set-initial-state 'mu4e-headers-mode 'normal)

;; use the standard bindings as a base
(evil-make-overriding-map mu4e-view-mode-map 'normal t)
(evil-make-overriding-map mu4e-main-mode-map 'normal t)
(evil-make-overriding-map mu4e-headers-mode-map 'normal t)

(evil-define-key 'normal mu4e-view-mode-map (read-kbd-macro "C-M-j") 'mu4e~view-open-attach-from-binding)



(evil-add-hjkl-bindings mu4e-view-mode-map 'normal
  "j" 'mu4e-view-headers-next
  "k" 'mu4e-view-headers-prev
                                        ;"j" 'evil-next-line
  "C" 'mu4e-compose-new
  "o" 'mu4e-view-message
  "Q" 'mu4e-raw-view-quit-buffer)

;; (evil-add-hjkl-bindings mu4e-view-raw-mode-map 'normal
;;   "J" 'mu4e-jump-to-maildir
;;   "j" 'evil-next-line
;;   "C" 'mu4e-compose-new
;;   "q" 'mu4e-raw-view-quit-buffer)

(evil-add-hjkl-bindings mu4e-headers-mode-map 'normal
  "J" 'mu4e~headers-jump-to-maildir
  "j" 'evil-next-line
  "C" 'mu4e-compose-new
  "o" 'mu4e-view-message)

(evil-add-hjkl-bindings mu4e-main-mode-map 'normal
  "J" 'mu4e~headers-jump-to-maildir
  "M" 'visit-mail-queue
  "j" 'evil-next-line
  "RET" 'mu4e-view-message)


;; ;; gets the string-list of contacts from hash-table that
;; ;; mu4e maintains
;; (setq mu4e~cands (hash-table-keys mu4e~contacts))

;; ;; setup helm
;; (setq cand-helm-source
;;       '((name . "HELM at the Emacs")
;;         (candidates . mu4e~cands)
;;         (action . (lambda (candidate)
;;                     (message "%s" candidate)))))

;; ;; then simple call helm complete
;; (helm :sources '(cand-helm-source))

;; recently added?
;;
;; (add-hook 'mu4e-mark-execute-pre-hook
;;           (lambda (mark msg)
;;             (cond ((member mark '(refile trash)) (mu4e-action-retag-message msg "-\\Inbox"))
;;                   ((equal mark 'flag) (mu4e-action-retag-message msg "\\Starred"))
;;                   ((equal mark 'unflag) (mu4e-action-retag-message msg "-\\Starred")))))



(setq smtpmail-queue-mail t  ;; start in queuing mode
      smtpmail-queue-dir   "~/Mail/queue/cur")

(defun visit-mail-queue ()
  (interactive)
  (dired-other-window smtpmail-queue-dir)
  (revert-buffer))


;; (defvar *export-buffer* nil)
;; (defvar *export-message* nil)

;; (defun export-all-emails ()
;;   (interactive)
;;   (let ((name (read-from-minibuffer "name: " "foo")))
;;     (let ((buffer (get-buffer-create (format "exported-mail-messages-%s.org" name))))
;;       (setf *export-buffer* buffer)
;;       (save-excursion
;;         (goto-char (point-min))
;;         (loop for x from 1 to (count-lines (point-min) (point-max))
;;               do (let* ((message (mu4e-message-at-point))
;;                         (docid (mu4e-message-field message :docid)))
;;                    (setf *export-message* message)
;;                    (mu4e~proc-view docid)
;;                    (forward-line))))
;;       (switch-to-buffer buffer)
;;       (goto-char (point-min))
;;       (org-mode)))
;;   (message "done exporting emails"))


;; (setf mu4e-view-func 'wch-mu4e-view-func)

;; (defun wch-mu4e-view-func (msg)
;;   (with-current-buffer *export-buffer*
;;     (let* ((subject (mu4e-message-field msg :subject))
;;            (date (mu4e-message-field msg :date))
;;            (from (car (mu4e-message-field msg :from)))
;;            (to (car (mu4e-message-field msg :to)))
;;            (body (mu4e-message-body-text msg))
;;            (thread (mu4e-message-field  :thread))
;;            (thread-level (if thread (plist-get thread :level) 0))
;;            (indent (make-string (+ thread-level 2) 32)))
;;       (insert
;;        (format "%-2s  %c:%c  %s  %s\n%s\n"
;;                (make-string (+ thread-level 1) ?*)
;;                (aref (if (car from) (car from) (cdr from)) 0)
;;                (aref (if (car to) (car to) (cdr to)) 0)
;;                (format-time-string "%y-%m-%d %H:%M" date)
;;                subject body)))))


;; (defun foo ()
;;   (interactive)
;;   (message "%s" (mu4e-message-at-point)))


;;; FIX MU4E Org export

(defun org~mu4e-mime-replace-images (str current-file)
  "Replace images in html files with cid links."
  (let (html-images)
    (cons
     (replace-regexp-in-string ;; replace images in html
      "src=\"\\([^\"]+\\)\""
      (lambda (text)
        (format
         "src=\"cid:%s\""
         (let* ((url (and (string-match "src=\"\\(file://\\)?\\([^\"]+\\)\"" text)
                          (match-string 2 text)))
                (path (expand-file-name
                       url (file-name-directory current-file)))
                (ext (file-name-extension path))
                (id (replace-regexp-in-string "[\/\\\\]" "_" path)))
           (add-to-list 'html-images
                        (org~mu4e-mime-file
			  (concat "image/" ext) path id))
           id)))
      str)
     html-images)))

