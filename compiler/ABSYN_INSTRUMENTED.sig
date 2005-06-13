(* absyn/absyn_instrumented.sig *)
(* the signature of the structure that does the instrumentation *)

signature ABSYN_INSTRUMENTED =
  sig

    structure Absyn	: ABSYN
    val instrument	: string * Absyn.module -> Absyn.module
    
  end (* signature ABSYN_INSTRUMENTED *)
