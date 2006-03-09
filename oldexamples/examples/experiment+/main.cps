
Applying local CPS-optimizations:
(MODULE Main)
(WITH RML)
(EXPORTS Main.main)

(define (Main.j v134:1 v135:1 v132:0 v133:1)
  (let ((v140:1 v134:1))
  (let ((v139:1 v135:1))
  (let ((v143:1 (rml_mkstruct 0 v140:1 v139:1))) (@sc v133:1 v143:1)))))

(define (Main.walk v131:4 v129:3 v130:2)
  (let ((v202:1 (fetch 0 v131:4)))
  (switch v202:1
    (((STRUCTHDR 0 0)) (@sc v130:2))
    (((STRUCTHDR 3 1))
     (let ((v203:1 (fetch 3 v131:4)))
     (let ((v204:1 (fetch 2 v131:4)))
     (let ((v205:1 (fetch 1 v131:4)))
     (let ((v195:1 v205:1))
     (let ((v194:1 v204:1))
     (let ((v193:1 v203:1))
     (let ((v206:1
	     (lambda "sc211" ()
	       (let ((v207:1
		       (lambda "sc210" ()
			 (let ((v208:1 (lambda "sc209" () (@sc v130:2))))
			 (@pv `,Main.walk v193:1 v129:3 v208:1)))))
	       (@pv `,RML.print v194:1 v129:3 v207:1)))))
     (@pv `,Main.walk v195:1 v129:3 v206:1))))))))))))

(define (Main.main v138:0 v136:8 v137:1)
  (let ((v146:1 `2))
  (let ((v147:1 v146:1))
  (let ((v150:1
	  (lambda "sc192" ( v151:1)
	    (let ((v152:2 v151:1))
	    (let ((v155:1
		    (lambda "sc191" ( v156:1)
		      (let ((v157:4 v156:1))
		      (let ((v160:1 v157:4))
		      (let ((v161:1 v160:1))
		      (let ((v164:2 v161:1))
		      (let ((v170:1 (fetch 2 v164:2)))
		      (let ((v171:1 (fetch 1 v164:2)))
		      (let ((v166:1 v171:1))
		      (let ((v165:1 v170:1))
		      (let ((v172:2 v157:4))
		      (let ((v178:1 (fetch 2 v172:2)))
		      (let ((v179:1 (fetch 1 v172:2)))
		      (let ((v174:1 v179:1))
		      (let ((v173:1 v178:1))
		      (let ((v180:1 (equal v157:4 v157:4)))
		      (switch v180:1
			((0) (@fc v136:8))
			(else
			 (let ((v181:1
				 (lambda "sc190" ()
				   (let ((v182:1
					   (lambda "sc189" ()
					     (let ((v183:1
						     (lambda "sc188" ()
						       (let ((v184:1
							       (lambda "sc187" ()
								 (let ((v185:1
									 (lambda "sc186" ()
									   (@sc v137:1))))
								 (@pv `,Main.walk
								      `#(1
									 #(1
									   #(0)
									   "1"
									   #(0))
									 "2"
									 #(1
									   #(0)
									   "3"
									   #(0)))
								      v136:8
								      v185:1)))))
						       (@pv `,RML.print v173:1
							    v136:8 v184:1)))))
					     (@pv `,RML.print v174:1 v136:8
						  v183:1)))))
				   (@pv `,RML.print v165:1 v136:8 v182:1)))))
			 (@pv `,RML.print v166:1 v136:8
			      v181:1)))))))))))))))))))))
	    (@pv `,Main.j v152:2 v152:2 v136:8 v155:1))))))
  (@pv `,RML.int_string v147:1 v136:8 v150:1)))))

Applying local CPS-optimizations:
(MODULE Main)
(WITH RML)
(EXPORTS Main.main)

(define (Main.walk v131:4 v129:3 v130:2)
  (let ((v202:1 (fetch 0 v131:4)))
  (switch v202:1
    (((STRUCTHDR 0 0)) (@sc v130:2))
    (((STRUCTHDR 3 1))
     (let ((v203:1 (fetch 3 v131:4)))
     (let ((v204:1 (fetch 2 v131:4)))
     (let ((v205:1 (fetch 1 v131:4)))
     (@pv `,Main.walk v205:1 v129:3
	  (lambda "sc211" ()
	    (@pv `,RML.print v204:1 v129:3
		 (lambda "sc210" ()
		   (@pv `,Main.walk v203:1 v129:3 v130:2))))))))))))

(define (Main.main v138:0 v136:7 v137:1)
  (@pv `,RML.int_string `2 v136:7
       (lambda "sc192" ( v151:2)
	 (let ((v143:1 (rml_mkstruct 0 v151:2 v151:2)))
	 (let ((v156:6 v143:1))
	 (let ((v170:1 (fetch 2 v156:6)))
	 (let ((v171:1 (fetch 1 v156:6)))
	 (let ((v178:1 (fetch 2 v156:6)))
	 (let ((v179:1 (fetch 1 v156:6)))
	 (let ((v180:1 (equal v156:6 v156:6)))
	 (switch v180:1
	   ((0) (@fc v136:7))
	   (else
	    (@pv `,RML.print v171:1 v136:7
		 (lambda "sc190" ()
		   (@pv `,RML.print v170:1 v136:7
			(lambda "sc189" ()
			  (@pv `,RML.print v179:1 v136:7
			       (lambda "sc188" ()
				 (@pv `,RML.print v178:1 v136:7
				      (lambda "sc187" ()
					(@pv `,Main.walk
					     `#(1 #(1 #(0) "1" #(0)) "2"
						#(1 #(0) "3" #(0))) v136:7
					     v137:1)))))))))))))))))))))

Applying local CPS-optimizations:
(MODULE Main)
(WITH RML)
(EXPORTS Main.main)

(define (Main.walk v131:4 v129:3 v130:2)
  (let ((v202:1 (fetch 0 v131:4)))
  (switch v202:1
    (((STRUCTHDR 0 0)) (@sc v130:2))
    (((STRUCTHDR 3 1))
     (let ((v203:1 (fetch 3 v131:4)))
     (let ((v204:1 (fetch 2 v131:4)))
     (let ((v205:1 (fetch 1 v131:4)))
     (@pv `,Main.walk v205:1 v129:3
	  (lambda "sc211" ()
	    (@pv `,RML.print v204:1 v129:3
		 (lambda "sc210" ()
		   (@pv `,Main.walk v203:1 v129:3 v130:2))))))))))))

(define (Main.main v138:0 v136:7 v137:1)
  (@pv `,RML.int_string `2 v136:7
       (lambda "sc192" ( v151:2)
	 (let ((v143:6 (rml_mkstruct 0 v151:2 v151:2)))
	 (let ((v170:1 (fetch 2 v143:6)))
	 (let ((v171:1 (fetch 1 v143:6)))
	 (let ((v178:1 (fetch 2 v143:6)))
	 (let ((v179:1 (fetch 1 v143:6)))
	 (let ((v180:1 (equal v143:6 v143:6)))
	 (switch v180:1
	   ((0) (@fc v136:7))
	   (else
	    (@pv `,RML.print v171:1 v136:7
		 (lambda "sc190" ()
		   (@pv `,RML.print v170:1 v136:7
			(lambda "sc189" ()
			  (@pv `,RML.print v179:1 v136:7
			       (lambda "sc188" ()
				 (@pv `,RML.print v178:1 v136:7
				      (lambda "sc187" ()
					(@pv `,Main.walk
					     `#(1 #(1 #(0) "1" #(0)) "2"
						#(1 #(0) "3" #(0))) v136:7
					     v137:1))))))))))))))))))))
