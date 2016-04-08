;; programming.el

;;; common lisp

(load (expand-file-name "~/quicklisp/slime-helper.el"))

(setq inferior-lisp-program "/usr/local/bin/sbcl --no-linedit")

(use-package slime)

(use-package lisp-helpers)

;; advanced highlighting of matching parentheses
(use-package mic-paren
  :config (paren-activate))

;; Show a vertical line (column highlighting) mode with (vline-mode).
(use-package vline)

(use-package auto-complete-config
  :config
  (ac-config-default)
  (setq ac-auto-show-menu nil))

(use-package ac-slime
  :config
  (add-hook 'slime-mode-hook 'set-up-slime-ac)
  (add-hook 'slime-repl-mode-hook 'set-up-slime-ac)
  (add-to-list 'ac-modes 'slime-repl-mode))

;;; Whitespace

(setq-default indent-tabs-mode nil)

(add-hook 'write-file-hooks 'safe-delete-trailing-whitespace)

(setq whitespace-style '(tabs trailing))

(add-hook 'lisp-mode-hook 'whitespace-mode)


;;; HTML/CSS

;; major mode for editing SCSS files
(use-package scss-mode)


;; (defvar *package-name-substitutions*
;;   '(("LAUNCH" . "☉ ")
;;     ("ACADEMY" . "⚛ ")))

;; (defun my-slime-lisp-package-prompt-string (fn)
;;   (let* ((name (funcall fn))
;;          (hit (assoc name *package-name-substitutions*)))
;;     (if hit (cdr hit) name)))

;; (my-slime-lisp-package-prompt-string #'slime-lisp-package-prompt-string)

;; (advice-add 'slime-lisp-package-prompt-string :around #'my-slime-lisp-package-prompt-string)


;;; elisp

;;; show function arglist or variable docstring in echo area
(use-package eldoc :config (add-hook 'emacs-lisp-mode-hook 'eldoc-mode))

; Possible SECURITY risk. We use this for color printing at the REPL.
(setq slime-enable-evaluate-in-emacs t)

;; the following was written by Helmut

(defun elisp-disassemble (function)
  (interactive (list (function-called-at-point)))
  (disassemble function))

(defun elisp-pp (sexp)
  (with-output-to-temp-buffer "*Pp Eval Output*"
    (pp sexp)
    (with-current-buffer standard-output
      (emacs-lisp-mode))))

(defun elisp-macroexpand (form)
  (interactive (list (form-at-point 'sexp)))
  (elisp-pp (macroexpand form)))

(defun elisp-macroexpand-all (form)
  (interactive (list (form-at-point 'sexp)))
  (elisp-pp (cl-macroexpand-all form)))

(defun elisp-push-point-marker ()
  (require 'etags)
  (cond ((featurep 'xemacs)
         (push-tag-mark))
        (t (ring-insert find-tag-marker-ring (point-marker)))))

(defun elisp-pop-found-function ()
  (interactive)
  (cond ((featurep 'xemacs) (pop-tag-mark nil))
        (t (pop-tag-mark))))

(defun elisp-find-definition (name)
  "Jump to the definition of the function (or variable) at point."
  (interactive (list (thing-at-point 'symbol)))
  (cond (name
         (let ((symbol (intern-soft name))
               (search (lambda (fun sym)
                         (let* ((r (save-excursion (funcall fun sym)))
                                (buffer (car r))
                                (point (cdr r)))
                           (cond ((not point)
                                  (error "Found no definition for %s in %s"
                                         name buffer))
                                 (t
                                  (switch-to-buffer buffer)
                                  (goto-char point)
                                  (recenter 1)))))))
           (cond ((fboundp symbol)
                  (elisp-push-point-marker)
                  (funcall search 'find-function-noselect symbol))
                 ((boundp symbol)
                  (elisp-push-point-marker)
                  (funcall search 'find-variable-noselect symbol))
                 (t
                  (message "Symbol not bound: %S" symbol)))))
        (t (message "No symbol at point"))))

(defun elisp-bytecompile-and-load ()
  (interactive)
  (or buffer-file-name
      (error "The buffer must be saved in a file first"))
  (require 'bytecomp)
  ;; Recompile if file or buffer has changed since last compilation.
  (when (and (buffer-modified-p)
             (y-or-n-p (format "save buffer %s first? " (buffer-name))))
    (save-buffer))
  (let ((filename (expand-file-name buffer-file-name)))
    (with-temp-buffer
      (byte-compile-file filename t))))

