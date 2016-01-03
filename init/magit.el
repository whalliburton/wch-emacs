;; magit.el

(use-package dash)
(use-package magit)

(setf magit-diff-highlight-hunk-body t)

(defun magit-amend ()
  (interactive)
  (magit-log-edit-toggle-amending))

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(magit-diff-added ((t (:foreground "#335533"))))
;;  '(magit-diff-added-highlight ((t (:foreground "#339933"))))
;;  '(magit-diff-base ((t (:foreground "#555522"))))
;;  '(magit-diff-base-highlight ((t (:foreground "#777722"))))
;;  '(magit-diff-removed ((t (:foreground "#335533"))))
;;  '(magit-diff-removed-highlight ((t (:foreground "#339933")))))
