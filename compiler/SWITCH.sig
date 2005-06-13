(* code/switch.sig *)

signature SWITCH =
  sig

    (* datatype gvar_name	= SPgvn | FCgvn | SCgvn | ARGgvn of int
    datatype gvar_scope	= INTRAgvs | INTERgvs
    datatype gvar'	= GVAR of {scope: gvar_scope, name: gvar_name} *)
    include CODE 
    (* sharing type gvar	= gvar' *)

  end (* signature SWITCH *)
