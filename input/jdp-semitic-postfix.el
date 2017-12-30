(require 'quail)

(quail-define-package
"jdp-semitic-postfix" "UTF-8" "Sem<" t
"Latin transcription for semitic languages.

accent name | postfix | examples
------------+---------+----------
escape      | \       |         
macron      | =       | Āā Ēē       
breve       | {       | Ăă      
            |         |         
            |         |         
            |         |         
            |         |         
            |         |         
            |         |         
            |         |         

Duplication of postfix

" nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules

 ("\\\\" ?\\)
 ("\\`" ?`)
 ("\\@" ?@)
 
 ("\\a" ?a)
 ("\\e" ?e)
 ("\\i" ?i)
 ("\\o" ?o)
 ("\\u" ?u)
 
 ("\\A" ?A)
 ("\\E" ?E)
 ("\\I" ?I)
 ("\\O" ?O)
 ("\\U" ?U)
 
 ("aa" ?ā)
 ("ee" ?ē)
 ("ii" ?ī)
 ("oo" ?ō)
 ("uu" ?ū)
 
 ("Aa" ?Ā)
 ("Ee" ?ē)
 ("Ii" ?ī)
 ("Oo" ?Ō)
 ("Uu" ?ū)
 
 ("a@" ?æ)
 ("A@" ?Æ)
 ("e@" ?ə)
 ("E@" ?Ə)
 ("a(" ?ă)
 ("A(" ?Ă)
 
 ("`" ?ʾ)
 ("``" ?ʿ)
 
 ("h." ?ḥ)
 ("s." ?ṣ)
 ("d." ?ḍ)
 ("t." ?ṭ)
 ("z." ?ẓ)
 
 ("g<" ?ǧ)
 ("s<" ?š)
 
 ("d_" ?ḏ)
 ("g_" ?ġ)
 ("t_" ?ṯ)
 ("h(" ?ḫ)
 
 ;("" ?)
 ;("" ?)
 ;("" ?)
)

(provide 'jdp-semitic-postfix)