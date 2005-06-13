(* test.sml *)

val tSites = ref(#[] : RDB.SiteDesc Vector.vector);
val t = RDB.MODULE{modId = "Test", srcFile = "test.sml", siteDescs = tSites,
		   bptArr = Array.array(10, RDB.STEP),
		   frameDesc = RDB.FRAME #[("t1",Dynamic.tyInt)],
		   frameVals = #[Dynamic.INT 99]};
val smain0 = RDB.SITE{region = (0,0), modDesc = t, siteNo = 0, procId = "main",
		      frameDesc = RDB.FRAME #[]};
val smain1 = RDB.SITE{region = (1,1), modDesc = t, siteNo = 1, procId = "",
		      frameDesc = RDB.FRAME #[("m1",Dynamic.tyString)]};
val smain2 = RDB.SITE{region = (2,2), modDesc = t, siteNo = 2, procId = "",
		      frameDesc = RDB.FRAME #[("m2",Dynamic.tyInt)]};
val sfoo0 = RDB.SITE{region = (3,3), modDesc = t, siteNo = 3, procId = "foo",
		     frameDesc = RDB.FRAME #[("f1",Dynamic.APPLY(#[Dynamic.tyInt],Dynamic.sayList))]};
val _ = tSites := #[smain0,smain1,smain2,sfoo0];
val _ = RDB.initMod t;

fun foo f1 =
  let val e0 = RDB.entry(sfoo0, #[f1])
  in
    Dynamic.INT 77
  end

fun main() =
  let val e0 = RDB.entry(smain0, #[])
      val m1 = Dynamic.STRING "main.m1"
      val e1 = RDB.call(smain1, #[m1], e0)
      val m2 = foo(Dynamic.STRUCT(1,#[Dynamic.INT 88, Dynamic.STRUCT(0,#[])]))
      val e2 = RDB.call(smain2, #[m2], e1)
  in
    RDB.reset()
  end
