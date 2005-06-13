;;; qp is taken from slib. I have put it here so that people who do
;;; not use slib can still use psd.
;;;
;;; qp is copyright by Aubrey Jaffer.
;;; 
;;; Qp writes its arguments, separated by spaces to
;;; (current-output-port).  Qp compresses printing by substituting
;;; `...'  for substructure it does not have sufficient room to print.
;;; *qp-width* is the largest number of characters that qp uses.

(define *qp-width* 80)

(define qp
  (let
      ((+ +) (- -) (< <) (= =) (apply apply) (boolean? boolean?)
	     (car car) (cdr cdr) (char? char?) (display display) (eq? eq?)
	     (for-each for-each) (input-port? input-port?) (newline newline)
	     (not not) (null? null?) (number->string number->string)
	     (number? number?) (output-port? output-port?)
	     (procedure? procedure?) (string-length string-length)
	     (string? string?) (substring substring)
	     (symbol->string symbol->string) (symbol? symbol?)
	     (vector-length vector-length) (vector-ref vector-ref)
	     (vector? vector?) (write write))
    (letrec
	((num-cdrs
	  (lambda (pairs max-cdrs)
	    (cond
	     ((null? pairs) 0)
	     ((< max-cdrs 1) 1)
	     ((pair? pairs) (+ 1 (num-cdrs (cdr pairs) (- max-cdrs 1))))
	     (else 1))))
	 
	 (l-elt-room
	  (lambda (room pairs)
	    (quotient room (num-cdrs pairs (quotient room 8)))))

	 (qp-pairs
	  (lambda (cdrs room)
	    (cond
	     ((null? cdrs) 0)
	     ((not (pair? cdrs))
	      (display " . ")
	      (+ 3 (qp-obj cdrs (l-elt-room (- room 3) cdrs))))
	     ((< 11 room)
	      (display #\ )
	      ((lambda (used)
		 (+ (qp-pairs (cdr cdrs) (- room used)) used))
	       (+ 1 (qp-obj (car cdrs) (l-elt-room (- room 1) cdrs)))))
	     (else
	      (display " ...") 4))))

	 (v-elt-room
	  (lambda (room vleft)
	    (quotient room (min vleft (quotient room 8)))))

	 (qp-vect
	  (lambda (vect i room)
	    (cond
	     ((= (vector-length vect) i) 0)
	     ((< 11 room)
	      (display #\ )
	      ((lambda (used)
		 (+ (qp-vect vect (+ i 1) (- room used)) used))
	       (+ 1 (qp-obj (vector-ref vect i)
			    (v-elt-room (- room 1)
					(- (vector-length vect) i))))))
	     (else
	      (display " ...") 4))))

	 (qp-string
	  (lambda (str room)
	    (cond
	     ((< (string-length str) room)
	      (display str)
	      (string-length str))
	     (else
	      (display (substring str 0 (- room 3)))
	      (display "...")
	      room))))

	 (qp-obj
	  (lambda (obj room)
	    (cond
	     ((null? obj) (write obj) 2)
	     ((boolean? obj) (write obj) 2)
	     ((char? obj) (write obj) 8)
	     ((number? obj) (qp-string (number->string obj) room))
	     ((string? obj)
	      (display #\")
	      ((lambda (ans) (display #\") ans)
	       (+ 2 (qp-string obj (- room 2)))))
	     ((symbol? obj) (qp-string (symbol->string obj) room))
	     ((input-port? obj) (display "#[input]") 8)
	     ((output-port? obj) (display "#[output]") 9)
	     ((procedure? obj) (display "#[proc]") 7)
	     ((vector? obj)
	      (set! room (- room 3))
	      (display "#(")
	      ((lambda (used) (display #\)) (+ used 3))
	       (cond
		((= 0 (vector-length obj)) 0)
		((< room 8) (display "...") 3)
		(else
		 ((lambda (used) (+ (qp-vect obj 1 (- room used)) used))
		  (qp-obj (vector-ref obj 0)
			  (v-elt-room room (vector-length obj))))))))
	     ((pair? obj) 
	      (set! room (- room 2))
	      (display #\()
	      ((lambda (used) (display #\)) (+ 2 used))
	       (if (< room 8) (begin (display "...") 3)
		   ((lambda (used)
		      (+ (qp-pairs (cdr obj) (- room used)) used))
		    (qp-obj (car obj) (l-elt-room room obj))))))
	     (else (display "#[unknown]") 10)))))

      (lambda objs
	(qp-pairs (cdr objs)
		  (- *qp-width*
		     (qp-obj (car objs) (l-elt-room *qp-width*
						    objs))))))))



