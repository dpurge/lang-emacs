(defvar dpurge-dictionary-buffer "*Dictionary*"
  "Buffer used by the dictionary window.")

(defun dpurge-dictionary-open ()
  "Open the dictionary window if it is not already visible."
  (interactive)
  (let ((buffer (get-buffer-create dpurge-dictionary-buffer)))
    (display-buffer buffer
        '((display-buffer-reuse-window
            display-buffer-at-bottom)
            (window-height . 0.3)))
    buffer))

(defun dpurge-dictionary-send (text)
  "Open the dictionary window and send TEXT to it."
  (interactive "sText: ")
  (let ((buffer (dpurge-dictionary-open)))
    (with-current-buffer buffer
      (goto-char (point-max))
      (insert text "\n"))))

(defun dpurge-dictionary-lookup (word lang script)
  "Open dictionary and look up WORD."
  (interactive "sWord: ")
  (dpurge-dictionary-open)
  ;; Call the dictionary package here.
  ;;(dictionary-search word)
  (dpurge-dictionary-send (format "Looking up %s in language=%s script=%s"
    word lang script)))

;;(defun dpurge-dictionary-lookup-at-point ()
;;  "Look up the word at point."
;;  (interactive)
;;  (dpurge-dictionary-lookup (thing-at-point 'word t)))

(provide 'dpurge-dictionary)
