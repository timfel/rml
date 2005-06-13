(* ReorderParse.sml *)


structure ReorderParse =
  ReorderParseFn(structure RMLParse = RMLParse
				 structure MODParse = MODParse
                 structure Reorder = Reorder
				 structure Control = Control
				 structure MOToRML = MOToRML);

