;; slime.el

;; taken from quicklisp and modified
(defun quicklisp-slime-helper-file-contents (file)
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-string)))
(defun quicklisp-slime-helper-slime-directory ()
  (let* ((base (expand-file-name "~/quicklisp/"))
	 (location-file (concat base "dists/quicklisp/installed/systems/swank.txt")))
    (when (file-exists-p location-file)
      (let ((relative (quicklisp-slime-helper-file-contents location-file)))
	(file-name-directory (concat base relative))))))

(cond
 ((file-exists-p  "/mnt/projects/site-lisp/slime/")
  (progn
    (add-to-list 'load-path "/mnt/projects/site-lisp/slime/")
    (add-to-list 'load-path "/mnt/projects/site-lisp/slime/contrib/")))
 ((file-exists-p "~/quicklisp")
  (progn
    (add-to-list 'load-path (quicklisp-slime-helper-slime-directory))
    (add-to-list 'load-path (concat (quicklisp-slime-helper-slime-directory) "contrib/")))))

(setq inferior-lisp-program "/usr/local/bin/sbcl --no-linedit")
(require 'slime)
(slime-setup '(slime-repl
               slime-c-p-c
               slime-fancy-inspector
               slime-editing-commands
               slime-fuzzy
               slime-scratch
               slime-references
;              slime-mdot-fu
               slime-fontifying-fu

;; this one allows for the lisp to send indentation hints to emacs
               slime-indentation

;              slime-presentations
;              slime-presentation-streams
               slime-xref-browser
               slime-asdf
;               slime-autodoc
;               slime-clipboard
))

(slime-fuzzy-init)
(slime-scratch-init)
(slime-references-init)
;(slime-mdot-fu-init)
(slime-asdf-init)

(setq slime-additional-font-lock-keywords
      '(("(\\(\\(\\s_\\|\\w\\)*:\\(define-\\|defun-\\|do-\\|with-\\)\\(\\s_\\|\\w\\)*\\)" 1 font-lock-keyword-face)
        ("(\\(\\(define-\\|defun-\\|do-\\|with-\\)\\(\\s_\\|\\w\\)*\\)" 1 font-lock-keyword-face)))
;        ("(\\(check-\\(\\s_\\|\\w\\)*\\)" 1 font-lock-warning-face)))

(slime-fontifying-fu-init)
(slime-indentation-init)
;(slime-presentations-init)

(setq slime-inspector-limit 2000)

;; (defun slime-maybe-show-compilation-log (notes)
;;   (unless (null notes)
;;     (slime-show-compilation-log notes)))

;(setf slime-compilation-finished-hook 'slime-maybe-show-compilation-log)

;(setf lisp-simple-loop-indentation 1
;      lisp-loop-keyword-indentation 6
;      lisp-loop-forms-indentation 6)

(defun slime-clisp ()
  (interactive)
  (let ((inferior-lisp-program "/usr/bin/clisp"))
    (slime)))

(setq common-lisp-hyperspec-root
      "file:/usr/share/doc/hyperspec/")

(add-hook 'lisp-mode-hook 'my-lisp-mode-hook)

(defun my-lisp-mode-hook ()
  (interactive)
  (make-local-variable 'lisp-indent-function)
  (put 'valid? 'lisp-indent-function nil)
  (put 'do-dialog 'lisp-indent-function nil)
  (setf fill-column 90))


(add-hook 'shell-mode-hook
          (lambda ()
             (local-set-key "\C-c\C-a" 'slime-switch-to-output-buffer)))

(global-set-key "\C-c\C-s"
                (lambda ()
                  (interactive)
                  (switch-to-buffer "*shell*")))

(add-hook 'slime-mode-hook
          (lambda ()
            (local-set-key "\C-c\C-s"
                           (lambda ()
                             (interactive)
                             (switch-to-buffer "*shell*")))
            (local-set-key "\C-c\C-s"
                           (lambda ()
                             (interactive)
                             (switch-to-buffer "*shell*")))))

(set-language-environment "UTF-8")
(setq slime-net-coding-system 'utf-8-unix)

(load "js-expander.el")

;; Possible SECURITY risk. I use this for color printing at the REPL.
(setq slime-enable-evaluate-in-emacs t)

(defun invoke-terminate-thread-restart ()
  (interactive)
  (sldb-invoke-restart-by-name "TERMINATE-THREAD"))

(define-key sldb-mode-map "T" 'invoke-terminate-thread-restart)


(custom-set-faces
 '(slime-error-face ((((class color) (background dark)) (:background "red"))))
 '(slime-warning-face ((((class color) (background dark)) (:background "coral"))))
 '(slime-style-warning-face ((((class color) (background dark)) (:background "gold4"))))
 '(slime-note-face ((((class color) (background dark)) (:background "goldenrod"))))
 '(sldb-topline-face ((((class color) (background dark)) (:foreground "red"))))
 '(sldb-section-face ((((class color) (background dark)) (:foreground "blue")))))

;; slime-cover

(cond
 ((file-exists-p  "/lisp/site-lisp/slime-cover/")
  (load "/lisp/site-lisp/slime-cover/slime-cover.el"))
 ((file-exists-p  "/mnt/projects/site-lisp/slime/")
  (load "/mnt/projects/site-lisp/slime-cover/slime-cover.el")))

(defun sldb-var-copy-down-to-repl ()
  (interactive)
  (let ((frame (sldb-frame-number-at-point))
        (var (sldb-var-number-at-point)))
    (slime-repl-eval-string (format "%s" `(swank::frame-var-value ,frame ,var)))))

(add-hook 'sldb-mode-hook
          (lambda ()
             (local-set-key "?" 'sldb-var-copy-down-to-repl)))

;; (define-key slime-repl-mode-map (kbd "<home>") 'beginning-of-buffer)

