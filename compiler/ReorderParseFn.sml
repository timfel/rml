(* reorder/reorder-parse.sml *)

functor ReorderParseFn(
			   structure RMLParse : PARSE
			   structure MODParse : PARSE
			   structure MOToRML  : PARSE
		       structure Reorder : REORDER
		       structure Control : CONTROL
		       sharing MODParse.Absyn = RMLParse.Absyn = MOToRML.Absyn = Reorder.Absyn 
			 ) : PARSE =
  struct

    structure Absyn = RMLParse.Absyn
    structure Absyn = MODParse.Absyn
    structure Absyn = MOToRML.Absyn

    fun parseInterface file =
      let val module = 
			case Control.fileType file
			of Control.RML_FILE => RMLParse.parseInterface file
			 | Control.MO_FILE  => MODParse.parseInterface file
      in
		if !Control.doReorder then
		  let val Absyn.MODULE(interface, _, infoM) = module
		  in
			Absyn.MODULE(Reorder.reorderInterface interface, [], infoM)
		  end
		else module
      end

    fun parseModule file =
      let val module = 	
			case Control.fileType file
			of Control.RML_FILE => RMLParse.parseModule file
			 | Control.MO_FILE  => MODParse.parseModule file
      in
		if !Control.doReorder then Reorder.reorderModule module
		else module
      end
      
    fun mo2rmlmodule           (modelica) = (MOToRML.mo2rmlmodule           modelica) 
    fun mo2rmlinterface        (modelica) = (MOToRML.mo2rmlinterface        modelica) 
    fun mo2imports             (modelica) = (MOToRML.mo2imports             modelica) 
	fun mo2recordconstructors  (modelica) = (MOToRML.mo2recordconstructors  modelica)
  end (* functor ReorderParseFn *)
