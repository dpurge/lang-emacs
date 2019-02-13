(require 'quail)

(quail-define-package
  "jdp-semitic-postfix" "UTF-8" "Sem<" t
  "Latin transcription for semitic languages."
  nil t nil nil nil nil nil nil nil nil t)

(quail-define-rules
  ("\\\\" ?\\)
  ("\\`" ?`)
  ("\\@" ?@)
  ("\\-" ?-)
  ("\\." ?.)

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
  ("H." ?Ḥ)
  ("s." ?ṣ)
  ("S." ?Ṣ)
  ("d." ?ḍ)
  ("D." ?Ḍ)
  ("g." ?ġ)
  ("G." ?Ġ)
  ("t." ?ṭ)
  ("T." ?Ṭ)
  ("z." ?ẓ)
  ("Z." ?Ẓ)

  ("c<" ?č)
  ("C<" ?Č)
  ("g<" ?ǧ)
  ("G<" ?Ǧ)
  ("s<" ?š)
  ("S<" ?Š)

  ("d_" ?ḏ)
  ("D_" ?Ḏ)
  ("g_" ?ġ)
  ("G_" ?Ġ)
  ("t_" ?ṯ)
  ("T_" ?Ṯ)
  ("h(" ?ḫ)
  ("H(" ?Ḫ)
)

(provide 'jdp-semitic-postfix)