(require 'quail)

(quail-define-package
  "jdp-dan" "UTF-8" "dan<" t
  "Danish input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("Aa" "Å")
("aa" "å")
("Ae" "Æ")
("ae" "æ")
("Oe" "Ø")
("oe" "ø")
)

(provide 'jdp-dan)
