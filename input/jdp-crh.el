(require 'quail)

(quail-define-package
  "jdp-crh" "UTF-8" "crh<" t
  "Crimean Tatar input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("C`" "Ç")
("c`" "ç")
("G`" "Ğ")
("g`" "ğ")
("N`" "Ñ")
("n`" "ñ")
("O`" "Ö")
("o`" "ö")
("S`" "Ş")
("s`" "ş")
("U`" "Ü")
("u`" "ü")
("I" "İ")
("i" "i")
("I`" "I")
("i`" "ı")
("A`" "Â")
("a`" "â")

("<<" "«")
(">>" "»")
(",," "„")
("''" "“")
("--" "—")
("..." "…")
)

(provide 'jdp-crh)