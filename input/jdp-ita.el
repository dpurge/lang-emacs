(require 'quail)

(quail-define-package
  "jdp-ita" "UTF-8" "ita<" t
  "Italian input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("A``" "Á")
("a``" "á")
("E``" "É")
("e``" "é")
("I``" "Í")
("i``" "í")
("O``" "Ó")
("o``" "ó")
("U``" "Ú")
("u``" "ú")
("A`" "À")
("a`" "à")
("E`" "È")
("e`" "è")
("I`" "Ì")
("i`" "ì")
("O`" "Ò")
("o`" "ò")
("U`" "Ù")
("u`" "ù")
("I^" "Î")
("i^" "î")
)

(provide 'jdp-ita)
