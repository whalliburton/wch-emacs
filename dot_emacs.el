;; .emacs
;; William Halliburton <whalliburton@gmail.com>

(add-to-list 'load-path "~/emacs/site-lisp")

(mapcar (lambda (name) (load-file (expand-file-name (format "%s/%s.el" "~/emacs/init" name))))
 '(

   "first"
   "display"
   "colors"
   "programming"
   "indentation"
   "keybindings"
   "last"

          ))

