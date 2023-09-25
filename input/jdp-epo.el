(require 'quail)

(quail-define-package
  "jdp-epo" "UTF-8" "epo<" t
  "Esperanto input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("Cx" "Ĉ")
("cx" "ĉ")
("Gx" "Ĝ")
("gx" "ĝ")
("Hx" "Ĥ")
("hx" "ĥ")
("Jx" "Ĵ")
("jx" "ĵ")
("Sx" "Ŝ")
("sx" "ŝ")
("Ux" "Ŭ")
("ux" "ŭ")
("--" "–")
("---" "—")
("<<" "«")
(">>" "»")
)

(provide 'jdp-epo)
