(* main/version.sml *)

functor VersionFn(structure SysDep : SYSDEP) : VERSION =
  struct

    val versionNumber = "2.4.6"
    (*let val is = TextIO.openIn "RELEASE"
          val line = TextIO.inputLine is
          val is = TextIO.closeIn is
      in
          String.substring(line, 0, String.size line - 1)
      end*)
    val builtDate = "2010-12-14 05:22"
    val builtUsing = SysDep.smlVersion

  end (* functor VersionFn *)
