(defun c:ExportFerruleCoordinates ( / ss ent ename coords text-value text-size text-rotation filehandle prefix documents-folder ferrule-folder)
  ;; Prompt user for a prefix
  (setq prefix (getstring "\nEnter the prefix to filter (leave blank for '*'): "))
  (if (equal prefix "") (setq prefix "*"))  ; Default to '*' if no prefix is provided

  ;; Create a selection set of all text and mtext entities
  (setq ss (ssget "X" '((0 . "TEXT,MTEXT"))))

  ;; Define the documents folder and ferrule folder paths
  (setq documents-folder (strcat (getenv "USERPROFILE") "\\Documents\\"))
  (setq ferrule-folder (strcat documents-folder "ferrule\\"))

  ;; Check if the ferrule folder exists, if not create it
  (if (not (vl-file-directory-p ferrule-folder))
    (progn
      (vl-mkdir ferrule-folder)
      ;; Check if the directory was created successfully
      (if (not (vl-file-directory-p ferrule-folder))
        (progn
          (princ (strcat "\nError: Could not create the folder " ferrule-folder))
          (exit)
        )
      )
    )
  )

  ;; Try to open a CSV file for writing in the ferrule folder
  (setq filehandle (open (strcat ferrule-folder "ferrule_coordinates.csv") "w"))

  ;; Check if the filehandle is valid
  (if filehandle
    (progn
      ;; Write the CSV header
      (write-line "X,Y,TextSize,Rotation,FerruleNumber" filehandle)

      ;; Loop through each text entity in the selection set
      (setq i 0)
      (while (< i (sslength ss))
        (setq ename (ssname ss i))
        (setq ent (entget ename))
        (setq text-value (cdr (assoc 1 ent)))

        ;; Check if the text starts with the specified prefix
        (if (= (substr text-value 1 (strlen prefix)) prefix)
          (progn
            ;; Get the insertion point (coordinates) of the text
            (setq coords (cdr (assoc 10 ent)))
            ;; Get the text size
            (setq text-size (cdr (assoc 40 ent)))
            ;; Get the text rotation angle in degrees
            (setq text-rotation (cdr (assoc 50 ent)))
            ;; Convert the rotation angle from radians to degrees if needed
            (setq text-rotation (* text-rotation (/ 180.0 pi)))
            ;; Write the data to the CSV file
            (write-line (strcat 
                          (vl-princ-to-string (car coords)) "," 
                          (vl-princ-to-string (cadr coords)) "," 
                          (vl-princ-to-string text-size) "," 
                          (vl-princ-to-string text-rotation) "," 
                          text-value) 
                        filehandle)
          )
        )

        (setq i (1+ i))
      )

      ;; Close the file
      (close filehandle)
      
      (princ (strcat "Data has been exported to " ferrule-folder "ferrule_coordinates.csv"))
    )
    ;; Handle the case where the file could not be opened
    (princ "\nError: Could not open the file for writing.")
  )

  (princ)
)

(princ)
