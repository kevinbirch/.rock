(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ag-highlight-search t)
 '(auctex-package t)
 '(c-echo-syntactic-information-p t)
 '(c-electric-pound-behavior (quote (alignleft)))
 '(c-indent-comments-syntactically-p t)
 '(c-support-package t)
 '(calc-package t)
 '(calendar-package t)
 '(cc-mode-package t)
 '(column-number-mode t)
 '(cookie-package t)
 '(crisp-package t)
 '(debug-package t)
 '(delete-key-deletes-forward t)
 '(diff-hl-draw-borders t)
 '(dired-package t)
 '(display-battery-mode nil)
 '(display-time-24hr-format t)
 '(display-time-mode t)
 '(ediff-package t)
 '(edit-utils-package t)
 '(emerge-package t)
 '(eterm-package t)
 '(eudc-package t)
 '(font-lock-mode t t (font-lock))
 '(font-lock-use-colors t)
 '(font-lock-use-fonts nil)
 '(frame-icon-package nil)
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(fsf-compat-package t)
 '(global-hl-line-mode t)
 '(global-linum-mode t)
 '(igrep-package t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(ispell-package t)
 '(ispell-program-name "aspell")
 '(ispell-extra-args '("--reverse"))
 '(net-utils-package t)
 '(ns-alternate-modifier (quote meta))
 '(os-utils-package t)
 '(package-get-require-signed-base-updates nil)
 '(paren-mode (quote blink-paren) nil (paren))
 '(prog-modes-package t)
 '(py-align-multiline-strings-p t)
 '(py-imenu-show-method-args-p t)
 '(query-user-mail-address nil)
 '(reftex-package t)
 '(save-place t nil (saveplace))
 '(save-place-file (expand-file-name ".places" user-emacs-directory))
 '(scroll-bar-mode nil)
 '(sh-script-package t)
 '(show-paren-mode t)
 '(show-paren-ring-bell-on-mismatch t)
 '(size-indication-mode t)
 '(slider-package t)
 '(strokes-package t)
 '(tab-width 4)
 '(text-modes-package t)
 '(time-package t)
 '(tm-package t)
 '(tool-bar-mode nil nil (tool-bar))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(user-full-name "kevin birch")
 '(user-mail-address "kmb@pobox.com")
 '(vc-cc-package t)
 '(vc-package t)
 '(view-process-package t)
 '(viper-package t)
 '(visible-bell t)
 '(visual-line-mode nil t)
)

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

(if (display-graphic-p)
    (load "gui-mode-config"))

; TODO - replace this with flycheck
;; flymake configuration
(require 'flymake)
(setq flymake-run-in-place nil)
(setq flymake-number-of-errors-to-display nil)
(setq flymake-check-should-restart t)

(defun flymake-create-temp-in-system-tempdir (filename prefix)
  (make-temp-file (or prefix "flymake")))

(require 'flymake-cursor)

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

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :family "DejaVu Sans Mono"))))
 '(diff-hl-change ((t (:background "blue4" :foreground "blue4"))))
 '(diff-hl-delete ((t (:inherit diff-removed :foreground "red4" :background "red4"))))
 '(diff-hl-insert ((t (:inherit diff-added :foreground "green4" :background "green4"))))
 '(flymake-errline ((t (:inverse-video nil :foreground nil :underline (:color "red" :style wave)))))
 '(flymake-infoline ((t (:inverse-video nil :foreground nil :underline "blue"))))
 '(flymake-warnline ((t (:inverse-video nil :foreground nil :underline "yellow"))))
 '(which-func ((t nil))))
