(* main/main.sml *)
(* adrpo
 * - added comments
 * - added calls to AST instrumentation
 *)

(* the main functor *)
functor MainFn(
           structure Version : VERSION
	       structure Util : UTIL
	       structure RMLParse : PARSE
	       structure MODParse : PARSE
	       structure StatElab : STAT_ELAB
	       structure AbsynPrint : ABSYN_PRINT
	       structure AbsynToFOL : ABSYNTOFOL
	       structure FOLPrint : FOL_PRINT
	       structure FOLOptim : FOL_OPTIM
	       structure FOLToCPS : FOLTOCPS
	       structure CPSOptim : CPS_OPTIM
	       structure CPSPrint : CPS_PRINT
	       structure CPSToSwitch : CPSTOCODE (* where type Code.gvar = Switch.gvar' *)
	       structure SwitchOptim : CODE_OPTIM 
	       structure CPSToPlain : CPSTOCODE (* where type Code.gvar = Plain.gvar' *)
	       structure PlainOptim : CODE_OPTIM
	       structure PlainToC : PLAINTOC
	       structure MaskToC : SWITCHTOC
	       structure DiffToC : SWITCHTOC
	       structure Interp : INTERP
	       structure CPSToSML : CPSTOSML
	       structure Control : CONTROL
	       structure Instrument : ABSYN_INSTRUMENTED
	       sharing MODParse.Absyn = RMLParse.Absyn = AbsynPrint.Absyn = Instrument.Absyn
	       sharing MODParse.Absyn = RMLParse.Absyn = StatElab.Absyn
	       sharing MODParse.Absyn = RMLParse.Absyn = Interp.Absyn
	       sharing MODParse.Absyn = RMLParse.Absyn = AbsynToFOL.Absyn
	       sharing AbsynToFOL.FOL = FOLPrint.FOL = FOLOptim.FOL = FOLToCPS.FOL
	       sharing FOLToCPS.CPS = CPSOptim.CPS = CPSPrint.CPS
	       sharing CPSPrint.CPS = CPSToSwitch.CPS
	       sharing CPSToSwitch.Code = SwitchOptim.Code = MaskToC.Code = DiffToC.Code
	       sharing CPSPrint.CPS = CPSToPlain.CPS
	       sharing CPSToPlain.Code = PlainOptim.Code = PlainToC.Code
	       sharing CPSToSML.CPS = FOLToCPS.CPS
		 ) : MAIN =
  struct

    (* error printing *)
    fun sayErr msg = TextIO.output(TextIO.stdErr, msg)

    (* flag to write the symboltable or not*)
    val emitDebug = ref false
    (* flag to emit the program database or not *)
    val emitRdb = ref false
    (* flag to emit the AST or not *)
    val emitAst = ref false
    (* flag to emit the FOL form or not *)
    val emitFol = ref false
    (* flag to emit the CPS form or not *)
    val emitCps = ref false
    
    (* enumeration datatype of code generation schemes (backends) *)
    datatype cgscheme = PLAIN | MASK | DIFF | SML
    (* default code generation scheme is set to PLAIN *)
    val cgScheme = ref PLAIN
    (* flag to optimize FOL representation or not *)
    val optFol = ref true
    (* flag to optimize CPS representation or not *)
    val optCps = ref true
    (* flag to optimize Code representation or not *)
    val optCode = ref true

    (* datatype for the result if is ok or if is error *)
    datatype 'a outcome = OK of 'a | ERR of exn
    
    (* function to write files with error handling *)
    fun withOutputOption f arg2 file =
      let val os = TextIO.openOut file
	  val outcome = (OK(f(SOME(os), arg2))) handle exn => ERR exn
      in
	    TextIO.closeOut os;
	    case outcome of (OK result) => result | (ERR exn) => raise exn
      end

    (* function to write files with error handling *)
    fun withOutput f arg2 file =
      let val os = TextIO.openOut file
	  val outcome = (OK(f(os, arg2))) handle exn => ERR exn
      in
	    TextIO.closeOut os;
	    case outcome of (OK result) => result | (ERR exn) => raise exn
      end

    (* function that does the rml to sml translation *)
    fun doSml((prefix, ext), cpsModule) =
      (withOutput CPSToSML.emitModule ((prefix, ext), cpsModule) (prefix ^ ".sml");
       withOutput CPSToSML.emitInterface cpsModule (prefix ^ ".sig"))

    (* generates code according to Switch runtime *)
    fun doSwitch((prefix, ext), switchModule) =
      let val switchModule = if !optCode then SwitchOptim.optimize switchModule
			     else switchModule
	  val cFile = prefix ^ ".c" and hFile = prefix ^ ".h"
      in
	case !cgScheme
	  of DIFF =>
	      (withOutput DiffToC.emitModule ((prefix, ext), switchModule) cFile;
	       withOutput DiffToC.emitInterface switchModule hFile)
	   | _ =>
	      (withOutput MaskToC.emitModule ((prefix, ext), switchModule) cFile;
	       withOutput MaskToC.emitInterface switchModule hFile)
      end

    (* generates code according to Plain runtime *)
    fun doPlain((prefix, ext), plainModule) =
      let val plainModule = if !optCode then PlainOptim.optimize plainModule
			    else plainModule
      in
		withOutput PlainToC.emitModule ((prefix, ext), plainModule) (prefix ^ ".c");
		withOutput PlainToC.emitInterface plainModule (prefix ^ ".h")
      end

    (* generates the AST representation *)
    fun doAst((prefix, ext), astModule) =
      (
       if !emitAst (* check if we should dump the AST *)
       then withOutput AbsynPrint.printModule astModule (prefix ^ ".ast")
       else ();
       if !emitDebug (* check if we should dump the DEBUG instrumented AST *)
       then withOutput AbsynPrint.printModule astModule (prefix ^ ".dbg")
       else ()       
      )

    (* instrument  *)
    fun doInstrument(prefix, astModule) =
       if !Control.doDebug then Instrument.instrument(prefix, astModule)
       else astModule
      
    (* dump the FOL representation *)
    fun folPrintOptim(folOs, folModule) =
      FOLOptim.optimize(SOME folOs, folModule)
            
    fun folPrint(folOs, folModule) =
		(FOLPrint.printModule(folOs, folModule); folModule)
      
    (* generate the FOL representation *)
    fun doFol((prefix, ext), folModule) =
      if !emitFol 
      then if !optFol then
			withOutput folPrintOptim 
				(withOutput folPrint folModule (prefix ^ ".fol")) 
				(prefix ^ ".optim.fol")
		   else
			withOutput folPrint folModule (prefix ^ ".fol")
      else if !optFol then 
			FOLOptim.optimize(NONE, folModule)
		   else 
			folModule

    (* dump the CPS representation *)
    fun cpsPrint(cpsOs, cpsModule) =
      if !optCps then CPSOptim.optimize(SOME cpsOs, cpsModule)
      else (CPSPrint.printModule(cpsOs, cpsModule); cpsModule)
    
    (* generate the CPS representation *)
    fun doCps((prefix, ext), cpsModule) =
      if !emitCps then withOutput cpsPrint cpsModule (prefix ^ ".cps")
      else if !optCps then CPSOptim.optimize(NONE, cpsModule)
      else cpsModule

    (* parse a module *)
    fun   parse ((prefix, ext as SOME("rml"))) = 
			RMLParse.parseModule( OS.Path.joinBaseExt {base = prefix, ext = ext} )
		| parse ((prefix, ext as SOME("mo"))) = 
			MODParse.parseModule ( OS.Path.joinBaseExt {base = prefix, ext = ext} )

    (* statically elaborate a module (typecheck) *)
    fun checkModule((prefix, ext), module) = 
		if !emitRdb
		then withOutputOption StatElab.checkModule module (prefix ^ ".rdb")
		else StatElab.checkModule(NONE, module)

    (* statically elaborate an entire program (typecheck) *)
    fun checkProgram modseq = 
		if !emitRdb
		then withOutputOption StatElab.checkProgram modseq ("_all_.rdb")
		else StatElab.checkProgram(NONE, modseq)
    

    (* flag that specifies if only typecheck should be performed, no codegen *)
    val onlyTypeCheck = ref false       
       

    (* function that translates a RML file into C representation (actual compilation) *)
    fun translate ( (prefix, ext) )=
      let  val astModule = 
			doInstrument(
				OS.Path.joinBaseExt {base = prefix, ext = ext}, 
				parse (prefix, ext) )
	  val _ = doAst((prefix, ext), astModule)
	  val _ = checkModule((prefix, ext), astModule)
      in
		if !onlyTypeCheck then () (* check if we only do typecheck *)
		else
		let val folModule = doFol((prefix, ext), AbsynToFOL.translate astModule)
			val cpsModule = doCps((prefix, ext), FOLToCPS.translate folModule)
		in
			case !cgScheme (* what backend should we use for codegen *)
			of PLAIN => doPlain((prefix, ext), CPSToPlain.translate cpsModule)
			| MASK => doSwitch((prefix, ext), CPSToSwitch.translate cpsModule)
			| DIFF => doSwitch((prefix, ext), CPSToSwitch.translate cpsModule)
			| SML => doSml((prefix, ext), cpsModule)
		end;
		()
      end

    fun usage badarg = (* check the compiler line arguments (parameters) *)
      (sayErr("rml: invalid argument '" ^ badarg ^ "'\n");
       sayErr "usage: rml [options] file.(rml|mo) ...\n";
       sayErr "valid options are:\n";
       sayErr "--\n";
       sayErr "-E{no-,}ast\n";
       sayErr "-E{no-,}cps\n";
       sayErr "-E{no-,}fol\n";
       sayErr "-E{no-,}rdb\n";
       sayErr "-E{plain,diff,mask,sml}\n";
       sayErr "-f{no-,}implicit-let\n";
       sayErr "-f{,no-}reorder\n";
       sayErr "-fswitch-rewrite-threshold=<integer>\n";
       sayErr "-f{,no-}typecheck-only\n";
       sayErr "-f{,no-}trace\n";
       sayErr "-f{,no-}debug\n";
       sayErr "-f{,no-}qualified-rdb\n";
       sayErr "-f{,no-}rdb-only\n";              
       sayErr "-O\n";
       sayErr "-O0\n";
       sayErr "-O{,no-}code\n";
       sayErr "-O{,no-}cps\n";
       sayErr "-O{,no-}fol\n";
       sayErr "-i\n";
       sayErr "-v\n";
       sayErr "-W{no-,}non-exhaustive\n";
       Util.error "Usage")
    
    (* function that outputs the version of the compiler *)
    fun version() = 
      (sayErr "rml version ";
       sayErr Version.versionNumber;
       sayErr " built ";
       sayErr Version.builtDate;
       sayErr " using ";
       sayErr Version.builtUsing;
       sayErr "\n")

    (* function that eats the compiler options and sets the flags *)
    fun option arg = 
      case arg
	of "-East" => emitAst := true
	 | "-Eno-ast" => emitAst := false
	 | "-Efol" => emitFol := true
	 | "-Eno-fol" => emitFol := false
	 | "-Ecps" => emitCps := true
	 | "-Eno-cps" => emitCps := false
	 | "-Erdb" => emitRdb := true
	 | "-Eno-rdb" => emitRdb := false
	 | "-Ofol" => optFol := true
	 | "-Ono-fol" => optFol := false
	 | "-Ocps" => optCps := true
	 | "-Ono-cps" => optCps := false
	 | "-Ocode" => optCode := true
	 | "-Ono-code" => optCode := false
	 | "-O" => (optFol := true; optCps := true; optCode := true)
	 | "-O0" => (optFol := false; optCps := false; optCode := false)
	 | "-Eplain" => cgScheme := PLAIN
	 | "-Emask" => cgScheme := MASK
	 | "-Ediff" => cgScheme := DIFF
	 | "-Esml" => cgScheme := SML
	 | "-fimplicit-let" => Control.allowImplicitLet := true
	 | "-fno-implicit-let" => Control.allowImplicitLet := false
	 | "-freorder" => Control.doReorder := true
	 | "-fno-reorder" => Control.doReorder := false
	 | "-ftypecheck-only" => onlyTypeCheck := true
	 | "-fno-typecheck-only" => onlyTypeCheck := false
         (* --start adrpo@ida.liu.se added 2002-06-14 *)
	 | "-fdebug" => (Control.doDebug := true; emitRdb := true; Control.qualifiedRdb := true)
	 | "-fno-debug" => Control.doDebug := false
         (* --end adrpo@ida.liu.se added 2002-06-14 *)
	 | "-ftrace" =>    Control.doTrace := true
	 | "-fno-trace" => Control.doTrace := false
	 | "-fqualified-rdb" => Control.qualifiedRdb := true
	 | "-fno-qualified-rdb" => Control.qualifiedRdb := false

	 | "-frdb-only" => 
		(
		 emitRdb := true; 
		 Control.rdbOnly := true;
		 Control.qualifiedRdb := false; 
		 onlyTypeCheck := true
		)
	 | "-fno-rdb-only" => ()
	 
	 | "-Wnon-exhaustive" => Control.warnNonExhaustive := true
	 | "-Wno-non-exhaustive" => Control.warnNonExhaustive := false
	 | "-v" => version()
	 | _ =>
	    let val size = String.size arg
		val srtPfx = "-fswitch-rewrite-threshold="
		val srtPfxSize = String.size srtPfx
	    in
	      if size > srtPfxSize andalso
		 String.substring(arg,0,srtPfxSize) = srtPfx then
		case Int.fromString(String.substring(arg,srtPfxSize,size-srtPfxSize))
		  of SOME i => Control.switchRewriteThreshold := i
		   | NONE => usage arg
	      else usage arg
	    end

    (* function that processes a rml file (compilation) *)
    fun compiler argv =
      let fun process arg =
	    if String.sub(arg, 0) = #"-" then option arg
	    else
	      case (Control.fileType arg)
			of Control.RML_FILE => translate (Control.pathSplit arg)
			 | Control.MO_FILE  => translate (Control.pathSplit arg)
		     | _ => usage arg
      in
		List.app process argv
      end

    (* function to run the interpreter *)
    fun run(prefixes, argv) =
      let val modseq = map parse prefixes
	  val _ = checkProgram modseq
      in
	    Interp.run(modseq, argv)
      end

    (* the main loop of the interpreter *)
    fun interpreter argv =
      let fun revRun([], _) = ()
	    | revRun(prefixes, argv) = run(rev prefixes, argv)
	  fun loop([], prefixes) = revRun(prefixes, [])
	    | loop("--"::argv, prefixes) = revRun(prefixes, argv)
	    | loop(arg::argv, prefixes) =
		if String.sub(arg, 0) = #"-" then
		  (option arg; loop(argv, prefixes))
		else
		  let val {base,ext} = OS.Path.splitBaseExt arg
		  in
		    case ext
		      of SOME "rml" => loop(argv, (base,ext)::prefixes)
		      |  SOME "mo"  => loop(argv, (base,ext)::prefixes)
		      | _ => usage arg
		  end
      in
		loop(argv, [])
      end

    (* the main function *)
    fun main argv =
      let fun loop("-i"::argv) = interpreter argv
	    | loop("-v"::argv) = (version(); loop argv)
	    | loop argv = compiler argv
      in
	    loop argv
      end

  end (* functor MainFn *)
