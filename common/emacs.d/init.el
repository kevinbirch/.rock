
;; add additional load paths
(add-to-list 'load-path (expand-file-name "~/.lisp/emacs/site-lisp"))
(add-to-list 'load-path (expand-file-name "~/.lisp/emacs/site-packages/slime/contrib"))
(add-to-list 'load-path (expand-file-name "~/.lisp/emacs/site-packages/slime"))
(add-to-list 'load-path (expand-file-name "~/.lisp/emacs/site-packages/emacs-color-theme-solarized"))
(add-to-list 'load-path (expand-file-name "~/.lisp/emacs/site-packages/dylan-mode"))

;; intialize and load elpa 
(load (expand-file-name "~/.lisp/emacs/elpa/package.el"))
(setq package-user-dir (expand-file-name "~/.lisp/emacs/elpa"))
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; This is the preferred style for my C, C++, Java and Objective C code:
(defconst my-c-style
  '((c-tab-always-indent        . t)
	(c-comment-only-line-offset . 0)
	(c-hanging-braces-alist     . ((class-open after)
				       (class-close after)
				       (defun-open after)
				       (defun-close after)
				       (inline-open after)
				       (inline-close after)
				       (brace-list-open after)
				       (brace-list-close after)
				       (brace-list-intro after)
				       (block-open . c-snug-do-while)
				       (block-close after)
				       (statement-case-open after)
				       (substatement-open after)))
	(c-hanging-colons-alist     . ((member-init-intro before)
				       (inher-intro)
				       (case-label after)
				       (label after)
				       (access-label after)))
	(c-cleanup-list             . (scope-operator
				       empty-defun-braces
				       defun-close-semi))
	(c-offsets-alist            . ((arglist-close . c-lineup-arglist)
				       (substatement-open . 0)
				       (case-label        . 4)
				       (block-open        . 0)
				       (defun-close       . 0)
				       (defun-open        . 0)
				       (block-open        . 0)))
	(c-echo-syntactic-information-p . t)
	)
  "PERSONAL")
     
;; C like language mode customizations
(add-hook `c-mode-common-hook 
          (lambda ()
            (turn-on-font-lock)
            (c-add-style "PERSONAL" my-c-style t)
            (c-toggle-auto-hungry-state 1)
            (setq c-basic-offset 4)
            (setq tab-width 4)
            (delete-selection-mode t)
            (setq c-recognize-knr-p nil)
            )
          )

;; Python mode customizations
(add-hook 'python-mode-hook
          (lambda () 
            (delete-selection-mode t)
            (turn-on-font-lock)
            (setq fume-display-in-modeline-p nil)
            (setq py-indent-offset 4)
            (setq indent-tabs-mode nil)
            (define-key py-mode-map '(return) 'newline-and-indent )
            (define-key py-mode-map "\C-c\C-c" 'comment-region )
            )
          )

;; Java mode customizations
(add-hook 'jde-mode-hook 
          (lambda ()
            (load-file (expand-file-name "~/.emacs.d/jde.el"))
            (global-set-key [f7] 'jde-ant-build)
            )
          )

;; LaTeX mode customizations
(add-hook 'LaTeX-mode-hook
          (lambda()
            (load-file (expand-file-name "~/.emacs.d/latex.el"))
             )
          )

;; Haskell mode customizations
(add-hook 'literate-haskell-mode-hook
          (lambda()
            (load-file (expand-file-name "~/.emacs.d/latex.el"))
             )
          )

;; SLIME mode setup
(setq slime-lisp-implementations
      '(
        (sbcl ("sbcl") :coding-system utf-8-unix)
        (ccl  ("ccl64"))
        ))

(setq inferior-lisp-program "sbcl")
(require 'slime)
(slime-setup '(slime-fancy))

(add-hook 'slime-mode-hook 
          (lambda ()
            (setf lisp-indent-function 'common-lisp-indent-function)
            (setf slime-multiprocessing t)
            (show-paren-mode t)
            (turn-on-font-lock)
            (setq tab-width 2)
            (delete-selection-mode t)
            )
          )

;; Common Lisp mode customizations
(setq common-lisp-hyperspec-root "file:///Users/kmb/Documents/eBooks/Common Lisp HyperSpec/")
(setq browse-url-browser-function
      (lambda (url &optional new-window) 
        (message url)
        (do-applescript (concat "tell application \"Safari\" to OpenURL \"" url "\""))))

(require 'slime-autoloads)
(slime-setup '(slime-scratch slime-editing-commands))

; par edit mode
(autoload 'paredit-mode "paredit" "Minor mode for pseudo-structurally editing Lisp code." t)

(require 'eldoc)

(defvar electrify-return-match "[\]}\)\"]"
  "If this regexp matches the text after the cursor, do an \"electric\" return.")

(defun electrify-return-if-match (arg)
  "If the text after the cursor matches `electrify-return-match' then open and indent an empty line between the cursor and the text.  Move the cursor to the new line."
  (interactive "P")
  (let ((case-fold-search nil))
    (if (looking-at electrify-return-match)
        (save-excursion (newline-and-indent)))
    (newline arg)
    (indent-according-to-mode)))

(defun paredit-mode-config-hook ()
  (paredit-mode t)
  (eldoc-add-command
    'paredit-backward-delete
    'paredit-close-round)
  (local-set-key (kbd "RET") 'electrify-return-if-match)
  (eldoc-add-command 'electrify-return-if-match)
  (show-paren-mode t))

(add-hook 'emacs-lisp-mode-hook       'paredit-mode-config-hook)
(add-hook 'lisp-mode-hook             'paredit-mode-config-hook)
(add-hook 'lisp-interaction-mode-hook 'paredit-mode-config-hook)
(add-hook 'scheme-mode-hook           'paredit-mode-config-hook)
(add-hook 'slime-repl-mode-hook       'paredit-mode-config-hook)

(defun override-slime-repl-bindings-with-paredit ()
  "Stop SLIME's REPL from grabbing DEL, which is annoying when backspacing over a '('"
  (define-key slime-repl-mode-map
      (read-kbd-macro paredit-backward-delete-key) nil))

(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

;; redshank configuration
(require 'redshank-loader (expand-file-name "~/.lisp/emacs/site-packages/redshank/redshank-loader"))

(eval-after-load "redshank-loader"
  `(redshank-setup '(lisp-mode-hook
                     slime-repl-mode-hook) t))

(eval-after-load "redshank"
  '(progn
    (setq redshank-accessor-name-function 'redshank-accessor-name/%)))

;; Dylan mode customization
(autoload 'dylan-mode "dylan-mode" "Major mode for editing Dylan source files" t)

(add-to-list 'auto-mode-alist '("\\.dylan\\'" . dylan-mode))

;; (setq inferior-dylan-program "/opt/OpenDylan-2011.1/bin/dswank")
;; (require 'dime)
;; (dime-setup '(dime-dylan dime-repl dime-compiler-notes-tree))

;; javascript mode
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js-mode))

(eval-after-load 'js
  '(progn (define-key js-mode-map "{" 'paredit-open-curly)
          (define-key js-mode-map "}" 'paredit-close-curly-and-newline)
          (add-hook 'js-mode-hook 'esk-paredit-nonlisp)
          (setq js-indent-level 2)
          ;; fixes problem with pretty function font-lock
          (define-key js-mode-map (kbd ",") 'self-insert-command)))

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

;; Color mode customization
(require 'color-theme)
(require 'color-theme-solarized)
(color-theme-solarized-dark)
(set-default 'cursor-type 'box)

;; Spelling checker customizations
(setq-default ispell-program-name "aspell")
(setq-default ispell-extra-args '("--reverse")) 

;; Linum mode customizations
(require 'linum+)
(global-linum-mode 1)
(setq linum-format "%d ")

;; Abbrev-mode customizations
(setq-default abbrev-mode t)
(setq save-abbrevs t)
(setq abbrev-file-name (expand-file-name "~/.emacs.d/abbreviations.el"))
(if (file-readable-p abbrev-file-name)
  (read-abbrev-file abbrev-file-name)
  )

(require 'ido)

;; Add back in the ability to change case on regions
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Set up function menu
;; (require 'func-menu)
(define-key global-map (kbd "\C-c l") 'fume-list-functions)
(define-key global-map (kbd "\C-c g") 'fume-prompt-function-goto)

;; Set up function key shortcuts
(global-set-key [f2] 'make-frame)
(global-set-key [f3] 'delete-frame)
(global-set-key [f4] 'kill-this-buffer)

(global-set-key [f5] 'search-forward)
(global-set-key [(meta f5)] 'search-backward)
(global-set-key [(shift f5)] 'query-replace)
(global-set-key [f6] 'next-error)
(global-set-key [(meta f6)] 'previous-error)
(global-set-key [(shift f6)] 'first-error)
(global-set-key [f7] 'compile)
(global-set-key [f8] 'gdb)
(global-set-key [f9] 'cvs-examine-other-window)

(global-set-key [(meta control i)] 'c-indent-line-or-region)

;; Configure Fume
(setq fume-max-items 30
    fume-fn-window-position 3
    fume-auto-position-popup t
    fume-display-in-modeline-p nil
    fume-buffer-name "*Function List*"
    fume-no-prompt-on-valid-default nil)

;; Grab all the files I was working on in the last session
;; (load "desktop")
;; (setq desktop-basefilename "desktop.lisp")
;; (setq desktop-dirname "~/.emacs.d/")
;; (desktop-load-default)
;; (desktop-read)
;; (add-hook 'kill-emacs-hook
;;           '(lambda ()
;; 	    (desktop-truncate search-ring 3)
;; 	    (desktop-truncate regexp-search-ring 3)
;; 	    (desktop-save "~/.emacs.d/")
;;             )
;; 	  )

;; Set values for insert-header function to work
(setq user-full-name "kevin birch")
(setq user-mail-address "kmb@pobox.com")
(setq user-organization "WebGuys Strategic Alliance")

(setq user-copyright
      (concat
"
  The MIT License

  Copyright (c) " (format-time-string "%Y") " " user-full-name " <" user-mail-address ">. Some rights reserved.

  Permission is hereby granted, free of charge, to any person obtaining a copy of
  this software and associated documentation files (the \"Software\"), to deal in
  the Software without restriction, including without limitation the rights to
  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
  of the Software, and to permit persons to whom the Software is furnished to do
  so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.

  Created: " (format-time-string "%D %H:%M:%")
))

;; This function inserts a copyright header and other information
;; into a source file.  The copyright is automatically grabbed
;; from the return value of the user-short-copyright method.
(defun insert-header ()
  "Insert a generic copyright notice and description for source code files."
  (interactive)
  (insert (user-short-copyright))
  ;; xxx - this needs to be rewritten to understand mode-specific comment characters
  )

(custom-set-variables
 '(auctex-package t)
 '(bbdb-package t)
 '(c-echo-syntactic-information-p t)
 '(c-electric-pound-behavior (quote (alignleft)))
 '(c-indent-comments-syntactically-p t)
 '(c-support-package t)
 '(calc-package t)
 '(calendar-package t)
 '(cc-mode-package t)
 '(column-number-mode t)
 '(cookie-package t)
 '(cperl-auto-newline t)
 '(cperl-auto-newline-after-colon t)
 '(cperl-electric-keywords t)
 '(cperl-electric-lbrace-space t)
 '(cperl-electric-linefeed t)
 '(cperl-electric-parens t)
 '(cperl-hairy t)
 '(cperl-help t)
 '(cperl-indent-level 4)
 '(cperl-info-on-command-no-prompt t)
 '(crisp-package t)
 '(debug-package t)
 '(delete-key-deletes-forward t)
 '(dired-package t)
 '(display-battery-mode t)
 '(display-time-mode t)
 '(ediff-package t)
 '(edit-utils-package t)
 '(efs-high-security-hosts nil)
 '(efs-make-backup-files (quote (sysV-unix bsd-unix next-unix apollo-unix dumb-unix dumb-apollo-unix super-dumb-unix)))
 '(efs-package t)
 '(efs-use-passive-mode t)
 '(emerge-package t)
 '(eterm-package t)
 '(eudc-package t)
 '(font-lock-mode t t (font-lock))
 '(font-lock-use-colors t)
 '(font-lock-use-fonts nil)
 '(footnote-package t)
 '(frame-icon-package nil)
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(fsf-compat-package t)
 '(fume-max-items 50 t)
 '(fume-menubar-menu-location nil)
 '(gnus-package t)
 '(gnuserv-program (concat exec-directory "/gnuserv"))
 '(global-hl-line-mode t)
 '(global-linum-mode t)
 '(hm--html-menus-package t)
 '(igrep-package t)
 '(ilisp-package t)
 '(indent-tabs-mode nil)
 '(ispell-package t)
 '(jde-build-use-make t)
 '(mac-option-modifier (quote meta))
 '(mail-lib-package t)
 '(mailcrypt-package t)
 '(mew-package t)
 '(net-utils-package t)
 '(os-utils-package t)
 '(package-get-require-signed-base-updates nil)
 '(paren-mode (quote blink-paren) nil (paren))
 '(pc-select-meta-moves-sexps t)
 '(pc-select-selection-keys-only t)
 '(pc-selection-mode t nil (pc-select))
 '(pcl-cvs-package t)
 '(prog-modes-package t)
 '(psgml-package t)
 '(py-align-multiline-strings-p t)
 '(py-imenu-show-method-args-p t)
 '(query-user-mail-address nil)
 '(reftex-package t)
 '(remote-compile-prompt-for-host t)
 '(remote-compile-prompt-for-user t)
 '(scroll-bar-mode nil)
 '(sgml-package t)
 '(sh-script-package t)
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(slider-package t)
 '(sounds-au-package t)
 '(sounds-wav-package t)
 '(speedbar-package t)
 '(strokes-package t)
 '(supercite-package t)
 '(tabbar-mode nil nil (tabbar))
 '(tab-width 4)
 '(tcl-auto-newline nil)
 '(texinfo-package t)
 '(text-modes-package t)
 '(textools-package t)
 '(time-package t)
 '(tm-package t)
 '(tool-bar-mode nil nil (tool-bar))
 '(vc-cc-package t)
 '(vc-package t)
 '(view-process-package t)
 '(viper-package t)
 '(visual-line-mode nil t)
 '(vm-package t)
 '(w3-package t)
 '(inhibit-splash-screen t)
)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 116 :width normal :family "Bitstream Vera Sans Mono")))))
