(* Control.sml *)

structure Control: CONTROL =
  struct

    structure PERSISTENTParse = PERSISTENTParse
    structure Util = Util
    
  fun bug  s = Util.bug("Control."^s)

  val debugFlag = false
  fun debug s = if (debugFlag) then Util.outStdErr("Control."^s) else ()  

        
  type serializationInfo = 
             {
                file:    string, (* which filename was serialized *)
                date:    string, (* date as string when it was serialized *)
                version: int     (* version of the serialized file *) 
             }

  datatype filetype = UNKNOWN_FILE 
            | RML_FILE 
            | MO_FILE 
            | RML_AST_FILE
            | RML_FOL_FILE
            | RML_CPS_FILE
            | RML_RDB_FILE
            | INTERFACE_FILE
            | SERIALIZATION_FILE 

    (* version of the serialized files. if we change their format we can discard them easy *)
  val serializationFileVersion = 6
  fun getSerializationInfo(file) = PERSISTENTParse.parseSerializationInfo(file)
    
    (* flag to write the symboltable or not*)
    val emitDebug = ref false
    (* flag to emit the program database or not *)
    val emitRdb = ref false
    (* flag to emit the AST or not *)
    val emitAst = ref false
    (* flag to emit the FOL form or not *)
    val emitFol = ref false
    (* flag to emit the CPS form or not *)
    val emitCps = ref false

    (* flag to output unifications to standard error *)
    val emitUnif = ref false

    (* flag that specifies if only typecheck should be performed, no codegen *)
    val onlyTypeCheck = ref false       

    (* options for ReorderParse *)
    val doReorder = ref true

    (* options for TypeCheck / StatElab *)
    val allowImplicitLet = ref false
    val relaxedTypeCheck = ref false;

    (* options for FOLToCPS *)
    val warnNonExhaustive  = ref false
    val printDFAStatistics = ref false

    (* options for warnings *)
    val disableWarnings  = ref true

    (* options for CodeToC *)
    val switchRewriteThreshold = ref 3

    (* options for Debbuging - added by adrpo@ida.liu.se 2002-06-14 *)
    (* should we do the debugging instrumentation? *)
    val doDebug = ref false;
    
    (* should we do a trace *)
    val doTrace = ref false; 
    
    (* the program database should be qualified? *)
    (* option for including moduleIdent.ident or just ident in the rdb file *)
    val qualifiedRdb = ref true
    (* should we only dump the program database *)
    val rdbOnly      = ref false
    
    (* should we fix the java names? *)
    val fixJavaNames = ref false
    
    (* should we dump the interface? *)
    val dumpInterface = ref false

    (* should we dump the dependency? *)
    val dumpDepends = ref false
    
  (* print import loadinging order  *)
    val importLoadOrder = ref false

  (* what are we currently compiling? *)    
  val currentlyCompiling = ref UNKNOWN_FILE

  (* list of search paths *)
  val iDirs = ref [""]
  (* output path for H files *)
  val oHDir = ref "."
  (* output path for C files *)
  val oCDir = ref "."
  (* output path for temp files *)
  val oTDir = ref "."
    
  (* this one helps in selecting messages depending on what we are currently compiling *)
  fun selectCompilerMessage(strRML, strMMC) =
  (
  case !currentlyCompiling of
    RML_FILE => strRML
  |  MO_FILE => strMMC
  |  _ => bug("selectCompilerMessage: We don't know what file type are we compiling!")
  )
    
  fun fileBase (file) =
    let val {base,ext} = OS.Path.splitBaseExt file
    in
      base
    end

  fun getFileName (file) = OS.Path.file file

  fun fileType (file) =
    let val {base,ext} = OS.Path.splitBaseExt file
    in
    case ext
      of SOME "rml"  => RML_FILE
       | SOME "mo"   => MO_FILE
       | SOME "ast"  => RML_AST_FILE
       | SOME "fol"  => RML_FOL_FILE
       | SOME "cps"  => RML_CPS_FILE
       | SOME "rdb"  => RML_RDB_FILE
       | SOME "sig"  => INTERFACE_FILE        
       | SOME "srz"  => SERIALIZATION_FILE
       | _           => UNKNOWN_FILE
    end
    
    fun getFileExt(RML_FILE)           = "rml"
    |   getFileExt(MO_FILE)            = "mo"  
    |   getFileExt(RML_AST_FILE)       = "ast"
    |   getFileExt(RML_FOL_FILE)       = "fol"
    |   getFileExt(RML_CPS_FILE)       = "cps"
    |   getFileExt(RML_RDB_FILE)       = "rdb"
    |   getFileExt(INTERFACE_FILE)     = "sig"
    |   getFileExt(SERIALIZATION_FILE) = "srz"
    |   getFileExt(_)                  = "unknown"

  fun joinFileExt(file, ext) = 
  let
    val fileName = OS.Path.joinBaseExt {base = file, ext = ext}
  in
    fileName
  end  
  
  fun joinPathFileExt(prefix, file, ext) = 
  let
    val fileName = OS.Path.joinBaseExt {base = file, ext = ext}
    val fullFile = 
          case prefix of 
            ""  => fileName 
          | "." => fileName 
          |  _  => OS.Path.joinDirFile {dir = prefix, file = fileName}
    val fullFile = OS.Path.toUnixPath(fullFile)
  in
    fullFile
  end  
    
  fun pathFileExtSplit (file) =
    let 
       val {base,ext} = OS.Path.splitBaseExt file
       val file = getFileName base
       val prefix = OS.Path.dir base
    in
     (prefix, file, ext)
    end
      
  fun splitFileExt (file) =
    let 
       val {base,ext} = OS.Path.splitBaseExt file
    in
     (base, ext)
    end


  fun fileExists(file) = (* see if there exists a file *)
  let
  in
    (
    if OS.FileSys.access(file, []) 
    then true
    else false
    ) handle exn => (
                      case exn of 
                        OS.SysErr(s, _) => 
                         bug("fileExists Error: " ^ s ^ "! Could not access file: " ^ file);
                         raise exn 
                    )

  end
      
  fun fileNewer(file1, file2) = (* see if file1 is newer than file2 *)
    let val timeFile1 = (OS.FileSys.modTime(file1) handle exn => 
                         (OS.Process.sleep(Time.fromMicroseconds(3500)); OS.FileSys.modTime(file1) handle exn => 
                          (OS.Process.sleep(Time.fromMicroseconds(3500)); OS.FileSys.modTime(file1) handle exn => 
                           (OS.Process.sleep(Time.fromMicroseconds(3500)); OS.FileSys.modTime(file1) handle exn => 
                            (OS.Process.sleep(Time.fromMicroseconds(3500)); OS.FileSys.modTime(file1) handle exn => 
                             (OS.Process.sleep(Time.fromMicroseconds(35000)); OS.FileSys.modTime(file1) handle exn => 
                              (OS.Process.sleep(Time.fromMicroseconds(35000)); OS.FileSys.modTime(file1) handle exn => 
                               (OS.Process.sleep(Time.fromMicroseconds(35000)); OS.FileSys.modTime(file1) handle exn => 
                                (OS.Process.sleep(Time.fromMicroseconds(350000)); OS.FileSys.modTime(file1) handle exn => 
                                 (OS.Process.sleep(Time.fromMicroseconds(350000)); OS.FileSys.modTime(file1) handle exn => 
                                  (case exn of OS.SysErr(s, _) => 
                                   bug("fileNewer Error: " ^ s ^ "! Could not access file: " ^ file1);
                                   raise exn)
                                 ))))))))))
        val timeFile2 = (OS.FileSys.modTime(file2) handle exn => 
                         (OS.Process.sleep(Time.fromMicroseconds(3500)); OS.FileSys.modTime(file2) handle exn => 
                          (OS.Process.sleep(Time.fromMicroseconds(3500)); OS.FileSys.modTime(file2) handle exn => 
                           (OS.Process.sleep(Time.fromMicroseconds(3500)); OS.FileSys.modTime(file2) handle exn => 
                            (OS.Process.sleep(Time.fromMicroseconds(35000)); OS.FileSys.modTime(file2) handle exn => 
                             (OS.Process.sleep(Time.fromMicroseconds(35000)); OS.FileSys.modTime(file2) handle exn => 
                              (OS.Process.sleep(Time.fromMicroseconds(35000)); OS.FileSys.modTime(file2) handle exn => 
                               (OS.Process.sleep(Time.fromMicroseconds(350000)); OS.FileSys.modTime(file2) handle exn => 
                                (OS.Process.sleep(Time.fromMicroseconds(350000)); OS.FileSys.modTime(file2) handle exn => 
                                 (OS.Process.sleep(Time.fromMicroseconds(350000)); OS.FileSys.modTime(file2) handle exn => 
                                  (case exn of OS.SysErr(s, _) => 
                                   bug("fileNewer Error: " ^ s ^ "! Could not access file: " ^ file2);
                                   raise exn)
                                 ))))))))))
    in
      case Time.compare(timeFile1, timeFile2) of
         GREATER => true
       | _ => false
    end
      
  fun getFullFileName(prefix, file, ftype) = 
    let 
      val fullFileName = joinPathFileExt(prefix, file, SOME(getFileExt(ftype)))
    in
      fullFileName      
    end
  
  fun fileCheckSerializationInfo(prefix, fileName, ext) =
    let 
       val serializationFile = getFullFileName(!oTDir, fileName, SERIALIZATION_FILE)
       val file = joinFileExt(fileName, ext)
    in
      if fileExists(serializationFile)
      then let val {file=serializedFile, date=date_str, version=version} = getSerializationInfo(serializationFile)
               val (p, f, e) = pathFileExtSplit(serializedFile)
               val serializedFile = joinFileExt(f, e)
           in
             if (serializedFile = file) andalso (version = serializationFileVersion)
             then true
             else false 
           end
      else false
    end

  fun getIncludesAsString([]) = ""
  |   getIncludesAsString(p::paths) = "-I" ^ p ^ " " ^ getIncludesAsString(paths)

  fun findFileInInclude(prefix, fileName, ext) =
  let 
    val _ = debug("fileExistsInInclude: Searching for file: prefix: " ^ prefix ^ " fileName: " ^ fileName ^ "\n");
    val file = joinFileExt(fileName, ext)
    val fullFileName = joinPathFileExt(prefix, fileName, ext)
    val _ = debug("fileExistsInInclude: Searching for file: " ^ file ^ "\n")
    fun prepathFile(file, paths) =
      case paths of
         nil => bug("findFileInInclude Error: could not find file: " ^ 
                    file ^ 
                    " in any of the given includes: " ^ 
                    getIncludesAsString(!iDirs))
      |    _ => let 
                   val _ = debug("fileExistsInInclude.prePathFile: Searching for file: prefix: " ^ (hd paths) ^ " fileName: " ^ file ^ "\n");
                   val fp = OS.Path.joinDirFile{dir = (hd paths), file = file}
                in
                  if fileExists(fp) then fp
                  else prepathFile(file, tl paths)
                end
  in
    if fileExists(fullFileName) 
    then fullFileName
    else prepathFile(file, !iDirs)
  end
    
  fun isSerializedFileValid(prefix, fileName, ext) = 
  let 
     val serializationFile = getFullFileName(!oTDir, fileName, SERIALIZATION_FILE)
     val file = findFileInInclude(prefix, fileName, ext)
  in
    if fileExists(file) andalso 
       fileExists(serializationFile) andalso
       fileNewer(serializationFile, file) andalso 
       fileCheckSerializationInfo(prefix, fileName, ext) 
    then true
    else false 
  end
  
  datatype 'a outcome = OK of 'a | ERR of exn
  
  (* this function reads the first line of the text file given *)
  fun readFirstLine(file) = 
  (
    let val is = TextIO.openIn file
        (* read the first line and see if the file is right! *)
      val outcome = (OK(TextIO.inputN(is,18+String.size(file)))) handle exn => ERR exn
      in
      TextIO.closeIn is;
      case outcome of (OK result) => result | (ERR exn) => raise exn
      end
  )
  
  (* this function sees if the interface (.sig) of the file is the actual interface of this file *)
  fun fileCheckInterfaceFile(prefix, fileName, ext) =
  let 
     val interfaceFile = getFullFileName(!oTDir, fileName, INTERFACE_FILE)
  in
    if fileExists(interfaceFile) andalso 
       readFirstLine(interfaceFile) = "(*interfaceOf[" ^ joinFileExt(fileName, ext) ^ "]*)"
    then true
    else false
  end
  
  fun isInterfaceFileValid(prefix, fileName, ext) = 
  let 
    val interfaceFile = getFullFileName(!oTDir, fileName, INTERFACE_FILE)
    val file = joinPathFileExt(prefix, fileName, ext)
  in
    if fileExists(file) andalso (* fileExists(interfaceFile) andalso *)
       fileNewer(interfaceFile, file) andalso 
       fileCheckInterfaceFile(prefix, fileName, ext) 
    then true
    else false 
  end  
  
  (* datatype for the result if is ok or if is error *)
  datatype 'a outcome = OK of 'a | ERR of exn

  fun removeFile(file) =
  let
    val x = OS.FileSys.remove(file) (* remove the file *)
                         handle exn => (
                                    case exn of 
                                    OS.SysErr(s, _) => ()
                                      (* 
                                      bug("removeFile Error: " ^ s ^ "! Could not remove temporary file: " ^ file);
                                      raise exn 
                                      *)
                                   )
  in
    x
  end 

  fun getTempFileName(file) =
  let
     val tempFile = OS.FileSys.tmpName() handle exn => 
                    (OS.Process.sleep(Time.fromMicroseconds(1400)); OS.FileSys.tmpName() handle exn => 
                     (OS.Process.sleep(Time.fromMicroseconds(1400)); OS.FileSys.tmpName() handle exn => 
                      (OS.Process.sleep(Time.fromMicroseconds(14000)); OS.FileSys.tmpName() handle exn => 
                       (OS.Process.sleep(Time.fromMicroseconds(14000)); OS.FileSys.tmpName() handle exn => 
                        (OS.Process.sleep(Time.fromMicroseconds(14000)); OS.FileSys.tmpName() handle exn => 
                         (OS.Process.sleep(Time.fromMicroseconds(14000)); OS.FileSys.tmpName() handle exn => 
                          (OS.Process.sleep(Time.fromMicroseconds(140000)); OS.FileSys.tmpName() handle exn => 
                           (OS.Process.sleep(Time.fromMicroseconds(140000)); OS.FileSys.tmpName() handle exn => 
                            (OS.Process.sleep(Time.fromMicroseconds(140000)); OS.FileSys.tmpName() handle exn => 
                    (
                      case exn of OS.SysErr(s, _) 
                      => bug("getTempFileName Error: " ^ s ^ "! Could not create temporary file for file: " ^ file);
                      raise exn
                    ))))))))))
  in
    tempFile
  end

  fun renameFile(old, new) =
  let
  in
      OS.FileSys.rename{old = old, new = new}
                           handle exn => (
                                    case exn of 
                                    OS.SysErr(s, _) => ()
                                    (*
                                      bug("renameFile Error: " ^ s ^ "! Could not rename file: " ^ old ^ " to: " ^ new);
                                      raise exn
                                    *)
                                   )
  end
    
  (* function to write files with error handling *)
  fun withOutputOption f arg2 (prefix, fileName, ext) =
    let 
      val fullFileName = joinPathFileExt(prefix, fileName, ext)
      val tempFileFull = getTempFileName(fullFileName) (* get the temp file name, i.e. /tmp/fileXAXYUA *)
      val tempFile = getFileName(tempFileFull) (* get only the name of the temp file *)
      val os = TextIO.openOut tempFile
      val outcome = (OK(f(SOME(os), arg2))) handle exn => ERR exn
    in
      TextIO.closeOut os;
      case outcome 
        of (OK result) => 
        (
          renameFile(tempFile, fullFileName);  (* rename the file *)
          removeFile(tempFileFull); (* remove the file in temp *)
          result (* return the result *)
        )
      | (ERR exn) => 
        (
          renameFile(tempFile, fullFileName);  (* rename the file *)
          removeFile(tempFileFull); (* remove the file in temp *)
          raise exn (* return the exception *)
        )
    end

  (* function to write files with error handling *)
  fun withOutput f arg2 (prefix, fileName, ext) =
    let 
      val fullFileName = joinPathFileExt(prefix, fileName, ext)
      val tempFileFull = getTempFileName(fullFileName) (* get the temp file name, i.e. /tmp/fileXAXYUA *)
      val tempFile = getFileName(tempFileFull) (* get only the name of the temp file *)
      val os = TextIO.openOut tempFile
      val outcome = (OK(f(os, arg2))) handle exn => ERR exn
    in
      TextIO.closeOut os;
      case outcome 
        of (OK result) => 
        (
          renameFile(tempFile, fullFileName);  (* rename the file *)
          removeFile(tempFileFull); (* remove the file in temp *)
          result (* return the result *)
        )
      | (ERR exn) => 
        (
          renameFile(tempFile, fullFileName);  (* rename the file *)
          removeFile(tempFileFull); (* remove the file in temp *)
          raise exn (* return the exception *)
        )
    end
      
  (* function to write files with error handling *)
  fun withOutputStream f arg2 os =
    let 
      val outcome = (OK(f(os, arg2))) handle exn => ERR exn
    in
      case outcome of (OK result) => result | (ERR exn) => raise exn
    end
      
  (* function to write files with error handling *)
  fun withOut f arg2 =
    let 
      val outcome = (OK(f(TextIO.stdErr, arg2))) handle exn => ERR exn
    in
      case outcome of (OK result) => result | (ERR exn) => raise exn
    end
           
  end (* structure Control *)
