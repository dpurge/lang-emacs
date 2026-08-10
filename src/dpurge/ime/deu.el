(require 'quail)

(quail-define-package
  "dpurge-deu" "UTF-8" "deu<" t
  "German input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("A`" "Ä")
("O`" "Ö")
("U`" "Ü")
("S`" "ẞ")
("a`" "ä")
("o`" "ö")
("u`" "ü")
("s`" "ß")
)

(provide 'dpurge-deu)
