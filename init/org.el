;; org.el

(use-package org)
(use-package org-agenda)
(use-package ox-publish)
(use-package ox-html)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(setq org-agenda-files (quote ("~/life"))
      org-default-notes-file "~/life/notes.org"
      org-refile-targets (quote ((nil :maxlevel . 9) (org-agenda-files :maxlevel . 9)))
      ;;      org-deadline-warning-days 14
      ;;      org-agenda-show-all-dates t
      ;;      org-babel-load-languages '((emacs-lisp . t) (lisp . t) (sh . t))
      org-src-fontify-natively t
      org-src-tab-acts-natively t
      )

(org-babel-do-load-languages 'org-babel-load-languages '((lisp . t) (sh . t)))
;; TODO study http://doc.norang.ca/org-mode.html

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


(setq diary-file "~/life/calendar-diary")


(setq org-publish-project-alist
      '(("public-notes"
         :base-directory "~/life/public"
         :base-extension "org"
         :publishing-directory "~/life/public_html/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         :auto-sitemap t
         :sitemap-filename "sitemap.org"
         :sitemap-title "Sitemap")
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
         :publishing-directory "~/blue-sky-stewardship/public_html/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4             ; Just the default for this project.
         :auto-preamble t
         :sitemap-filename "sitemap.org"
         :sitemap-title "Sitemap")
        ("bss-static"
         :base-directory "~/blue-sky-stewardship/public"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/blue-sky-stewardship/public_html/"
         :recursive t
         :publishing-function org-publish-attachment)
        ("bss" :components ("bss-notes" "bss-static"))


        ))
