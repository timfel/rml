(* main/control.sml *)

signature CONTROL =
  sig
          
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
  val serializationFileVersion: int
  val getSerializationInfo: string -> serializationInfo
  
  (* flag to write the symboltable or not*)
  val emitDebug : bool ref
  (* flag to emit the program database or not *)
  val emitRdb   : bool ref
  (* flag to emit the AST or not *)
  val emitAst   : bool ref
  (* flag to emit the FOL form or not *)
  val emitFol   : bool ref
  (* flag to emit the CPS form or not *)
  val emitCps   : bool ref

  (* flag to output unifications to standard error *)
  val emitUnif : bool ref


  (* flag that specifies if only typecheck should be performed, no codegen *)
  val onlyTypeCheck : bool ref
  
  (* options for ReorderParse *)
  val doReorder: bool ref

  (* options for TypeCheck / StatElab *)
  val allowImplicitLet: bool ref
  val relaxedTypeCheck: bool ref

  (* options for FOLToCPS *)
  val warnNonExhaustive: bool ref
  val printDFAStatistics: bool ref    

  (* options for warnings *)
  val disableWarnings: bool ref

  (* options for CodeToC *)
  val switchRewriteThreshold: int ref

  (* should we do the debugging instrumentation? *)
  val doDebug: bool ref

  (* should we do a trace *)
  val doTrace: bool ref
    
  (* the program database should be qualified? *)
  val qualifiedRdb: bool ref

  (* should we only dump the program database *)
  val rdbOnly: bool ref
    
  (* should we fix the java names? *)
  val fixJavaNames : bool ref
    
  (* should we dump the interface? *)
  val dumpInterface : bool ref
    
  (* should we dump the dependency? *)
  val dumpDepends : bool ref
    
  (* what are we currently compiling? *)
  val currentlyCompiling : filetype ref
    
  (* this one helps in selecting messages depending on what we are currently compiling *)
  val selectCompilerMessage: string * string -> string    
  
  val getFileName:   string -> string
  val fileBase:   string -> string
  val fileType:   string -> filetype
  val getFileExt: filetype -> string
  val pathFileExtSplit:  string -> string * string * string option
  val splitFileExt:  string -> string * string option
  val fileExists: string -> bool    
  val fileNewer: string * string -> bool (* see if file1 is newer than file2 *)
  val getFullFileName: string * string * filetype -> string 
  val fileCheckSerializationInfo: string * string * string option -> bool
  val isSerializedFileValid: string * string  * string option -> bool
  val isInterfaceFileValid:  string * string * string option -> bool
  val joinPathFileExt: string * string * string option -> string
  val joinFileExt: string * string option -> string
  
  (* datatype for the result if is ok or if is error *)
  datatype 'a outcome = OK of 'a | ERR of exn
    
  (* function to write files with error handling *)
  val withOutputOption: (TextIO.outstream option * 'a -> 'b) -> 'a -> (string*string*string option) -> 'b
  (* function to write files with error handling *)
  val withOutput      : (TextIO.outstream * 'a -> 'b) -> 'a -> (string*string*string option) -> 'b     
  (* function to write files with error handling *)
  val withOutputStream: ('a * 'b -> 'c) -> 'b -> 'a -> 'c
  (* function to write files with error handling *)
  val withOut         : (TextIO.outstream * 'a -> 'b) -> 'a -> 'b
  
  (* print import loadinging order  *)
  val importLoadOrder : bool ref

  (* list of search paths *)
  val iDirs : string list ref
  (* output path for H files *)
  val oHDir : string ref
  (* output path for C files *)
  val oCDir : string ref
  (* output path for temp files *)
  val oTDir : string ref
  
end (* signature CONTROL *)

