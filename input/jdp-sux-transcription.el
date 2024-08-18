(require 'quail)

(quail-define-package
  "jdp-sux-transcription" "UTF-8" "sux-t<" t
  "Sumerian input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
("c" "š")
("sz" "š")
("s," "ṣ")
("t," "ṭ")
("t_" "ṯ")
("j" "ŋ")
("g~" "g̃")
("h" "ḫ")
("h," "ḥ")
("a^" "â")
("i^" "î")
("u^" "û")
("o^" "ô")
("e^" "ê")
("a~" "ā")
("i~" "ī")
("u~" "ū")
("o~" "ō")
("'" "ʿ")
("`" "ʾ")
)

(provide 'jdp-sux-transcription)