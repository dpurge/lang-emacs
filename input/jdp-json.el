(require 'subr-x)
(require 'json)

(defvar jdp-anki-pattern-vocabulary-phrase-with-transcription
"\t{\n\t\t\"phrase\": %s,\n\t\t\"transcription\": \"\",\n\t\t\"grammar\": \"\",\n\t\t\"translation\": \"\",\n\t\t\"notes\": \"\"\n\t},"
  "Pattern of the JSON record for vocabulary with transcription field.")
  
(defvar jdp-anki-pattern-vocabulary-phrase-no-transcription
  "\t{\n\t\t\"phrase\": %s,\n\t\t\"grammar\": \"\",\n\t\t\"translation\": \"\",\n\t\t\"notes\": \"\"\n\t},"
  "Pattern of the JSON record for vocabulary without transcription field.")
  
(defvar jdp-anki-pattern-vocabulary-transcription-only
  "\t{\n\t\t\"phrase\": \"\",\n\t\t\"transcription\": %s,\n\t\t\"grammar\": \"\",\n\t\t\"translation\": \"\",\n\t\t\"notes\": \"\"\n\t},"
  "Pattern of the JSON record for vocabulary with transcription field.")
  
(defvar jdp-json-format-pattern
  jdp-anki-pattern-vocabulary-phrase-with-transcription
  "Default pattern of the JSON record for vocabulary.")


(defun jdp-apply-json-format (&optional $from $to)
  (interactive
    (if (use-region-p)
      (list (region-beginning) (region-end))
      (list (line-beginning-position) (line-end-position) ) ) )
  (let (inputStr outputStr)
    (setq inputStr (buffer-substring-no-properties $from $to) )
	(setq outputStr (
	    format jdp-json-format-pattern (
		    json-encode-string (
			    string-trim inputStr))) )
	(save-excursion
        (delete-region $from $to)
        (goto-char $from)
        (insert outputStr) ) )
)


(defun jdp-set-json-format-pattern (pattern-name)
  "Set up buffer for Arabic editing."
  (interactive "sChoose JSON format: ")
  (pcase pattern-name
    ("phrase"
      (setq jdp-json-format-pattern
	    jdp-anki-pattern-vocabulary-phrase-with-transcription))
    ("phrase-simple"
      (setq jdp-json-format-pattern
	    jdp-anki-pattern-vocabulary-phrase-no-transcription))
    ("transcription"
      (setq jdp-json-format-pattern
	    jdp-anki-pattern-vocabulary-transcription-only))
    (otherwise
      (message "Unknown JSON format %S" pattern-name)))
)

(provide 'jdp-json)