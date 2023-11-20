(require 'quail)

(quail-define-package
  "jdp-fin" "UTF-8" "fin<" t
  "Finnish input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("A`" "Ä")
("a`" "ä")
("O`" "Ö")
("o`" "ö")
("A``" "Å")
("a``" "å")
("S`" "Š")
("s`" "š")
("Z`" "Ž")
("z`" "ž")
)

(provide 'jdp-fin)
