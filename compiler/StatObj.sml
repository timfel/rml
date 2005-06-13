(* StatObj.sml *)

structure StatObj =
  StatObjFn(structure Absyn = Absyn
            structure TyFcn = TyFcn
            structure TyScheme = TyScheme);
