;; display.el


;; We prefer to get right to work. You can view the spash page with
;; (display-spash-screen)

(setq inhibit-splash-screen t
      inhibit-startup-message t
      inhibit-startup-echo-area-message t)


;; Disable the visual bell.
;;
;; Non-nil means try to flash the frame to represent a bell.

(setq visible-bell t)


;; Disable the menu bar.
;;
;; Toggle display of a menu bar on each frame (Menu Bar mode).
;; With a prefix argument ARG, enable Menu Bar mode if ARG is
;; positive, and disable it otherwise.  If called from Lisp, enable
;; Menu Bar mode if ARG is omitted or nil.
;;
;; This command applies to all frames that exist and frames to be
;; created in the future.

(menu-bar-mode 0)


;; When under X11 disble the tool bar and the scroll bar.

(when (eq window-system 'x)
  (tool-bar-mode 0)
  (scroll-bar-mode))


;; Only prompt y/n for minibuffer questions.

(fset 'yes-or-no-p 'y-or-n-p)


;; Start with a blank *scratch* buffer.

(setq initial-scratch-message nil)
