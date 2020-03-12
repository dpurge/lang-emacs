(require 'quail)

(quail-define-package
  "jdp-lit" "UTF-8" "lit<" t
  "Lithuanian input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("aa" "ą")
("cx" "č")
("ee" "ę")
("ex" "ė")
("ii" "į")
("sx" "š")
("uu" "ų")
("ux" "ū")
("zx" "ž")

("Aa" "Ą")
("Cx" "Č")
("Ee" "Ę")
("Ex" "Ė")
("Ii" "Į")
("Sx" "Š")
("Uu" "Ų")
("Ux" "Ū")
("Zx" "Ž")
)

(provide 'jdp-lit)
