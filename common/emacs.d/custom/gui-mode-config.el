;; Don't quit emacs without confirmation in gui mode
(setq confirm-kill-emacs 'yes-or-no-p)

;; Save our session when running in gui mode
(setq desktop-path (list (expand-file-name "desktop" user-emacs-directory)))
(setq desktop-base-file-name "emacs.desktop")
(desktop-save-mode 1)

(if (eq 'darwin system-type)
    (toggle-frame-fullscreen))
