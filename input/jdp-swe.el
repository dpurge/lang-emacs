(require 'quail)

(quail-define-package
  "jdp-swe" "UTF-8" "swe<" t
  "Swedish input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("Aa" "Å")
("aa" "å")
("Ae" "Ä")
("ae" "ä")
("Oe" "Ö")
("oe" "ö")
)

(provide 'jdp-swe)
