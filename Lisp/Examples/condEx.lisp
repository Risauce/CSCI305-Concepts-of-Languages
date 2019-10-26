
(defun testIf( alist )

    (cond

    ((null alist) 0)
    ((atom alist) 1)
    ((list alist) 33)
    (t 55)
   )
)


(write(testIf 4))  ;;
	
