(* util/source.sml *)

structure Source : SOURCE =
  struct

	structure Control = Control

    datatype source
      = SOURCE of
	  { fileName: string,
	    newLines: int list }	(* _descending_ order *)

    val dummy = SOURCE{fileName="", newLines=[]}

	val debugFlag = false
	fun debug s = if (debugFlag) then print ("MODParseFn."^s) else ()	

    (* The pos of an imaginary newline before a file's very
     * first character. This is necessary to adjust for the
     * weird notion of ML-Lex that the first character has
     * position 2. Not 0 or 1, but 2.
     * XXX: THIS WILL BREAK IF ML-LEX IS FIXED
     *)
    val startPos:int = 1

	(*
	fun prDebugLines (newLines, pos) = 
	let fun prLines([]) = ()
		|	prLines(newLine::newLines) = 
			(
			print ("["^Int.toString(newLine)^"] ");
			prLines(newLines)
			)
	in
		print ("\n - POS: "^Int.toString(pos)^" in list of: "^
			Int.toString(List.length newLines)^" elements: ");
		prLines(newLines);
		print  ("\n")
	end	    
	
	*)
	
    fun lookup(newLines, pos) =
      let fun loop([], _, x) = {line = 1, column = pos - startPos, nr_calls = x}
	    | loop(newLine::newLines, line, x) =
		if pos > newLine then {line = line, column = pos - newLine, nr_calls = x}
		else loop(newLines, line - 1, x + 1)
      in
		(* prDebugLines(newLines, pos); *)
		case loop(newLines, 1 + List.length newLines, 0) of
		   {line, column, nr_calls} => 
			(
				debug ("lookup: nr_calls:"
				       ^Int.toString(nr_calls)
				       ^" line: "^Int.toString(line)
				       ^" column: "^Int.toString(column)
				       ^"\n");
				{line=line, column=column}
			)
      end
	
	(*
	local 
	
	val linesCache = ref NONE
	
	fun getLinesCache (newLines) = 
	(
		case !linesCache of
			NONE => 
			let val v = Vector.fromList(newLines)
			in 
			 linesCache := SOME(v); v
			end 
		|	SOME(v) => v
	)
    
    in
    
    (* adrpo changed the implementation for more efficiency *)
    fun lookup(newLines, pos:word) =
      let val cachedLines = getLinesCache (newLines)
		  val maxLines =  1 + Int.fromInt (List.length newLines)
		  fun search(vec, min, max, pos) =
			let val middle = (min+max) div 2
			in 
				(*
				print ("\nmin: "^Int.toString(min)^
				       " max: "^Int.toString(max)^
				       " val: "^Int.toString(Vector.sub(vec, middle))^
				       " pos: "^Int.toString(pos));
				*)
				if (max-min = 1 orelse min = max) 
				then (min) 
				else
				(
					if pos < Vector.sub(vec, Int.toInt middle)
					then search(vec, middle, max, pos)
					else search(vec, min, middle, pos)
				)
			end
      in
        (* search for the first value, less than pos *)
        if (pos < Vector.sub(cachedLines, Vector.length(cachedLines)-1))
        then { line = 1, column = pos } (* first line before the \n *)
        else 
        if (pos > Vector.sub(cachedLines, 0)) (* after the \n of last line *)
        then { line = Int.fromInt (Vector.length(cachedLines)), column = pos - Vector.sub(cachedLines, 0) }  
        else (* normal case *)
        if (Vector.length(cachedLines) = 0) 
        then {line = 1, column = pos - startPos}
        else 
			let val l = search(cachedLines, 0, Int.fromInt (Vector.length cachedLines), pos)
			in
				{line = l, column = pos - Vector.sub(cachedLines, Int.toInt l)}
			end
      end
    
    end
	
	*)
	
    fun sayErr s = TextIO.output(TextIO.stdErr, s)
    fun sayErr1 c = TextIO.output1(TextIO.stdErr, c)

    fun sayFile file = (sayErr file; sayErr1 #":")

    fun sayPos(newLines, pos) =
      let val {line,column} = lookup(newLines, pos)
      in
		sayErr(Int.toString line);
		sayErr1 #".";
		sayErr(Int.toString column)
      end
      
    fun sayMsg (SOURCE{fileName,newLines}) (msg,leftPos,rightPos) =
      (sayFile fileName;
       sayPos(newLines, leftPos);
       sayErr1 #"-";
       sayPos(newLines, rightPos);
       sayErr1 #" ";
       sayErr msg;
       sayErr1 #"\n")
       
    fun getLC({line, column}) = (line, column)
       
    fun getLoc((SOURCE{fileName, newLines}), spos, epos) =
	if (!Control.doDebug orelse !Control.rdbOnly) 
	then (* generate line no only if we do trace or program databse *)
	
		let val (sline, scolumn) = getLC(lookup(newLines, spos))
			val (eline, ecolumn) = getLC(lookup(newLines, epos))
		in
		{
		fileName=fileName,
		sline = sline, 
		scolumn = scolumn, 
		eline = eline, 
		ecolumn = ecolumn
		}
		end
	
	else (*do not generate line/col no if we don't do trace *)
		{
		fileName=fileName,
		sline =   0, 
		scolumn = 0, 
		eline =   0, 
		ecolumn = 0
		}

  end (* structure Source *)
