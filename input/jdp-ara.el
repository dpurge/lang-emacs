(require 'quail)

(quail-define-package
"jdp-ara" "UTF-8" "ara<" t
"Arabic input method."
nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("'" "ء") ; lone hamza
("|" "آ") ; madda on alif
(">" "أ") ; hamza on alif
("&" "ؤ")
("<" "إ")
("}" "ئ")
("A" "ا")
("b" "ب")
("p" "ة") ; ta marbuta
("t" "ت")
("v" "ث")
("j" "ج")
("H" "ح")
("x" "خ")
("d" "د")
("*" "ذ")
("r" "ر")
("z" "ز")
("s" "س")
("$" "ش")
("S" "ص")
("D" "ض")
("T" "ط")
("Z" "ظ")
("E" "ع")
("g" "غ")
("_" "ـ")
("f" "ف")
("q" "ق")
("k" "ك")
("l" "ل")
("m" "م")
("n" "ن")
("h" "ه")
("w" "و")
("Y" "ى")
("y" "ي")
("F" "ً") ; fathatayn
("N" "ٌ") ; dammatayn
("K" "ٍ") ; kasratayn
("a" "َ") ; fatha
("u" "ُ") ; damma
("i" "ِ") ; kasra
("~" "ّ") ; shadda
("o" "ْ") ; sukun
("`" "ٰ")
("{" "ٱ")
("?" "؟")
("," "،")
)

(provide 'jdp-ara)