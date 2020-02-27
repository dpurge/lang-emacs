(require 'quail)

(quail-define-package
  "jdp-hin" "UTF-8" "hin<" t
  "Hindi input method."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules

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

; ----------

("a" ["अ"]) ; a
("A" ["आ"]) ; ā
("i" ["इ"]) ; i
("I" ["ई"]) ; ī
("u" ["उ"]) ; u
("U" ["ऊ"]) ; ū
("e" ["ए"]) ; ē
("E" ["ऐ"]) ; ai
("o" ["ओ"]) ; ō
("O" ["औ"]) ; au
("q" ["ऋ"]) ; r̥
("Q" ["ॠ"]) ; r̥̄
("L" ["ऌ"]) ; l̥
("LY" ["ॡ"]) ; l̥̄

("aM" ["अं"]) ; ṁ
("aH" ["अः"]) ; ḥ
("az" ["अँ"]) ; anunansika
("Z" "ऽ") ; avagraha

; ----------

("k`" ["क्"]) ; k
("k " ["क "]) ; -k
("ka" ["क"]) ; ka
("kA" ["का"]) ; kā
("ki" ["कि"]) ; ki
("kI" ["की"]) ; kī
("ku" ["कु"]) ; ku
("kU" ["कू"]) ; kū
("ke" ["के"]) ; kē
("kE" ["कै"]) ; kai
("ko" ["को"]) ; kō
("kO" ["कौ"]) ; kau
("kq" ["कृ"]) ; kr̥
("kQ" ["कॄ"]) ; kr̥̄
("kL" ["कॢ"]) ; kl̥
("kLY" ["कॣ"]) ; kl̥̄
("kaM" ["कं"]) ; kṁ
("kaH" ["कः"]) ; kaḥ

("K`" ["ख्"]) ; kh
("K " ["ख "]) ; -kh
("Ka" ["ख"]) ; kha
;("KA" [""]) ; khā
;("Ki" [""]) ; khi
;("KI" [""]) ; khī
;("Ku" [""]) ; khu
;("KU" [""]) ; khū
;("Ke" [""]) ; khē
;("KE" [""]) ; khai
;("Ko" [""]) ; khō
;("KO" [""]) ; khau
;("Kq" [""]) ; khr̥
;("KQ" [""]) ; khr̥̄
;("KL" [""]) ; khl̥
;("KLY" [""]) ; khl̥̄
;("KaM" [""]) ; khaṁ
;("KaH" [""]) ; khaḥ

("g`" ["ग्"]) ; g
("g " ["ग "]) ; -g
("ga" ["ग"]) ; ga
;("gA" [""]) ; _ā
;("gi" [""]) ; _i
;("gI" [""]) ; _ī
;("gu" [""]) ; _u
;("gU" [""]) ; _ū
;("ge" [""]) ; _ē
;("gE" [""]) ; _ai
;("go" [""]) ; _ō
;("gO" [""]) ; _au
;("gq" [""]) ; _r̥
;("gQ" [""]) ; _r̥̄
;("gL" [""]) ; _l̥
;("gLY" [""]) ; _l̥̄
;("gaM" [""]) ; _ṁ
;("gaH" [""]) ; _aḥ

("G`" ["घ्"]) ; gh
("G " ["घ "]) ; -gh
("Ga" ["घ"]) ; gha
;("GA" [""]) ; ghā
;("Gi" [""]) ; ghi
;("GI" [""]) ; ghī
;("Gu" [""]) ; _u
;("GU" [""]) ; _ū
;("Ge" [""]) ; _ē
;("GE" [""]) ; _ai
;("Go" [""]) ; _ō
;("GO" [""]) ; _au
;("Gq" [""]) ; _r̥
;("GQ" [""]) ; _r̥̄
;("GL" [""]) ; _l̥
;("GLY" [""]) ; _l̥̄
;("GaM" [""]) ; _ṁ
;("GaH" [""]) ; _aḥ

("f`" ["ङ्"]) ; _
("f " ["ङ "]) ; -_
("fa" ["ङ"]) ; _a
;("fA" [""]) ; _ā
;("fi" [""]) ; _i
;("fI" [""]) ; _ī
;("fu" [""]) ; _u
;("fU" [""]) ; _ū
;("fe" [""]) ; _ē
;("fE" [""]) ; _ai
;("fo" [""]) ; _ō
;("fO" [""]) ; _au
;("fq" [""]) ; _r̥
;("fQ" [""]) ; _r̥̄
;("fL" [""]) ; _l̥
;("fLY" [""]) ; _l̥̄
;("faM" [""]) ; _ṁ
;("faH" [""]) ; _aḥ

; ----------

("c`" ["च्"]) ; _
;("c " [""]) ; -_
;("ca" [""]) ; _a
;("cA" [""]) ; _ā
;("ci" [""]) ; _i
;("cI" [""]) ; _ī
;("cu" [""]) ; _u
;("cU" [""]) ; _ū
;("ce" [""]) ; _ē
;("cE" [""]) ; _ai
;("co" [""]) ; _ō
;("cO" [""]) ; _au
;("cq" [""]) ; _r̥
;("cQ" [""]) ; _r̥̄
;("cL" [""]) ; _l̥
;("cLY" [""]) ; _l̥̄
;("caM" [""]) ; _ṁ
;("caH" [""]) ; _aḥ

("C" ["छ्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("j" ["ज्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("J" ["झ्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("F" ["ञ्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

; ----------

("t" ["ट्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("T" ["ठ्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("d" ["ड्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("D" ["ढ्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("N" ["ण्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

; ----------

("w" ["त्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("W" ["थ्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("x" ["द्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("X" ["ध्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("n" ["न्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

; ----------

("p" ["प्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("P" ["फ्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("b" ["ब्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("B" ["भ्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("m" ["म्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

; ----------

;("y`" ["य्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

;("r`" ["र्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

;("l`" ["ल्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

;("v`" ["व्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

; ----------

("S`" ["श्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("R`" ["ष्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("s`" ["स्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

("h`" ["ह्"])
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

; ----------

;("kRa" "क्ष") ; kṣa
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

;("wra" "त्र") ; tra
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

;("jFa" "ज्ञ") ; jña
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

;("Sra" "श्र") ; śra
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

;("kZa" "क़") ; qa
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

;("KZa" "ख़") ; k͟ha
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

;("gZa" "ग़") ; ġa
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

;("jZa" "ज़") ; za
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

;("PZa" "फ़") ; fa
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

;("dZa" "ड़") ; ṛa
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

;("DZa" "ढ़") ; ṛha
;("_`" [""]) ; _
;("_ " [""]) ; -_
;("_a" [""]) ; _a
;("_A" [""]) ; _ā
;("_i" [""]) ; _i
;("_I" [""]) ; _ī
;("_u" [""]) ; _u
;("_U" [""]) ; _ū
;("_e" [""]) ; _ē
;("_E" [""]) ; _ai
;("_o" [""]) ; _ō
;("_O" [""]) ; _au
;("_q" [""]) ; _r̥
;("_Q" [""]) ; _r̥̄
;("_L" [""]) ; _l̥
;("_LY" [""]) ; _l̥̄
;("_aM" [""]) ; _ṁ
;("_aH" [""]) ; _aḥ

)

(provide 'jdp-hin)