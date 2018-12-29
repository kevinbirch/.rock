;; global custom functions
(defun push-defun-close-down (syntax pos)
  "custom function for hanging braces alist to push the close brace down to the next line."
  (unless (bolp) (progn (open-line 1))))

;; This is the preferred style for my C, C++, Java and Objective C code:
(defconst my-c-style
  '((c-tab-always-indent        . t)
    (c-comment-only-line-offset . 0)
    (c-hanging-braces-alist     . ((class-open . (before after))
                                   (class-close . (before after))
                                   (defun-open . (after before))
                                   (defun-close . push-defun-close-down)
                                   (inline-open . (before after))
                                   (inline-close after)
                                   (brace-list-open . (before after))
                                   (brace-list-close after)
                                   (brace-list-intro after)
                                   (block-open . c-snug-do-while)
                                   (block-close . push-defun-close-down)
                                   (statement-case-open . (before after))
                                   (substatement-open after)))
    (c-hanging-colons-alist     . ((member-init-intro before)
                                   (inher-intro)
                                   (case-label after)
                                   (label after)
                                   (access-label after)))
    (c-cleanup-list             . (scope-operator
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
            (flymake-mode)
            )
          )

(defvar compile-dwim-command ""
  "The most recent compile command.")

(defun compile-dwim-prompt (project-dir)
  "Prompt for the compile command"
  (let* ((default "make ")
         (cmd (cond ((not (equal compile-dwim-command "")) compile-dwim-command)
                    (project-dir (concat default "-C " project-dir " "))
                    (t default))))
    (read-from-minibuffer "Compile command: " cmd nil nil 'compile-history)
    )
  )

(defun compile-dwim (&optional arg)
  "Interactive command to run compile smartly.  Prompts for the command to run if the universal argument is given or if run for the first time.  Otherwise it runs recompile.  Automatically searches for the make files in the parent directories of the source file, and runs make there by default."
  (interactive "P")
  (let* ((project-dir (locate-dominating-file buffer-file-name "Makefile"))
         (orig-default-dir default-directory))
    (if (or arg (equal compile-dwim-command ""))
        (setq compile-dwim-command (compile-dwim-prompt project-dir)))
    (if project-dir (setq default-directory project-dir))
    (compile compile-dwim-command)
    (if project-dir (setq default-directory orig-default-dir))
    )
  )
