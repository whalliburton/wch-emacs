;; mail.el

;; wanderlust

(use-package wl)
(use-package elmo-maildir)

;; ;; IMAP, gmail:
;; (setq elmo-imap4-default-server "imap.gmail.com"
;;       elmo-imap4-default-user "whalliburton@gmail.com"
;;       elmo-imap4-default-authenticate-type 'clear
;;       elmo-imap4-default-port '993
;;       elmo-imap4-default-stream-type 'ssl

;;       ;;for non ascii-characters in folder-names
;;       elmo-imap4-use-modified-utf7 t)

;; Maildir

(setq elmo-maildir-folder-path "~/Mail")

;; SMTP
(setq wl-smtp-connection-type 'starttls
      wl-smtp-posting-port 587
      wl-smtp-authenticate-type "plain"
      wl-smtp-posting-user "whalliburton"
      wl-smtp-posting-server "smtp.gmail.com"
      wl-local-domain "gmail.com"
      wl-message-id-domain "smtp.gmail.com")

(setq wl-from "William Halliburton <whalliburton@gmail.com>"


;;       ;;all system folders (draft, trash, spam, etc) are placed in the
;;       ;;[Gmail]-folder, except inbox. "%" means it's an IMAP-folder
;;       wl-default-folder "%inbox"
;;       wl-draft-folder   "%[Gmail]/Drafts"
;;       wl-trash-folder   "%[Gmail]/Trash"
;;       wl-fcc            "%[Gmail]/Sent"

;;       ;; mark sent messages as read (sent messages get sent back to you and
;;       ;; placed in the folder specified by wl-fcc)
;;       wl-fcc-force-as-read    t

;;       ;;for when auto-compleating foldernames
;;       wl-default-spec "%"

      )

;; ignore  all fields
(setq wl-message-ignored-field-list '("^.*:"))

;; ..but these five
(setq wl-message-visible-field-list
      '("^To:"
        "^Cc:"
        "^From:"
        "^Subject:"
        "^Date:"))

(setq wl-message-sort-field-list
      '("^From:"
        "^Subject:"
        "^Date:"
        "^To:"
        "^Cc:"))


(use-package mu4e)

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
 user-mail-address "whalliburton@gmail.com"
 user-full-name  "William Halliburton"
 smtpmail-auth-credentials '(("smtp.gmail.com" 587 "whalliburton@gmail.com" nil))
 mu4e-sent-folder   "/whalliburton/[Gmail].Sent Mail"
 mu4e-drafts-folder "/whalliburton/[Gmail].Drafts"
 mu4e-trash-folder  "/whalliburton/[Gmail].Trash"
 mu4e-compose-signature
 (concat
  "William Halliburton\n"
  "Blue Sky Stewardship\n"
  "120 Hickory St, Suite A\n"
  "Missoula, MT 59801\n"))

(defvar my-mu4e-account-alist
  '(
    ("whalliburton"
     (user-mail-address  "whalliburton@gmail.com")
     (user-full-name     "William Halliburton")
     (mu4e-sent-folder   "/whalliburton/[Gmail].Sent Mail")
     (mu4e-drafts-folder "/whalliburton/[Gmail].Drafts")
     (mu4e-trash-folder  "/whalliburton/[Gmail].Trash")
     smtpmail-auth-credentials '(("smtp.gmail.com" 587 "whalliburton@gmail.com" nil))
    ;; (mu4e-refile-folder "/private/Archive")
     )
    ("will"
     (user-mail-address  "will@blueskystewardship.org")
     (user-full-name     "William Halliburton")
     (mu4e-sent-folder   "/will/[Gmail].Sent Mail")
     (mu4e-drafts-folder "/will/[Gmail].Drafts")
     (mu4e-trash-folder  "/will/[Gmail].Trash")
     smtpmail-auth-credentials '(("smtp.gmail.com" 587 "will@blueskystewardship.org" nil))
    ;; (mu4e-refile-folder "/private/Archive")
     )
   ("info"
     (user-mail-address  "info@blueskystewardship.org")
     (user-full-name     "Blue Sky Stewardship")
     (mu4e-sent-folder   "/info/[Gmail].Sent Mail")
     (mu4e-drafts-folder "/info/[Gmail].Drafts")
     (mu4e-trash-folder  "/info/[Gmail].Trash")
     smtpmail-auth-credentials '(("smtp.gmail.com" 587 "info@blueskystewardship.org" nil))
    ;; (mu4e-refile-folder "/private/Archive")
     )))

(setq mu4e-user-mail-address-list
      (mapcar (lambda (account) (cadr (assq 'user-mail-address account)))
                            my-mu4e-account-alist))

(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var))
                                                my-mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                             nil t nil nil (caar my-mu4e-account-alist))))
         (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
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
      '( ("/INBOX"               . ?i)
         ("/[Gmail].Sent Mail"   . ?s)
         ("/[Gmail].Trash"       . ?t)
         ("/[Gmail].All Mail"    . ?a)))

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

;; (setq mu4e-html2text-command "w3m -T text/html")

