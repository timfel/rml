(* main/control.sml *)

signature CONTROL =
  sig

	datatype filetype = BAD_FILE | RML_FILE | MO_FILE

    (* options for ReorderParse *)
    val doReorder: bool ref

    (* options for TypeCheck / StatElab *)
    val allowImplicitLet: bool ref

    (* options for FOLToCPS *)
    val warnNonExhaustive: bool ref

    (* options for CodeToC *)
    val switchRewriteThreshold: int ref


    (* adrpo added options *)
    val doDebug: bool ref

    (* adrpo added options *)
    val doTrace: bool ref
    
    val qualifiedRdb: bool ref

    val rdbOnly: bool ref
    
    val fileType: string -> filetype
    val pathSplit: string -> (string * string option)

  end (* signature CONTROL *)

