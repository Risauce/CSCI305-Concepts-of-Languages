(setq numbers '(-2 4 -3 5 -3 1 -2 3))



; (defun list-to-2d-array (list)
; 	"Converts a list to an Array for easier referencing."
;   (make-array (list (length list)
;                     (length (first list)))
;               :initial-contents list))

(defun list-to-2d-array (list)
  (map 'array #'identity list))
     
(defun recursive-add (list)
       "Goes through a list of numbers and recursively adds them up. Finds Sum."
	
       (if (null list) 0                                  ; Go until end
             (+ (car list) (recursive-add(cdr list)))     ; recursive call
              )	
	)                  
     
     


(defun myMax (list)
	"Goes through and finds the max of a list."
	
	(if (null list) 0
		(max (car list) (myMax (cdr list)))
		)
	
	)


; In order to calculate the maximum sublist recursively we need to use divide and conquer. 
; We can split up the list into different parts, the left and right halves, and last possibility 
; that the max sublist goes over the middle. 

; The base case is a single element; the max of a single element in a list is that element. 
; Otherwise, we need to return (recursively) the maximum of either the max (left half) of the list, the 
; max(right) or the max(crossing). 


;Max crossing might be needed to detect a greatest subarray that passes over the middle 
;however I cannot get it to work...
;(defun maxCrossing (list)
;	(let (totalSum 0)
;		(leftSum -1000) (middle (/(list-length list)2)))
;		(loop for i from 0 to m 
;				do(
;					((setf totalSum (+ totalSum )))
;						(if (test)
;							())
;					)
;			)
;
;	)

(defun recursiveMaxSubarray (list start end)
	"Attempts to use Divide and Conquer to recursively find the maximum sub array within list. Hits a 
	stack overflow error because it somehow never hits the base case. This is an attempt at converting
	python code... my was it a lot easier to make in python."

		(if (= start end) (car list) ; Check if the List is just one value, if so return that.
			;(if (= 1 (length list)))
		
			(progn (setq middle (/ (+ start end) 2)) ;Else, Find the middle and recursively look for right/left max

				(max (recursiveMaxSubarray list 0 middle) (recursiveMaxSubarray list (+ 1 middle) end) )
			)
		)
	 
	)

;An attempt at just brute forcing it with an array. 
; (defun	bruteForce (array)
; 	(let ((maxSoFar -1000) (ending 0))

; 		(loop for i from 0 to (dimensions array)
; 			(setf maxSoFar (+ maxSoFar (aref array i)))
; 			(if (< maxSoFar ending) (setf mxSoFar ending)

; 			)
; 			(if (< ending 0) (= ending 0))
; 		)
			
; 	)
; )


; Online solution for notes only.----------------------------
(defun max-subseq (list)
  (let ((best-sum 0) (current-sum 0) (end 0))
    ;; determine the best sum, and the end of the max subsequence
    (do ((list list (rest list))
         (i 0 (1+ i)))
        ((endp list))
      (setf current-sum (max 0 (+ current-sum (first list))))
      (when (> current-sum best-sum)
        (setf end i
              best-sum current-sum)))
    ;; take the subsequence of list ending at end, and remove elements
    ;; from the beginning until the subsequence sums to best-sum.
    (let* ((sublist (subseq list 0 (1+ end)))
           (sum (reduce #'+ sublist)))
      (do ((start 0 (1+ start))
           (sublist sublist (rest sublist))
           (sum sum (- sum (first sublist))))
          ((or (endp sublist) (eql sum best-sum))
           (values best-sum sublist start (1+ end)))))))

;---------------------------------------------------------------
;What I've learned about Lisp: It makes no sense at all and is frankly incredibly annoying to work with. 
;I could do these problems a 1000x easier in java, python, c#, and most other languages, why someone
;would choose to this over those nowadays baffles me. 

(setq convArray (list-to-2d-array numbers))

(write(recursive-add numbers)) ;Recursive add took me about 5 minutes to make.
(print "It will Stackoverflow, the code is not perfect...")
(print(recursiveMaxSubarray numbers 0 (-(length numbers) 1))) ;This function, however, I spent 8+ hours 
																;on and never finished. Even went to the 
																;CS help center and didn't get it. 