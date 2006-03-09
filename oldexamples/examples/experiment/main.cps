
Applying local CPS-optimizations:
(MODULE Main)
(WITH RML)
(EXPORTS Main.print_array Main.main)

(define (Main.apply v187:1 v185:9 v186:1)
  (let ((v203:1 v187:1))
  (let ((v206:1 (rml_mkstruct 1 `10.0 `#(0))))
  (let ((v207:1 v206:1))
  (let ((v208:1 v207:1))
  (let ((v211:1 (rml_mkstruct 1 `10.1 `#(0))))
  (let ((v212:1 (rml_mkstruct 1 `1.0 v211:1)))
  (let ((v213:1 (rml_mkstruct 1 `2.0 `#(0))))
  (let ((v214:1 (rml_mkstruct 1 `3.0 `#(0))))
  (let ((v215:1 (rml_mkstruct 1 v214:1 `#(0))))
  (let ((v216:1 (rml_mkstruct 1 v213:1 v215:1)))
  (let ((v217:1 (rml_mkstruct 1 v212:1 v216:1)))
  (let ((v218:1 v217:1))
  (let ((v219:1 v218:1))
  (let ((v222:1
	  (lambda "sc290" ( v223:0)
	    (let ((v226:1
		    (lambda "sc289" ( v227:1)
		      (let ((v228:1 v227:1))
		      (let ((v231:1
			      (lambda "sc288" ( v232:1)
				(let ((v233:2 v232:1))
				(let ((v236:1 (rml_mkstruct 1 `3.0 `#(0))))
				(let ((v237:1 v236:1))
				(let ((v238:6 v237:1))
				(let ((v241:1 v233:2))
				(let ((v242:1 v241:1))
				(let ((v245:1
					(lambda "sc287" ( v246:1)
					  (let ((v247:1 v246:1))
					  (let ((v250:1
						  (lambda "sc286" ( v251:1)
						    (let ((v252:1 v251:1))
						    (let ((v255:1
							    (lambda "sc285" (
									     v256:1)
							      (let ((v257:1
								      v256:1))
							      (let ((v260:1
								      (lambda "sc284" (
										       v261:1)
									(let ((v262:1
										v261:1))
									(let ((v265:1
										(lambda "sc283" (
												 v266:0)
										  (let ((v269:1
											  (lambda "sc282" (
													   v270:1)
											    (let ((v271:1
												    v270:1))
											    (let ((v274:1
												    v271:1))
											    (let ((v275:1
												    v274:1))
											    (let ((v278:1
												    (rml_mkstruct
												      1
												      v242:1
												      v275:1)))
											    (let ((v279:0
												    v278:1))
											    (@sc v186:1)))))))))
										  (@pv `,RML.array_add
										       v262:1
										       v238:6
										       v185:9
										       v269:1)))))
									(@pv `,RML.array_setnth
									     v252:1
									     `2
									     v238:6
									     v185:9
									     v265:1))))))
							      (@pv `,RML.array_update
								   v257:1 `5
								   v238:6 v185:9
								   v260:1))))))
						    (@pv `,RML.array_setnth
							 v247:1 `2 v238:6 v185:9
							 v255:1))))))
					  (@pv `,RML.array_setnth v233:2 `1
					       v238:6 v185:9 v250:1))))))
				(@pv `,RML.array_setnth v228:1 `1 v238:6 v185:9
				     v245:1)))))))))))
		      (@pv `,RML.list_array v219:1 v185:9 v231:1))))))
	    (@pv `,RML.array_create `10 v208:1 v185:9 v226:1)))))
  (@pv `,RML.array_vector v203:1 v185:9 v222:1))))))))))))))))

(define (Main.loop v190:1 v191:1 v192:1 v188:2 v189:2)
  (let ((v293:4 v190:1))
  (let ((v292:3 v191:1))
  (let ((v291:1 v192:1))
  (let ((v296:1 (rml_marker)))
  (let ((v297:9
	  (lambda "fc304" ()
	    (begin
	      (rml_unwind v296:1)
	      (let ((v298:1
		      (lambda "sc303" ( v299:1)
			(switch v299:1
			  ((1) (@sc v189:2))
			  (else (@fc v188:2))))))
	      (@pv `,RML.int_ge v293:4 v292:3 v188:2 v298:1))))))
  (let ((v305:1
	  (lambda "sc341" ( v306:1)
	    (switch v306:1
	      ((1)
	       (let ((v310:1
		       (lambda "sc340" ( v311:1)
			 (let ((v312:3 v311:1))
			 (let ((v315:1
				 (lambda "sc339" ( v316:1)
				   (let ((v317:1 v316:1))
				   (let ((v320:1 (rml_mkstruct 1 v317:1 `#(0))))
				   (let ((v321:1
					   (lambda "sc338" ( v322:1)
					     (let ((v323:3 v322:1))
					     (let ((v326:1
						     (lambda "sc337" ( v327:1)
						       (let ((v328:1 v327:1))
						       (let ((v331:1
							       (lambda "sc336" ()
								 (let ((v332:1
									 (lambda "sc335" ()
									   (let ((v333:1
										   (lambda "sc334" ()
										     (@sc v189:2))))
									   (@pv `,Main.loop
										v312:3
										v292:3
										v323:3
										v297:9
										v333:1)))))
								 (@pv `,Main.apply
								      v323:3
								      v297:9
								      v332:1)))))
						       (@pv `,RML.debug_print
							    `"\nset:" v328:1
							    v297:9 v331:1))))))
					     (@pv `,RML.array_nth v323:3 v293:4
						  v297:9 v326:1))))))
				   (@pv `,RML.array_update v291:1 v312:3 v320:1
					v297:9 v321:1)))))))
			 (@pv `,RML.int_real v312:3 v297:9 v315:1))))))
	       (@pv `,RML.int_add v293:4 `1 v297:9 v310:1)))
	      (else (@fc v297:9))))))
  (@pv `,RML.int_lt v293:4 v292:3 v297:9 v305:1))))))))

(define (Main.print_a v195:1 v196:1 v193:0 v194:2)
  (let ((v379:3 v195:1))
  (let ((v378:3 v196:1))
  (let ((v382:1 (rml_marker)))
  (let ((v383:7 (lambda "fc384" () (begin (rml_unwind v382:1) (@sc v194:2)))))
  (let ((v385:1
	  (lambda "sc412" ( v386:1)
	    (let ((v387:1 v386:1))
	    (let ((v390:1
		    (lambda "sc411" ( v391:1)
		      (switch v391:1
			((1)
			 (let ((v395:1
				 (lambda "sc410" ( v396:1)
				   (let ((v397:1 v396:1))
				   (let ((v400:1
					   (lambda "sc409" ()
					     (let ((v401:1
						     (lambda "sc408" ( v402:1)
						       (let ((v403:1 v402:1))
						       (let ((v406:1
							       (lambda "sc407" ()
								 (@sc v194:2))))
						       (@pv `,Main.print_a
							    v379:3 v403:1 v383:7
							    v406:1))))))
					     (@pv `,RML.int_add v378:3 `1 v383:7
						  v401:1)))))
				   (@pv `,RML.debug_print `"el" v397:1 v383:7
					v400:1))))))
			 (@pv `,RML.array_nth v379:3 v378:3 v383:7 v395:1)))
			(else (@fc v383:7))))))
	    (@pv `,RML.int_lt v378:3 v387:1 v383:7 v390:1))))))
  (@pv `,RML.array_length v379:3 v383:7 v385:1)))))))

(define (Main.print_array v199:1 v197:1 v198:1)
  (let ((v413:1 v199:1))
  (let ((v416:1 (lambda "sc417" () (@sc v198:1))))
  (@pv `,Main.print_a v413:1 `0 v197:1 v416:1))))

(define (Main.main v202:0 v200:5 v201:1)
  (let ((v344:1 `20))
  (let ((v345:2 v344:1))
  (let ((v348:1 (rml_mkstruct 1 `10.0 `#(0))))
  (let ((v349:1 v348:1))
  (let ((v350:2 v349:1))
  (let ((v353:1
	  (lambda "sc377" ( v354:1)
	    (let ((v355:1 v354:1))
	    (let ((v358:1
		    (lambda "sc376" ( v359:1)
		      (let ((v360:2 v359:1))
		      (let ((v363:2
			      `#(1 ,Main.print_array
				 #(1 ,Main.print_array #(0)))))
		      (let ((v370:1 (fetch 0 v363:2)))
		      (switch v370:1
			(((STRUCTHDR 2 1))
			 (let ((v371:1 (fetch 1 v363:2)))
			 (let ((v364:1 v371:1))
			 (let ((v372:1
				 (lambda "sc375" ()
				   (let ((v373:1
					   (lambda "sc374" () (@sc v201:1))))
				   (@pv `,Main.loop `0 v345:2 v360:2 v200:5
					v373:1)))))
			 (@pv v364:1 v360:2 v200:5 v372:1)))))
			(else (@fc v200:5)))))))))
	    (@pv `,RML.array_setnth v355:1 `1 v350:2 v200:5 v358:1))))))
  (@pv `,RML.array_create v345:2 v350:2 v200:5 v353:1))))))))

Applying local CPS-optimizations:
(MODULE Main)
(WITH RML)
(EXPORTS Main.print_array Main.main)

(define (Main.print_a v195:3 v196:3 v193:0 v194:2)
  (let ((v382:1 (rml_marker)))
  (let ((v383:5 (lambda "fc384" () (begin (rml_unwind v382:1) (@sc v194:2)))))
  (@pv `,RML.array_length v195:3 v383:5
       (lambda "sc412" ( v386:1)
	 (let ((v432:1 (int_lt v196:3 v386:1)))
	 (let ((v391:1 v432:1))
	 (switch v391:1
	   ((1)
	    (@pv `,RML.array_nth v195:3 v196:3 v383:5
		 (lambda "sc410" ( v396:1)
		   (@pv `,RML.debug_print `"el" v396:1 v383:5
			(lambda "sc409" ()
			  (let ((v429:1 (int_add v196:3 `1)))
			  (@pv `,Main.print_a v195:3 v429:1 v383:5 v194:2)))))))
	   (else (@fc v383:5))))))))))

(define (Main.loop v190:4 v191:3 v192:1 v188:1 v189:2)
  (let ((v296:1 (rml_marker)))
  (let ((v297:15
	  (lambda "fc304" ()
	    (begin
	      (rml_unwind v296:1)
	      (let ((v418:1 v190:4))
	      (let ((v419:1 v191:3))
	      (let ((v420:1 (int_ge v418:1 v419:1)))
	      (@sc (lambda "sc303" ( v299:1)
		     (switch v299:1 ((1) (@sc v189:2)) (else (@fc v188:1))))
		   v420:1))))))))
  (let ((v424:1 v190:4))
  (let ((v425:1 v191:3))
  (let ((v426:1 (int_lt v424:1 v425:1)))
  (@sc (lambda "sc341" ( v306:1)
	 (switch v306:1
	   ((1)
	    (let ((v423:1 (int_add v190:4 `1)))
	    (let ((v311:3 v423:1))
	    (@pv `,RML.int_real v311:3 v297:15
		 (lambda "sc339" ( v316:1)
		   (let ((v320:1 (rml_mkstruct 1 v316:1 `#(0))))
		   (@pv `,RML.array_update v192:1 v311:3 v320:1 v297:15
			(lambda "sc338" ( v322:3)
			  (@pv `,RML.array_nth v322:3 v190:4 v297:15
			       (lambda "sc337" ( v327:1)
				 (@pv `,RML.debug_print `"\nset:" v327:1 v297:15
				      (lambda "sc336" ()
					(@pv `,RML.array_vector v322:3 v297:15
					     (lambda "sc290" ( v223:0)
					       (@pv `,RML.array_create `10
						    `#(1 10.0 #(0)) v297:15
						    (lambda "sc289" ( v227:1)
						      (@pv `,RML.list_array
							   `#(1
							      #(1 1.0
								#(1 10.1 #(0)))
							      #(1 #(1 2.0 #(0))
								#(1
								  #(1 3.0 #(0))
								  #(0))))
							   v297:15
							   (lambda "sc288" (
									    v232:1)
							     (@pv `,RML.array_setnth
								  v227:1 `1
								  `#(1 3.0 #(0))
								  v297:15
								  (lambda "sc287" (
										   v246:1)
								    (@pv `,RML.array_setnth
									 v232:1
									 `1
									 `#(1
									    3.0
									    #(0))
									 v297:15
									 (lambda "sc286" (
											  v251:1)
									   (@pv `,RML.array_setnth
										v246:1
										`2
										`#(1
										   3.0
										   #(0))
										v297:15
										(lambda "sc285" (
												 v256:1)
										  (@pv `,RML.array_update
										       v256:1
										       `5
										       `#(1
											  3.0
											  #(0))
										       v297:15
										       (lambda "sc284" (
													v261:1)
											 (@pv `,RML.array_setnth
											      v251:1
											      `2
											      `#(1
												 3.0
												 #(0))
											      v297:15
											      (lambda "sc283" (
													       v266:0)
												(@pv `,RML.array_add
												     v261:1
												     `#(1
													3.0
													#(0))
												     v297:15
												     (lambda "sc282" (
														      v270:0)
												       (@pv `,Main.loop
													    v311:3
													    v191:3
													    v322:3
													    v297:15
													    v189:2)))))))))))))))))))))))))))))))
	   (else (@fc v297:15)))) v426:1)))))))

(define (Main.print_array v199:1 v197:1 v198:1)
  (@pv `,Main.print_a v199:1 `0 v197:1 v198:1))

(define (Main.main v202:0 v200:4 v201:1)
  (@pv `,RML.array_create `20 `#(1 10.0 #(0)) v200:4
       (lambda "sc377" ( v354:1)
	 (@pv `,RML.array_setnth v354:1 `1 `#(1 10.0 #(0)) v200:4
	      (lambda "sc376" ( v359:2)
		(@pv `,Main.print_array v359:2 v200:4
		     (lambda "sc375" ()
		       (@pv `,Main.loop `0 `20 v359:2 v200:4 v201:1))))))))

Applying local CPS-optimizations:
(MODULE Main)
(WITH RML)
(EXPORTS Main.print_array Main.main)

(define (Main.loop v190:4 v191:3 v192:1 v188:1 v189:2)
  (let ((v296:1 (rml_marker)))
  (let ((v297:15
	  (lambda "fc304" ()
	    (begin
	      (rml_unwind v296:1)
	      (let ((v420:1 (int_ge v190:4 v191:3)))
	      (let ((v299:1 v420:1))
	      (switch v299:1 ((1) (@sc v189:2)) (else (@fc v188:1)))))))))
  (let ((v426:1 (int_lt v190:4 v191:3)))
  (let ((v306:1 v426:1))
  (switch v306:1
    ((1)
     (let ((v423:3 (int_add v190:4 `1)))
     (@pv `,RML.int_real v423:3 v297:15
	  (lambda "sc339" ( v316:1)
	    (let ((v320:1 (rml_mkstruct 1 v316:1 `#(0))))
	    (@pv `,RML.array_update v192:1 v423:3 v320:1 v297:15
		 (lambda "sc338" ( v322:3)
		   (@pv `,RML.array_nth v322:3 v190:4 v297:15
			(lambda "sc337" ( v327:1)
			  (@pv `,RML.debug_print `"\nset:" v327:1 v297:15
			       (lambda "sc336" ()
				 (@pv `,RML.array_vector v322:3 v297:15
				      (lambda "sc290" ( v223:0)
					(@pv `,RML.array_create `10
					     `#(1 10.0 #(0)) v297:15
					     (lambda "sc289" ( v227:1)
					       (@pv `,RML.list_array
						    `#(1 #(1 1.0 #(1 10.1 #(0)))
						       #(1 #(1 2.0 #(0))
							 #(1 #(1 3.0 #(0))
							   #(0)))) v297:15
						    (lambda "sc288" ( v232:1)
						      (@pv `,RML.array_setnth
							   v227:1 `1
							   `#(1 3.0 #(0))
							   v297:15
							   (lambda "sc287" (
									    v246:1)
							     (@pv `,RML.array_setnth
								  v232:1 `1
								  `#(1 3.0 #(0))
								  v297:15
								  (lambda "sc286" (
										   v251:1)
								    (@pv `,RML.array_setnth
									 v246:1
									 `2
									 `#(1
									    3.0
									    #(0))
									 v297:15
									 (lambda "sc285" (
											  v256:1)
									   (@pv `,RML.array_update
										v256:1
										`5
										`#(1
										   3.0
										   #(0))
										v297:15
										(lambda "sc284" (
												 v261:1)
										  (@pv `,RML.array_setnth
										       v251:1
										       `2
										       `#(1
											  3.0
											  #(0))
										       v297:15
										       (lambda "sc283" (
													v266:0)
											 (@pv `,RML.array_add
											      v261:1
											      `#(1
												 3.0
												 #(0))
											      v297:15
											      (lambda "sc282" (
													       v270:0)
												(@pv `,Main.loop
												     v423:3
												     v191:3
												     v322:3
												     v297:15
												     v189:2))))))))))))))))))))))))))))))
    (else (@fc v297:15))))))))

(define (Main.print_a v195:3 v196:3 v193:0 v194:2)
  (let ((v382:1 (rml_marker)))
  (let ((v383:5 (lambda "fc384" () (begin (rml_unwind v382:1) (@sc v194:2)))))
  (@pv `,RML.array_length v195:3 v383:5
       (lambda "sc412" ( v386:1)
	 (let ((v432:1 (int_lt v196:3 v386:1)))
	 (switch v432:1
	   ((1)
	    (@pv `,RML.array_nth v195:3 v196:3 v383:5
		 (lambda "sc410" ( v396:1)
		   (@pv `,RML.debug_print `"el" v396:1 v383:5
			(lambda "sc409" ()
			  (let ((v429:1 (int_add v196:3 `1)))
			  (@pv `,Main.print_a v195:3 v429:1 v383:5 v194:2)))))))
	   (else (@fc v383:5)))))))))

(define (Main.print_array v199:1 v197:1 v198:1)
  (@pv `,Main.print_a v199:1 `0 v197:1 v198:1))

(define (Main.main v202:0 v200:4 v201:1)
  (@pv `,RML.array_create `20 `#(1 10.0 #(0)) v200:4
       (lambda "sc377" ( v354:1)
	 (@pv `,RML.array_setnth v354:1 `1 `#(1 10.0 #(0)) v200:4
	      (lambda "sc376" ( v359:2)
		(@pv `,Main.print_array v359:2 v200:4
		     (lambda "sc375" ()
		       (@pv `,Main.loop `0 `20 v359:2 v200:4 v201:1))))))))

Applying local CPS-optimizations:
(MODULE Main)
(WITH RML)
(EXPORTS Main.print_array Main.main)

(define (Main.print_a v195:3 v196:3 v193:0 v194:2)
  (let ((v382:1 (rml_marker)))
  (let ((v383:5 (lambda "fc384" () (begin (rml_unwind v382:1) (@sc v194:2)))))
  (@pv `,RML.array_length v195:3 v383:5
       (lambda "sc412" ( v386:1)
	 (let ((v432:1 (int_lt v196:3 v386:1)))
	 (switch v432:1
	   ((1)
	    (@pv `,RML.array_nth v195:3 v196:3 v383:5
		 (lambda "sc410" ( v396:1)
		   (@pv `,RML.debug_print `"el" v396:1 v383:5
			(lambda "sc409" ()
			  (let ((v429:1 (int_add v196:3 `1)))
			  (@pv `,Main.print_a v195:3 v429:1 v383:5 v194:2)))))))
	   (else (@fc v383:5)))))))))

(define (Main.loop v190:4 v191:3 v192:1 v188:1 v189:2)
  (let ((v296:1 (rml_marker)))
  (let ((v297:15
	  (lambda "fc304" ()
	    (begin
	      (rml_unwind v296:1)
	      (let ((v420:1 (int_ge v190:4 v191:3)))
	      (switch v420:1 ((1) (@sc v189:2)) (else (@fc v188:1))))))))
  (let ((v426:1 (int_lt v190:4 v191:3)))
  (switch v426:1
    ((1)
     (let ((v423:3 (int_add v190:4 `1)))
     (@pv `,RML.int_real v423:3 v297:15
	  (lambda "sc339" ( v316:1)
	    (let ((v320:1 (rml_mkstruct 1 v316:1 `#(0))))
	    (@pv `,RML.array_update v192:1 v423:3 v320:1 v297:15
		 (lambda "sc338" ( v322:3)
		   (@pv `,RML.array_nth v322:3 v190:4 v297:15
			(lambda "sc337" ( v327:1)
			  (@pv `,RML.debug_print `"\nset:" v327:1 v297:15
			       (lambda "sc336" ()
				 (@pv `,RML.array_vector v322:3 v297:15
				      (lambda "sc290" ( v223:0)
					(@pv `,RML.array_create `10
					     `#(1 10.0 #(0)) v297:15
					     (lambda "sc289" ( v227:1)
					       (@pv `,RML.list_array
						    `#(1 #(1 1.0 #(1 10.1 #(0)))
						       #(1 #(1 2.0 #(0))
							 #(1 #(1 3.0 #(0))
							   #(0)))) v297:15
						    (lambda "sc288" ( v232:1)
						      (@pv `,RML.array_setnth
							   v227:1 `1
							   `#(1 3.0 #(0))
							   v297:15
							   (lambda "sc287" (
									    v246:1)
							     (@pv `,RML.array_setnth
								  v232:1 `1
								  `#(1 3.0 #(0))
								  v297:15
								  (lambda "sc286" (
										   v251:1)
								    (@pv `,RML.array_setnth
									 v246:1
									 `2
									 `#(1
									    3.0
									    #(0))
									 v297:15
									 (lambda "sc285" (
											  v256:1)
									   (@pv `,RML.array_update
										v256:1
										`5
										`#(1
										   3.0
										   #(0))
										v297:15
										(lambda "sc284" (
												 v261:1)
										  (@pv `,RML.array_setnth
										       v251:1
										       `2
										       `#(1
											  3.0
											  #(0))
										       v297:15
										       (lambda "sc283" (
													v266:0)
											 (@pv `,RML.array_add
											      v261:1
											      `#(1
												 3.0
												 #(0))
											      v297:15
											      (lambda "sc282" (
													       v270:0)
												(@pv `,Main.loop
												     v423:3
												     v191:3
												     v322:3
												     v297:15
												     v189:2))))))))))))))))))))))))))))))
    (else (@fc v297:15)))))))

(define (Main.print_array v199:1 v197:1 v198:1)
  (@pv `,Main.print_a v199:1 `0 v197:1 v198:1))

(define (Main.main v202:0 v200:4 v201:1)
  (@pv `,RML.array_create `20 `#(1 10.0 #(0)) v200:4
       (lambda "sc377" ( v354:1)
	 (@pv `,RML.array_setnth v354:1 `1 `#(1 10.0 #(0)) v200:4
	      (lambda "sc376" ( v359:2)
		(@pv `,Main.print_array v359:2 v200:4
		     (lambda "sc375" ()
		       (@pv `,Main.loop `0 `20 v359:2 v200:4 v201:1))))))))
