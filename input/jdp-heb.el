(require 'quail)

(quail-define-package
"jdp-heb" "UTF-8" "Heb<" t
"Latin transcription for Hebrew.
" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules

;; Escapes
("\\\\" "\\")
("\\$" "$")
("\\*" "*")
("\\:" ":")
("\\<" "<")
("\\>" ">")
("\\=" "=")
("\\'" "'")
("\\\"" "\"")

;; Consonants - simple
(">" "\u05D0") ; alef
("b" "\u05D1") ; beyt
("g" "\u05D2") ; gimel
("d" "\u05D3") ; dalet
("h" "\u05D4") ; he
("v" "\u05D5") ; vav
("z" "\u05D6") ; zayin
("H" "\u05D7") ; het
("T" "\u05D8") ; tet
("y" "\u05D9") ; yud
("K" "\u05DA") ; kaf sofit
("k" "\u05DB") ; kaf
("l" "\u05DC") ; lamed
("M" "\u05DD") ; mem sofit
("m" "\u05DE") ; mem
("N" "\u05DF") ; nun sofit
("n" "\u05E0") ; nun
("S" "\u05E1") ; samekh
("<" "\u05E2") ; ain
("P" "\u05E3") ; pe sofit
("p" "\u05E4") ; pe
("C" "\u05E5") ; tsade sofit
("c" "\u05E6") ; tsade
("q" "\u05E7") ; qof
("r" "\u05E8") ; resh
("w" "\u05E9") ; shin
("t" "\u05EA") ; tav

;; Variants of shin
("W" ["\u05E9\u05C1"]) ; shin with dot
("s" ["\u05E9\u05C2"]) ; sin with dot

;; Alternative input
("F" "\u05E3") ; pe sofit
("f" "\u05E4") ; pe
("x" "\u05D7") ; het
("X" "\u05DA") ; kaf sofit

;; Vowels
("="   "\u05B0")        ; shva
("a"  "\u05B7")       ; patah
("A" "\u05B8")       ; qamats
("a=" "\u05B2")       ; hataf patah
("e"  "\u05B6")       ; segol
("E" "\u05B5")       ; tsere
("e=" "\u05B1")       ; hataf segol
("i"  "\u05B4")       ; hirik
("I" ["\u05B4\u05D9"]) ; hirik yud
("o"  "\u05B9")       ; holam
("O" ["\u05D5\u05B9"]) ; holam vav
("o=" "\u05B3")       ; hataf kamats
("u"  "\u05BB")       ; qubuts
("U" ["\u05D5\u05BC"]) ; vav dagesh

;; Other signs
("*" "\u05BC") ; dagesh, mappiq
("-" "\u05BE") ; maqaf
("\'" "\u059C") ; geresh
("\"" "\u059E") ; gershayim
("\:" "\u05C3") ; sof pasuq
)

(provide 'jdp-heb)