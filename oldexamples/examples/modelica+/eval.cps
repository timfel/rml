
Applying local CPS-optimizations:
(MODULE Eval)
(WITH RML)
(EXPORTS Eval.eval)

(define (Eval.eval v153:11 v151:50 v152:6)
  (let ((v179:1 (fetch 0 v153:11)))
  (switch v179:1
    (((STRUCTHDR 2 1))
     (let ((v180:1 (fetch 2 v153:11)))
     (let ((v181:1 (fetch 1 v153:11)))
     (let ((v155:2 v181:1))
     (let ((v154:2 v180:1))
     (let ((v182:1
	     (lambda "sc213" ()
	       (let ((v183:1
		       (lambda "sc212" ()
			 (let ((v184:1
				 (lambda "sc211" ( v185:1)
				   (let ((v186:3 v185:1))
				   (let ((v189:1
					   (lambda "sc210" ()
					     (let ((v190:1
						     (lambda "sc209" ()
						       (let ((v191:1
							       (lambda "sc208" ()
								 (let ((v192:1
									 (lambda "sc207" (
											  v193:1)
									   (let ((v194:2
										   v193:1))
									   (let ((v197:1
										   (lambda "sc206" ()
										     (let ((v198:1
											     (lambda "sc205" ()
											       (let ((v199:1
												       (lambda "sc204" (
															v200:1)
													 (let ((v201:1
														 v200:1))
													 (@sc v152:6
													      v201:1)))))
											       (@pv `,RML.real_add
												    v186:3
												    v194:2
												    v151:50
												    v199:1)))))
										     (@pv `,RML.debug
											  `"eval.mo"
											  `22
											  `13
											  `22
											  `21
											  `"eval"
											  `"call:real_add(v1,v2) => (temp101)"
											  v151:50
											  v198:1)))))
									   (@pv `,RML.debug_push_in02
										`"v1"
										v186:3
										`"v2"
										v194:2
										v151:50
										v197:1))))))
								 (@pv `,Eval.eval
								      v154:2
								      v151:50
								      v192:1)))))
						       (@pv `,RML.debug
							    `"eval.mo" `21 `26
							    `21 `36 `"eval"
							    `"call:eval(e2) => (v2)"
							    v151:50 v191:1)))))
					     (@pv `,RML.debug_push_in01 `"e2"
						  v154:2 v151:50 v190:1)))))
				   (@pv `,RML.debug_push_out01 `"v1" v186:3
					v151:50 v189:1))))))
			 (@pv `,Eval.eval v155:2 v151:50 v184:1)))))
	       (@pv `,RML.debug `"eval.mo" `21 `11 `21 `21 `"eval"
		    `"call:eval(e1) => (v1)" v151:50 v183:1)))))
     (@pv `,RML.debug_push_in01 `"e1" v155:2 v151:50 v182:1)))))))
    (((STRUCTHDR 2 3))
     (let ((v214:1 (fetch 2 v153:11)))
     (let ((v215:1 (fetch 1 v153:11)))
     (let ((v157:2 v215:1))
     (let ((v156:2 v214:1))
     (let ((v216:1
	     (lambda "sc247" ()
	       (let ((v217:1
		       (lambda "sc246" ()
			 (let ((v218:1
				 (lambda "sc245" ( v219:1)
				   (let ((v220:3 v219:1))
				   (let ((v223:1
					   (lambda "sc244" ()
					     (let ((v224:1
						     (lambda "sc243" ()
						       (let ((v225:1
							       (lambda "sc242" ()
								 (let ((v226:1
									 (lambda "sc241" (
											  v227:1)
									   (let ((v228:2
										   v227:1))
									   (let ((v231:1
										   (lambda "sc240" ()
										     (let ((v232:1
											     (lambda "sc239" ()
											       (let ((v233:1
												       (lambda "sc238" (
															v234:1)
													 (let ((v235:1
														 v234:1))
													 (@sc v152:6
													      v235:1)))))
											       (@pv `,RML.real_mul
												    v220:3
												    v228:2
												    v151:50
												    v233:1)))))
										     (@pv `,RML.debug
											  `"eval.mo"
											  `28
											  `13
											  `28
											  `21
											  `"eval"
											  `"call:real_mul(v1,v2) => (temp103)"
											  v151:50
											  v232:1)))))
									   (@pv `,RML.debug_push_in02
										`"v1"
										v220:3
										`"v2"
										v228:2
										v151:50
										v231:1))))))
								 (@pv `,Eval.eval
								      v156:2
								      v151:50
								      v226:1)))))
						       (@pv `,RML.debug
							    `"eval.mo" `27 `26
							    `27 `36 `"eval"
							    `"call:eval(e2) => (v2)"
							    v151:50 v225:1)))))
					     (@pv `,RML.debug_push_in01 `"e2"
						  v156:2 v151:50 v224:1)))))
				   (@pv `,RML.debug_push_out01 `"v1" v220:3
					v151:50 v223:1))))))
			 (@pv `,Eval.eval v157:2 v151:50 v218:1)))))
	       (@pv `,RML.debug `"eval.mo" `27 `11 `27 `21 `"eval"
		    `"call:eval(e1) => (v1)" v151:50 v217:1)))))
     (@pv `,RML.debug_push_in01 `"e1" v157:2 v151:50 v216:1)))))))
    (((STRUCTHDR 1 5))
     (let ((v248:1 (fetch 1 v153:11)))
     (let ((v158:2 v248:1))
     (let ((v249:1
	     (lambda "sc270" ()
	       (let ((v250:1
		       (lambda "sc269" ()
			 (let ((v251:1
				 (lambda "sc268" ( v252:1)
				   (let ((v253:3 v252:1))
				   (let ((v256:1
					   (lambda "sc267" ()
					     (let ((v257:1
						     (lambda "sc266" ()
						       (let ((v258:1
							       (lambda "sc265" ()
								 (let ((v259:1
									 (lambda "sc264" (
											  v260:1)
									   (let ((v261:1
										   v260:1))
									   (@sc v152:6
										v261:1)))))
								 (@pv `,RML.real_neg
								      v253:3
								      v151:50
								      v259:1)))))
						       (@pv `,RML.debug
							    `"eval.mo" `34 `13
							    `34 `18 `"eval"
							    `"call:real_neg(v1) => (temp105)"
							    v151:50 v258:1)))))
					     (@pv `,RML.debug_push_in01 `"v1"
						  v253:3 v151:50 v257:1)))))
				   (@pv `,RML.debug_push_out01 `"v1" v253:3
					v151:50 v256:1))))))
			 (@pv `,Eval.eval v158:2 v151:50 v251:1)))))
	       (@pv `,RML.debug `"eval.mo" `33 `11 `33 `21 `"eval"
		    `"call:eval(e1) => (v1)" v151:50 v250:1)))))
     (@pv `,RML.debug_push_in01 `"e1" v158:2 v151:50 v249:1)))))
    (((STRUCTHDR 2 4))
     (let ((v271:1 (fetch 2 v153:11)))
     (let ((v272:1 (fetch 1 v153:11)))
     (let ((v160:2 v272:1))
     (let ((v159:2 v271:1))
     (let ((v273:1
	     (lambda "sc304" ()
	       (let ((v274:1
		       (lambda "sc303" ()
			 (let ((v275:1
				 (lambda "sc302" ( v276:1)
				   (let ((v277:3 v276:1))
				   (let ((v280:1
					   (lambda "sc301" ()
					     (let ((v281:1
						     (lambda "sc300" ()
						       (let ((v282:1
							       (lambda "sc299" ()
								 (let ((v283:1
									 (lambda "sc298" (
											  v284:1)
									   (let ((v285:2
										   v284:1))
									   (let ((v288:1
										   (lambda "sc297" ()
										     (let ((v289:1
											     (lambda "sc296" ()
											       (let ((v290:1
												       (lambda "sc295" (
															v291:1)
													 (let ((v292:1
														 v291:1))
													 (@sc v152:6
													      v292:1)))))
											       (@pv `,RML.real_div
												    v277:3
												    v285:2
												    v151:50
												    v290:1)))))
										     (@pv `,RML.debug
											  `"eval.mo"
											  `31
											  `13
											  `31
											  `21
											  `"eval"
											  `"call:real_div(v1,v2) => (temp104)"
											  v151:50
											  v289:1)))))
									   (@pv `,RML.debug_push_in02
										`"v1"
										v277:3
										`"v2"
										v285:2
										v151:50
										v288:1))))))
								 (@pv `,Eval.eval
								      v159:2
								      v151:50
								      v283:1)))))
						       (@pv `,RML.debug
							    `"eval.mo" `30 `26
							    `30 `36 `"eval"
							    `"call:eval(e2) => (v2)"
							    v151:50 v282:1)))))
					     (@pv `,RML.debug_push_in01 `"e2"
						  v159:2 v151:50 v281:1)))))
				   (@pv `,RML.debug_push_out01 `"v1" v277:3
					v151:50 v280:1))))))
			 (@pv `,Eval.eval v160:2 v151:50 v275:1)))))
	       (@pv `,RML.debug `"eval.mo" `30 `11 `30 `21 `"eval"
		    `"call:eval(e1) => (v1)" v151:50 v274:1)))))
     (@pv `,RML.debug_push_in01 `"e1" v160:2 v151:50 v273:1)))))))
    (((STRUCTHDR 2 2))
     (let ((v305:1 (fetch 2 v153:11)))
     (let ((v306:1 (fetch 1 v153:11)))
     (let ((v162:2 v306:1))
     (let ((v161:2 v305:1))
     (let ((v307:1
	     (lambda "sc338" ()
	       (let ((v308:1
		       (lambda "sc337" ()
			 (let ((v309:1
				 (lambda "sc336" ( v310:1)
				   (let ((v311:3 v310:1))
				   (let ((v314:1
					   (lambda "sc335" ()
					     (let ((v315:1
						     (lambda "sc334" ()
						       (let ((v316:1
							       (lambda "sc333" ()
								 (let ((v317:1
									 (lambda "sc332" (
											  v318:1)
									   (let ((v319:2
										   v318:1))
									   (let ((v322:1
										   (lambda "sc331" ()
										     (let ((v323:1
											     (lambda "sc330" ()
											       (let ((v324:1
												       (lambda "sc329" (
															v325:1)
													 (let ((v326:1
														 v325:1))
													 (@sc v152:6
													      v326:1)))))
											       (@pv `,RML.real_sub
												    v311:3
												    v319:2
												    v151:50
												    v324:1)))))
										     (@pv `,RML.debug
											  `"eval.mo"
											  `25
											  `13
											  `25
											  `21
											  `"eval"
											  `"call:real_sub(v1,v2) => (temp102)"
											  v151:50
											  v323:1)))))
									   (@pv `,RML.debug_push_in02
										`"v1"
										v311:3
										`"v2"
										v319:2
										v151:50
										v322:1))))))
								 (@pv `,Eval.eval
								      v161:2
								      v151:50
								      v317:1)))))
						       (@pv `,RML.debug
							    `"eval.mo" `24 `26
							    `24 `36 `"eval"
							    `"call:eval(e2) => (v2)"
							    v151:50 v316:1)))))
					     (@pv `,RML.debug_push_in01 `"e2"
						  v161:2 v151:50 v315:1)))))
				   (@pv `,RML.debug_push_out01 `"v1" v311:3
					v151:50 v314:1))))))
			 (@pv `,Eval.eval v162:2 v151:50 v309:1)))))
	       (@pv `,RML.debug `"eval.mo" `24 `11 `24 `21 `"eval"
		    `"call:eval(e1) => (v1)" v151:50 v308:1)))))
     (@pv `,RML.debug_push_in01 `"e1" v162:2 v151:50 v307:1)))))))
    (((STRUCTHDR 1 0))
     (let ((v339:1 (fetch 1 v153:11)))
     (let ((v163:3 v339:1))
     (let ((v340:1
	     (lambda "sc345" ()
	       (let ((v341:1
		       (lambda "sc344" ()
			 (let ((v342:1 (lambda "sc343" () (@sc v152:6 v163:3))))
			 (@pv `,RML.debug_push_out01 `"v1" v163:3 v151:50
			      v342:1)))))
	       (@pv `,RML.debug `"eval.mo" `19 `26 `19 `28 `"eval"
		    `"axiom:eval(RCONST(v1)) => (v1)" v151:50 v341:1)))))
     (@pv `,RML.debug_push_in01 `"v1" v163:3 v151:50 v340:1))))))))

Applying local CPS-optimizations:
(MODULE Eval)
(WITH RML)
(EXPORTS Eval.eval)

(define (Eval.eval v153:11 v151:50 v152:6)
  (let ((v179:1 (fetch 0 v153:11)))
  (switch v179:1
    (((STRUCTHDR 2 1))
     (let ((v180:2 (fetch 2 v153:11)))
     (let ((v181:2 (fetch 1 v153:11)))
     (@pv `,RML.debug_push_in01 `"e1" v181:2 v151:50
	  (lambda "sc213" ()
	    (@pv `,RML.debug `"eval.mo" `21 `11 `21 `21 `"eval"
		 `"call:eval(e1) => (v1)" v151:50
		 (lambda "sc212" ()
		   (@pv `,Eval.eval v181:2 v151:50
			(lambda "sc211" ( v185:3)
			  (@pv `,RML.debug_push_out01 `"v1" v185:3 v151:50
			       (lambda "sc210" ()
				 (@pv `,RML.debug_push_in01 `"e2" v180:2 v151:50
				      (lambda "sc209" ()
					(@pv `,RML.debug `"eval.mo" `21 `26 `21
					     `36 `"eval"
					     `"call:eval(e2) => (v2)" v151:50
					     (lambda "sc208" ()
					       (@pv `,Eval.eval v180:2 v151:50
						    (lambda "sc207" ( v193:2)
						      (@pv `,RML.debug_push_in02
							   `"v1" v185:3 `"v2"
							   v193:2 v151:50
							   (lambda "sc206" ()
							     (@pv `,RML.debug
								  `"eval.mo" `22
								  `13 `22 `21
								  `"eval"
								  `"call:real_add(v1,v2) => (temp101)"
								  v151:50
								  (lambda "sc205" ()
								    (@pv `,RML.real_add
									 v185:3
									 v193:2
									 v151:50
									 v152:6))))))))))))))))))))))
    (((STRUCTHDR 2 3))
     (let ((v214:2 (fetch 2 v153:11)))
     (let ((v215:2 (fetch 1 v153:11)))
     (@pv `,RML.debug_push_in01 `"e1" v215:2 v151:50
	  (lambda "sc247" ()
	    (@pv `,RML.debug `"eval.mo" `27 `11 `27 `21 `"eval"
		 `"call:eval(e1) => (v1)" v151:50
		 (lambda "sc246" ()
		   (@pv `,Eval.eval v215:2 v151:50
			(lambda "sc245" ( v219:3)
			  (@pv `,RML.debug_push_out01 `"v1" v219:3 v151:50
			       (lambda "sc244" ()
				 (@pv `,RML.debug_push_in01 `"e2" v214:2 v151:50
				      (lambda "sc243" ()
					(@pv `,RML.debug `"eval.mo" `27 `26 `27
					     `36 `"eval"
					     `"call:eval(e2) => (v2)" v151:50
					     (lambda "sc242" ()
					       (@pv `,Eval.eval v214:2 v151:50
						    (lambda "sc241" ( v227:2)
						      (@pv `,RML.debug_push_in02
							   `"v1" v219:3 `"v2"
							   v227:2 v151:50
							   (lambda "sc240" ()
							     (@pv `,RML.debug
								  `"eval.mo" `28
								  `13 `28 `21
								  `"eval"
								  `"call:real_mul(v1,v2) => (temp103)"
								  v151:50
								  (lambda "sc239" ()
								    (@pv `,RML.real_mul
									 v219:3
									 v227:2
									 v151:50
									 v152:6))))))))))))))))))))))
    (((STRUCTHDR 1 5))
     (let ((v248:2 (fetch 1 v153:11)))
     (@pv `,RML.debug_push_in01 `"e1" v248:2 v151:50
	  (lambda "sc270" ()
	    (@pv `,RML.debug `"eval.mo" `33 `11 `33 `21 `"eval"
		 `"call:eval(e1) => (v1)" v151:50
		 (lambda "sc269" ()
		   (@pv `,Eval.eval v248:2 v151:50
			(lambda "sc268" ( v252:3)
			  (@pv `,RML.debug_push_out01 `"v1" v252:3 v151:50
			       (lambda "sc267" ()
				 (@pv `,RML.debug_push_in01 `"v1" v252:3 v151:50
				      (lambda "sc266" ()
					(@pv `,RML.debug `"eval.mo" `34 `13 `34
					     `18 `"eval"
					     `"call:real_neg(v1) => (temp105)"
					     v151:50
					     (lambda "sc265" ()
					       (@pv `,RML.real_neg v252:3
						    v151:50
						    v152:6)))))))))))))))
    (((STRUCTHDR 2 4))
     (let ((v271:2 (fetch 2 v153:11)))
     (let ((v272:2 (fetch 1 v153:11)))
     (@pv `,RML.debug_push_in01 `"e1" v272:2 v151:50
	  (lambda "sc304" ()
	    (@pv `,RML.debug `"eval.mo" `30 `11 `30 `21 `"eval"
		 `"call:eval(e1) => (v1)" v151:50
		 (lambda "sc303" ()
		   (@pv `,Eval.eval v272:2 v151:50
			(lambda "sc302" ( v276:3)
			  (@pv `,RML.debug_push_out01 `"v1" v276:3 v151:50
			       (lambda "sc301" ()
				 (@pv `,RML.debug_push_in01 `"e2" v271:2 v151:50
				      (lambda "sc300" ()
					(@pv `,RML.debug `"eval.mo" `30 `26 `30
					     `36 `"eval"
					     `"call:eval(e2) => (v2)" v151:50
					     (lambda "sc299" ()
					       (@pv `,Eval.eval v271:2 v151:50
						    (lambda "sc298" ( v284:2)
						      (@pv `,RML.debug_push_in02
							   `"v1" v276:3 `"v2"
							   v284:2 v151:50
							   (lambda "sc297" ()
							     (@pv `,RML.debug
								  `"eval.mo" `31
								  `13 `31 `21
								  `"eval"
								  `"call:real_div(v1,v2) => (temp104)"
								  v151:50
								  (lambda "sc296" ()
								    (@pv `,RML.real_div
									 v276:3
									 v284:2
									 v151:50
									 v152:6))))))))))))))))))))))
    (((STRUCTHDR 2 2))
     (let ((v305:2 (fetch 2 v153:11)))
     (let ((v306:2 (fetch 1 v153:11)))
     (@pv `,RML.debug_push_in01 `"e1" v306:2 v151:50
	  (lambda "sc338" ()
	    (@pv `,RML.debug `"eval.mo" `24 `11 `24 `21 `"eval"
		 `"call:eval(e1) => (v1)" v151:50
		 (lambda "sc337" ()
		   (@pv `,Eval.eval v306:2 v151:50
			(lambda "sc336" ( v310:3)
			  (@pv `,RML.debug_push_out01 `"v1" v310:3 v151:50
			       (lambda "sc335" ()
				 (@pv `,RML.debug_push_in01 `"e2" v305:2 v151:50
				      (lambda "sc334" ()
					(@pv `,RML.debug `"eval.mo" `24 `26 `24
					     `36 `"eval"
					     `"call:eval(e2) => (v2)" v151:50
					     (lambda "sc333" ()
					       (@pv `,Eval.eval v305:2 v151:50
						    (lambda "sc332" ( v318:2)
						      (@pv `,RML.debug_push_in02
							   `"v1" v310:3 `"v2"
							   v318:2 v151:50
							   (lambda "sc331" ()
							     (@pv `,RML.debug
								  `"eval.mo" `25
								  `13 `25 `21
								  `"eval"
								  `"call:real_sub(v1,v2) => (temp102)"
								  v151:50
								  (lambda "sc330" ()
								    (@pv `,RML.real_sub
									 v310:3
									 v318:2
									 v151:50
									 v152:6))))))))))))))))))))))
    (((STRUCTHDR 1 0))
     (let ((v339:3 (fetch 1 v153:11)))
     (@pv `,RML.debug_push_in01 `"v1" v339:3 v151:50
	  (lambda "sc345" ()
	    (@pv `,RML.debug `"eval.mo" `19 `26 `19 `28 `"eval"
		 `"axiom:eval(RCONST(v1)) => (v1)" v151:50
		 (lambda "sc344" ()
		   (@pv `,RML.debug_push_out01 `"v1" v339:3 v151:50
			(lambda "sc343" () (@sc v152:6 v339:3))))))))))))
