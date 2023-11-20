(require 'quail)

(quail-define-package
  "jdp-lav" "UTF-8" "lav<" t
  "Latvian input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("A`" "Ā")
("a`" "ā")
("C`" "Č")
("c`" "č")
("E`" "Ē")
("e`" "ē")
("G`" "Ģ")
("g`" "ģ")
("I`" "Ī")
("i`" "ī")
("K`" "Ķ")
("k`" "ķ")
("L`" "Ļ")
("l`" "ļ")
("N`" "Ņ")
("n`" "ņ")
("S`" "Š")
("s`" "š")
("U`" "Ū")
("u`" "ū")
("Z`" "Ž")
("z`" "ž")
("O`" "Ō")
("o`" "ō")
("R`" "Ŗ")
("r`" "ŗ")
)

(provide 'jdp-lav)
