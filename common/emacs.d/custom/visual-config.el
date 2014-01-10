(global-diff-hl-mode)

;; Color mode customization
(load-theme 'solarized-dark t)
(set-default 'cursor-type 'box)

(require 'ethan-wspace)
(global-ethan-wspace-mode 1)

;; Linum mode customizations
(require 'linum+)
(global-linum-mode 1)
(setq linum-format "%d ")
