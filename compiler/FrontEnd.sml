(* FrontEnd.sml *)

structure FrontEnd = FrontEndFn(
  structure Cache        = Cache
  structure Control      = Control
  structure Absyn        = Absyn
  structure RMLParse     = RMLParse 
  structure MODParse     = MODParse 
  structure StatElab     = StatElab
  structure AbsynPrint   = AbsynPrint
  structure AbsynPersist = AbsynPersist
  structure Util         = Util
  structure Reorder      = Reorder
  structure MOToRML      = MOToRML
  structure Instrument   = Instrument
);

