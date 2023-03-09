;;; $DOOMDIR/+functions.el -*- lexical-binding: t; -*-
(defun insert-console-log (start end)
  "Insert console.log of the variable at point."
  (interactive "r")
  (copy-region-as-kill start end)
  (end-of-line)
  (newline-and-indent)
  (insert (format "// eslint-disable-next-line no-console\nconsole.log(\"%s: \", %s);"
                  (car kill-ring)
                  (car kill-ring))))

(defun my/capitalize-first-char (&optional string)
  "Capitalize only the first character of the input STRING."
  (when (and string (> (length string) 0))
    (let ((first-char (substring string nil 1))
          (rest-str   (substring string 1)))
      (concat (capitalize first-char) rest-str))))
