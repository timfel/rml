(* StatElab.sml *)


structure StatElab =
  StatElabFn(structure Util = Util
             structure RMLParse = ReorderParse
             structure MODParse = ReorderParse
             structure StatObj = StatObj
			 structure Control = Control
			 structure Instrument = Instrument
	       );

