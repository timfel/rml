(* code/plaintoc.sml *)
(* -- start adrpo 27 june *)
(* added to Control to PlainToCFn interface to be 
   used for Control.doDebug -- enabling/disabling the trace on stderr *)
(* -- end adrpo 27 june *) 

functor PlainToCFn(structure Util : UTIL
		   structure Code : PLAIN
		   structure CodeToC : CODETOC
                   structure Control : CONTROL
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


(* -- start adrpo 2002-10-03 
  fun instrumentCode adds the debbuger code in the generated code or not, 
  depending on the first variable

    fun instrumentCode os (ref false, label) = ()
      | instrumentCode os (ref true, label) = ()
	(output(os,"\trml_state_print(\"");
	CodeToC.prLabel os label;
	output(os,"\", rmlState);"))
 -- end adrpo 2002-10-03 *) 


    fun emitLabDecs(_, []) = ()
      | emitLabDecs(os, labdefs) =
	  (output1(os, #"\n"); List.app (prLabDec os) labdefs)

    fun prLabBody os (Code.LABDEF{globalP,label,varHP,nalloc,nargs,code,...}) =
      (output1(os, #"\n");
       if globalP then () else output(os, "static ");
        output(os, "RML_BEGIN_LABEL(");
       CodeToC.prLabel os label;
       output(os, ")\n{");
     if nalloc > 0 
     then
	 (
		output(os, "\tvoid *");
		CodeToC.prLVar os varHP;
			output(os, ";");
		output(os, "\n\tRML_ALLOC(");
		CodeToC.prLVar os varHP;
		output1(os, #",");
		CodeToC.prInt os nalloc;
		output1(os, #",");
		CodeToC.prInt os nargs;
		output1(os, #",");
		CodeToC.prLabel os label;	(* for `new' runtime *)
		output(os, ");");
		if !Control.doTrace
		then
		(
			output(os, "\n\tfprintf(stderr, \"");
			CodeToC.prLabel os label; output(os, "\\n\"); fflush(stderr);\n")
		)
		else
			()
	  )
      else 
      (
		if !Control.doTrace
		then
		(      
			output(os, "\n\tfprintf(stderr, \"");
			CodeToC.prLabel os label; output(os, "\\n\"); fflush(stderr);\n")
		)
		else
			()
      );
            
	  (* adrpo 2005-12-29 changed this to the one below! 
      CodeToC.prCode os code;
      *)
      output(os, "\n\t{");
      CodeToC.prCode os code;
      output(os, "}");      
      output(os, "\n}\nRML_END_LABEL\n"))

    fun emitLabDefs(os, labdefs) = List.app (prLabBody os) labdefs

    fun emitModule(os, ((prefix, ext), module as Code.MODULE{modname, xmods, xlabs, xvals, values, litdefs, labdefs, ...})) =
      let val (Code.Mangle.NAME modname) = Code.Mangle.encode modname
      in
	output(os, "/* module "); output(os, modname); output(os, " */\n");
	output(os, "#include \"rml.h\"\n");
	output(os, "#include <stdlib.h>\n");
	output(os, "#include <stdio.h>\n");
	if !Control.fixJavaNames 
	then output(os, "#include \"ExternalRMLDefines.h\"\n")	
	else ();
	(* adrpo added 2004-10-19: include module name in file *)
	output(os, "RML_DEFINE_MODULE(\""); output(os, modname); output(os, "\")\n");
	List.app (CodeToC.prImpLab os) xlabs;
	List.app (CodeToC.prValDec os) xvals;
	emitLabDecs(os, labdefs);
	CodeToC.emitLitdefs os litdefs;
	CodeToC.emitValues os values;
	CodeToC.prInitProc (os,prefix) (fn () => ()) module;
	emitLabDefs(os, labdefs)
      end

    fun emitInterface(os, module) = CodeToC.prInterface os module

  end (* functor PlainToCFn *)
