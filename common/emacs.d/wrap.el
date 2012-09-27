
(defun wrap-region (left right beg end)
  "Wrap the region in the text from 'beg' to 'end' with 'left' and 'right'."
  (interactive)
  (save-excursion
    (goto-char end)
    (insert right)
    (goto-char beg)
    (insert left))
  )

(defmacro wrap-region-function (left right)
  "Returns a function to wrap the active region with 'left' and 'right'."
  `(lambda () (interactive)
     (wrap-region-or-insert ,left ,right))
  )

(defun wrap-region-or-insert (left right)
  "Wrap the active region with 'left' and 'right'."
  (interactive)
  (if (and mark-active transient-mark-mode)
      (wrap-region left right (region-beginning) (region-end))
    (insert left))
  )

(defun k-electric-quote ()
  (interactive)
  (if (and mark-active transient-mark-mode)
      (save-excursion
	(goto-char end)
	(self-insert-command)
	(goto-char beg)
	(self-insert-command))
    (self-insert-command))
  )

