(require 'quail)

(quail-define-package
  "jdp-ron" "UTF-8" "ron<" t
  "Romanian input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("A``" "Ă")
("a``" "ă")
("A`" "Â")
("a`" "â")
("I`" "Î")
("i`" "î")
("S`" "Ș")
("s`" "ș")
("T`" "Ț")
("t`" "ț")
)

(provide 'jdp-ron)
