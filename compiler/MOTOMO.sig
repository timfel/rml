(* MOTOMO.sig *)

signature MOTOMO =
  sig

    structure Absyn	: ABSYN
    
	val mo2imports            :  Absyn.modelica -> (string list * Absyn.modelica)
	val mo2recordconstructors :  Absyn.modelica -> Absyn.Package list
  end 

(* signature MOTOMO *)
