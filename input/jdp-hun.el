(require 'quail)

(quail-define-package
  "jdp-hun" "UTF-8" "hun<" t
  "Hungarian input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("A`" "Á")
("a`" "á")
("E`" "É")
("e`" "é")
("I`" "Í")
("i`" "í")
("O`" "Ó")
("o`" "ó")
("O``" "Ö")
("o``" "ö")
("O```" "Ő")
("o```" "ő")
("U`" "Ú")
("u`" "ú")
("U``" "Ü")
("u``" "ü")
("U```" "Ű")
("u```" "ű")
)

(provide 'jdp-hun)
