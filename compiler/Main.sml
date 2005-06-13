(* Main.sml *)

structure Main =
  MainFn(structure Version = Version
	 structure Util = Util
	 structure RMLParse = ReorderParse
	 structure MODParse = ReorderParse
	 structure StatElab = StatElab
	 structure AbsynPrint = AbsynPrint
	 structure AbsynToFOL = AbsynToFOL
	 structure FOLPrint = FOLPrint
	 structure FOLOptim = FOLOptim
	 structure FOLToCPS = FOLToCPS
	 structure CPSOptim = CPSOptim
	 structure CPSPrint = CPSPrint
	 structure CPSToSwitch = CPSToSwitch
	 structure SwitchOptim = SwitchOptim
	 structure CPSToPlain = CPSToPlain
	 structure PlainOptim = PlainOptim
	 structure PlainToC = PlainToC
	 structure MaskToC = MaskToC
	 structure DiffToC = DiffToC
	 structure CPSToSML = CPSToSML
	 structure Interp = Interp
	 structure Control = Control
	 structure Instrument = Instrument
	   );
