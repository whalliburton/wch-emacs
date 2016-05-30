;; .emacs
;; William Halliburton <whalliburton@gmail.com>

(add-to-list 'load-path "~/emacs/site-lisp")

;;(byte-recompile-directory "~/emacs/init" 0)

(mapcar (lambda (name) (load-file (expand-file-name (format "%s/%s.el" "~/emacs/init" name))))
 '(

   "first"
   "utility"
   "evil"
   "paredit"
   "display"
   "colors"
   "programming"
   "indentation"
   "modeline"
   "w3m"
   "erc"
   "magit"
   "fonts"
   "ssh-keys"
   "org"
   "helm"
   "projectile"
   "packages"
   "markdown"
   "mail"
   "elfeed"
   "ledger"
   "future"
   "keybindings"
   "bbdb"
   "templates"
   "crypt"
   "linux"
   "registers"
   "last"

         ))

;;           "registers"
;;           "xterm"
;;           "automode"

;;           "fonts"
;;           "gnus"
;;           "mailcrypt"
;;           "haskell"
;;           "edit-server"
;;           "commands"
;;           "languages"
;;           "music"
;;           "journal"
;;           "wiki"
;;           "multiple-cursors"
;;           "packages"

;;           "helm"


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elfeed-search-title-face ((t (:foreground "#aaa"))))
 '(elfeed-search-unread-title-face ((t (:foreground "#FFF" :weight bold))))
 '(font-lock-builtin-face ((t (:foreground "#839496"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#859900"))))
 '(font-lock-comment-face ((t (:foreground "#586e75"))))
 '(font-lock-function-name-face ((t (:foreground "#268bd2"))))
 '(font-lock-keyword-face ((t (:foreground "#859900"))))
 '(font-lock-string-face ((t (:foreground "#2aa198"))))
 '(helm-buffer-directory ((t (:background "black" :foreground "color-32" :weight bold))))
 '(helm-ff-directory ((t (:background "black" :foreground "color-32" :weight bold))))
 '(helm-ff-dotted-directory ((t (:background "black" :foreground "color-27" :weight bold))))
 '(helm-ff-dotted-symlink-directory ((t (:background "black" :foreground "DarkOrange"))))
 '(helm-selection ((t (:background "color-236" :distant-foreground "black"))))
 '(hl-line ((t (:background "grey10"))))
 '(ledger-font-xact-highlight-face ((t (:background "#222")))))


;; (s-base03    "#002b36")
;; (s-base02    "#073642")
;; emphasized content
;; (s-base01    "#586e75")
;; primary content
;; (s-base00    "#657b83")
;; (s-base0     "#839496")
;; comments
;; (s-base1     "#93a1a1")
;; background highlight light
;; (s-base2     "#eee8d5")
;; background light
;; (s-base3     "#fdf6e3")

;; Solarized accented colors
;; (yellow    "#b58900")
;; (orange    "#cb4b16")
;; (red       "#dc322f")
;; (magenta   "#d33682")
;; (violet    "#6c71c4")
;; (blue      "#268bd2")
;; (cyan      "#2aa198")
;; (green     "#859900")

;;(font-lock-builtin-face ((,class (:foreground ,base0 :weight ,s-maybe-bold
;;                                               :slant ,s-maybe-italic))))
;;`(font-lock-comment-delimiter-face
;;  ((,class (:foreground ,base01 :slant ,s-maybe-italic))))
;;`(font-lock-comment-face ((,class (:foreground ,base01))))
;;`(font-lock-constant-face ((,class (:foreground ,blue :weight bold))))
;;`(font-lock-doc-face ((,class (:foreground ,(if solarized-distinct-doc-face violet cyan)
;;                                           :slant ,s-maybe-italic))))
;;`(font-lock-function-name-face ((,class (:foreground ,blue))))
;;`(font-lock-keyword-face ((,class (:foreground ,green :weight ,s-maybe-bold))))
;;`(font-lock-negation-char-face ((,class (:foreground ,yellow :weight bold))))
;;`(font-lock-preprocessor-face ((,class (:foreground ,blue))))
;;`(font-lock-regexp-grouping-construct ((,class (:foreground ,yellow :weight bold))))
;;`(font-lock-regexp-grouping-backslash ((,class (:foreground ,green :weight bold))))
;;`(font-lock-string-face ((,class (:foreground ,cyan))))
;;`(font-lock-type-face ((,class (:foreground ,yellow))))
;;`(font-lock-variable-name-face ((,class (:foreground ,blue))))
;;`(font-lock-warning-face ((,class (:inherit error :weight bold))))
;;`(c-annotation-face ((,class (:inherit font-lock-constant-face))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ledger-reports
   (quote
    (("ads" "ledger bal Assest")
     ("bal" "ledger -f %(ledger-file) bal")
     ("reg" "ledger -f %(ledger-file) reg")
     ("payee" "ledger -f %(ledger-file) reg @%(payee)")
     ("account" "ledger -f %(ledger-file) reg %(account)"))))
 '(org-agenda-files
   (quote
    ("~/life/hackathon.org" "~/quicklisp/local-projects/hackathon/hackathon.org" "~/life/skills.org" "~/life/fb-connections.org" "~/life/dinner-parties.org" "~/life/building.org" "~/life/digestion.org" "~/life/war.org" "~/life/communications.org" "~/life/urban-forest.org" "~/hackathon/missoula-civic-hackathon-notes/tasks.org" "~/quicklisp/local-projects/web/documentation/web-tasks.org" "~/quicklisp/local-projects/wiki/documentation/wiki-tasks.org" "~/quicklisp/local-projects/hold/documentation/hold-notes.org" "~/quicklisp/local-projects/launch/documentation/launcher-notes.org" "~/life/computers.org" "~/quicklisp/local-projects/web/documentation/notes.org" "~/emacs/emacs-notes.org" "~/quicklisp/local-projects/spaces/documentation/worklog.org" "~/life/organization-intake.org" "/home/conrad/life/blue-sky-stewardship.org" "/home/conrad/life/diary.org" "/home/conrad/life/graph-databases.org" "/home/conrad/life/grin.org" "/home/conrad/life/linux.org" "/home/conrad/life/manufacturing-incubator.org" "/home/conrad/life/missoula-forest-gardens.org" "/home/conrad/life/notes.org" "/home/conrad/life/refile.org" "/home/conrad/life/worklog.org")))
 '(safe-local-variable-values
   (quote
    ((Package . CL-USER)
     (Base . 10)
     (Package . HUNCHENTOOT)
     (Syntax . COMMON-LISP))))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.gmail.com")
 '(smtpmail-smtp-service 25))
(put 'scroll-left 'disabled nil)
