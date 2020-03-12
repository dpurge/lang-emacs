(require 'quail)

(quail-define-package
  "jdp-srp" "UTF-8" "srp<" t
  "Serbian input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("D`" "Đ")
("d`" "đ")
("Z`" "Ž")
("z`" "ž")
("C``" "Ć")
("c``" "ć")
("C`" "Č")
("c`" "č")
("S`" "Š")
("s`" "š")
)

(provide 'jdp-srp)
