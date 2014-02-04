
;; Auto refresh buffers
(global-auto-revert-mode)

;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;; Turn on auto-compression so we can read and write .gz files
(auto-compression-mode t)

;; autocomplete
(require 'auto-complete)
(setq ac-comphist-file (expand-file-name "auto-complete/ac-comphist.dat" user-emacs-directory))
(add-to-list 'ac-dictionary-directories (expand-file-name "auto-complete" user-emacs-directory))
(require 'auto-complete-config)
(ac-config-default)

(require 'expand-region)
(require 'eldoc)
(require 'autopair)
(autopair-global-mode)
(setq autopair-autowrap t)

(require 'dired-x)

;; globally show which function contains the point
(which-function-mode)

(projectile-global-mode)
(setq projectile-known-projects-file (expand-file-name "projectile/bookmarks.eld" user-emacs-directory))
(setq projectile-cache-file (expand-file-name "projectile/cache" user-emacs-directory))

;; Add back in the ability to change case on regions
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; mode configurations for files where we don't have any other mode specific configuration
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))
