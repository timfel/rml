(* code/plaintoc.sml *)
functor PlainToCFn(structure Util : UTIL
       structure Code : PLAIN
       structure CodeToC : CODETOC
                   structure Control : CONTROL
       sharing Code = CodeToC.Code
         ) : PLAINTOC =
  struct

    structure Code = Code
    structure ConRep = Code.ConRep

    fun emitModule(os, ((prefix, fileName, ext), module as Code.MODULE{modname, xmods, xlabs, xvals, values, litdefs, labdefs, source, ...})) =
    let 
    val _ = CodeToC.setCurrentSource(source)
  
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

    fun getLocalVars(Code.CODE{code,...}, lv, ld) = getLocalV(code, lv, ld)

    and getLocalV(Code.STORE(dst,src,code), lv, ld) = getLocalVars(code, lv, ld)
    |   getLocalV(Code.BIND(SOME(Code.LOCvar(lvar as Code.LVAR{tag, name})), v, code), lv, ld) =
          getLocalVars(code, lvar::lv, ld)
    |   getLocalV(Code.BIND(_, v, code), lv, ld) =
          getLocalVars(code, lv, ld)
    |   getLocalV(Code.SWITCH(v, cases as (case0::_), default, var), lv, ld) =
        let val (lv1, ld1) = getLocalVarsDefault(default, lv, ld)
            val (lv1, ld1) = case case0 of 
                        (Code.REALct _, _) => (lv1, var::ld1)
                      | (Code.STRINGct _, _) => (var::lv1, ld1)
                      | _ => (lv1, ld1)
        in
          getLocalVarsCases(cases, lv1, ld1)
        end
    |   getLocalV(_, lv, ld) = (lv, ld)

    and getLocalVarsDefault(SOME(code), lv, ld) = getLocalVars(code, lv, ld)
    |   getLocalVarsDefault(NONE, lv, ld) = (lv, ld)

    and getLocalVarsCases([], lv, ld) = (lv, ld)
    |   getLocalVarsCases((_, code)::rest, lv, ld) = 
        let val (lv1, ld1) = getLocalVars(code, lv, ld)
        in 
          getLocalVarsCases(rest, lv1, ld1)
        end
    
    
    fun printLocalDeclarations(os,nalloc,varHP,code) = 
    let val (locals, dvars) = getLocalVars(code, [], [])
        val lvars = if nalloc > 0 then varHP::locals else locals
        fun printLocalVars(os, [x], prefix) = (output(os,prefix); CodeToC.prLVarName os x)
        |   printLocalVars(os, x::rest, prefix) = 
            (output(os,prefix); CodeToC.prLVarName os x; output(os, ",\n       ");
             printLocalVars(os, rest, prefix))
    in
      if List.length(lvars) > 0
      then (output(os, "  void "); printLocalVars(os, lvars, "*"); output(os, ";\n"))
      else ();
      if List.length(dvars) > 0
      then (output(os, "  double "); printLocalVars(os, dvars, ""); output(os, ";\n"))
      else ()
    end

    fun prLabBody os (Code.LABDEF{globalP,label,varHP,nalloc,nargs,nlocals,code,pos,...}) =
     (
       output1(os, #"\n");
       
       if globalP then () else output(os, "static ");
       
       output(os, "RML_BEGIN_LABEL(");
       CodeToC.prLabel os label;
       output(os, ")\n{\n");

       printLocalDeclarations(os, nalloc, varHP, code);

       if !Control.doTrace
       then
       (
         output(os, "  if (rml_trace_enabled) { fprintf(stderr, \"");
         CodeToC.prLabelUnmangled os label; output(os, "\\n\"); fflush(stderr); }\n")
       )
       else
       ();

       if nalloc > 0
       then
       ( 
         if !Control.doTrace
         then 
         (
           output(os, "  RML_ALLOC_TRACE(");
           CodeToC.prLVar os varHP; 
           output1(os, #",");
           CodeToC.prInt os nalloc;
           output1(os, #",");
           CodeToC.prInt os nargs;
           output1(os, #",");
           CodeToC.prLabel os label;  (* for `new' runtime *)
           output(os, ",\"");
           CodeToC.prLabel os label;  (* string label *)
           output(os, "\");\n")
         )
         else
         (
           output(os, "  RML_ALLOC(");
           CodeToC.prLVar os varHP;
           output1(os, #",");
           CodeToC.prInt os nalloc;
           output1(os, #",");
           CodeToC.prInt os nargs;
           output(os, ");\n")
         )
       )
       else 
       ();
       
       CodeToC.prCode os code;

       output(os, "\n}\nRML_END_LABEL\n"))

    fun emitLabDefs(os, labdefs) = List.app (prLabBody os) labdefs

    val (Code.Mangle.NAME modname) = Code.Mangle.encode modname
  
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
    CodeToC.prInitProc (os, fileName) (fn () => ()) module;
    emitLabDefs(os, labdefs)
  end

  fun emitInterface(os, module) = CodeToC.prInterface os module

end (* functor PlainToCFn *)
