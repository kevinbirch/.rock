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
            )
          )

(require 'pymacs)
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-shortcuts nil)
(setq ropemacs-local-prefix "C-c C-p")

(defun flymake-pycheck ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy 'flymake-create-temp-in-system-tempdir)))
      (list (expand-file-name "~/bin/pycheck") (list temp-file))))

(add-to-list 'flymake-allowed-file-name-masks '("\\.py\\'" flymake-pycheck))

(add-to-list 'ac-sources 'ac-source-ropemacs)
