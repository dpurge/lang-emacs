(require 'quail)

(quail-define-package
  "jdp-zho-pinyin" "UTF-8" "ZhPy<" t
  "Pinyin transcription for Chinese."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("A1" "Ā")
("a1" "ā")
("A2" "Á")
("a2" "á")
("A3" "Ǎ")
("a3" "ǎ")
("A4" "À")
("a4" "à")
("E1" "Ē")
("e1" "ē")
("E2" "É")
("e2" "é")
("E3" "Ě")
("e3" "ě")
("E4" "È")
("e4" "è")
("I1" "Ī")
("i1" "ī")
("I2" "Í")
("i2" "í")
("I3" "Ǐ")
("i3" "ǐ")
("I4" "Ì")
("i4" "ì")
("O1" "Ō")
("o1" "ō")
("O2" "Ó")
("o2" "ó")
("O3" "Ǒ")
("o3" "ǒ")
("O4" "Ò")
("o4" "ò")
("U1" "Ū")
("u1" "ū")
("U2" "Ú")
("u2" "ú")
("U3" "Ǔ")
("u3" "ǔ")
("U4" "Ù")
("u4" "ù")
("V" "Ü")
("v" "ü")
("V2" "Ǘ")
("v2" "ǘ")
("V3" "Ǚ")
("v3" "ǚ")
("V4" "Ǜ")
("v4" "ǜ")
("<<" "«")
(">>" "»")
;("" "⸢")
;("" "⸣")
;("" "⸤")
;("" "⸥")
)

(provide 'jdp-zho-pinyin)