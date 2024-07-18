(defun increment-number-in-text (prefix base-num increment suffix)
  (strcat prefix (itoa (+ base-num increment)) suffix)
)

(defun c:IncrementText (/ ss i prefix suffix base-ent base-txt base-num increment ent entData newTxt)
  (princ "\nEnter the prefix text: ")
  (setq prefix (getstring))
  (princ (strcat "\nPrefix: " prefix))  ; Debug message

  (princ "\nEnter the suffix text (leave blank for none): ")
  (setq suffix (getstring))
  (princ (strcat "\nSuffix: " suffix))  ; Debug message

  (setq ss (ssget '((0 . "TEXT,MTEXT"))))  ; Select all text and mtext entities manually
  (if ss
    (progn
      (setq base-ent (ssname ss 0)
            base-txt (cdr (assoc 1 (entget base-ent)))
            base-num (extract-number base-txt prefix)
            increment 0) ; Start incrementing from 0 to keep base text unchanged

      (princ (strcat "\nBase Text: " base-txt))  ; Debug message
      (princ (strcat "\nBase Number: " (itoa base-num)))  ; Debug message

      ; Process each selected entity
      (setq i 0)
      (while (< i (sslength ss))
        (setq ent (ssname ss i))
        (setq entData (entget ent))
        (if (and entData (not (= ent base-ent)))
          (progn
            (setq newTxt (increment-number-in-text prefix base-num increment suffix))
            (princ (strcat "\nModified Text: " newTxt))  ; Debug message

            ; Update the text entity with the modified text
            (entmod (subst (cons 1 newTxt) (assoc 1 entData) entData))
            (entupd ent)

            (setq increment (1+ increment))
          )
        )
        (setq i (1+ i))
      )
    )
    (princ "\nNo text entities found.")
  )
  (princ "\nIncrementText function complete.")  ; Debug message
  (princ)
)

(defun C:IncrementTextCommand ()  ; Command function to be called from AutoCAD command line
  (c:IncrementText)  ; Call the main function
  (princ)
)

(princ "\nType IncrementTextCommand to run the script.")
(princ)
