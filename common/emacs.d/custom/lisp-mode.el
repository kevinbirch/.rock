;; slime mode setup
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

;; common lisp mode setup
(setq common-lisp-hyperspec-root "file:///Users/kmb/Documents/eBooks/Common Lisp HyperSpec/")
(setq browse-url-browser-function
      (lambda (url &optional new-window)
        (message url)
        (do-applescript (concat "open location \"" url "\""))))

;; emacs lisp mode setup
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)

; par edit mode setup
(autoload 'paredit-mode "paredit" "Minor mode for pseudo-structurally editing Lisp code." t)

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

;; redshank mode setup
(require 'redshank-loader)

(eval-after-load "redshank-loader"
  `(redshank-setup '(lisp-mode-hook
                     slime-repl-mode-hook) t))

(eval-after-load "redshank"
  '(progn
    (setq redshank-accessor-name-function 'redshank-accessor-name/%)))
