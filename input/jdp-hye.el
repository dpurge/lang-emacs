(require 'quail)

(quail-define-package
  "jdp-hye" "UTF-8" "hye<" t
  "Armenian input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("A" "Ա")
("a" "ա")
("B" "Բ")
("b" "բ")
("G" "Գ")
("g" "գ")
("D" "Դ")
("d" "դ")
("E" "Ե")
("e" "ե")
("Z" "Զ")
("z" "զ")
("Ee" "Է")
("ee" "է")
("E`" "Ը")
("e`" "ը")
("Th" "Թ")
("th" "թ")
("Zh" "Ժ")
("zh" "ժ")
("I" "Ի")
("i" "ի")
("L" "Լ")
("l" "լ")
("X" "Խ")
("x" "խ")
("" "Ծ")
("" "ծ")
("K" "Կ")
("k" "կ")
("H" "Հ")
("h" "հ")
("J" "Ձ")
("j" "ձ")
("" "Ղ")
("" "ղ")
("" "Ճ")
("" "ճ")
("M" "Մ")
("m" "մ")
("Y" "Յ")
("y" "յ")
("N" "Ն")
("n" "ն")
("" "Շ")
("" "շ")
("O" "Ո")
("o" "ո")
("" "Չ")
("" "չ")
("P" "Պ")
("p" "պ")
("" "Ջ")
("" "ջ")
("" "Ռ")
("" "ռ")
("S" "Ս")
("s" "ս")
("V" "Վ")
("v" "վ")
("T" "Տ")
("t" "տ")
("R" "Ռ")
("r" "ր")
("" "Ց")
("" "ց")
("W" "Ւ")
("w" "ւ")
("" "Փ")
("" "փ")
("" "Ք")
("" "ք")
("" "Օ")
("" "օ")
("F" "Ֆ")
("f" "ֆ")
("ew" "և")

;("" "ՙ")
;("" "՚")
;("" "՛")
("!" "՜")
("?" "՞")
("," "՝")
("." "։")
;("" "՟")
)

(provide 'jdp-hye)
