(defun c:AddPrefixAndSuffixToTextCommand ()  ; Command function
  (c:addPrefixAndSuffixToSelectedText)  ; Call the main function
  (princ)
)

(defun c:addPrefixAndSuffixToSelectedText ()
  (setq prefix (getstring "\nEnter the text to add as prefix: "))  ; Prompt for text to add
  (setq suffix (getstring "\nEnter the text to add as suffix (leave blank for none): "))  ; Prompt for suffix
  (setq ss (ssget '((0 . "TEXT,MTEXT"))))  ; Select TEXT and MTEXT objects
  (if ss
    (progn
      (setq cnt (sslength ss))
      (setq i 0)
      (while (< i cnt)
        (setq obj (ssname ss i))
        (cond
          ((eq (cdr (assoc 0 (entget obj))) "TEXT")
            (setq oldText (cdr (assoc 1 (entget obj))))
            (setq newText (strcat prefix oldText suffix))  ; Concatenate prefix, old text, and suffix
            (entmod (subst (cons 1 newText) (assoc 1 (entget obj)) (entget obj))))
          ((eq (cdr (assoc 0 (entget obj))) "MTEXT")
            (setq oldText (cdr (assoc 1 (entget obj))))
            (setq newText (strcat prefix oldText suffix))  ; Concatenate prefix, old text, and suffix
            (entmod (subst (cons 1 newText) (assoc 1 (entget obj)) (entget obj))))
        )
        (setq i (1+ i))
      )
      (princ (strcat "\n" (itoa cnt) " text objects updated with prefix and suffix."))
    )
    (princ "\nNo text objects selected.")
  )
  (princ)
)

(princ "\nType 'AddPrefixAndSuffixToTextCommand' to run the script.")  ; Instruction message
(princ)
