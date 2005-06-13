(* Switch.sml *)


structure Switch =
  SwitchFn(structure MakeString = MakeString
	   structure ConRep = ConRep
	   structure Mangle = Mangle);
