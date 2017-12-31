(require 'quail)

(quail-define-package
  "jdp-indic-postfix" "UTF-8" "Ind<" t
  "Input method for Indic transliteration with postfix modifiers."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ;; long vowels
 ("aa" "ā")
 ("ii" "ī")
 ("uu" "ū")
 ("rr." "ṝ")
 ("ee" "ē")
 ("oo" "ō")

 ;; dot below
 ("r." "ṛ")
 ("l." "ḷ")
 ("m." "ṃ")
 ("h." "ḥ")
 ("t." "ṭ")
 ("d." "ḍ")
 ("n." "ṇ")
 ("s." "ṣ")
 
 ;; diacritic above
 ("n'" "ṅ")
 ("s'" "ś")
 ("n~" "ñ")
 
 ("gy" ["jñ"])  ; as in, gyaana becomes jñāna
)

(provide 'jdp-indic-postfix)
