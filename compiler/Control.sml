(* main/control.sml *)

structure Control : CONTROL =
  struct

	datatype filetype = BAD_FILE | RML_FILE | MO_FILE

    (* options for ReorderParse *)
    val doReorder = ref true

    (* options for TypeCheck / StatElab *)
    val allowImplicitLet = ref false

    (* options for FOLToCPS *)
    val warnNonExhaustive = ref false

    (* options for CodeToC *)
    val switchRewriteThreshold = ref 3

    (* options for Debbuging (added by adrpo@ida.liu.se 2002-06-14) *)
    val doDebug = ref false;
    (* --end adrpo@ida.liu.se 2002-06-14 *)

    val doTrace = ref false; 
    (* option for including moduleIdent.ident or just ident in the rdb file *)
    val qualifiedRdb = ref true
    val rdbOnly      = ref false

	fun fileType (file) =
	  let val {base,ext} = OS.Path.splitBaseExt file
	  in
		case ext
		  of SOME "rml" => RML_FILE
		   | SOME "mo"  => MO_FILE
		   | _ => BAD_FILE
	  end
	  
	fun pathSplit (file) =
	  let val {base,ext} = OS.Path.splitBaseExt file
	  in
	   (base, ext)
	  end

  end (* structure Control *)
