;; python mode setup
(if (equal 'darwin system-type)
    (progn
      (add-to-list 'exec-path "/usr/local/share/python")
      (if (not (string-match "/usr/local/share/python*" (getenv "PATH")))
          (setenv "PATH" (concat "/usr/local/share/python:" (getenv "PATH")))
        )
      )
    )

(require 'python)

(add-hook 'python-mode-hook
          (lambda ()
            (delete-selection-mode t)
            (define-key python-mode-map [(return)] 'newline-and-indent)
            (flymake-mode)
            (fci-mode)
            (setq fci-rule-column 80)
            (setq fci-rule-color "#002b36")
            (highlight-indentation-current-column-mode)
            )
          )

;; from https://github.com/nayefc/dotfiles/blob/master/emacs/.emacs.d/languages.el
(defun python-add-breakpoint ()
  "Add python breakpoint."
  (interactive)
  (move-beginning-of-line nil)
  (indent-for-tab-command)
  (insert "import ipdb; ipdb.set_trace()")
  (newline-and-indent))
;; (define-key python-mode-map (kbd "C-c t") 'python-add-breakpoint)

;; (add-to-list 'ac-sources 'ac-source-ropemacs)
