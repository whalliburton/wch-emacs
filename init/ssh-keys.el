;; ssh-keys.el

;; While keeping long standing emacs sessions on remote machines
;; inside terminal multiplexers such as 'screen' and 'tmux', the
;; SSH_AUTH_SOCK environment variable of the emacs process becomes
;; stale after disconnection and reconnection. The interactive
;; function SET-SSH-AGENT-SOCKET below allows for a quick and dirty
;; way to automatically reset this variable to the latest incoming SSH
;; agent authorization socket.

(defun string-starts-with (string prefix)
  (let ((plen (length prefix)))
    (when (>= (length string) plen)
      (string-equal (substring string 0 plen) prefix))))

;; Note that no attempt is made to distinguish users. This work is
;; needed in order to use this code on a machine with multiple users
;; SSHing in.

(defun find-latest-ssh-socket ()
  "Return the latest incoming ssh agent socket."
  (first
   (directory-files
          (caar
           (sort (directory-files-and-attributes "/tmp" t "ssh-.*")
                 (lambda (a b)
                   (tod> (sixth a) (sixth b))))) t "agent.*")))

(defun tod> (a b)
  (or (> (first a) (first b)) (> (second a) (second b))))

(defun set-ssh-agent-socket (&optional path)
  "[Re]set the SSH_AUTH_SOCK environment variable. If PATH
is not specified, an attempt is made to discover the latest
connection into the machine."
  (interactive)
  (unless path
    (setf path (find-latest-ssh-socket)))
  (unless (file-attributes path)
    (error "Socket %S was not found." path))
  (setenv "SSH_AUTH_SOCK" path)
  (message "sSet SSH_AUTH_SOCK to %S" path))
