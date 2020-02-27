(require 'quail)

(quail-define-package
  "jdp-hin" "UTF-8" "hin<" t
  "Hindi input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules

; D I G I T S

("0" "०")
("1" "१")
("2" "२")
("3" "३")
("4" "४")
("5" "५")
("6" "६")
("7" "७")
("8" "८")
("9" "९")

; C O N S O N A N T S

("k" "क") ; ka
("K" "ख") ; kha
("g" "ग") ; ga
("G" "घ") ; gha
("f" "ङ") ; ṅa
("c" "च") ; ca
("C" "छ") ; cha
("j" "ज") ; ja
("J" "झ") ; jha
("F" "ञ") ; ña
("t" "ट") ; ṭa
("T" "ठ") ; ṭha
("d" "ड") ; ḍa
("D" "ढ") ; ḍha
("N" "ण") ; ṇa
("w" "त") ; ta
("W" "थ") ; tha
("x" "द") ; da
("X" "ध") ; dha
("n" "न") ; na
("p" "प") ; pa
("P" "फ") ; pha
("b" "ब") ; ba
("B" "भ") ; bha
("m" "म") ; ma
("y" "य") ; ya
("r" "र") ; ra
("l" "ल") ; la
("v" "व") ; va
("S" "श") ; śa
("R" "ष") ; ṣa
("s" "स") ; sa
("h" "ह") ; ha

; C O N S O N A N T S  W I T H  N U K T A

;("kZ" "\u0958") ; क़ qa
;("KZ" "\u0959") ; ख़ k͟ha
;("gZ" "\u095a") ; ग़ ġa
;("jZ" "\u095b") ; ज़ za
;("dZ" "\u095c") ; ड़ ṛa
;("DZ" "\u095d") ; ढ़ ṛha
;("PZ" "\u095e") ; फ़ fa

; V O W E L S  --  I N I T I A L

("a" "अ") ; a
("`a" "अ") ; a
("`A" ["आ"]) ; ā
("`i" ["इ"]) ; i
("`I" ["ई"]) ; ī
("`u" ["उ"]) ; u
("`U" ["ऊ"]) ; ū
("`e" ["ए"]) ; ē
("`E" ["ऐ"]) ; ai
("`o" ["ओ"]) ; ō
("`O" ["औ"]) ; au
("`q" ["ऋ"]) ; r̥
("`Q" ["ॠ"]) ; r̥̄
("`L" ["ऌ"]) ; l̥
("`LY" ["ॡ"]) ; l̥̄

; V O W E L S  --  B A S I C

("`" "\u094d") ; ् -- (virama)
("A" "\u093e") ; ा -ā
("i" "\u093f") ; ि -i
("I" "\u0940") ; ी -ī
("u" "\u0941") ; ु -u
("U" "\u0942") ; ू -ū
("e" "\u0947") ; े -ē
("E" "\u0948") ; ै -ai
("o" "\u094b") ; ो -ō
("O" "\u094c") ; ौ -au
("q" "\u0943") ; ृ -r̥
("Q" "\u0944") ; ॄ -r̥̄
("L" "\u0962") ; ॢ -l̥
("LY" "\u0963") ; ॣ -l̥̄

; O T H E R

; ("" "\u0900") ; ऀ (inverted candrabindu)
("z" "\u0901") ; ◌ँ (candrabindu)
("M" "\u0902") ; ◌ं ṁ (anusvāra)
("H" "\u0903") ; ः ḥ (visarga)
("Z" "\u093c") ; ़ (nukta)
; ("Z" "\u093d") ; ऽ (avagraha)

; P U N C T U A T I O N

("." "\u0964") ; । (daṇḍa)
(".." "\u0965") ; ॥ (double daṇḍa)
("..." "\u0970") ; ॰ (abbreviation sign)
;("" "ॱ") ; (high spacing dot)
;("?" "") ; ___
;("!" "") ; ___
;("," "") ; ___
;(";" "") ; ___
;(":" "") ; ___
;("-" "") ; ___
;("" "") ; ___
;("" "") ; ___
;("" "") ; ___

)

(provide 'jdp-hin)
