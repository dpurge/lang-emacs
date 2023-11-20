(require 'quail)

(quail-define-package
  "jdp-fas" "UTF-8" "fas<" t
  "Persian input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("a" "ا")
("A" "آ")
("b" "ب")
("p" "پ")
("t" "ت")
("t`" "ث")
("j" "ج")
("c" "چ")
("H" "ح")
("x" "خ")
("d" "د")
("d`" "ذ")
("r" "ر")
("z" "ز")
("J" "ژ")
("s" "س")
("s`" "ش")
("S" "ص")
("D" "ض")
("T" "ط")
("T`" "ظ")
("G" "ع")
("G`" "غ")
("f" "ف")
("q" "ق")
("k" "ک")
("g" "گ")
("l" "ل")
("m" "م")
("n" "ن")
("w" "و")
("h" "ه")
("y" "ی")

("h`" "هٔ")
("Y" "ي")
("a`" "أ")
("w`" "ؤ")
("y`" "ئ")
("'" "ء")

("?" "؟")
(";" "؛")
("," "،")
("<<" "«")
(">>" "»")

("0" "۰")
("1" "۱")
("2" "۲")
("3" "۳")
("4" "۴")
("5" "۵")
("6" "۶")
("7" "۷")
("8" "۸")
("9" "۹")
;("" "٬")
;("" "٫")
("%" "٪")

("i" "َ") ; fatha
("ii" "ً"); fathtayn
("u" "ُ"); damma
("~" "ّ"); shadda
("o" "ْ");sukun
("e" "ِ");kasra

("_" "ـ"); tatwil
("\\" "‌"); zero width non joiner
)

(provide 'jdp-fas)
