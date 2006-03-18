structure MainMLton = 
struct

    fun main  () = 
    let
		val argz = CommandLine.arguments()
		
	in  
		Main.main argz handle 
			exn => 
				TextIO.output(TextIO.stdErr, ("\nError: " ^ 
				exnMessage exn; OS.Process.exit OS.Process.success))
    end

end
