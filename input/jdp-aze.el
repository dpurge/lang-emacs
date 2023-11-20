(require 'quail)

(quail-define-package
  "jdp-aze" "UTF-8" "aze<" t
  "Azerbaijani input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("C`" "Ç")
("c`" "ç")
("A`" "Ə")
("a`" "ə")
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
)

(provide 'jdp-aze)
