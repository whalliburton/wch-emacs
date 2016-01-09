;; org.el

(use-package org)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(setq org-agenda-files (quote ("~/life"))
      org-default-notes-file "~/life/notes.org"
      org-refile-targets (quote ((nil :maxlevel . 9) (org-agenda-files :maxlevel . 9)))
;;      org-deadline-warning-days 14
;;      org-agenda-show-all-dates t
      )

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
