structure RML
  : sig val main: unit -> unit
    end = 
struct
    fun main  () = 
    let
		val argz = CommandLine.arguments()
		
	in  
		Main.main argz 
			handle 
				exn => print ("\nException raised during compilation :" ^ exnMessage exn; OS.Process.exit 0)(*; 
        print "\nOver!\n"*)
    end
end


