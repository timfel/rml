(* absyn/absyn_instrumented.sig *)
(* the signature of the structure that does the instrumentation *)

signature ABSYN_INSTRUMENTED =
  sig

    structure Absyn	: ABSYN
    val instrument	: string * Absyn.module -> Absyn.module
    val getPatAsString : Absyn.pat -> string
    val getInfoFromPat : Absyn.pat -> Absyn.info
    
  end (* signature ABSYN_INSTRUMENTED *)
