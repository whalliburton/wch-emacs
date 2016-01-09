;; .emacs
;; William Halliburton <whalliburton@gmail.com>

(add-to-list 'load-path "~/emacs/site-lisp")

(byte-recompile-directory "~/emacs/init" 0)

(mapcar (lambda (name) (load-file (expand-file-name (format "%s/%s.elc" "~/emacs/init" name))))
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



