(require 'quail)

(quail-define-package
  "jdp-deu" "UTF-8" "deu<" t
  "German input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("Ae" "Ä")
("Oe" "Ö")
("Ue" "Ü")
("Sz" "ẞ")
("ae" "ä")
("oe" "ö")
("ue" "ü")
("sz" "ß")
)

(provide 'jdp-deu)
