(* rdb.sml *)

functor RDBFun(structure Dynamic : DYNAMIC
	       structure Parse : PARSE) : RDB =
  struct

    fun sayOut s = TextIO.output(TextIO.stdOut, s)
    fun flushOut() = TextIO.flushOut TextIO.stdOut

    structure Dynamic	= Dynamic
    type CPos		= int
    type Ident		= string
    datatype FrameDesc	= FRAME of (Ident * Dynamic.Type) vector
    datatype BptState	= IGNORE | BREAK | STEP
    datatype ModDesc	= MODULE of {modId	: Ident,
				     srcFile	: string,
				     frameDesc	: FrameDesc,
				     frameVals	: Dynamic.Value vector,
				     bptArr	: BptState array,
				     siteDescs	: SiteDesc vector ref	}
    and SiteDesc	= SITE of {region	: CPos * CPos,
				   procId	: string,
				   frameDesc	: FrameDesc,
				   modDesc	: ModDesc,
				   siteNo	: int	}

    fun sayFrame(FRAME desc, vals) =
      let fun sayVar(i, (id,ty)) =
	    (sayOut id; sayOut " = "; Dynamic.say(ty, Vector.sub(vals,i));
	     sayOut "\n")
      in
	Vector.appi sayVar (desc,0,NONE)
      end


    datatype Event	= EVENT of {siteDesc	: SiteDesc,
				    frameVals	: Dynamic.Value vector,
				    eventLink	: EventLink	}
    and EventLink	= STATIC of Event
			| DYNAMIC of Event option

    fun saySite(SITE{region=(from,to),modDesc=MODULE{srcFile,...},...}) =
      (sayOut "\^Z\^Z"; sayOut srcFile; sayOut ":"; sayOut(Int.toString from);
       sayOut ":"; sayOut(Int.toString to); sayOut "\n"; flushOut())

    fun sayEvent(EVENT{siteDesc,...}) =
      let val _ = sayOut "\n"
	  val _ = saySite siteDesc
	  val SITE{modDesc,siteNo,...} = siteDesc
	  val MODULE{bptArr,...} = modDesc
      in
	case Array.sub(bptArr, siteNo)
	  of BREAK => sayOut "breakpoint\n"
	   | _ => ()
      end

    (* For performance, we maintain the following invariants:
     * 1. If stepMode is true, then:
     *	  Every BPA entry in every module is either BREAK or STEP.
     * 2. If stepMode is false, then:
     *	  Every BPA entry in every module is either BREAK or IGNORE.
     *
     * This allows us to "step" after a stepping halt, or "continue"
     * after a breakpoint halt, without updating any BPA entries.
     *
     * To maintain this invariant, we must
     * a. check if stepMode is changed when executing "step" or "continue",
     *    and if so, update all BPA entries
     * b. initialize a module's BPA when it is registered with the debugger
     *)

    val allModules = ref([] : ModDesc list)
    val stepMode = ref true	(* to force an initial break into the debugger *)

    fun siteOfPoint(Parse.POINT(srcFile', cPos)) =
      let fun lookReg(modDesc as MODULE{siteDescs,...}) =
	    let val siteDescs = !siteDescs
		val numSites = Vector.length siteDescs
		fun lookNo siteNo =
		  if siteNo >= numSites then
		    (sayOut "there is no site for position ";
		     sayOut(Int.toString cPos); sayOut "\^G\n"; NONE)
		  else
		    let val siteDesc = Vector.sub(siteDescs, siteNo)
		      val SITE{region=(from,to),...} = siteDesc
		    in
		      if from <= cPos andalso cPos <= to then SOME(modDesc,siteNo)
		      else lookNo(siteNo + 1)
		    end
	    in
	      lookNo 0
	    end
	  fun lookMod [] =
		(sayOut "file not found: "; sayOut srcFile'; sayOut "\^G\n"; NONE)
	    | lookMod((modDesc as MODULE{srcFile,...})::rest) =
		if srcFile' = srcFile then lookReg modDesc else lookMod rest
      in
	lookMod(!allModules)
      end

    (* INV: `!sp' is always a valid index in `stack' *)
    datatype Stack = STACK of {stack: Event Vector.vector, sp: int ref}

    fun stackOfEvent ev =
      let fun dynLink(EVENT{eventLink=DYNAMIC evOpt,...}) = evOpt
	    | dynLink(EVENT{eventLink=STATIC ev,...}) = dynLink ev
	  fun explode ev =
	    ev :: (case dynLink ev of SOME ev => explode ev | NONE => [])
      in
	STACK{stack = Vector.fromList(explode ev), sp = ref 0}
      end

    fun exeBreak pt =
      case siteOfPoint pt
	of NONE => ()
	 | SOME(MODULE{bptArr,...},siteNo) =>
	    Array.update(bptArr, siteNo, BREAK)

    fun exeClear pt =
      case siteOfPoint pt
	of NONE => ()
	 | SOME(MODULE{bptArr,...},siteNo) =>
	    Array.update(bptArr, siteNo, if !stepMode then STEP else IGNORE)

    fun exeAllClear() =
      let val newState = if !stepMode then STEP else IGNORE
	  fun clearBpt(_) = newState
	  fun modAllClear(MODULE{bptArr,...}) = Array.modify clearBpt bptArr
      in
	List.app modAllClear (!allModules)
      end

    fun exeAllBreaks() =
      let fun showBpt siteDescs (siteNo, BREAK) =
		saySite(Vector.sub(siteDescs, siteNo))
	    | showBpt _ (_, _) = ()
	  fun modAllBreaks(MODULE{bptArr,siteDescs,...}) =
	    Array.appi (showBpt (!siteDescs)) (bptArr,0,NONE)
      in
	List.app modAllBreaks (!allModules)
      end

    fun modStepOn(MODULE{bptArr,...}) =
      let fun stepOn(state as BREAK) = state
	    | stepOn(_) = STEP
      in
	Array.modify stepOn bptArr
      end

    fun exeStep() =
      (case !stepMode
	 of false => (List.app modStepOn (!allModules); stepMode := true)
	  | true => ())

    fun modStepOff(MODULE{bptArr,...}) =
      let fun stepOff(state as BREAK) = state
	    | stepOff(_) = IGNORE
      in
	Array.modify stepOff bptArr
      end

    fun exeContinue() =
      (case !stepMode
	 of true => (List.app modStepOff (!allModules); stepMode := false)
	  | false => ())

    fun exeUpDown(STACK{stack,sp,...}, spOffset) =
      let val sp' = !sp + spOffset
      in
	if sp' >= 0 andalso sp' < Vector.length stack then
	  let val _ = sp := sp'
	      val EVENT{siteDesc,...} = Vector.sub(stack, sp')
	  in
	    saySite siteDesc
	  end
	else sayOut "already at end of stack\^G\n"
      end

    fun exeDown stack = exeUpDown(stack, ~1)
    fun exeUp stack = exeUpDown(stack, 1)

    fun exeAllVars(STACK{stack,sp,...}) =
      let fun loop(EVENT{siteDesc,frameVals,eventLink,...}) =
	    let val SITE{frameDesc,...} = siteDesc
	    in
	      sayFrame(frameDesc, frameVals);
	      case eventLink
		of STATIC ev => loop ev
		 | DYNAMIC _ =>
		    let val SITE{modDesc,...} = siteDesc
			val MODULE{frameDesc,frameVals,...} = modDesc
		    in
		      sayFrame(frameDesc, frameVals)
		    end
	    end
      in
	loop(Vector.sub(stack, !sp))
      end

    fun exePrint(STACK{stack,sp,...}, var) =
      let fun lookInFrame(FRAME desc) =
	    let fun look i =
		  if i < 0 then NONE
		  else
		    let val (var',ty) = Vector.sub(desc, i)
		    in
		      if var = var' then SOME(i,ty)
		      else look(i - 1)
		    end
	    in
	      look(Vector.length desc - 1)
	    end
	  fun sayVar(ty, v) =
	    (sayOut var; sayOut " = "; Dynamic.say(ty,v); sayOut "\n")
	  fun lookInEvent(EVENT{siteDesc,frameVals,eventLink,...}) =
	    let val SITE{frameDesc,...} = siteDesc
	    in
	      case lookInFrame frameDesc
		of SOME(i,ty) => sayVar(ty, Vector.sub(frameVals,i))
		 | NONE =>
		    case eventLink
		      of STATIC ev => lookInEvent ev
		       | DYNAMIC _ =>
			  let val SITE{modDesc,...} = siteDesc
			      val MODULE{frameDesc,frameVals,...} = modDesc
			  in
			    case lookInFrame frameDesc
			      of SOME(i,ty) => sayVar(ty, Vector.sub(frameVals,i))
			       | NONE => sayOut "variable not found\^G\n"
			  end
	    end
      in
	lookInEvent(Vector.sub(stack, !sp))
      end

    fun exeWhere(STACK{stack,...}) =
      let fun sayArg frameVals (i,(_,ty)) =
	    (if i > 0 then sayOut ", " else ();
	     Dynamic.say(ty, Vector.sub(frameVals,i)))
	  fun loop(EVENT{siteDesc,frameVals,eventLink,...}) =
	    case eventLink
	      of STATIC ev => loop ev
	       | DYNAMIC evOpt =>
		  let val SITE{procId,frameDesc,modDesc,...} = siteDesc
		      val FRAME frameDesc = frameDesc
		      val MODULE{modId,...} = modDesc
		  in
		    sayOut modId; sayOut "."; sayOut procId; sayOut "(";
		    Vector.appi (sayArg frameVals) (frameDesc,0,NONE); sayOut ")\n";
		    case evOpt
		      of SOME ev => loop ev
		       | NONE => ()
		  end
      in
	loop(Vector.sub(stack, 0))
      end

    fun exeHelp() =
      sayOut	"$b\t\tshow all breakpoints\n\
		\$c\t\tshow call stack\n\
		\$d\t\tmove down one stack frame\n\
		\$q\t\tquit\n\
		\$r\t\tshow visible variables\n\
		\$u\t\tmove up one stack frame\n\
		\<variable>/p\tprint the value of a variable\n\
		\<file> <pos>:b\tset breakpoint\n\
		\:c\t\tcontinue execution\n\
		\<file> <pos>:d\tdelete breakpoint\n\
		\:s\t\tsingle-step execution\n\
		\:z\t\tzap all breakpoints\n\
		\?\t\tprint some help information\n"

    fun repl stack =
      let fun loop() =
	case Parse.parse()
	  of Parse.ALLBREAKS	=> (exeAllBreaks(); loop())
	   | Parse.ALLCLEAR	=> (exeAllClear(); loop())
	   | Parse.ALLVARS	=> (exeAllVars stack; loop())
	   | Parse.BREAK pt	=> (exeBreak pt; loop())
	   | Parse.CLEAR pt	=> (exeClear pt; loop())
	   | Parse.CONTINUE	=> exeContinue()
	   | Parse.DOWN		=> (exeDown stack; loop())
	   | Parse.HELP		=> (exeHelp(); loop())
	   | Parse.PRINT var	=> (exePrint(stack,var); loop())
	   | Parse.QUIT		=> OS.Process.exit 0
	   | Parse.STEP		=> exeStep()
	   | Parse.UP		=> (exeUp stack; loop())
	   | Parse.WHERE	=> (exeWhere stack; loop())
      in
	loop()
      end

    fun initMod modDesc =
      (if !stepMode then modStepOn modDesc else modStepOff modDesc;
       allModules := modDesc :: !allModules)

    fun monitor ev = (sayEvent ev; repl(stackOfEvent ev))

    fun event(site, ev) =
      let val SITE{siteNo,modDesc,...} = site
	  val MODULE{bptArr,...} = modDesc
      in
	case Array.sub(bptArr, siteNo)
	  of IGNORE	=> ev
	   | _		=> (monitor ev; ev)
      end

    val lastCaller = ref(DYNAMIC NONE)
    fun reset() = lastCaller := DYNAMIC NONE
    val stepMode = exeStep

    fun entry(siteDesc, frameVals) =
      let val ev = EVENT{siteDesc = siteDesc,
			 frameVals = frameVals,
			 eventLink = !lastCaller}
      in
	event(siteDesc, ev)
      end

    fun call(siteDesc, frameVals, staticLink) =
      let val ev = EVENT{siteDesc = siteDesc,
			 frameVals = frameVals,
			 eventLink = STATIC staticLink}
      in
	lastCaller := DYNAMIC(SOME ev);
	event(siteDesc, ev)
      end

  end (* functor RDBFun *)
