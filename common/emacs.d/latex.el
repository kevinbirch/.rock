;; This file cribbed from: http://www.math.umn.edu/~aoleg/emacs/latex.shtml

; First let us make the space key expand the abbreviations
(defun smart-space () ; make the space key behave in a smarter way
  (interactive)
  (if (not (expand-abbrev)) ; test if the current word is an abbrev. If yes, expand it.
      (insert " ")          ; If not, insert a plain space
    )                       ; Now you know how to use 'if' in emacs lisp
  )
(local-set-key [(space)] 'smart-space) ; bind the 'smart-space' function to the 'space' key

(defun latex-frac ()
  (interactive)
  (insert "\\frac{}{}")
  (backward-char 3)
  )

(defun latex-equation ()
  (interactive)
  (insert "\\begin{equation}\\label{}\n")
  (insert "  \n")
  (insert "\\end{equation}")
  (previous-line 3)
  (forward-char 24)
  )

(defun latex-list ()
  (interactive)
  (insert "\\begin{list}{}\n")
  (insert "\\item \n")
  (insert "\\end{list}\n")
  (previous-line 2)
  (forward-char 6)
  )

(defun latex-enumerate ()
  (interactive)
  (insert "\\begin{enumerate}\n")
  (insert "\\item \n")
  (insert "\\end{enumerate}\n")
  (previous-line 2)
  (forward-char 6)
  )

(defun latex-theorem ()
  (interactive)
  (insert "\\begin{theorem}\\label{}\n\n\\end{theorem}")
  (previous-line 2)
  (end-of-line)
  (backward-char 1)
  )

(defun latex-corollary ()
  (interactive)
  (insert "\\begin{corollary}\\label{}\n\n\\end{corollary}")
  (previous-line 2)
  (end-of-line)
  (backward-char 1)
  )

(defun latex-lemma ()
  (interactive)
  (insert "\\begin{lemma}\\label{}\n\n\\end{lemma}")
  (previous-line 2)
  (end-of-line)
  (backward-char 1)
  )

(defun latex-proof ()
  (interactive)
  (insert "\\begin{proof}\n\n\\end{proof}")
  (previous-line 1)
  )

(defun latex-center ()
  (interactive)
  (insert "\\begin{center}\n\n\\end{center}")
  (previous-line 1)
  )

(defun latex-ref ()
  (interactive)
  (insert "(\\ref{})")
  (backward-char 2)
  )

(defun latex-int-lim ()
  (interactive)
  (insert "\\int\\limits_{}^{}\\!\\,d")
  (backward-char 9)  
  )

(defun latex-int ()
  (interactive)
  (insert "\\int_{}^{}\\!\\,d")
  (backward-char 10)
  )

(defun latex-sum-lim ()
  (interactive )
  (insert "\\sum\\limits_{}^{}")
  (backward-char 4)
  )

(defun latex-sum ()
  (interactive )
  (insert "\\sum_{}^{}")
  (backward-char 4)
  )

(defun latex-code ()
  (interactive)
  (insert "\\begin{code}\n\n\\end{code}\n\n")
  (previous-line 3)
  )

; Lastly, let us define two more useful shortcuts (which were described in the LaTeX tip)
(local-set-key [(meta a)] 'define-mode-abbrev) ; define abbrevs on the fly with Alt-a
(local-set-key [(meta space)] 'dabbrev-expand) ; expand dinamic abbreviations with Alt-space