(global-diff-hl-mode)

;; Color mode customization
(load-theme 'solarized-dark t)
(set-default 'cursor-type 'box)

;(require 'ethan-wspace)
;(global-ethan-wspace-mode 1)
;; ethan-wspace-mode doesn't work for makefiles, they require tabs
;(add-hook 'makefile-mode-hook (lambda () (ethan-wspace-mode 0)))

;; Linum mode customizations
(require 'linum+)
(global-linum-mode 1)
(setq linum-format "%d ")

;; Enable window numbering mode
(window-numbering-mode)
