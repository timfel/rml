
Applying local CPS-optimizations:
(MODULE exp1)
(WITH RML)
(EXPORTS exp1.eval)

(define (exp1.eval v148:11 v146:54 v147:6)
  (let ((v174:1 (fetch 0 v148:11)))
  (switch v174:1
    (((STRUCTHDR 2 1))
     (let ((v175:1 (fetch 2 v148:11)))
     (let ((v176:1 (fetch 1 v148:11)))
     (let ((v150:2 v176:1))
     (let ((v149:2 v175:1))
     (let ((v177:1
	     (lambda "sc210" ()
	       (let ((v178:1
		       (lambda "sc209" ()
			 (let ((v179:1
				 (lambda "sc208" ( v180:1)
				   (let ((v181:3 v180:1))
				   (let ((v184:1
					   (lambda "sc207" ()
					     (let ((v185:1
						     (lambda "sc206" ()
						       (let ((v186:1
							       (lambda "sc205" ()
								 (let ((v187:1
									 (lambda "sc204" (
											  v188:1)
									   (let ((v189:3
										   v188:1))
									   (let ((v192:1
										   (lambda "sc203" ()
										     (let ((v193:1
											     (lambda "sc202" ()
											       (let ((v194:1
												       (lambda "sc201" ()
													 (let ((v195:1
														 (lambda "sc200" (
																  v196:1)
														   (let ((v197:1
															   v196:1))
														   (@sc v147:6
															v197:1)))))
													 (@pv `,RML.real_add
													      v181:3
													      v189:3
													      v146:54
													      v195:1)))))
											       (@pv `,RML.debug
												    `"exp1.rml"
												    `28
												    `45
												    `28
												    `58
												    `"eval"
												    `"call:RML.real_add(v1,v2) => (v3)"
												    v146:54
												    v194:1)))))
										     (@pv `,RML.debug_push_in02
											  `"v1"
											  v181:3
											  `"v2"
											  v189:3
											  v146:54
											  v193:1)))))
									   (@pv `,RML.debug_push_out01
										`"v2"
										v189:3
										v146:54
										v192:1))))))
								 (@pv `,exp1.eval
								      v149:2
								      v146:54
								      v187:1)))))
						       (@pv `,RML.debug
							    `"exp1.rml" `28 `27
							    `28 `33 `"eval"
							    `"call:eval(e2) => (v2)"
							    v146:54 v186:1)))))
					     (@pv `,RML.debug_push_in01 `"e2"
						  v149:2 v146:54 v185:1)))))
				   (@pv `,RML.debug_push_out01 `"v1" v181:3
					v146:54 v184:1))))))
			 (@pv `,exp1.eval v150:2 v146:54 v179:1)))))
	       (@pv `,RML.debug `"exp1.rml" `28 `9 `28 `15 `"eval"
		    `"call:eval(e1) => (v1)" v146:54 v178:1)))))
     (@pv `,RML.debug_push_in01 `"e1" v150:2 v146:54 v177:1)))))))
    (((STRUCTHDR 2 3))
     (let ((v211:1 (fetch 2 v148:11)))
     (let ((v212:1 (fetch 1 v148:11)))
     (let ((v152:2 v212:1))
     (let ((v151:2 v211:1))
     (let ((v213:1
	     (lambda "sc246" ()
	       (let ((v214:1
		       (lambda "sc245" ()
			 (let ((v215:1
				 (lambda "sc244" ( v216:1)
				   (let ((v217:3 v216:1))
				   (let ((v220:1
					   (lambda "sc243" ()
					     (let ((v221:1
						     (lambda "sc242" ()
						       (let ((v222:1
							       (lambda "sc241" ()
								 (let ((v223:1
									 (lambda "sc240" (
											  v224:1)
									   (let ((v225:3
										   v224:1))
									   (let ((v228:1
										   (lambda "sc239" ()
										     (let ((v229:1
											     (lambda "sc238" ()
											       (let ((v230:1
												       (lambda "sc237" ()
													 (let ((v231:1
														 (lambda "sc236" (
																  v232:1)
														   (let ((v233:1
															   v232:1))
														   (@sc v147:6
															v233:1)))))
													 (@pv `,RML.real_mul
													      v217:3
													      v225:3
													      v146:54
													      v231:1)))))
											       (@pv `,RML.debug
												    `"exp1.rml"
												    `36
												    `47
												    `36
												    `60
												    `"eval"
												    `"call:RML.real_mul(v1,v2) => (v3)"
												    v146:54
												    v230:1)))))
										     (@pv `,RML.debug_push_in02
											  `"v1"
											  v217:3
											  `"v2"
											  v225:3
											  v146:54
											  v229:1)))))
									   (@pv `,RML.debug_push_out01
										`"v2"
										v225:3
										v146:54
										v228:1))))))
								 (@pv `,exp1.eval
								      v151:2
								      v146:54
								      v223:1)))))
						       (@pv `,RML.debug
							    `"exp1.rml" `36 `28
							    `36 `35 `"eval"
							    `"call:eval(e2) => (v2)"
							    v146:54 v222:1)))))
					     (@pv `,RML.debug_push_in01 `"e2"
						  v151:2 v146:54 v221:1)))))
				   (@pv `,RML.debug_push_out01 `"v1" v217:3
					v146:54 v220:1))))))
			 (@pv `,exp1.eval v152:2 v146:54 v215:1)))))
	       (@pv `,RML.debug `"exp1.rml" `36 `9 `36 `16 `"eval"
		    `"call:eval(e1) => (v1)" v146:54 v214:1)))))
     (@pv `,RML.debug_push_in01 `"e1" v152:2 v146:54 v213:1)))))))
    (((STRUCTHDR 1 5))
     (let ((v247:1 (fetch 1 v148:11)))
     (let ((v153:2 v247:1))
     (let ((v248:1
	     (lambda "sc269" ()
	       (let ((v249:1
		       (lambda "sc268" ()
			 (let ((v250:1
				 (lambda "sc267" ( v251:1)
				   (let ((v252:3 v251:1))
				   (let ((v255:1
					   (lambda "sc266" ()
					     (let ((v256:1
						     (lambda "sc265" ()
						       (let ((v257:1
							       (lambda "sc264" ()
								 (let ((v258:1
									 (lambda "sc263" (
											  v259:1)
									   (let ((v260:1
										   v259:1))
									   (@sc v147:6
										v260:1)))))
								 (@pv `,RML.real_neg
								      v252:3
								      v146:54
								      v258:1)))))
						       (@pv `,RML.debug
							    `"exp1.rml" `44 `27
							    `44 `36 `"eval"
							    `"call:RML.real_neg(v1) => (v2)"
							    v146:54 v257:1)))))
					     (@pv `,RML.debug_push_in01 `"v1"
						  v252:3 v146:54 v256:1)))))
				   (@pv `,RML.debug_push_out01 `"v1" v252:3
					v146:54 v255:1))))))
			 (@pv `,exp1.eval v153:2 v146:54 v250:1)))))
	       (@pv `,RML.debug `"exp1.rml" `44 `9 `44 `15 `"eval"
		    `"call:eval(e) => (v1)" v146:54 v249:1)))))
     (@pv `,RML.debug_push_in01 `"e" v153:2 v146:54 v248:1)))))
    (((STRUCTHDR 2 4))
     (let ((v270:1 (fetch 2 v148:11)))
     (let ((v271:1 (fetch 1 v148:11)))
     (let ((v155:2 v271:1))
     (let ((v154:2 v270:1))
     (let ((v272:1
	     (lambda "sc305" ()
	       (let ((v273:1
		       (lambda "sc304" ()
			 (let ((v274:1
				 (lambda "sc303" ( v275:1)
				   (let ((v276:3 v275:1))
				   (let ((v279:1
					   (lambda "sc302" ()
					     (let ((v280:1
						     (lambda "sc301" ()
						       (let ((v281:1
							       (lambda "sc300" ()
								 (let ((v282:1
									 (lambda "sc299" (
											  v283:1)
									   (let ((v284:3
										   v283:1))
									   (let ((v287:1
										   (lambda "sc298" ()
										     (let ((v288:1
											     (lambda "sc297" ()
											       (let ((v289:1
												       (lambda "sc296" ()
													 (let ((v290:1
														 (lambda "sc295" (
																  v291:1)
														   (let ((v292:1
															   v291:1))
														   (@sc v147:6
															v292:1)))))
													 (@pv `,RML.real_div
													      v276:3
													      v284:3
													      v146:54
													      v290:1)))))
											       (@pv `,RML.debug
												    `"exp1.rml"
												    `40
												    `47
												    `40
												    `60
												    `"eval"
												    `"call:RML.real_div(v1,v2) => (v3)"
												    v146:54
												    v289:1)))))
										     (@pv `,RML.debug_push_in02
											  `"v1"
											  v276:3
											  `"v2"
											  v284:3
											  v146:54
											  v288:1)))))
									   (@pv `,RML.debug_push_out01
										`"v2"
										v284:3
										v146:54
										v287:1))))))
								 (@pv `,exp1.eval
								      v154:2
								      v146:54
								      v282:1)))))
						       (@pv `,RML.debug
							    `"exp1.rml" `40 `28
							    `40 `35 `"eval"
							    `"call:eval(e2) => (v2)"
							    v146:54 v281:1)))))
					     (@pv `,RML.debug_push_in01 `"e2"
						  v154:2 v146:54 v280:1)))))
				   (@pv `,RML.debug_push_out01 `"v1" v276:3
					v146:54 v279:1))))))
			 (@pv `,exp1.eval v155:2 v146:54 v274:1)))))
	       (@pv `,RML.debug `"exp1.rml" `40 `9 `40 `16 `"eval"
		    `"call:eval(e1) => (v1)" v146:54 v273:1)))))
     (@pv `,RML.debug_push_in01 `"e1" v155:2 v146:54 v272:1)))))))
    (((STRUCTHDR 2 2))
     (let ((v306:1 (fetch 2 v148:11)))
     (let ((v307:1 (fetch 1 v148:11)))
     (let ((v157:2 v307:1))
     (let ((v156:2 v306:1))
     (let ((v308:1
	     (lambda "sc341" ()
	       (let ((v309:1
		       (lambda "sc340" ()
			 (let ((v310:1
				 (lambda "sc339" ( v311:1)
				   (let ((v312:3 v311:1))
				   (let ((v315:1
					   (lambda "sc338" ()
					     (let ((v316:1
						     (lambda "sc337" ()
						       (let ((v317:1
							       (lambda "sc336" ()
								 (let ((v318:1
									 (lambda "sc335" (
											  v319:1)
									   (let ((v320:3
										   v319:1))
									   (let ((v323:1
										   (lambda "sc334" ()
										     (let ((v324:1
											     (lambda "sc333" ()
											       (let ((v325:1
												       (lambda "sc332" ()
													 (let ((v326:1
														 (lambda "sc331" (
																  v327:1)
														   (let ((v328:1
															   v327:1))
														   (@sc v147:6
															v328:1)))))
													 (@pv `,RML.real_sub
													      v312:3
													      v320:3
													      v146:54
													      v326:1)))))
											       (@pv `,RML.debug
												    `"exp1.rml"
												    `32
												    `47
												    `32
												    `60
												    `"eval"
												    `"call:RML.real_sub(v1,v2) => (v3)"
												    v146:54
												    v325:1)))))
										     (@pv `,RML.debug_push_in02
											  `"v1"
											  v312:3
											  `"v2"
											  v320:3
											  v146:54
											  v324:1)))))
									   (@pv `,RML.debug_push_out01
										`"v2"
										v320:3
										v146:54
										v323:1))))))
								 (@pv `,exp1.eval
								      v156:2
								      v146:54
								      v318:1)))))
						       (@pv `,RML.debug
							    `"exp1.rml" `32 `28
							    `32 `35 `"eval"
							    `"call:eval(e2) => (v2)"
							    v146:54 v317:1)))))
					     (@pv `,RML.debug_push_in01 `"e2"
						  v156:2 v146:54 v316:1)))))
				   (@pv `,RML.debug_push_out01 `"v1" v312:3
					v146:54 v315:1))))))
			 (@pv `,exp1.eval v157:2 v146:54 v310:1)))))
	       (@pv `,RML.debug `"exp1.rml" `32 `9 `32 `16 `"eval"
		    `"call:eval(e1) => (v1)" v146:54 v309:1)))))
     (@pv `,RML.debug_push_in01 `"e1" v157:2 v146:54 v308:1)))))))
    (((STRUCTHDR 1 0))
     (let ((v342:1 (fetch 1 v148:11)))
     (let ((v158:3 v342:1))
     (let ((v343:1
	     (lambda "sc348" ()
	       (let ((v344:1
		       (lambda "sc347" ()
			 (let ((v345:1 (lambda "sc346" () (@sc v147:6 v158:3))))
			 (@pv `,RML.debug_push_out01 `"ival" v158:3 v146:54
			      v345:1)))))
	       (@pv `,RML.debug `"exp1.rml" `20 `3 `20 `36 `"eval"
		    `"axiom:eval(RCONST(ival)) => (ival)" v146:54 v344:1)))))
     (@pv `,RML.debug_push_in01 `"ival" v158:3 v146:54 v343:1))))))))

Applying local CPS-optimizations:
(MODULE exp1)
(WITH RML)
(EXPORTS exp1.eval)

(define (exp1.eval v148:11 v146:54 v147:6)
  (let ((v174:1 (fetch 0 v148:11)))
  (switch v174:1
    (((STRUCTHDR 2 1))
     (let ((v175:2 (fetch 2 v148:11)))
     (let ((v176:2 (fetch 1 v148:11)))
     (@pv `,RML.debug_push_in01 `"e1" v176:2 v146:54
	  (lambda "sc210" ()
	    (@pv `,RML.debug `"exp1.rml" `28 `9 `28 `15 `"eval"
		 `"call:eval(e1) => (v1)" v146:54
		 (lambda "sc209" ()
		   (@pv `,exp1.eval v176:2 v146:54
			(lambda "sc208" ( v180:3)
			  (@pv `,RML.debug_push_out01 `"v1" v180:3 v146:54
			       (lambda "sc207" ()
				 (@pv `,RML.debug_push_in01 `"e2" v175:2 v146:54
				      (lambda "sc206" ()
					(@pv `,RML.debug `"exp1.rml" `28 `27 `28
					     `33 `"eval"
					     `"call:eval(e2) => (v2)" v146:54
					     (lambda "sc205" ()
					       (@pv `,exp1.eval v175:2 v146:54
						    (lambda "sc204" ( v188:3)
						      (@pv `,RML.debug_push_out01
							   `"v2" v188:3 v146:54
							   (lambda "sc203" ()
							     (@pv `,RML.debug_push_in02
								  `"v1" v180:3
								  `"v2" v188:3
								  v146:54
								  (lambda "sc202" ()
								    (@pv `,RML.debug
									 `"exp1.rml"
									 `28 `45
									 `28 `58
									 `"eval"
									 `"call:RML.real_add(v1,v2) => (v3)"
									 v146:54
									 (lambda "sc201" ()
									   (@pv `,RML.real_add
										v180:3
										v188:3
										v146:54
										v147:6))))))))))))))))))))))))
    (((STRUCTHDR 2 3))
     (let ((v211:2 (fetch 2 v148:11)))
     (let ((v212:2 (fetch 1 v148:11)))
     (@pv `,RML.debug_push_in01 `"e1" v212:2 v146:54
	  (lambda "sc246" ()
	    (@pv `,RML.debug `"exp1.rml" `36 `9 `36 `16 `"eval"
		 `"call:eval(e1) => (v1)" v146:54
		 (lambda "sc245" ()
		   (@pv `,exp1.eval v212:2 v146:54
			(lambda "sc244" ( v216:3)
			  (@pv `,RML.debug_push_out01 `"v1" v216:3 v146:54
			       (lambda "sc243" ()
				 (@pv `,RML.debug_push_in01 `"e2" v211:2 v146:54
				      (lambda "sc242" ()
					(@pv `,RML.debug `"exp1.rml" `36 `28 `36
					     `35 `"eval"
					     `"call:eval(e2) => (v2)" v146:54
					     (lambda "sc241" ()
					       (@pv `,exp1.eval v211:2 v146:54
						    (lambda "sc240" ( v224:3)
						      (@pv `,RML.debug_push_out01
							   `"v2" v224:3 v146:54
							   (lambda "sc239" ()
							     (@pv `,RML.debug_push_in02
								  `"v1" v216:3
								  `"v2" v224:3
								  v146:54
								  (lambda "sc238" ()
								    (@pv `,RML.debug
									 `"exp1.rml"
									 `36 `47
									 `36 `60
									 `"eval"
									 `"call:RML.real_mul(v1,v2) => (v3)"
									 v146:54
									 (lambda "sc237" ()
									   (@pv `,RML.real_mul
										v216:3
										v224:3
										v146:54
										v147:6))))))))))))))))))))))))
    (((STRUCTHDR 1 5))
     (let ((v247:2 (fetch 1 v148:11)))
     (@pv `,RML.debug_push_in01 `"e" v247:2 v146:54
	  (lambda "sc269" ()
	    (@pv `,RML.debug `"exp1.rml" `44 `9 `44 `15 `"eval"
		 `"call:eval(e) => (v1)" v146:54
		 (lambda "sc268" ()
		   (@pv `,exp1.eval v247:2 v146:54
			(lambda "sc267" ( v251:3)
			  (@pv `,RML.debug_push_out01 `"v1" v251:3 v146:54
			       (lambda "sc266" ()
				 (@pv `,RML.debug_push_in01 `"v1" v251:3 v146:54
				      (lambda "sc265" ()
					(@pv `,RML.debug `"exp1.rml" `44 `27 `44
					     `36 `"eval"
					     `"call:RML.real_neg(v1) => (v2)"
					     v146:54
					     (lambda "sc264" ()
					       (@pv `,RML.real_neg v251:3
						    v146:54
						    v147:6)))))))))))))))
    (((STRUCTHDR 2 4))
     (let ((v270:2 (fetch 2 v148:11)))
     (let ((v271:2 (fetch 1 v148:11)))
     (@pv `,RML.debug_push_in01 `"e1" v271:2 v146:54
	  (lambda "sc305" ()
	    (@pv `,RML.debug `"exp1.rml" `40 `9 `40 `16 `"eval"
		 `"call:eval(e1) => (v1)" v146:54
		 (lambda "sc304" ()
		   (@pv `,exp1.eval v271:2 v146:54
			(lambda "sc303" ( v275:3)
			  (@pv `,RML.debug_push_out01 `"v1" v275:3 v146:54
			       (lambda "sc302" ()
				 (@pv `,RML.debug_push_in01 `"e2" v270:2 v146:54
				      (lambda "sc301" ()
					(@pv `,RML.debug `"exp1.rml" `40 `28 `40
					     `35 `"eval"
					     `"call:eval(e2) => (v2)" v146:54
					     (lambda "sc300" ()
					       (@pv `,exp1.eval v270:2 v146:54
						    (lambda "sc299" ( v283:3)
						      (@pv `,RML.debug_push_out01
							   `"v2" v283:3 v146:54
							   (lambda "sc298" ()
							     (@pv `,RML.debug_push_in02
								  `"v1" v275:3
								  `"v2" v283:3
								  v146:54
								  (lambda "sc297" ()
								    (@pv `,RML.debug
									 `"exp1.rml"
									 `40 `47
									 `40 `60
									 `"eval"
									 `"call:RML.real_div(v1,v2) => (v3)"
									 v146:54
									 (lambda "sc296" ()
									   (@pv `,RML.real_div
										v275:3
										v283:3
										v146:54
										v147:6))))))))))))))))))))))))
    (((STRUCTHDR 2 2))
     (let ((v306:2 (fetch 2 v148:11)))
     (let ((v307:2 (fetch 1 v148:11)))
     (@pv `,RML.debug_push_in01 `"e1" v307:2 v146:54
	  (lambda "sc341" ()
	    (@pv `,RML.debug `"exp1.rml" `32 `9 `32 `16 `"eval"
		 `"call:eval(e1) => (v1)" v146:54
		 (lambda "sc340" ()
		   (@pv `,exp1.eval v307:2 v146:54
			(lambda "sc339" ( v311:3)
			  (@pv `,RML.debug_push_out01 `"v1" v311:3 v146:54
			       (lambda "sc338" ()
				 (@pv `,RML.debug_push_in01 `"e2" v306:2 v146:54
				      (lambda "sc337" ()
					(@pv `,RML.debug `"exp1.rml" `32 `28 `32
					     `35 `"eval"
					     `"call:eval(e2) => (v2)" v146:54
					     (lambda "sc336" ()
					       (@pv `,exp1.eval v306:2 v146:54
						    (lambda "sc335" ( v319:3)
						      (@pv `,RML.debug_push_out01
							   `"v2" v319:3 v146:54
							   (lambda "sc334" ()
							     (@pv `,RML.debug_push_in02
								  `"v1" v311:3
								  `"v2" v319:3
								  v146:54
								  (lambda "sc333" ()
								    (@pv `,RML.debug
									 `"exp1.rml"
									 `32 `47
									 `32 `60
									 `"eval"
									 `"call:RML.real_sub(v1,v2) => (v3)"
									 v146:54
									 (lambda "sc332" ()
									   (@pv `,RML.real_sub
										v311:3
										v319:3
										v146:54
										v147:6))))))))))))))))))))))))
    (((STRUCTHDR 1 0))
     (let ((v342:3 (fetch 1 v148:11)))
     (@pv `,RML.debug_push_in01 `"ival" v342:3 v146:54
	  (lambda "sc348" ()
	    (@pv `,RML.debug `"exp1.rml" `20 `3 `20 `36 `"eval"
		 `"axiom:eval(RCONST(ival)) => (ival)" v146:54
		 (lambda "sc347" ()
		   (@pv `,RML.debug_push_out01 `"ival" v342:3 v146:54
			(lambda "sc346" () (@sc v147:6 v342:3))))))))))))
