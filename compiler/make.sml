val _ = Control.shareDefError := false;
val _ = CM.make("sources.cm");
val _ = SMLofNJ.exportFn("rml", Start.start Main.main);
