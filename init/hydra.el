;;; hydra.el

(use-package hydra
             :config
             (defhydra hydra-git-gutter (:body-pre (git-gutter-mode 1)
                                         :hint nil)
               "
Git gutter:
  _j_: next hunk        _s_tage hunk     _q_uit
  _k_: previous hunk    _r_evert hunk    _Q_uit and deactivate git-gutter
  ^ ^                   _p_opup hunk
  _h_: first hunk
  _l_: last hunk        set start _R_evision
"
               ("j" git-gutter:next-hunk)
               ("k" git-gutter:previous-hunk)
               ("h" (progn (goto-char (point-min))
                           (git-gutter:next-hunk 1)))
               ("l" (progn (goto-char (point-min))
                           (git-gutter:previous-hunk 1)))
               ("s" git-gutter:stage-hunk)
               ("r" git-gutter:revert-hunk)
               ("p" git-gutter:popup-hunk)
               ("R" git-gutter:set-start-revision)
               ("q" nil :color blue)
               ("Q" (progn (git-gutter-mode -1)
                           ;; git-gutter-fringe doesn't seem to
                           ;; clear the markup right away
                           (sit-for 0.1)
                           (git-gutter:clear))
                    :color blue))

             (defhydra hydra-buffer-menu (:color pink
                                          :hint nil)
                 "
^Mark^             ^Unmark^           ^Actions^          ^Search
^^^^^^^^-----------------------------------------------------------------
_m_: mark          _u_: unmark        _x_: execute       _R_: re-isearch
_s_: save          _U_: unmark up     _b_: bury          _I_: isearch
_d_: delete        ^ ^                _g_: refresh       _O_: multi-occur
_D_: delete up     ^ ^                _T_: files only: % -28`Buffer-menu-files-only
_~_: modified
"
               ("m" Buffer-menu-mark)
               ("u" Buffer-menu-unmark)
               ("U" Buffer-menu-backup-unmark)
               ("d" Buffer-menu-delete)
               ("D" Buffer-menu-delete-backwards)
               ("s" Buffer-menu-save)
               ("~" Buffer-menu-not-modified)
               ("x" Buffer-menu-execute)
               ("b" Buffer-menu-bury)
               ("g" revert-buffer)
               ("T" Buffer-menu-toggle-files-only)
               ("O" Buffer-menu-multi-occur :color blue)
               ("I" Buffer-menu-isearch-buffers :color blue)
               ("R" Buffer-menu-isearch-buffers-regexp :color blue)
               ("c" nil "cancel")
               ("v" Buffer-menu-select "select" :color blue)
               ("o" Buffer-menu-other-window "other-window" :color blue)
               ("q" quit-window "quit" :color blue))

             ; (define-key Buffer-menu-mode-map "." 'hydra-buffer-menu/body)

             (defun ora-ex-point-mark ()
               (interactive)
               (if rectangle-mark-mode
                   (exchange-point-and-mark)
                   (let ((mk (mark)))
                     (rectangle-mark-mode 1)
                     (goto-char mk))))

             (defhydra hydra-rectangle (:body-pre (rectangle-mark-mode 1)
                                        :color pink
                                        :post (deactivate-mark))
                 "
  ^_k_^     _d_elete    _s_tring
_h_   _l_   _o_k        _y_ank
  ^_j_^     _n_ew-copy  _r_eset
^^^^        _e_xchange  _u_ndo
^^^^        ^ ^         _p_aste
"
               ("h" backward-char nil)
               ("l" forward-char nil)
               ("k" previous-line nil)
               ("j" next-line nil)
               ("e" ora-ex-point-mark nil)
               ("n" copy-rectangle-as-kill nil)
               ("d" delete-rectangle nil)
               ("r" (if (region-active-p)
                        (deactivate-mark)
                        (rectangle-mark-mode 1)) nil)
               ("y" yank-rectangle nil)
               ("u" undo nil)
               ("s" string-rectangle nil)
               ("p" kill-rectangle nil)
               ("o" nil nil))

             ;(global-set-key (kbd "C-x SPC") 'hydra-rectangle/body)


             )


