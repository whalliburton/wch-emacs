;; tmeplates.el

(use-package yasnippet
             :config (yas-global-mode 1)
             (setf auto-insert 'other
                   auto-insert-directory "~/emacs/autoinsert/"
                   auto-insert-query nil
                   auto-insert-alist '((("\\.\\([Hh]\\|hh\\|hpp\\)\\'" . "C / C++ header") . ["template.h" c++-mode my/autoinsert-yas-expand])
                                       (("\\.\\([C]\\|cc\\|cpp\\)\\'" . "C++ source") . ["template.cc" my/autoinsert-yas-expand])
                                       (("\\.sh\\'" . "Shell script") . ["template.sh" my/autoinsert-yas-expand])
                                       (("\\.el\\'" . "Emacs Lisp") . ["template.el" my/autoinsert-yas-expand])
                                       (("\\.lisp\\'" . "Common Lisp") . ["template.lisp" my/autoinsert-yas-expand])
                                       (("\\.org\\'" . "Org Mode") . ["template.org" my/autoinsert-yas-expand])
                                       (("\\.pl\\'" . "Perl script") . ["template.pl" my/autoinsert-yas-expand])
                                       (("\\.pm\\'" . "Perl module") . ["template.pm" my/autoinsert-yas-expand])
                                       (("\\.py\\'" . "Python script") . ["template.py" my/autoinsert-yas-expand])
                                       (("[mM]akefile\\'" . "Makefile") . ["Makefile" my/autoinsert-yas-expand])
                                       (("\\.tex\\'" . "TeX/LaTeX") . ["template.tex" my/autoinsert-yas-expand]))))

(use-package common-lisp-snippets)

(add-hook 'find-file-hook 'auto-insert)

(defun my/autoinsert-yas-expand ()
  "Replace text in yasnippet template."
  (yas-expand-snippet (buffer-string) (point-min) (point-max)))


