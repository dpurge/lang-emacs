(require 'quail)

(quail-define-package
  "jdp-tur" "UTF-8" "tur<" t
  "Turkish input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("C`" "Ç")
("c`" "ç")
("G`" "Ğ")
("g`" "ğ")
("I`" "I")
("i`" "ı")
("I" "İ")
("i" "i")
("O`" "Ö")
("o`" "ö")
("S`" "Ş")
("s`" "ş")
("U`" "Ü")
("u`" "ü")
("Aa" "Â")
("aa" "â")
("Ii" "Î")
("ii" "î")
("Uu" "Û")
("uu" "û")
)

(provide 'jdp-tur)
