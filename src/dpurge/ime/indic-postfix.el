(require 'quail)

(quail-define-package
  "dpurge-indic-postfix" "UTF-8" "Ind<" t
  "Input method for Indic transliteration with postfix modifiers."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
 ("aa" "ā")
 ("ii" "ī")
 ("uu" "ū")
 ("rr." "ṝ")
 ("ee" "ē")
 ("oo" "ō")

 ("r." "ṛ")
 ("l." "ḷ")
 ("m." "ṃ")
 ("h." "ḥ")
 ("t." "ṭ")
 ("d." "ḍ")
 ("n." "ṇ")
 ("s." "ṣ")
 
 ("n'" "ṅ")
 ("s'" "ś")
 ("n~" "ñ")
 
 ("gy" ["jñ"]))

(provide 'dpurge-indic-postfix)
