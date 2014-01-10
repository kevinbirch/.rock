
;; Set up function key shortcuts
(global-set-key [f3] 'highlight-symbol-at-point)
(global-set-key [(control f3)] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [(meta f3)] 'highlight-symbol-query-replace)
(global-set-key [f4] 'kill-this-buffer)

(global-set-key [f5] 'search-forward)
(global-set-key [(meta f5)] 'search-backward)
(global-set-key [(shift f5)] 'query-replace)
(global-set-key [f6] 'next-error)
(global-set-key [(meta f6)] 'previous-error)
(global-set-key [(shift f6)] 'first-error)
(global-set-key [f7] 'compile-dwim)
(global-set-key [f8] 'gdb)

(global-set-key [(meta control i)] 'c-indent-line-or-region)
(global-set-key [(shift control j)] 'join-line)
(global-set-key [(control a)] 'beginning-of-indentation-or-line)
(global-set-key [(meta g)] 'goto-line)
(global-set-key [(control q)] 'current-word-manual)
(global-set-key [(control meta k)] 'kill-whole-line)
(global-unset-key [(control x) ?d])
(global-set-key [(control x) ?d] 'duplicate-line-or-region-below)
(global-set-key [(control x) ?D] 'duplicate-line-below-comment)
(global-set-key [(control shift down)] 'move-text-down)
(global-set-key [(control shift up)] 'move-text-up)
(global-set-key [(control meta w)] 'er/expand-region)
(global-set-key [(control meta W)] 'er/contract-region)

(global-set-key (kbd "C-x C-g") 'find-file-in-repository)
(global-set-key (kbd "C-x C-r") 'rename-current-buffer-file)
(global-set-key (kbd "C-c l") 'ido-goto)
