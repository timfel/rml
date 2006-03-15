structure MainMLton = 
struct

fun main args = 
let open Start Main
in
	start main args
end

val main = MLton.Process.makeMain main

end