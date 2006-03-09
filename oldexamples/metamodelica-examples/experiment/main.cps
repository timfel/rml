
Applying local CPS-optimizations:
(MODULE Main)
(WITH RML)
(EXPORTS Main.tree Main.main Main.eval)

(define Main.tree `#(1 #(0 1.0) #(0 2.0)))

(define (Main.main v162:0 v160:11 v161:1)
  (let ((v357:1
	  (lambda "sc386" ()
	    (let ((v358:1
		    (lambda "sc385" ()
		      (let ((v359:1
			      (lambda "sc384" ( v360:1)
				(let ((v361:4 v360:1))
				(let ((v364:1
					(lambda "sc383" ()
					  (let ((v365:1
						  (lambda "sc382" ()
						    (let ((v366:1
							    (lambda "sc381" ()
							      (let ((v367:1
								      (lambda "sc380" (
										       v368:1)
									(let ((v369:3
										v368:1))
									(let ((v372:1
										(lambda "sc379" ()
										  (let ((v373:1
											  (lambda "sc378" ()
											    (let ((v374:1
												    (lambda "sc377" ()
												      (let ((v375:1
													      (lambda "sc376" ()
														(@sc v161:1
														     v361:4))))
												      (@pv `,RML.print
													   v369:3
													   v160:11
													   v375:1)))))
											    (@pv `,RML.debug
												 `"main.mo"
												 `51
												 `4
												 `51
												 `13
												 `"main"
												 `"call:print(str) => ()"
												 v160:11
												 v374:1)))))
										  (@pv `,RML.debug_push_in01
										       `"str"
										       v369:3
										       v160:11
										       v373:1)))))
									(@pv `,RML.debug_push_out01
									     `"str"
									     v369:3
									     v160:11
									     v372:1))))))
							      (@pv `,RML.real_string
								   v361:4
								   v160:11
								   v367:1)))))
						    (@pv `,RML.debug `"main.mo"
							 `50 `8 `50 `24 `"main"
							 `"call:real_string(i) => (str)"
							 v160:11 v366:1)))))
					  (@pv `,RML.debug_push_in01 `"i" v361:4
					       v160:11 v365:1)))))
				(@pv `,RML.debug_push_out01 `"i" v361:4 v160:11
				     v364:1))))))
		      (@pv `,Main.eval `#(1 #(0 1.0) #(0 2.0)) v160:11
			   v359:1)))))
	    (@pv `,RML.debug `"main.mo" `49 `6 `49 `18 `"main"
		 `"call:eval(tree) => (i)" v160:11 v358:1)))))
  (@pv `,RML.debug_push_in01 `"tree" `#(1 #(0 1.0) #(0 2.0)) v160:11 v357:1)))

(define (Main.eval v159:11 v157:50 v158:6)
  (let ((v188:1 (fetch 0 v159:11)))
  (switch v188:1
    (((STRUCTHDR 2 1))
     (let ((v189:1 (fetch 2 v159:11)))
     (let ((v190:1 (fetch 1 v159:11)))
     (let ((v164:2 v190:1))
     (let ((v163:2 v189:1))
     (let ((v191:1
	     (lambda "sc222" ()
	       (let ((v192:1
		       (lambda "sc221" ()
			 (let ((v193:1
				 (lambda "sc220" ( v194:1)
				   (let ((v195:3 v194:1))
				   (let ((v198:1
					   (lambda "sc219" ()
					     (let ((v199:1
						     (lambda "sc218" ()
						       (let ((v200:1
							       (lambda "sc217" ()
								 (let ((v201:1
									 (lambda "sc216" (
											  v202:1)
									   (let ((v203:2
										   v202:1))
									   (let ((v206:1
										   (lambda "sc215" ()
										     (let ((v207:1
											     (lambda "sc214" ()
											       (let ((v208:1
												       (lambda "sc213" (
															v209:1)
													 (let ((v210:1
														 v209:1))
													 (@sc v158:6
													      v210:1)))))
											       (@pv `,RML.real_add
												    v195:3
												    v203:2
												    v157:50
												    v208:1)))))
										     (@pv `,RML.debug
											  `"main.mo"
											  `24
											  `13
											  `24
											  `21
											  `"eval"
											  `"call:real_add(v1,v2) => (temp101)"
											  v157:50
											  v207:1)))))
									   (@pv `,RML.debug_push_in02
										`"v1"
										v195:3
										`"v2"
										v203:2
										v157:50
										v206:1))))))
								 (@pv `,Main.eval
								      v163:2
								      v157:50
								      v201:1)))))
						       (@pv `,RML.debug
							    `"main.mo" `23 `26
							    `23 `36 `"eval"
							    `"call:eval(e2) => (v2)"
							    v157:50 v200:1)))))
					     (@pv `,RML.debug_push_in01 `"e2"
						  v163:2 v157:50 v199:1)))))
				   (@pv `,RML.debug_push_out01 `"v1" v195:3
					v157:50 v198:1))))))
			 (@pv `,Main.eval v164:2 v157:50 v193:1)))))
	       (@pv `,RML.debug `"main.mo" `23 `11 `23 `21 `"eval"
		    `"call:eval(e1) => (v1)" v157:50 v192:1)))))
     (@pv `,RML.debug_push_in01 `"e1" v164:2 v157:50 v191:1)))))))
    (((STRUCTHDR 2 3))
     (let ((v223:1 (fetch 2 v159:11)))
     (let ((v224:1 (fetch 1 v159:11)))
     (let ((v166:2 v224:1))
     (let ((v165:2 v223:1))
     (let ((v225:1
	     (lambda "sc256" ()
	       (let ((v226:1
		       (lambda "sc255" ()
			 (let ((v227:1
				 (lambda "sc254" ( v228:1)
				   (let ((v229:3 v228:1))
				   (let ((v232:1
					   (lambda "sc253" ()
					     (let ((v233:1
						     (lambda "sc252" ()
						       (let ((v234:1
							       (lambda "sc251" ()
								 (let ((v235:1
									 (lambda "sc250" (
											  v236:1)
									   (let ((v237:2
										   v236:1))
									   (let ((v240:1
										   (lambda "sc249" ()
										     (let ((v241:1
											     (lambda "sc248" ()
											       (let ((v242:1
												       (lambda "sc247" (
															v243:1)
													 (let ((v244:1
														 v243:1))
													 (@sc v158:6
													      v244:1)))))
											       (@pv `,RML.real_mul
												    v229:3
												    v237:2
												    v157:50
												    v242:1)))))
										     (@pv `,RML.debug
											  `"main.mo"
											  `30
											  `13
											  `30
											  `21
											  `"eval"
											  `"call:real_mul(v1,v2) => (temp103)"
											  v157:50
											  v241:1)))))
									   (@pv `,RML.debug_push_in02
										`"v1"
										v229:3
										`"v2"
										v237:2
										v157:50
										v240:1))))))
								 (@pv `,Main.eval
								      v165:2
								      v157:50
								      v235:1)))))
						       (@pv `,RML.debug
							    `"main.mo" `29 `26
							    `29 `36 `"eval"
							    `"call:eval(e2) => (v2)"
							    v157:50 v234:1)))))
					     (@pv `,RML.debug_push_in01 `"e2"
						  v165:2 v157:50 v233:1)))))
				   (@pv `,RML.debug_push_out01 `"v1" v229:3
					v157:50 v232:1))))))
			 (@pv `,Main.eval v166:2 v157:50 v227:1)))))
	       (@pv `,RML.debug `"main.mo" `29 `11 `29 `21 `"eval"
		    `"call:eval(e1) => (v1)" v157:50 v226:1)))))
     (@pv `,RML.debug_push_in01 `"e1" v166:2 v157:50 v225:1)))))))
    (((STRUCTHDR 1 5))
     (let ((v257:1 (fetch 1 v159:11)))
     (let ((v167:2 v257:1))
     (let ((v258:1
	     (lambda "sc279" ()
	       (let ((v259:1
		       (lambda "sc278" ()
			 (let ((v260:1
				 (lambda "sc277" ( v261:1)
				   (let ((v262:3 v261:1))
				   (let ((v265:1
					   (lambda "sc276" ()
					     (let ((v266:1
						     (lambda "sc275" ()
						       (let ((v267:1
							       (lambda "sc274" ()
								 (let ((v268:1
									 (lambda "sc273" (
											  v269:1)
									   (let ((v270:1
										   v269:1))
									   (@sc v158:6
										v270:1)))))
								 (@pv `,RML.real_neg
								      v262:3
								      v157:50
								      v268:1)))))
						       (@pv `,RML.debug
							    `"main.mo" `36 `13
							    `36 `18 `"eval"
							    `"call:real_neg(v1) => (temp105)"
							    v157:50 v267:1)))))
					     (@pv `,RML.debug_push_in01 `"v1"
						  v262:3 v157:50 v266:1)))))
				   (@pv `,RML.debug_push_out01 `"v1" v262:3
					v157:50 v265:1))))))
			 (@pv `,Main.eval v167:2 v157:50 v260:1)))))
	       (@pv `,RML.debug `"main.mo" `35 `11 `35 `21 `"eval"
		    `"call:eval(e1) => (v1)" v157:50 v259:1)))))
     (@pv `,RML.debug_push_in01 `"e1" v167:2 v157:50 v258:1)))))
    (((STRUCTHDR 2 4))
     (let ((v280:1 (fetch 2 v159:11)))
     (let ((v281:1 (fetch 1 v159:11)))
     (let ((v169:2 v281:1))
     (let ((v168:2 v280:1))
     (let ((v282:1
	     (lambda "sc313" ()
	       (let ((v283:1
		       (lambda "sc312" ()
			 (let ((v284:1
				 (lambda "sc311" ( v285:1)
				   (let ((v286:3 v285:1))
				   (let ((v289:1
					   (lambda "sc310" ()
					     (let ((v290:1
						     (lambda "sc309" ()
						       (let ((v291:1
							       (lambda "sc308" ()
								 (let ((v292:1
									 (lambda "sc307" (
											  v293:1)
									   (let ((v294:2
										   v293:1))
									   (let ((v297:1
										   (lambda "sc306" ()
										     (let ((v298:1
											     (lambda "sc305" ()
											       (let ((v299:1
												       (lambda "sc304" (
															v300:1)
													 (let ((v301:1
														 v300:1))
													 (@sc v158:6
													      v301:1)))))
											       (@pv `,RML.real_div
												    v286:3
												    v294:2
												    v157:50
												    v299:1)))))
										     (@pv `,RML.debug
											  `"main.mo"
											  `33
											  `13
											  `33
											  `21
											  `"eval"
											  `"call:real_div(v1,v2) => (temp104)"
											  v157:50
											  v298:1)))))
									   (@pv `,RML.debug_push_in02
										`"v1"
										v286:3
										`"v2"
										v294:2
										v157:50
										v297:1))))))
								 (@pv `,Main.eval
								      v168:2
								      v157:50
								      v292:1)))))
						       (@pv `,RML.debug
							    `"main.mo" `32 `26
							    `32 `36 `"eval"
							    `"call:eval(e2) => (v2)"
							    v157:50 v291:1)))))
					     (@pv `,RML.debug_push_in01 `"e2"
						  v168:2 v157:50 v290:1)))))
				   (@pv `,RML.debug_push_out01 `"v1" v286:3
					v157:50 v289:1))))))
			 (@pv `,Main.eval v169:2 v157:50 v284:1)))))
	       (@pv `,RML.debug `"main.mo" `32 `11 `32 `21 `"eval"
		    `"call:eval(e1) => (v1)" v157:50 v283:1)))))
     (@pv `,RML.debug_push_in01 `"e1" v169:2 v157:50 v282:1)))))))
    (((STRUCTHDR 2 2))
     (let ((v314:1 (fetch 2 v159:11)))
     (let ((v315:1 (fetch 1 v159:11)))
     (let ((v171:2 v315:1))
     (let ((v170:2 v314:1))
     (let ((v316:1
	     (lambda "sc347" ()
	       (let ((v317:1
		       (lambda "sc346" ()
			 (let ((v318:1
				 (lambda "sc345" ( v319:1)
				   (let ((v320:3 v319:1))
				   (let ((v323:1
					   (lambda "sc344" ()
					     (let ((v324:1
						     (lambda "sc343" ()
						       (let ((v325:1
							       (lambda "sc342" ()
								 (let ((v326:1
									 (lambda "sc341" (
											  v327:1)
									   (let ((v328:2
										   v327:1))
									   (let ((v331:1
										   (lambda "sc340" ()
										     (let ((v332:1
											     (lambda "sc339" ()
											       (let ((v333:1
												       (lambda "sc338" (
															v334:1)
													 (let ((v335:1
														 v334:1))
													 (@sc v158:6
													      v335:1)))))
											       (@pv `,RML.real_sub
												    v320:3
												    v328:2
												    v157:50
												    v333:1)))))
										     (@pv `,RML.debug
											  `"main.mo"
											  `27
											  `13
											  `27
											  `21
											  `"eval"
											  `"call:real_sub(v1,v2) => (temp102)"
											  v157:50
											  v332:1)))))
									   (@pv `,RML.debug_push_in02
										`"v1"
										v320:3
										`"v2"
										v328:2
										v157:50
										v331:1))))))
								 (@pv `,Main.eval
								      v170:2
								      v157:50
								      v326:1)))))
						       (@pv `,RML.debug
							    `"main.mo" `26 `26
							    `26 `36 `"eval"
							    `"call:eval(e2) => (v2)"
							    v157:50 v325:1)))))
					     (@pv `,RML.debug_push_in01 `"e2"
						  v170:2 v157:50 v324:1)))))
				   (@pv `,RML.debug_push_out01 `"v1" v320:3
					v157:50 v323:1))))))
			 (@pv `,Main.eval v171:2 v157:50 v318:1)))))
	       (@pv `,RML.debug `"main.mo" `26 `11 `26 `21 `"eval"
		    `"call:eval(e1) => (v1)" v157:50 v317:1)))))
     (@pv `,RML.debug_push_in01 `"e1" v171:2 v157:50 v316:1)))))))
    (((STRUCTHDR 1 0))
     (let ((v348:1 (fetch 1 v159:11)))
     (let ((v172:3 v348:1))
     (let ((v349:1
	     (lambda "sc354" ()
	       (let ((v350:1
		       (lambda "sc353" ()
			 (let ((v351:1 (lambda "sc352" () (@sc v158:6 v172:3))))
			 (@pv `,RML.debug_push_out01 `"v1" v172:3 v157:50
			      v351:1)))))
	       (@pv `,RML.debug `"main.mo" `21 `26 `21 `28 `"eval"
		    `"axiom:eval(RCONST(v1)) => (v1)" v157:50 v350:1)))))
     (@pv `,RML.debug_push_in01 `"v1" v172:3 v157:50 v349:1))))))))

Applying local CPS-optimizations:
(MODULE Main)
(WITH RML)
(EXPORTS Main.tree Main.main Main.eval)

(define Main.tree `#(1 #(0 1.0) #(0 2.0)))

(define (Main.main v162:0 v160:11 v161:1)
  (@pv `,RML.debug_push_in01 `"tree" `#(1 #(0 1.0) #(0 2.0)) v160:11
       (lambda "sc386" ()
	 (@pv `,RML.debug `"main.mo" `49 `6 `49 `18 `"main"
	      `"call:eval(tree) => (i)" v160:11
	      (lambda "sc385" ()
		(@pv `,Main.eval `#(1 #(0 1.0) #(0 2.0)) v160:11
		     (lambda "sc384" ( v360:4)
		       (@pv `,RML.debug_push_out01 `"i" v360:4 v160:11
			    (lambda "sc383" ()
			      (@pv `,RML.debug_push_in01 `"i" v360:4 v160:11
				   (lambda "sc382" ()
				     (@pv `,RML.debug `"main.mo" `50 `8 `50 `24
					  `"main"
					  `"call:real_string(i) => (str)"
					  v160:11
					  (lambda "sc381" ()
					    (@pv `,RML.real_string v360:4
						 v160:11
						 (lambda "sc380" ( v368:3)
						   (@pv `,RML.debug_push_out01
							`"str" v368:3 v160:11
							(lambda "sc379" ()
							  (@pv `,RML.debug_push_in01
							       `"str" v368:3
							       v160:11
							       (lambda "sc378" ()
								 (@pv `,RML.debug
								      `"main.mo"
								      `51 `4 `51
								      `13
								      `"main"
								      `"call:print(str) => ()"
								      v160:11
								      (lambda "sc377" ()
									(@pv `,RML.print
									     v368:3
									     v160:11
									     (lambda "sc376" ()
									       (@sc v161:1
										    v360:4))))))))))))))))))))))))

(define (Main.eval v159:11 v157:50 v158:6)
  (let ((v188:1 (fetch 0 v159:11)))
  (switch v188:1
    (((STRUCTHDR 2 1))
     (let ((v189:2 (fetch 2 v159:11)))
     (let ((v190:2 (fetch 1 v159:11)))
     (@pv `,RML.debug_push_in01 `"e1" v190:2 v157:50
	  (lambda "sc222" ()
	    (@pv `,RML.debug `"main.mo" `23 `11 `23 `21 `"eval"
		 `"call:eval(e1) => (v1)" v157:50
		 (lambda "sc221" ()
		   (@pv `,Main.eval v190:2 v157:50
			(lambda "sc220" ( v194:3)
			  (@pv `,RML.debug_push_out01 `"v1" v194:3 v157:50
			       (lambda "sc219" ()
				 (@pv `,RML.debug_push_in01 `"e2" v189:2 v157:50
				      (lambda "sc218" ()
					(@pv `,RML.debug `"main.mo" `23 `26 `23
					     `36 `"eval"
					     `"call:eval(e2) => (v2)" v157:50
					     (lambda "sc217" ()
					       (@pv `,Main.eval v189:2 v157:50
						    (lambda "sc216" ( v202:2)
						      (@pv `,RML.debug_push_in02
							   `"v1" v194:3 `"v2"
							   v202:2 v157:50
							   (lambda "sc215" ()
							     (@pv `,RML.debug
								  `"main.mo" `24
								  `13 `24 `21
								  `"eval"
								  `"call:real_add(v1,v2) => (temp101)"
								  v157:50
								  (lambda "sc214" ()
								    (@pv `,RML.real_add
									 v194:3
									 v202:2
									 v157:50
									 v158:6))))))))))))))))))))))
    (((STRUCTHDR 2 3))
     (let ((v223:2 (fetch 2 v159:11)))
     (let ((v224:2 (fetch 1 v159:11)))
     (@pv `,RML.debug_push_in01 `"e1" v224:2 v157:50
	  (lambda "sc256" ()
	    (@pv `,RML.debug `"main.mo" `29 `11 `29 `21 `"eval"
		 `"call:eval(e1) => (v1)" v157:50
		 (lambda "sc255" ()
		   (@pv `,Main.eval v224:2 v157:50
			(lambda "sc254" ( v228:3)
			  (@pv `,RML.debug_push_out01 `"v1" v228:3 v157:50
			       (lambda "sc253" ()
				 (@pv `,RML.debug_push_in01 `"e2" v223:2 v157:50
				      (lambda "sc252" ()
					(@pv `,RML.debug `"main.mo" `29 `26 `29
					     `36 `"eval"
					     `"call:eval(e2) => (v2)" v157:50
					     (lambda "sc251" ()
					       (@pv `,Main.eval v223:2 v157:50
						    (lambda "sc250" ( v236:2)
						      (@pv `,RML.debug_push_in02
							   `"v1" v228:3 `"v2"
							   v236:2 v157:50
							   (lambda "sc249" ()
							     (@pv `,RML.debug
								  `"main.mo" `30
								  `13 `30 `21
								  `"eval"
								  `"call:real_mul(v1,v2) => (temp103)"
								  v157:50
								  (lambda "sc248" ()
								    (@pv `,RML.real_mul
									 v228:3
									 v236:2
									 v157:50
									 v158:6))))))))))))))))))))))
    (((STRUCTHDR 1 5))
     (let ((v257:2 (fetch 1 v159:11)))
     (@pv `,RML.debug_push_in01 `"e1" v257:2 v157:50
	  (lambda "sc279" ()
	    (@pv `,RML.debug `"main.mo" `35 `11 `35 `21 `"eval"
		 `"call:eval(e1) => (v1)" v157:50
		 (lambda "sc278" ()
		   (@pv `,Main.eval v257:2 v157:50
			(lambda "sc277" ( v261:3)
			  (@pv `,RML.debug_push_out01 `"v1" v261:3 v157:50
			       (lambda "sc276" ()
				 (@pv `,RML.debug_push_in01 `"v1" v261:3 v157:50
				      (lambda "sc275" ()
					(@pv `,RML.debug `"main.mo" `36 `13 `36
					     `18 `"eval"
					     `"call:real_neg(v1) => (temp105)"
					     v157:50
					     (lambda "sc274" ()
					       (@pv `,RML.real_neg v261:3
						    v157:50
						    v158:6)))))))))))))))
    (((STRUCTHDR 2 4))
     (let ((v280:2 (fetch 2 v159:11)))
     (let ((v281:2 (fetch 1 v159:11)))
     (@pv `,RML.debug_push_in01 `"e1" v281:2 v157:50
	  (lambda "sc313" ()
	    (@pv `,RML.debug `"main.mo" `32 `11 `32 `21 `"eval"
		 `"call:eval(e1) => (v1)" v157:50
		 (lambda "sc312" ()
		   (@pv `,Main.eval v281:2 v157:50
			(lambda "sc311" ( v285:3)
			  (@pv `,RML.debug_push_out01 `"v1" v285:3 v157:50
			       (lambda "sc310" ()
				 (@pv `,RML.debug_push_in01 `"e2" v280:2 v157:50
				      (lambda "sc309" ()
					(@pv `,RML.debug `"main.mo" `32 `26 `32
					     `36 `"eval"
					     `"call:eval(e2) => (v2)" v157:50
					     (lambda "sc308" ()
					       (@pv `,Main.eval v280:2 v157:50
						    (lambda "sc307" ( v293:2)
						      (@pv `,RML.debug_push_in02
							   `"v1" v285:3 `"v2"
							   v293:2 v157:50
							   (lambda "sc306" ()
							     (@pv `,RML.debug
								  `"main.mo" `33
								  `13 `33 `21
								  `"eval"
								  `"call:real_div(v1,v2) => (temp104)"
								  v157:50
								  (lambda "sc305" ()
								    (@pv `,RML.real_div
									 v285:3
									 v293:2
									 v157:50
									 v158:6))))))))))))))))))))))
    (((STRUCTHDR 2 2))
     (let ((v314:2 (fetch 2 v159:11)))
     (let ((v315:2 (fetch 1 v159:11)))
     (@pv `,RML.debug_push_in01 `"e1" v315:2 v157:50
	  (lambda "sc347" ()
	    (@pv `,RML.debug `"main.mo" `26 `11 `26 `21 `"eval"
		 `"call:eval(e1) => (v1)" v157:50
		 (lambda "sc346" ()
		   (@pv `,Main.eval v315:2 v157:50
			(lambda "sc345" ( v319:3)
			  (@pv `,RML.debug_push_out01 `"v1" v319:3 v157:50
			       (lambda "sc344" ()
				 (@pv `,RML.debug_push_in01 `"e2" v314:2 v157:50
				      (lambda "sc343" ()
					(@pv `,RML.debug `"main.mo" `26 `26 `26
					     `36 `"eval"
					     `"call:eval(e2) => (v2)" v157:50
					     (lambda "sc342" ()
					       (@pv `,Main.eval v314:2 v157:50
						    (lambda "sc341" ( v327:2)
						      (@pv `,RML.debug_push_in02
							   `"v1" v319:3 `"v2"
							   v327:2 v157:50
							   (lambda "sc340" ()
							     (@pv `,RML.debug
								  `"main.mo" `27
								  `13 `27 `21
								  `"eval"
								  `"call:real_sub(v1,v2) => (temp102)"
								  v157:50
								  (lambda "sc339" ()
								    (@pv `,RML.real_sub
									 v319:3
									 v327:2
									 v157:50
									 v158:6))))))))))))))))))))))
    (((STRUCTHDR 1 0))
     (let ((v348:3 (fetch 1 v159:11)))
     (@pv `,RML.debug_push_in01 `"v1" v348:3 v157:50
	  (lambda "sc354" ()
	    (@pv `,RML.debug `"main.mo" `21 `26 `21 `28 `"eval"
		 `"axiom:eval(RCONST(v1)) => (v1)" v157:50
		 (lambda "sc353" ()
		   (@pv `,RML.debug_push_out01 `"v1" v348:3 v157:50
			(lambda "sc352" () (@sc v158:6 v348:3))))))))))))
