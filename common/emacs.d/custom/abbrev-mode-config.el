;; Abbrev-mode customizations
(setq-default abbrev-mode t)
(setq save-abbrevs t)
(setq abbrev-file-name (expand-file-name "custom/abbreviations.el" user-emacs-directory))
(if (file-readable-p abbrev-file-name)
  (read-abbrev-file abbrev-file-name)
  )
