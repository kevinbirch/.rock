;; dylan mode setup
(autoload 'dylan-mode "dylan-mode" "Major mode for editing Dylan source files" t)

(add-to-list 'auto-mode-alist '("\\.dylan\\'" . dylan-mode))

;; (setq inferior-dylan-program "/opt/OpenDylan-2011.1/bin/dswank")
;; (require 'dime)
;; (dime-setup '(dime-dylan dime-repl dime-compiler-notes-tree))
