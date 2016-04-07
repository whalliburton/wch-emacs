;; erc

(require 'erc-track)
(erc-track-mode t)

(setq erc-autojoin-channels-alist ;'(("freenode.net" "#lisp"))
      '(("irc.oftc.net" "#publiclab"))
      erc-track-exclude-server-buffer t
      erc-track-exclude-types '("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE")
      erc-hide-list '("MODE")
      erc-track-showcount t
      erc-track-visibility 'visible
      erc-truncate-mode t
      erc-mode-line-format "%t %a")
