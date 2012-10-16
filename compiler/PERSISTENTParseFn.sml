(* PERSISTENTParseFn.sml *)

functor PERSISTENTParseFn(structure Absyn : ABSYN
    structure Cache : CACHE
    structure LexArgSimple : LEXARG_SIMPLE where type poz = Cache.poz
    structure PERSISTENTParser : ARG_PARSER
            where type arg = LexArgSimple.lexarg
            and type pos = int
    structure Tokens : PERSISTENT_TOKENS
    sharing type Tokens.token = PERSISTENTParser.Token.token
    sharing type Tokens.svalue = PERSISTENTParser.svalue
    sharing type PERSISTENTParser.result = Absyn.serialized = Cache.Absyn.serialized
    sharing type PERSISTENTParser.lexarg = LexArgSimple.lexarg
    sharing type Cache.restriction =  LexArgSimple.restriction    
    sharing type Cache.visibility =  LexArgSimple.visibility
    sharing type Cache.StrDict.dict = LexArgSimple.StrDict.dict
      ) : PERSISTENT_PARSE =
  struct
  
    structure Absyn = Cache.Absyn
    type repository = Cache.repository

    structure Util = Util
    fun bug  s = Util.bug("PERSISTENTParseFn."^s)


    val debugFlag = false
    fun debug s = if (debugFlag) then Util.outStdErr("PERSISTENTParseFn."^s) else ()  

    fun openFile(file, fname) =  (* adrpo, try 10 to open the file *)
    ((TextIO.openIn file) handle exn => 
     (OS.Process.sleep(Time.fromMicroseconds(3000)); (TextIO.openIn file) handle exn =>
      (OS.Process.sleep(Time.fromMicroseconds(3000)); (TextIO.openIn file) handle exn =>
       (OS.Process.sleep(Time.fromMicroseconds(3000)); (TextIO.openIn file) handle exn =>
        (OS.Process.sleep(Time.fromMicroseconds(3000)); (TextIO.openIn file) handle exn =>
         (OS.Process.sleep(Time.fromMicroseconds(3000)); (TextIO.openIn file) handle exn =>
          (OS.Process.sleep(Time.fromMicroseconds(3000)); (TextIO.openIn file) handle exn =>
           (OS.Process.sleep(Time.fromMicroseconds(3000)); (TextIO.openIn file) handle exn =>
            (OS.Process.sleep(Time.fromMicroseconds(3000)); (TextIO.openIn file) handle exn =>
             (OS.Process.sleep(Time.fromMicroseconds(3000)); (TextIO.openIn file) handle exn =>
           (
             case exn of IO.Io({name, function, cause})
             => (bug(fname ^ " Error: name = " ^  name ^ " function: " ^ function ^ "! Could not open file: " ^ file);
                 case cause of OS.SysErr(s, _) 
                  => bug(fname ^ "Error: " ^ s ^ "! Could not open file: " ^ file);
             raise exn)))))))))))
    )

    fun parse(startToken, file, repository, isInterface) =
      let
         val is = openFile(file, "parse")
      in 
       (let val (lexarg, inputf) = LexArgSimple.new(file, is)
        val pos = 2  (*XXX: ML-Lex*)
        val lexer = PERSISTENTParser.makeLexer inputf lexarg
        val lexer = PERSISTENTParser.Stream.cons(startToken(pos,pos), lexer)
        val (result,_) = 
      PERSISTENTParser.parse(
        0,
        lexer,
        LexArgSimple.errorMsg lexarg,
        lexarg)
     val Absyn.SERIALIZED(
        pInfo,
        SOME(Absyn.MODULE(
            Absyn.INTERFACE({modid,specs,...}, infoI),_,_))) = result
     val program = Absyn.SRZ_FILE(file, result)  
   in
     if LexArgSimple.seenErr lexarg then raise PERSISTENTParser.ParseError else ();
     TextIO.closeIn is;
     Cache.insert(
      repository, 
      Cache.srzCache,
      file,
      Cache.makeEntry(
      let val fileInfo =
        Cache.makeFileInfo(
          program,
          LexArgSimple.getImports(lexarg),
          LexArgSimple.getExternals(lexarg),
          LexArgSimple.getRestrictions(lexarg),
          ref true, (* reordered *)
          ref false (* elaborated *)
          )
      in
        if (isInterface)
        then (modid, NONE, SOME(fileInfo))
        else (modid, SOME(fileInfo), NONE)
      end
      ));     
      program
        end) handle e => (TextIO.closeIn is; raise e)
      end
      
    fun parse_normal(startToken, file) =
      let 
         val is = openFile(file, "parse_normal")
      in
      (let val (lexarg, inputf) = LexArgSimple.new(file, is)
       val pos = 2  (*XXX: ML-Lex*)
       val lexer = PERSISTENTParser.makeLexer inputf lexarg
       val lexer = PERSISTENTParser.Stream.cons(startToken(pos,pos), lexer)
       val (result,_) = 
      PERSISTENTParser.parse(
        0,
        lexer,
        LexArgSimple.errorMsg lexarg,
        lexarg)
   in
     if LexArgSimple.seenErr lexarg then raise PERSISTENTParser.ParseError else ();
     TextIO.closeIn is;
     result
   end) handle e => (TextIO.closeIn is; raise e)
      end
      

    fun parseModule(file, repository) = 
    let 
    val _ = debug("parseModule: "^file^"\n")
    val result = parse(Tokens.START_MODULE, file, repository, false)
  in
    result
  end
  
    fun parseInterface(file, repository) = 
    let 
    val _ = debug("parseInterface: "^file^"\n")
    val result = parse(Tokens.START_INTERFACE, file, repository, true)
  in
    result
  end
    
    fun parseSerializationInfo  file = 
    let 
    val _ = debug("parseSerializationInfo: "^file^"\n")
    val Absyn.SERIALIZED(Absyn.SERIALIZE(srzInfo),_) = 
        parse_normal(Tokens.START_SERIALIZATION_INFO, file)
  in
    srzInfo
  end
    
  end (* functor ParseFn *)
