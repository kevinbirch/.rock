;; This file contains my functions to support my jde mode customizations

(defun def-string-const ()
  (interactive)
  (insert "public static final String ")
  (insert (read-string "Constant name: ") " = \"" (read-string "value: ") "\";")
  )

(defun def-int-const ()
  (interactive)
  (insert "public static final int ")
  (insert (read-string "Constant name: ") " = " (read-string "value: ") ";")
  )

  