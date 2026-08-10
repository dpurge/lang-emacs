(require 'quail)

(quail-define-package
 "dpurge-cop" "UTF-8" "Cop<" t
 "Latin transcription for Coptic."
 nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("A" "Ⲁ") ("B" "Ⲃ") ("G" "Ⲅ") ("D" "Ⲇ") ("E" "Ⲉ")
 ("S" "Ⲋ") ("Z" "Ⲍ") ("H" "Ⲏ") ("Th" "Ⲑ") ("I" "Ⲓ")
 ("K" "Ⲕ") ("L" "Ⲗ") ("M" "Ⲙ") ("N" "Ⲛ") ("X" "Ⲝ")
 ("O" "Ⲟ") ("P" "Ⲡ") ("R" "Ⲣ") ("C" "Ⲥ") ("T" "Ⲧ")
 ("U" "Ⲩ") ("Ph" "Ⲫ") ("Kh" "Ⲭ") ("Ps" "Ⲯ") ("W" "Ⲱ")
 ("Sh" "Ϣ") ("F" "Ϥ") ("Hh" "Ϧ") ("J" "Ϫ") ("Ch" "Ϭ")
 ("Ti" "Ϯ")

 ("a" "ⲁ") ("b" "ⲃ") ("g" "ⲅ") ("d" "ⲇ") ("e" "ⲉ")
 ("s" "ⲋ") ("z" "ⲍ") ("h" "ⲏ") ("th" "ⲑ") ("i" "ⲓ")
 ("k" "ⲕ") ("l" "ⲗ") ("m" "ⲙ") ("n" "ⲛ") ("x" "ⲝ")
 ("o" "ⲟ") ("p" "ⲡ") ("r" "ⲣ") ("c" "ⲥ") ("t" "ⲧ")
 ("u" "ⲩ") ("ph" "ⲫ") ("kh" "ⲭ") ("ps" "ⲯ") ("w" "ⲱ")
 ("sh" "ϣ") ("f" "ϥ") ("hh" "ϧ") ("j" "ϫ") ("ch" "ϭ")
 ("ti" "ϯ"))

(provide 'dpurge-cop)
