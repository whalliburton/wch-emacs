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
   "last"
   "magit"
   "keybindings"

          ))

;;           ;; "yasnippets" ; using assoc
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
;;           "editing"
;;           "journal"
;;           "wiki"
;;           "terminal"
;;           "ssh-keys"
;;           "multiple-cursors"
;;           "packages"
;;           "org"
;;           "helm"
;;           "colors"
;;           "last"

