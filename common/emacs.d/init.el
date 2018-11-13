
(load (expand-file-name "customizations.el" user-emacs-directory))

;; configure PATH
(if (not (member "/usr/local/bin" exec-path))
    (setenv "PATH" (concat (expand-file-name "~/bin") ":/usr/local/bin:/usr/local/sbin:" (getenv "PATH"))))

(add-to-list 'exec-path "/usr/local/sbin")
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path (expand-file-name "~/bin"))

(setq user-site-dir "~/.lisp/emacs")

;; intialize and load elpa
(require 'package)
(setq package-user-dir (expand-file-name "elpa" user-site-dir))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; add additional load paths
(add-to-list 'load-path (expand-file-name "site-lisp" user-site-dir))
(add-to-list 'load-path (expand-file-name "custom" user-emacs-directory))

(require 'use-package)

(if (display-graphic-p)
    (load "gui-mode-config"))

;; flymake configuration
(require 'flymake)
(setq flymake-run-in-place nil)
(setq flymake-number-of-errors-to-display nil)
(setq flymake-check-should-restart t)

(defun flymake-create-temp-in-system-tempdir (filename prefix)
  (make-temp-file (or prefix "flymake")))

(use-package flymake-diagnostic-at-point
  :after flymake
  :config
  (add-hook 'flymake-mode-hook #'flymake-diagnostic-at-point-mode))

(load "visual-config")
(load "editor-config")
(load "editor-functions")
(load "key-bindings")

(load "ido-config")
(load "cc-mode-config")
(load "python-mode-config")
(load "markdown-mode-config")
(load "yaml-mode-config")
(load "abbrev-mode-config")
