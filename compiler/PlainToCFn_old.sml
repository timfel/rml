(* code/plaintoc.sml *)

functor PlainToCFn(structure Util : UTIL
		   structure Code : PLAIN 
		   structure CodeToC : CODETOC
		   sharing Code = CodeToC.Code
		     ) : PLAINTOC =
  struct

    structure Code = Code

    val output = TextIO.output
    val output1 = TextIO.output1

    fun prLabDec os (Code.LABDEF{globalP, label, ...}) =
      (if globalP then () else output(os, "static ");
       output(os, "RML_FORWARD_LABEL(");
       CodeToC.prLabel os label;
       output(os, ");\n"))

    fun emitLabDecs(_, []) = ()
      | emitLabDecs(os, labdefs) =
	  (output1(os, #"\n"); List.app (prLabDec os) labdefs)

    fun prLabBody os (Code.LABDEF{globalP,label,varHP,nalloc,nargs,code,...}) =
      (output1(os, #"\n");
       if globalP then () else output(os, "static ");
       output(os, "RML_BEGIN_LABEL(");
       CodeToC.prLabel os label;
       output(os, ")\n{");
       if nalloc > 0 then
	 (output(os, "\tvoid *");
	  CodeToC.prLVar os varHP;
	  output(os, ";\n\tRML_ALLOC(");
	  CodeToC.prLVar os varHP;
	  output1(os, #",");
	  CodeToC.prInt os nalloc;
	  output1(os, #",");
	  CodeToC.prInt os nargs;
	  output1(os, #",");
	  CodeToC.prLabel os label;	(* for `new' runtime *)
	  output(os, ");"))
       else ();
       CodeToC.prCode os code;
       output(os, "\n}\nRML_END_LABEL\n"))

    fun emitLabDefs(os, labdefs) = List.app (prLabBody os) labdefs

    fun emitModule(os, module as Code.MODULE{modname, xmods, xlabs, xvals, values, litdefs, labdefs, ...}) =
      let val (Code.Mangle.NAME modname) = Code.Mangle.encode modname
      in
	output(os, "/* module "); output(os, modname); output(os, " */\n");
	output(os, "#include \"rml.h\"\n");
	List.app (CodeToC.prImpLab os) xlabs;
	List.app (CodeToC.prValDec os) xvals;
	emitLabDecs(os, labdefs);
	CodeToC.emitLitdefs os litdefs;
	CodeToC.emitValues os values;
	CodeToC.prInitProc os (fn () => ()) module;
	emitLabDefs(os, labdefs)
      end

    fun emitInterface(os, module) = CodeToC.prInterface os module

  end (* functor PlainToCFn *)
