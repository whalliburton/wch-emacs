;; org.el

(add-to-list 'load-path "~/emacs/org-mode/contrib/lisp/")

(use-package org)
(use-package org-agenda)
(use-package ox-publish)
(use-package ox-html)
(use-package ob-calc)
(use-package ob-ledger)

(use-package org-wl)
(use-package org-git-link)

(use-package org-mu4e
  :config (setq org-mu4e-link-query-in-headers-mode nil))



(use-package org-elisp-help)

(use-package org-manage
  :config (setq org-manage-directory-org "~/life"))

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(setq org-agenda-files (quote ("~/life"))
      org-default-notes-file "~/life/notes.org"
      org-refile-targets (quote ((nil :maxlevel . 9) (org-agenda-files :maxlevel . 9)))
      ;;      org-deadline-warning-days 14
      ;;      org-agenda-show-all-dates t
      ;;      org-babel-load-languages '((emacs-lisp . t) (lisp . t) (sh . t))
      org-src-fontify-natively t
      org-src-tab-acts-natively t
      org-clock-idle-time 10
      org-confirm-babel-evaluate nil)

(org-babel-do-load-languages 'org-babel-load-languages
                             '((lisp . t) (sh . t) (calc . t)
                               (ditaa . t) (ledger . t) (C . t)
                               (dot . t) (plantuml . t)))
;; TODO study http://doc.norang.ca/org-mode.html

(setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar"
      org-plantuml-jar-path "~/emacs/bin/plantuml.jar")

(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/life/refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/life/refile.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/life/refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/life/diary.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/life/refile.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file "~/life/refile.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/life/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/life/refile.org")
                              "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))


(advice-add 'org-agenda-quit :before 'org-save-all-org-buffers)


(setq diary-file "~/life/calendar-diary")


(setq org-publish-project-alist
      '(("public-notes"
         :base-directory "~/life/public"
         :base-extension "org"
         :publishing-directory "~/life/public_html/_posts"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         :auto-sitemap t
         :body-only t
         :html-extension "html")
        ("public-static"
         :base-directory "~/life/public"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/life/public_html/"
         :recursive t
         :publishing-function org-publish-attachment)
        ("public" :components ("public-notes" "public-static"))
        ("bss-notes"
         :base-directory "~/blue-sky-stewardship/public"
         :base-extension "org"
         :publishing-directory "~/blue-sky-stewardship/public_html/_posts"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         :body-only t
         :html-extension "html")
        ("bss-static"
         :base-directory "~/blue-sky-stewardship/public"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/blue-sky-stewardship/public_html/"
         :recursive t
         :publishing-function org-publish-attachment)
        ("bss" :components ("bss-notes" "bss-static"))


        ))

(setq org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                          (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING")
)
      org-todo-keyword-faces
      '(("TODO" :foreground "red" :weight bold)
        ("NEXT" :foreground "blue" :weight bold)
        ("DONE" :foreground "forest green" :weight bold)
        ("WAITING" :foreground "orange" :weight bold)
        ("HOLD" :foreground "magenta" :weight bold)
        ("CANCELLED" :foreground "forest green" :weight bold)
        ("MEETING" :foreground "forest green" :weight bold)
        ("PHONE" :foreground "forest green" :weight bold)))

(setq org-todo-state-tags-triggers
      '(("CANCELLED" ("CANCELLED" . t))
        ("WAITING" ("WAITING" . t))
        ("HOLD" ("WAITING") ("HOLD" . t))
        (done ("WAITING") ("HOLD"))
        ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
        ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
        ("DONE" ("WAITING") ("CANCELLED") ("HOLD"))))

;; Remove empty LOGBOOK drawers on clock out
(defun bh/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK" (point))))

(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)

;;;; Refile settings

;; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)

(setq org-agenda-custom-commands
      '(("N" "Notes" tags "NOTE"
         ((org-agenda-overriding-header "Notes")
          (org-tags-match-list-sublevels t)))
        ("h" "Habits" tags-todo "STYLE=\"habit\""
         ((org-agenda-overriding-header "Habits")
          (org-agenda-sorting-strategy
           '(todo-state-down effort-up category-keep))))))

;; link abbrevs
(add-to-list 'org-link-abbrev-alist '("emacswiki" . "http://www.emacswiki.org/cgi-bin/wiki/"))
(add-to-list 'org-link-abbrev-alist '("google" . "http://www.google.com/search?q="))



;;; add ascii text output to platnuml

(defun org-babel-execute:plantuml (body params)
  "Execute a block of plantuml code with org-babel.
This function is called by `org-babel-execute-src-block'."
  (let* ((ascii (cdr (assoc :ascii params)))
         (unicode (cdr (assoc :unicode params)))
         (text (or ascii unicode)))
    (let* ((out-file (or text
                         (cdr (assoc :file params))
                      (error "PlantUML requires a \":file\", \":ascii\", or \"unicode\" header argument")))
           (cmdline (cdr (assoc :cmdline params)))
           (in-file (org-babel-temp-file "plantuml-"))
           (java (or (cdr (assoc :java params)) ""))
           (cmd (if (string= "" org-plantuml-jar-path)
                    (error "`org-plantuml-jar-path' is not set")
                    (concat "java " java " -jar "
                            (shell-quote-argument
                             (expand-file-name org-plantuml-jar-path))
                            (if (and (not text) (string= (file-name-extension out-file) "svg"))
                                " -tsvg" "")
                            (if (and (not text) (string= (file-name-extension out-file) "eps"))
                                " -teps" "")
                            " -p "
                            (when ascii " -txt ")
                            (when unicode " -utxt ")
                            cmdline " < "
                            (org-babel-process-file-name in-file)
                            (when (not text) " > ")
                            (when (not text) (org-babel-process-file-name out-file))))))
      (unless (file-exists-p org-plantuml-jar-path)
        (error "Could not find plantuml.jar at %s" org-plantuml-jar-path))
      (with-temp-file in-file (insert (concat "@startuml\n" body "\n@enduml")))
      (message "%s" cmd)
      (let ((rtn (org-babel-eval cmd "")))
        (if text
            rtn
            nil ;; signal that output has already been written to file
            )))))

