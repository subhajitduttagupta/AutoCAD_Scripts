(defun c:DelTextInArea ( / ss pt1 pt2 prefix i ent entType txt)
  (setq prefix (getstring "\nEnter the prefix of the text to delete: "))
  (setq pt1 (getpoint "\nSelect first corner of the area: "))
  (setq pt2 (getcorner pt1 "\nSelect opposite corner of the area: "))
  (setq ss (ssget "C" pt1 pt2 '((0 . "TEXT,MTEXT"))))  ; Select text and mtext entities within the specified area

  (if ss
    (progn
      (princ (strcat "\nNumber of text entities found: " (itoa (sslength ss))))
      (setq i 0)
      (repeat (sslength ss)
        (setq ent (ssname ss i))
        (setq entType (cdr (assoc 0 (entget ent))))
        (if (or (= entType "TEXT") (= entType "MTEXT"))
          (progn
            (setq txt (cdr (assoc 1 (entget ent))))
            (if txt
              (progn
                (princ (strcat "\nText found: " txt))
                (if (= (substr txt 1 (strlen prefix)) prefix) ; Check if the text starts with the prefix
                  (progn
                    (princ (strcat "\nDeleting text: " txt))
                    (entdel ent)
                  )
                  (princ (strcat "\nText does not start with prefix '" prefix "': " txt))
                )
              )
              (princ "\nNo text content found.")
            )
          )
          (princ (strcat "\nEntity is not text or mtext: " entType))
        )
        (setq i (1+ i))
      )
    )
    (princ "\nNo text entities found in the selected area.")
  )
  (princ)
)

(princ "\nType DelTextInArea to run the script.")
(princ)
