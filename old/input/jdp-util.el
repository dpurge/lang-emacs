(defun wrap-region-anki-closure ()
  "Insert Anki clozure markup {{c1::text::translation}} around a region."
  (interactive)
  (save-excursion
    (goto-char (region-end))
    (insert "::}}")
    (goto-char (region-beginning))
    (insert "{{c1::"))
    (skip-chars-forward ":"))

(provide 'jdp-util)