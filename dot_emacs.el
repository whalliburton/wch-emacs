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
   "keybindings"
   "ssh-keys"
   "org"
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


