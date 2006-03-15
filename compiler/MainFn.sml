(* main/main.sml *)
(* adrpo
 * - added comments
 * - added calls to AST instrumentation
 *)

(* the main functor *)
functor MainFn(
	       structure Cache   : CACHE
           structure Version : VERSION
	       structure Util : UTIL
	       structure FrontEnd : FRONTEND where type repository = Cache.repository
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
           sharing type FrontEnd.Absyn.module = Interp.Absyn.module = AbsynToFOL.Absyn.module
	       sharing type AbsynToFOL.FOL.module = FOLPrint.FOL.module = 
	                    FOLOptim.FOL.module = FOLToCPS.FOL.module
	       
	       sharing type FOLToCPS.CPS.module = CPSOptim.CPS.module = CPSPrint.CPS.module =
		                CPSPrint.CPS.module = CPSToSwitch.CPS.module
	       sharing type CPSToSwitch.Code.module = SwitchOptim.Code.module = 
	                    MaskToC.Code.module = DiffToC.Code.module
	       sharing type CPSToPlain.Code.module = PlainOptim.Code.module = PlainToC.Code.module
	       
	       sharing type CPSPrint.CPS.module = CPSToPlain.CPS.module
	       sharing type CPSToSML.CPS.module = FOLToCPS.CPS.module
		 ) : MAIN =
  struct
		
    (* error printing *)
    fun sayErr msg = TextIO.output(TextIO.stdErr, msg)
        
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
    
    structure StrDict = Cache.StrDict
    
    (* function that does the rml to sml translation *)
    fun doSml((prefix, ext), cpsModule) =
      (Control.withOutput CPSToSML.emitModule ((prefix, ext), cpsModule) (prefix ^ ".sml");
       Control.withOutput CPSToSML.emitInterface cpsModule (prefix ^ ".sig"))

    (* generates code according to Switch runtime *)
    fun doSwitch((prefix, ext), switchModule) =
      let val switchModule = 
		  if !optCode 
		  then SwitchOptim.optimize switchModule
		  else switchModule
	  val cFile = prefix ^ ".c" and hFile = prefix ^ ".h"
      in
		case !cgScheme of 
			DIFF =>
	      (Control.withOutput DiffToC.emitModule ((prefix, ext), switchModule) cFile;
	       Control.withOutput DiffToC.emitInterface switchModule hFile)
	    | _ =>
	      (Control.withOutput MaskToC.emitModule ((prefix, ext), switchModule) cFile;
	       Control.withOutput MaskToC.emitInterface switchModule hFile)
      end

    (* generates code according to Plain runtime *)
    fun doPlain((prefix, ext), plainModule) =
      let val plainModule = if !optCode then PlainOptim.optimize plainModule
			    else plainModule
      in
		Control.withOutput PlainToC.emitModule ((prefix, ext), plainModule) (prefix ^ ".c");
		Control.withOutput PlainToC.emitInterface plainModule (prefix ^ ".h")
      end
      
    (* dump the FOL representation *)
    fun folPrintOptim(folOs, folModule) =
      FOLOptim.optimize(SOME folOs, folModule)
            
    fun folPrint(folOs, folModule) =
		(FOLPrint.printModule(folOs, folModule); folModule)
      
    (* generate the FOL representation *)
    fun doFol((prefix, ext), folModule) =
      if !Control.emitFol 
      then if !optFol then
			Control.withOutput folPrintOptim 
				(Control.withOutput folPrint folModule (prefix ^ ".fol")) 
				(prefix ^ ".optim.fol")
		   else
			Control.withOutput folPrint folModule (prefix ^ ".fol")
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
      if !Control.emitCps 
      then Control.withOutput cpsPrint cpsModule (prefix ^ ".cps")
      else  if !optCps 
			then CPSOptim.optimize(NONE, cpsModule)
			else cpsModule
           
    (* function that translates a RML file into C representation (actual compilation) *)
    fun translate ( (prefix, ext) )=
      let	val fileName = OS.Path.joinBaseExt {base = prefix, ext = ext}
			val astModule = 
					FrontEnd.processFile(
						(prefix,ext),
						Cache.new(
							Cache.new(
								Cache.new(
									ref StrDict.empty, Cache.rmlCache), 
								Cache.modCache), 
							Cache.srzCache)) 
	  in	  		
		case astModule of
			SOME(astModule) =>
				let (* print the FOL ast if required by -Efol *)
					val folModule = doFol((prefix, ext), AbsynToFOL.translate astModule)
					(* print the CPS ast if required by -Ecps *)
					val cpsModule = doCps((prefix, ext), FOLToCPS.translate folModule)
				in
					case !cgScheme (* what backend should we use for codegen *)
					of PLAIN => doPlain((prefix, ext), CPSToPlain.translate cpsModule)
					|  MASK  => doSwitch((prefix, ext), CPSToSwitch.translate cpsModule)
					|  DIFF  => doSwitch((prefix, ext), CPSToSwitch.translate cpsModule)
					|  SML   => doSml((prefix, ext), cpsModule)
				end
		|	NONE => ()
      end

	fun help() =
	(
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
       sayErr "-fdump-interface\n";
       sayErr "-fdump-depends\n";
       sayErr "-O\n";
       sayErr "-O0\n";
       sayErr "-O{,no-}code\n";
       sayErr "-O{,no-}cps\n";
       sayErr "-O{,no-}fol\n";
       sayErr "-i\n";
       sayErr "-v\n";
       sayErr "-W{no-,}non-exhaustive\n";
       sayErr "-help|--help|-h\n"
    )

    fun usage badarg = (* check the compiler line arguments (parameters) *)
      (sayErr("rml: invalid argument '" ^ badarg ^ "'\n");
       help();
       Util.error "Usage")
    
    (* function that outputs the version of the compiler *)
    fun version() = 
      (sayErr "rml+mmc compiler version ";
       sayErr Version.versionNumber;
       sayErr " built ";
       sayErr Version.builtDate;
       sayErr " using ";
       sayErr Version.builtUsing;
       sayErr "\n")

    (* function that eats the compiler options and sets the flags *)
    fun option arg = 
      case arg
	of "-East"     => Control.emitAst := true
	 | "-Eno-ast"  => Control.emitAst := false
	 | "-Efol"     => Control.emitFol := true
	 | "-Eno-fol"  => Control.emitFol := false
	 | "-Ecps"     => Control.emitCps := true
	 | "-Eno-cps"  => Control.emitCps := false
	 | "-Erdb"     => Control.emitRdb := true
	 | "-Eno-rdb"  => Control.emitRdb := false
	 | "-Ofol"     => optFol := true
	 | "-Ono-fol"  => optFol := false
	 | "-Ocps"     => optCps := true
	 | "-Ono-cps"  => optCps := false
	 | "-Ocode"    => optCode := true
	 | "-Ono-code" => optCode := false
	 | "-O"        => (optFol := true; optCps := true; optCode := true)
	 | "-O0"       => (optFol := false; optCps := false; optCode := false)
	 | "-Eplain"   => cgScheme := PLAIN
	 | "-Emask"    => cgScheme := MASK
	 | "-Ediff"    => cgScheme := DIFF
	 | "-Esml"     => cgScheme := SML
	 | "-fimplicit-let"      => Control.allowImplicitLet := true
	 | "-fno-implicit-let"   => Control.allowImplicitLet := false
	 | "-freorder"           => Control.doReorder := true
	 | "-fno-reorder"        => Control.doReorder := false
	 | "-ftypecheck-only"    => Control.onlyTypeCheck := true
	 | "-fno-typecheck-only" => Control.onlyTypeCheck := false
	 | "-fdebug" => 
	 (
		Control.doDebug := true; 
		Control.emitRdb := true; 
		Control.qualifiedRdb := true
	 )
	 | "-fno-debug"         => Control.doDebug := false
	 | "-ftrace"            => Control.doTrace := true
	 | "-fno-trace"         => Control.doTrace := false
	 | "-fqualified-rdb"    => Control.qualifiedRdb := true
	 | "-fno-qualified-rdb" => Control.qualifiedRdb := false
	 | "-frdb-only" => 
		(
		 Control.emitRdb := true; 
		 Control.rdbOnly := true;
		 Control.qualifiedRdb := false; 
		 Control.onlyTypeCheck := true
		)
	 | "-fno-rdb-only" => ()	 
	 | "-Wnon-exhaustive"    => Control.warnNonExhaustive := true
	 | "-Wno-non-exhaustive" => Control.warnNonExhaustive := false
	 | "-ffix-java-names" => 
		(
		  Control.fixJavaNames := true;
		  Util.warn("#include \"ExternalRMLDefines.h\" will be added to the  generated .c file!")
		)	 
	 | "-fdump-interface" => 
		(
		  Control.dumpInterface := true
		)
	 | "-fdump-depends" => 
		(
		  Control.dumpDepends := true
		  (*
		  Control.dumpInterface := true (* do not load additional files *)	
		  *)	  
		)		
	 | "-v" => version()
	 | "--help" => usage arg
	 | "-help"  => usage arg
	 | "-h"     => usage arg
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
	      case (Control.fileType arg) of 
				Control.RML_FILE => 
				(
				Control.currentlyCompiling := Control.RML_FILE;
				translate (Control.pathSplit arg)
				)
		  |		Control.MO_FILE  => 
				(
				Control.currentlyCompiling := Control.MO_FILE;				
				translate (Control.pathSplit arg)
				)
		  |		_ => usage arg
      in
		List.app process argv
      end

    (* function to run the interpreter *)
    fun run(prefixes, argv) =
	  let val modseq = 
				FrontEnd.processProgram(
					prefixes,
						Cache.new(
							Cache.new(
								Cache.new(
									ref StrDict.empty, Cache.rmlCache), 
								Cache.modCache), 
							Cache.srzCache))
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
	    (* | loop("-dep"::argv) = dependency argv *)
	    | loop argv = compiler argv
      in
	    loop argv
      end

  end (* functor MainFn *)
