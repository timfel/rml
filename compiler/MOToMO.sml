(* MOToMO.sml *)

structure MOToMO = 
		MOToMOFn(structure Absyn = Absyn
				  structure Control = Control
				  structure Util = Util);

