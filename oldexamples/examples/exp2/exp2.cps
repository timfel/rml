
Applying local CPS-optimizations:
(MODULE exp2)
(WITH RML)
(EXPORTS exp2.eval)

(define (exp2.apply_unop v152:0 v153:1 v150:9 v151:1)
  (let ((v162:3 v153:1))
  (let ((v165:1
	  (lambda "sc186" ()
	    (let ((v166:1
		    (lambda "sc185" ()
		      (let ((v167:1
			      (lambda "sc184" ()
				(let ((v168:1
					(lambda "sc183" ()
					  (let ((v169:1
						  (lambda "sc182" ()
						    (let ((v170:1
							    (lambda "sc181" ()
							      (let ((v171:1
								      (lambda "sc180" (
										       v172:1)
									(let ((v173:2
										v172:1))
									(let ((v176:1
										(lambda "sc179" ()
										  (let ((v177:1
											  (lambda "sc178" ()
											    (@sc v151:1
												 v173:2))))
										  (@pv `,RML.debug_print
										       `"v2"
										       v173:2
										       v150:9
										       v177:1)))))
									(@pv `,RML.debug_print
									     `"v2"
									     `"<- match"
									     v150:9
									     v176:1))))))
							      (@pv `,RML.int_neg
								   v162:3 v150:9
								   v171:1)))))
						    (@pv `,RML.debug_print `"v"
							 v162:3 v150:9
							 v170:1)))))
					  (@pv `,RML.debug `"exp2.rml" `52 `9
					       `52 `24 `"apply_unop"
					       `"call:int_neg(v) => (v2)" v150:9
					       v169:1)))))
				(@pv `,RML.debug_print `"v" v162:3 v150:9
				     v168:1)))))
		      (@pv `,RML.debug_print `"v" `"<- match" v150:9 v167:1)))))
	    (@pv `,RML.debug_print `"NEG" `0 v150:9 v166:1)))))
  (@pv `,RML.debug_print `"NEG" `"<- match" v150:9 v165:1))))

(define (exp2.apply_binop v156:1 v157:4 v158:4 v154:48 v155:4)
  (switch v156:1
    ((1)
     (let ((v188:3 v157:4))
     (let ((v187:3 v158:4))
     (let ((v201:1
	     (lambda "sc228" ()
	       (let ((v202:1
		       (lambda "sc227" ()
			 (let ((v203:1
				 (lambda "sc226" ()
				   (let ((v204:1
					   (lambda "sc225" ()
					     (let ((v205:1
						     (lambda "sc224" ()
						       (let ((v206:1
							       (lambda "sc223" ()
								 (let ((v207:1
									 (lambda "sc222" ()
									   (let ((v208:1
										   (lambda "sc221" ()
										     (let ((v209:1
											     (lambda "sc220" ()
											       (let ((v210:1
												       (lambda "sc219" (
															v211:1)
													 (let ((v212:2
														 v211:1))
													 (let ((v215:1
														 (lambda "sc218" ()
														   (let ((v216:1
															   (lambda "sc217" ()
															     (@sc v155:4
																  v212:2))))
														   (@pv `,RML.debug_print
															`"v3"
															v212:2
															v154:48
															v216:1)))))
													 (@pv `,RML.debug_print
													      `"v3"
													      `"<- match"
													      v154:48
													      v215:1))))))
											       (@pv `,RML.int_sub
												    v188:3
												    v187:3
												    v154:48
												    v210:1)))))
										     (@pv `,RML.debug_print
											  `"v2"
											  v187:3
											  v154:48
											  v209:1)))))
									   (@pv `,RML.debug_print
										`"v1"
										v188:3
										v154:48
										v208:1)))))
								 (@pv `,RML.debug
								      `"exp2.rml"
								      `36 `9 `36
								      `28
								      `"apply_binop"
								      `"call:int_sub(v1,v2) => (v3)"
								      v154:48
								      v207:1)))))
						       (@pv `,RML.debug_print
							    `"v2" v187:3 v154:48
							    v206:1)))))
					     (@pv `,RML.debug_print `"v2"
						  `"<- match" v154:48
						  v205:1)))))
				   (@pv `,RML.debug_print `"v1" v188:3 v154:48
					v204:1)))))
			 (@pv `,RML.debug_print `"v1" `"<- match" v154:48
			      v203:1)))))
	       (@pv `,RML.debug_print `"SUB" `1 v154:48 v202:1)))))
     (@pv `,RML.debug_print `"SUB" `"<- match" v154:48 v201:1)))))
    ((3)
     (let ((v190:3 v157:4))
     (let ((v189:3 v158:4))
     (let ((v229:1
	     (lambda "sc256" ()
	       (let ((v230:1
		       (lambda "sc255" ()
			 (let ((v231:1
				 (lambda "sc254" ()
				   (let ((v232:1
					   (lambda "sc253" ()
					     (let ((v233:1
						     (lambda "sc252" ()
						       (let ((v234:1
							       (lambda "sc251" ()
								 (let ((v235:1
									 (lambda "sc250" ()
									   (let ((v236:1
										   (lambda "sc249" ()
										     (let ((v237:1
											     (lambda "sc248" ()
											       (let ((v238:1
												       (lambda "sc247" (
															v239:1)
													 (let ((v240:2
														 v239:1))
													 (let ((v243:1
														 (lambda "sc246" ()
														   (let ((v244:1
															   (lambda "sc245" ()
															     (@sc v155:4
																  v240:2))))
														   (@pv `,RML.debug_print
															`"v3"
															v240:2
															v154:48
															v244:1)))))
													 (@pv `,RML.debug_print
													      `"v3"
													      `"<- match"
													      v154:48
													      v243:1))))))
											       (@pv `,RML.int_div
												    v190:3
												    v189:3
												    v154:48
												    v238:1)))))
										     (@pv `,RML.debug_print
											  `"v2"
											  v189:3
											  v154:48
											  v237:1)))))
									   (@pv `,RML.debug_print
										`"v1"
										v190:3
										v154:48
										v236:1)))))
								 (@pv `,RML.debug
								      `"exp2.rml"
								      `44 `9 `44
								      `28
								      `"apply_binop"
								      `"call:int_div(v1,v2) => (v3)"
								      v154:48
								      v235:1)))))
						       (@pv `,RML.debug_print
							    `"v2" v189:3 v154:48
							    v234:1)))))
					     (@pv `,RML.debug_print `"v2"
						  `"<- match" v154:48
						  v233:1)))))
				   (@pv `,RML.debug_print `"v1" v190:3 v154:48
					v232:1)))))
			 (@pv `,RML.debug_print `"v1" `"<- match" v154:48
			      v231:1)))))
	       (@pv `,RML.debug_print `"DIV" `3 v154:48 v230:1)))))
     (@pv `,RML.debug_print `"DIV" `"<- match" v154:48 v229:1)))))
    ((2)
     (let ((v192:3 v157:4))
     (let ((v191:3 v158:4))
     (let ((v257:1
	     (lambda "sc284" ()
	       (let ((v258:1
		       (lambda "sc283" ()
			 (let ((v259:1
				 (lambda "sc282" ()
				   (let ((v260:1
					   (lambda "sc281" ()
					     (let ((v261:1
						     (lambda "sc280" ()
						       (let ((v262:1
							       (lambda "sc279" ()
								 (let ((v263:1
									 (lambda "sc278" ()
									   (let ((v264:1
										   (lambda "sc277" ()
										     (let ((v265:1
											     (lambda "sc276" ()
											       (let ((v266:1
												       (lambda "sc275" (
															v267:1)
													 (let ((v268:2
														 v267:1))
													 (let ((v271:1
														 (lambda "sc274" ()
														   (let ((v272:1
															   (lambda "sc273" ()
															     (@sc v155:4
																  v268:2))))
														   (@pv `,RML.debug_print
															`"v3"
															v268:2
															v154:48
															v272:1)))))
													 (@pv `,RML.debug_print
													      `"v3"
													      `"<- match"
													      v154:48
													      v271:1))))))
											       (@pv `,RML.int_mul
												    v192:3
												    v191:3
												    v154:48
												    v266:1)))))
										     (@pv `,RML.debug_print
											  `"v2"
											  v191:3
											  v154:48
											  v265:1)))))
									   (@pv `,RML.debug_print
										`"v1"
										v192:3
										v154:48
										v264:1)))))
								 (@pv `,RML.debug
								      `"exp2.rml"
								      `40 `9 `40
								      `28
								      `"apply_binop"
								      `"call:int_mul(v1,v2) => (v3)"
								      v154:48
								      v263:1)))))
						       (@pv `,RML.debug_print
							    `"v2" v191:3 v154:48
							    v262:1)))))
					     (@pv `,RML.debug_print `"v2"
						  `"<- match" v154:48
						  v261:1)))))
				   (@pv `,RML.debug_print `"v1" v192:3 v154:48
					v260:1)))))
			 (@pv `,RML.debug_print `"v1" `"<- match" v154:48
			      v259:1)))))
	       (@pv `,RML.debug_print `"MUL" `2 v154:48 v258:1)))))
     (@pv `,RML.debug_print `"MUL" `"<- match" v154:48 v257:1)))))
    ((0)
     (let ((v194:3 v157:4))
     (let ((v193:3 v158:4))
     (let ((v285:1
	     (lambda "sc312" ()
	       (let ((v286:1
		       (lambda "sc311" ()
			 (let ((v287:1
				 (lambda "sc310" ()
				   (let ((v288:1
					   (lambda "sc309" ()
					     (let ((v289:1
						     (lambda "sc308" ()
						       (let ((v290:1
							       (lambda "sc307" ()
								 (let ((v291:1
									 (lambda "sc306" ()
									   (let ((v292:1
										   (lambda "sc305" ()
										     (let ((v293:1
											     (lambda "sc304" ()
											       (let ((v294:1
												       (lambda "sc303" (
															v295:1)
													 (let ((v296:2
														 v295:1))
													 (let ((v299:1
														 (lambda "sc302" ()
														   (let ((v300:1
															   (lambda "sc301" ()
															     (@sc v155:4
																  v296:2))))
														   (@pv `,RML.debug_print
															`"v3"
															v296:2
															v154:48
															v300:1)))))
													 (@pv `,RML.debug_print
													      `"v3"
													      `"<- match"
													      v154:48
													      v299:1))))))
											       (@pv `,RML.int_add
												    v194:3
												    v193:3
												    v154:48
												    v294:1)))))
										     (@pv `,RML.debug_print
											  `"v2"
											  v193:3
											  v154:48
											  v293:1)))))
									   (@pv `,RML.debug_print
										`"v1"
										v194:3
										v154:48
										v292:1)))))
								 (@pv `,RML.debug
								      `"exp2.rml"
								      `32 `9 `32
								      `28
								      `"apply_binop"
								      `"call:int_add(v1,v2) => (v3)"
								      v154:48
								      v291:1)))))
						       (@pv `,RML.debug_print
							    `"v2" v193:3 v154:48
							    v290:1)))))
					     (@pv `,RML.debug_print `"v2"
						  `"<- match" v154:48
						  v289:1)))))
				   (@pv `,RML.debug_print `"v1" v194:3 v154:48
					v288:1)))))
			 (@pv `,RML.debug_print `"v1" `"<- match" v154:48
			      v287:1)))))
	       (@pv `,RML.debug_print `"ADD" `0 v154:48 v286:1)))))
     (@pv `,RML.debug_print `"ADD" `"<- match" v154:48 v285:1)))))))

(define (exp2.eval v161:7 v159:43 v160:3)
  (let ((v328:1 (fetch 0 v161:7)))
  (switch v328:1
    (((STRUCTHDR 3 1))
     (let ((v329:1 (fetch 3 v161:7)))
     (let ((v330:1 (fetch 2 v161:7)))
     (let ((v331:1 (fetch 1 v161:7)))
     (let ((v315:3 v331:1))
     (let ((v314:3 v330:1))
     (let ((v313:3 v329:1))
     (let ((v332:1
	     (lambda "sc389" ()
	       (let ((v333:1
		       (lambda "sc388" ()
			 (let ((v334:1
				 (lambda "sc387" ()
				   (let ((v335:1
					   (lambda "sc386" ()
					     (let ((v336:1
						     (lambda "sc385" ()
						       (let ((v337:1
							       (lambda "sc384" ()
								 (let ((v338:1
									 (lambda "sc383" (
											  v339:1)
									   (let ((v340:3
										   v339:1))
									   (let ((v343:1
										   (lambda "sc382" ()
										     (let ((v344:1
											     (lambda "sc381" ()
											       (let ((v345:1
												       (lambda "sc380" ()
													 (let ((v346:1
														 (lambda "sc379" ()
														   (let ((v347:1
															   (lambda "sc378" (
																	    v348:1)
															     (let ((v349:3
																     v348:1))
															     (let ((v352:1
																     (lambda "sc377" ()
																       (let ((v353:1
																	       (lambda "sc376" ()
																		 (let ((v354:1
																			 (lambda "sc375" ()
																			   (let ((v355:1
																				   (lambda "sc374" ()
																				     (let ((v356:1
																					     (lambda "sc373" ()
																					       (let ((v357:1
																						       (lambda "sc372" ()
																							 (let ((v358:1
																								 (lambda "sc371" (
																										  v359:1)
																								   (let ((v360:3
																									   v359:1))
																								   (let ((v363:1
																									   (lambda "sc370" ()
																									     (let ((v364:1
																										     (lambda "sc369" ()
																										       (let ((v365:1
																											       (lambda "sc368" ()
																												 (let ((v366:1
																													 (lambda "sc367" ()
																													   (@sc v160:3
																														v360:3))))
																												 (@pv `,RML.debug_print
																												      `"v3"
																												      v360:3
																												      v159:43
																												      v366:1)))))
																										       (@pv `,RML.debug
																											    `"exp2.rml"
																											    `22
																											    `37
																											    `22
																											    `41
																											    `"eval"
																											    `"return:(v3)"
																											    v159:43
																											    v365:1)))))
																									     (@pv `,RML.debug_print
																										  `"v3"
																										  v360:3
																										  v159:43
																										  v364:1)))))
																								   (@pv `,RML.debug_print
																									`"v3"
																									`"<- match"
																									v159:43
																									v363:1))))))
																							 (@pv `,exp2.apply_binop
																							      v314:3
																							      v340:3
																							      v349:3
																							      v159:43
																							      v358:1)))))
																					       (@pv `,RML.debug_print
																						    `"v2"
																						    v349:3
																						    v159:43
																						    v357:1)))))
																				     (@pv `,RML.debug_print
																					  `"v1"
																					  v340:3
																					  v159:43
																					  v356:1)))))
																			   (@pv `,RML.debug_print
																				`"binop"
																				v314:3
																				v159:43
																				v355:1)))))
																		 (@pv `,RML.debug
																		      `"exp2.rml"
																		      `20
																		      `9
																		      `20
																		      `38
																		      `"eval"
																		      `"call:apply_binop(binop,v1,v2) => (v3)"
																		      v159:43
																		      v354:1)))))
																       (@pv `,RML.debug_print
																	    `"v2"
																	    v349:3
																	    v159:43
																	    v353:1)))))
															     (@pv `,RML.debug_print
																  `"v2"
																  `"<- match"
																  v159:43
																  v352:1))))))
														   (@pv `,exp2.eval
															v313:3
															v159:43
															v347:1)))))
													 (@pv `,RML.debug_print
													      `"e2"
													      v313:3
													      v159:43
													      v346:1)))))
											       (@pv `,RML.debug
												    `"exp2.rml"
												    `19
												    `9
												    `19
												    `22
												    `"eval"
												    `"call:eval(e2) => (v2)"
												    v159:43
												    v345:1)))))
										     (@pv `,RML.debug_print
											  `"v1"
											  v340:3
											  v159:43
											  v344:1)))))
									   (@pv `,RML.debug_print
										`"v1"
										`"<- match"
										v159:43
										v343:1))))))
								 (@pv `,exp2.eval
								      v315:3
								      v159:43
								      v338:1)))))
						       (@pv `,RML.debug_print
							    `"e1" v315:3 v159:43
							    v337:1)))))
					     (@pv `,RML.debug `"exp2.rml" `18 `9
						  `18 `22 `"eval"
						  `"call:eval(e1) => (v1)"
						  v159:43 v336:1)))))
				   (@pv `,RML.debug_print `"e2" v313:3 v159:43
					v335:1)))))
			 (@pv `,RML.debug_print `"binop" v314:3 v159:43
			      v334:1)))))
	       (@pv `,RML.debug_print `"e1" v315:3 v159:43 v333:1)))))
     (@pv `,RML.debug_print `"BINARY(e1,binop,e2)" `"<- match" v159:43
	  v332:1)))))))))
    (((STRUCTHDR 2 2))
     (let ((v390:1 (fetch 2 v161:7)))
     (let ((v391:1 (fetch 1 v161:7)))
     (let ((v317:3 v391:1))
     (let ((v316:3 v390:1))
     (let ((v392:1
	     (lambda "sc431" ()
	       (let ((v393:1
		       (lambda "sc430" ()
			 (let ((v394:1
				 (lambda "sc429" ()
				   (let ((v395:1
					   (lambda "sc428" ()
					     (let ((v396:1
						     (lambda "sc427" ()
						       (let ((v397:1
							       (lambda "sc426" (
										v398:1)
								 (let ((v399:3
									 v398:1))
								 (let ((v402:1
									 (lambda "sc425" ()
									   (let ((v403:1
										   (lambda "sc424" ()
										     (let ((v404:1
											     (lambda "sc423" ()
											       (let ((v405:1
												       (lambda "sc422" ()
													 (let ((v406:1
														 (lambda "sc421" ()
														   (let ((v407:1
															   (lambda "sc420" (
																	    v408:1)
															     (let ((v409:3
																     v408:1))
															     (let ((v412:1
																     (lambda "sc419" ()
																       (let ((v413:1
																	       (lambda "sc418" ()
																		 (let ((v414:1
																			 (lambda "sc417" ()
																			   (let ((v415:1
																				   (lambda "sc416" ()
																				     (@sc v160:3
																					  v409:3))))
																			   (@pv `,RML.debug_print
																				`"v2"
																				v409:3
																				v159:43
																				v415:1)))))
																		 (@pv `,RML.debug
																		      `"exp2.rml"
																		      `26
																		      `31
																		      `26
																		      `35
																		      `"eval"
																		      `"return:(v2)"
																		      v159:43
																		      v414:1)))))
																       (@pv `,RML.debug_print
																	    `"v2"
																	    v409:3
																	    v159:43
																	    v413:1)))))
															     (@pv `,RML.debug_print
																  `"v2"
																  `"<- match"
																  v159:43
																  v412:1))))))
														   (@pv `,exp2.apply_unop
															v317:3
															v399:3
															v159:43
															v407:1)))))
													 (@pv `,RML.debug_print
													      `"v1"
													      v399:3
													      v159:43
													      v406:1)))))
											       (@pv `,RML.debug_print
												    `"unop"
												    v317:3
												    v159:43
												    v405:1)))))
										     (@pv `,RML.debug
											  `"exp2.rml"
											  `24
											  `27
											  `24
											  `51
											  `"eval"
											  `"call:apply_unop(unop,v1) => (v2)"
											  v159:43
											  v404:1)))))
									   (@pv `,RML.debug_print
										`"v1"
										v399:3
										v159:43
										v403:1)))))
								 (@pv `,RML.debug_print
								      `"v1"
								      `"<- match"
								      v159:43
								      v402:1))))))
						       (@pv `,exp2.eval v316:3
							    v159:43 v397:1)))))
					     (@pv `,RML.debug_print `"e" v316:3
						  v159:43 v396:1)))))
				   (@pv `,RML.debug `"exp2.rml" `24 `9 `24 `21
					`"eval" `"call:eval(e) => (v1)" v159:43
					v395:1)))))
			 (@pv `,RML.debug_print `"e" v316:3 v159:43 v394:1)))))
	       (@pv `,RML.debug_print `"unop" v317:3 v159:43 v393:1)))))
     (@pv `,RML.debug_print `"UNARY(unop,e)" `"<- match" v159:43 v392:1)))))))
    (((STRUCTHDR 1 0))
     (let ((v432:1 (fetch 1 v161:7)))
     (let ((v318:3 v432:1))
     (let ((v433:1
	     (lambda "sc440" ()
	       (let ((v434:1
		       (lambda "sc439" ()
			 (let ((v435:1
				 (lambda "sc438" ()
				   (let ((v436:1
					   (lambda "sc437" ()
					     (@sc v160:3 v318:3))))
				   (@pv `,RML.debug_print `"ival" v318:3 v159:43
					v436:1)))))
			 (@pv `,RML.debug `"exp2.rml" `16 `3 `16 `33 `"eval"
			      `"axiom:" v159:43 v435:1)))))
	       (@pv `,RML.debug_print `"ival" v318:3 v159:43 v434:1)))))
     (@pv `,RML.debug_print `"INT(ival)" `"<- match" v159:43 v433:1))))))))

Applying local CPS-optimizations:
(MODULE exp2)
(WITH RML)
(EXPORTS exp2.eval)

(define (exp2.eval v161:7 v159:94 v160:3)
  (let ((v328:1 (fetch 0 v161:7)))
  (switch v328:1
    (((STRUCTHDR 3 1))
     (let ((v329:3 (fetch 3 v161:7)))
     (let ((v330:3 (fetch 2 v161:7)))
     (let ((v331:3 (fetch 1 v161:7)))
     (@pv `,RML.debug_print `"BINARY(e1,binop,e2)" `"<- match" v159:94
	  (lambda "sc389" ()
	    (@pv `,RML.debug_print `"e1" v331:3 v159:94
		 (lambda "sc388" ()
		   (@pv `,RML.debug_print `"binop" v330:3 v159:94
			(lambda "sc387" ()
			  (@pv `,RML.debug_print `"e2" v329:3 v159:94
			       (lambda "sc386" ()
				 (@pv `,RML.debug `"exp2.rml" `18 `9 `18 `22
				      `"eval" `"call:eval(e1) => (v1)" v159:94
				      (lambda "sc385" ()
					(@pv `,RML.debug_print `"e1" v331:3
					     v159:94
					     (lambda "sc384" ()
					       (@pv `,exp2.eval v331:3 v159:94
						    (lambda "sc383" ( v339:14)
						      (@pv `,RML.debug_print
							   `"v1" `"<- match"
							   v159:94
							   (lambda "sc382" ()
							     (@pv `,RML.debug_print
								  `"v1" v339:14
								  v159:94
								  (lambda "sc381" ()
								    (@pv `,RML.debug
									 `"exp2.rml"
									 `19 `9
									 `19 `22
									 `"eval"
									 `"call:eval(e2) => (v2)"
									 v159:94
									 (lambda "sc380" ()
									   (@pv `,RML.debug_print
										`"e2"
										v329:3
										v159:94
										(lambda "sc379" ()
										  (@pv `,exp2.eval
										       v329:3
										       v159:94
										       (lambda "sc378" (
													v348:15)
											 (@pv `,RML.debug_print
											      `"v2"
											      `"<- match"
											      v159:94
											      (lambda "sc377" ()
												(@pv `,RML.debug_print
												     `"v2"
												     v348:15
												     v159:94
												     (lambda "sc376" ()
												       (@pv `,RML.debug
													    `"exp2.rml"
													    `20
													    `9
													    `20
													    `38
													    `"eval"
													    `"call:apply_binop(binop,v1,v2) => (v3)"
													    v159:94
													    (lambda "sc375" ()
													      (@pv `,RML.debug_print
														   `"binop"
														   v330:3
														   v159:94
														   (lambda "sc374" ()
														     (@pv `,RML.debug_print
															  `"v1"
															  v339:14
															  v159:94
															  (lambda "sc373" ()
															    (@pv `,RML.debug_print
																 `"v2"
																 v348:15
																 v159:94
																 (lambda "sc372" ()
																   (let ((v155:4
																	   (lambda "sc371" (
																			    v359:3)
																	     (@pv `,RML.debug_print
																		  `"v3"
																		  `"<- match"
																		  v159:94
																		  (lambda "sc370" ()
																		    (@pv `,RML.debug_print
																			 `"v3"
																			 v359:3
																			 v159:94
																			 (lambda "sc369" ()
																			   (@pv `,RML.debug
																				`"exp2.rml"
																				`22
																				`37
																				`22
																				`41
																				`"eval"
																				`"return:(v3)"
																				v159:94
																				(lambda "sc368" ()
																				  (@pv `,RML.debug_print
																				       `"v3"
																				       v359:3
																				       v159:94
																				       (lambda "sc367" ()
																					 (@sc v160:3
																					      v359:3))))))))))))
																   (switch v330:3
																     ((1)
																      (@pv `,RML.debug_print
																	   `"SUB"
																	   `"<- match"
																	   v159:94
																	   (lambda "sc228" ()
																	     (@pv `,RML.debug_print
																		  `"SUB"
																		  `1
																		  v159:94
																		  (lambda "sc227" ()
																		    (@pv `,RML.debug_print
																			 `"v1"
																			 `"<- match"
																			 v159:94
																			 (lambda "sc226" ()
																			   (@pv `,RML.debug_print
																				`"v1"
																				v339:14
																				v159:94
																				(lambda "sc225" ()
																				  (@pv `,RML.debug_print
																				       `"v2"
																				       `"<- match"
																				       v159:94
																				       (lambda "sc224" ()
																					 (@pv `,RML.debug_print
																					      `"v2"
																					      v348:15
																					      v159:94
																					      (lambda "sc223" ()
																						(@pv `,RML.debug
																						     `"exp2.rml"
																						     `36
																						     `9
																						     `36
																						     `28
																						     `"apply_binop"
																						     `"call:int_sub(v1,v2) => (v3)"
																						     v159:94
																						     (lambda "sc222" ()
																						       (@pv `,RML.debug_print
																							    `"v1"
																							    v339:14
																							    v159:94
																							    (lambda "sc221" ()
																							      (@pv `,RML.debug_print
																								   `"v2"
																								   v348:15
																								   v159:94
																								   (lambda "sc220" ()
																								     (let ((v445:2
																									     (int_sub
																									       v339:14
																									       v348:15)))
																								     (@pv `,RML.debug_print
																									  `"v3"
																									  `"<- match"
																									  v159:94
																									  (lambda "sc218" ()
																									    (@pv `,RML.debug_print
																										 `"v3"
																										 v445:2
																										 v159:94
																										 (lambda "sc217" ()
																										   (@sc v155:4
																											v445:2)))))))))))))))))))))))))
																     ((3)
																      (@pv `,RML.debug_print
																	   `"DIV"
																	   `"<- match"
																	   v159:94
																	   (lambda "sc256" ()
																	     (@pv `,RML.debug_print
																		  `"DIV"
																		  `3
																		  v159:94
																		  (lambda "sc255" ()
																		    (@pv `,RML.debug_print
																			 `"v1"
																			 `"<- match"
																			 v159:94
																			 (lambda "sc254" ()
																			   (@pv `,RML.debug_print
																				`"v1"
																				v339:14
																				v159:94
																				(lambda "sc253" ()
																				  (@pv `,RML.debug_print
																				       `"v2"
																				       `"<- match"
																				       v159:94
																				       (lambda "sc252" ()
																					 (@pv `,RML.debug_print
																					      `"v2"
																					      v348:15
																					      v159:94
																					      (lambda "sc251" ()
																						(@pv `,RML.debug
																						     `"exp2.rml"
																						     `44
																						     `9
																						     `44
																						     `28
																						     `"apply_binop"
																						     `"call:int_div(v1,v2) => (v3)"
																						     v159:94
																						     (lambda "sc250" ()
																						       (@pv `,RML.debug_print
																							    `"v1"
																							    v339:14
																							    v159:94
																							    (lambda "sc249" ()
																							      (@pv `,RML.debug_print
																								   `"v2"
																								   v348:15
																								   v159:94
																								   (lambda "sc248" ()
																								     (switch v348:15
																								       ((0)
																									(@fc v159:94))
																								       (else
																									(let ((v448:2
																										(int_div
																										  v339:14
																										  v348:15)))
																									(@pv `,RML.debug_print
																									     `"v3"
																									     `"<- match"
																									     v159:94
																									     (lambda "sc246" ()
																									       (@pv `,RML.debug_print
																										    `"v3"
																										    v448:2
																										    v159:94
																										    (lambda "sc245" ()
																										      (@sc v155:4
																											   v448:2)))))))))))))))))))))))))))
																     ((2)
																      (@pv `,RML.debug_print
																	   `"MUL"
																	   `"<- match"
																	   v159:94
																	   (lambda "sc284" ()
																	     (@pv `,RML.debug_print
																		  `"MUL"
																		  `2
																		  v159:94
																		  (lambda "sc283" ()
																		    (@pv `,RML.debug_print
																			 `"v1"
																			 `"<- match"
																			 v159:94
																			 (lambda "sc282" ()
																			   (@pv `,RML.debug_print
																				`"v1"
																				v339:14
																				v159:94
																				(lambda "sc281" ()
																				  (@pv `,RML.debug_print
																				       `"v2"
																				       `"<- match"
																				       v159:94
																				       (lambda "sc280" ()
																					 (@pv `,RML.debug_print
																					      `"v2"
																					      v348:15
																					      v159:94
																					      (lambda "sc279" ()
																						(@pv `,RML.debug
																						     `"exp2.rml"
																						     `40
																						     `9
																						     `40
																						     `28
																						     `"apply_binop"
																						     `"call:int_mul(v1,v2) => (v3)"
																						     v159:94
																						     (lambda "sc278" ()
																						       (@pv `,RML.debug_print
																							    `"v1"
																							    v339:14
																							    v159:94
																							    (lambda "sc277" ()
																							      (@pv `,RML.debug_print
																								   `"v2"
																								   v348:15
																								   v159:94
																								   (lambda "sc276" ()
																								     (let ((v451:2
																									     (int_mul
																									       v339:14
																									       v348:15)))
																								     (@pv `,RML.debug_print
																									  `"v3"
																									  `"<- match"
																									  v159:94
																									  (lambda "sc274" ()
																									    (@pv `,RML.debug_print
																										 `"v3"
																										 v451:2
																										 v159:94
																										 (lambda "sc273" ()
																										   (@sc v155:4
																											v451:2)))))))))))))))))))))))))
																     ((0)
																      (@pv `,RML.debug_print
																	   `"ADD"
																	   `"<- match"
																	   v159:94
																	   (lambda "sc312" ()
																	     (@pv `,RML.debug_print
																		  `"ADD"
																		  `0
																		  v159:94
																		  (lambda "sc311" ()
																		    (@pv `,RML.debug_print
																			 `"v1"
																			 `"<- match"
																			 v159:94
																			 (lambda "sc310" ()
																			   (@pv `,RML.debug_print
																				`"v1"
																				v339:14
																				v159:94
																				(lambda "sc309" ()
																				  (@pv `,RML.debug_print
																				       `"v2"
																				       `"<- match"
																				       v159:94
																				       (lambda "sc308" ()
																					 (@pv `,RML.debug_print
																					      `"v2"
																					      v348:15
																					      v159:94
																					      (lambda "sc307" ()
																						(@pv `,RML.debug
																						     `"exp2.rml"
																						     `32
																						     `9
																						     `32
																						     `28
																						     `"apply_binop"
																						     `"call:int_add(v1,v2) => (v3)"
																						     v159:94
																						     (lambda "sc306" ()
																						       (@pv `,RML.debug_print
																							    `"v1"
																							    v339:14
																							    v159:94
																							    (lambda "sc305" ()
																							      (@pv `,RML.debug_print
																								   `"v2"
																								   v348:15
																								   v159:94
																								   (lambda "sc304" ()
																								     (let ((v454:2
																									     (int_add
																									       v339:14
																									       v348:15)))
																								     (@pv `,RML.debug_print
																									  `"v3"
																									  `"<- match"
																									  v159:94
																									  (lambda "sc302" ()
																									    (@pv `,RML.debug_print
																										 `"v3"
																										 v454:2
																										 v159:94
																										 (lambda "sc301" ()
																										   (@sc v155:4
																											v454:2)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
    (((STRUCTHDR 2 2))
     (let ((v390:3 (fetch 2 v161:7)))
     (let ((v391:2 (fetch 1 v161:7)))
     (@pv `,RML.debug_print `"UNARY(unop,e)" `"<- match" v159:94
	  (lambda "sc431" ()
	    (@pv `,RML.debug_print `"unop" v391:2 v159:94
		 (lambda "sc430" ()
		   (@pv `,RML.debug_print `"e" v390:3 v159:94
			(lambda "sc429" ()
			  (@pv `,RML.debug `"exp2.rml" `24 `9 `24 `21 `"eval"
			       `"call:eval(e) => (v1)" v159:94
			       (lambda "sc428" ()
				 (@pv `,RML.debug_print `"e" v390:3 v159:94
				      (lambda "sc427" ()
					(@pv `,exp2.eval v390:3 v159:94
					     (lambda "sc426" ( v398:5)
					       (@pv `,RML.debug_print `"v1"
						    `"<- match" v159:94
						    (lambda "sc425" ()
						      (@pv `,RML.debug_print
							   `"v1" v398:5 v159:94
							   (lambda "sc424" ()
							     (@pv `,RML.debug
								  `"exp2.rml"
								  `24 `27 `24
								  `51 `"eval"
								  `"call:apply_unop(unop,v1) => (v2)"
								  v159:94
								  (lambda "sc423" ()
								    (@pv `,RML.debug_print
									 `"unop"
									 v391:2
									 v159:94
									 (lambda "sc422" ()
									   (@pv `,RML.debug_print
										`"v1"
										v398:5
										v159:94
										(lambda "sc421" ()
										  (@pv `,RML.debug_print
										       `"NEG"
										       `"<- match"
										       v159:94
										       (lambda "sc186" ()
											 (@pv `,RML.debug_print
											      `"NEG"
											      `0
											      v159:94
											      (lambda "sc185" ()
												(@pv `,RML.debug_print
												     `"v"
												     `"<- match"
												     v159:94
												     (lambda "sc184" ()
												       (@pv `,RML.debug_print
													    `"v"
													    v398:5
													    v159:94
													    (lambda "sc183" ()
													      (@pv `,RML.debug
														   `"exp2.rml"
														   `52
														   `9
														   `52
														   `24
														   `"apply_unop"
														   `"call:int_neg(v) => (v2)"
														   v159:94
														   (lambda "sc182" ()
														     (@pv `,RML.debug_print
															  `"v"
															  v398:5
															  v159:94
															  (lambda "sc181" ()
															    (let ((v442:4
																    (int_neg
																      v398:5)))
															    (@pv `,RML.debug_print
																 `"v2"
																 `"<- match"
																 v159:94
																 (lambda "sc179" ()
																   (@pv `,RML.debug_print
																	`"v2"
																	v442:4
																	v159:94
																	(lambda "sc178" ()
																	  (@pv `,RML.debug_print
																	       `"v2"
																	       `"<- match"
																	       v159:94
																	       (lambda "sc419" ()
																		 (@pv `,RML.debug_print
																		      `"v2"
																		      v442:4
																		      v159:94
																		      (lambda "sc418" ()
																			(@pv `,RML.debug
																			     `"exp2.rml"
																			     `26
																			     `31
																			     `26
																			     `35
																			     `"eval"
																			     `"return:(v2)"
																			     v159:94
																			     (lambda "sc417" ()
																			       (@pv `,RML.debug_print
																				    `"v2"
																				    v442:4
																				    v159:94
																				    (lambda "sc416" ()
																				      (@sc v160:3
																					   v442:4)))))))))))))))))))))))))))))))))))))))))))))))))))
    (((STRUCTHDR 1 0))
     (let ((v432:3 (fetch 1 v161:7)))
     (@pv `,RML.debug_print `"INT(ival)" `"<- match" v159:94
	  (lambda "sc440" ()
	    (@pv `,RML.debug_print `"ival" v432:3 v159:94
		 (lambda "sc439" ()
		   (@pv `,RML.debug `"exp2.rml" `16 `3 `16 `33 `"eval" `"axiom:"
			v159:94
			(lambda "sc438" ()
			  (@pv `,RML.debug_print `"ival" v432:3 v159:94
			       (lambda "sc437" ()
				 (@sc v160:3 v432:3))))))))))))))
