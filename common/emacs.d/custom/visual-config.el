(global-diff-hl-mode)

;; Color mode customization
(load-theme 'solarized-dark t)
(set-default 'cursor-type 'box)

;; Linum mode customizations
(require 'linum+)
(global-linum-mode 1)
(setq linum-format "%d ")

;; Enable window numbering mode
(window-numbering-mode)
