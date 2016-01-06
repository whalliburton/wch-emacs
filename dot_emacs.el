;; .emacs
;; William Halliburton <whalliburton@gmail.com>

(add-to-list 'load-path "~/emacs/site-lisp")

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
   "keybindings"
   "last"

         ))

;;           "registers"
;;           "xterm"
;;           "automode"
;;           "bbdb"
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
 '(helm-buffer-directory ((t (:background "black" :foreground "color-32" :weight bold))))
 '(helm-ff-directory ((t (:background "black" :foreground "color-32" :weight bold))))
 '(helm-ff-dotted-directory ((t (:background "black" :foreground "color-27" :weight bold))))
 '(helm-ff-dotted-symlink-directory ((t (:background "black" :foreground "DarkOrange"))))
 '(helm-selection ((t (:background "color-236" :distant-foreground "black")))))
