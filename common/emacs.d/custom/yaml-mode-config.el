(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

(add-hook 'python-mode-hook
          (lambda ()
            (highlight-indentation-current-column-mode)
            )
          )
