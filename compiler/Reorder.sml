(* Reorder.sml *)

structure Reorder =
  ReorderFn(structure ReorderTy = ReorderTy
            structure ReorderVal = ReorderVal);
