;; Markdown mode customization
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.mkdn\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))

(add-hook 'markdown-mode-hook
          (lambda()
            (setq markdown-command "markdown | smartypants")
            (setq markdown-enable-math t)
            (setq markdown-enable-itex t)
            )
          )

(require 'markdown-mode)
