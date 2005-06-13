(* config/start.sml *)

functor StartFn(structure SysDep  : SYSDEP) : START =
  struct
    fun sayErr msg = TextIO.output(TextIO.stdErr, msg)
    fun start main (arg0,argv) =
      (
	  (*
	  SMLofNJ.Internals.ProfControl.profileOn();
	  *)
      SysDep.handleInterrupt(main, argv);
      (*
	  SMLofNJ.Internals.ProfControl.profileOff();
	  print "\n---- Timing report start ----\n";
	  Profile.report (TextIO.stdOut);
	  print "\n---- Timing report end   ----\n"; 
	  *)
      OS.Process.success
      )
      handle SysDep.Interrupt => (sayErr "Interrupt\n"; OS.Process.failure)
	   | exn => (sayErr "Error: "; sayErr(General.exnMessage exn);
		     sayErr "\n"; OS.Process.failure)
  end (* functor StartFn *)

