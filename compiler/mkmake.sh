#!/bin/sh
# Determine how to invoke SML/NJ's compilation manager.

#set -x
SMLCM=$1

echo 'let val _ = CM.autoload "$smlnj/cm/full.cm" in OS.Process.exit OS.Process.failure end;' | $SMLCM > /dev/null 2>&1
    # 110.17 or older
    CMINIT='Control.shareDefError := false'
    CMMAKE='CM.make("sources.cm")'

# uncomment this if you have problems with the compilation
# echo "val _ = ${CMINIT};"
echo "val _ = ${CMMAKE};"
echo 'val _ = SMLofNJ.exportFn("rml", Start.start Main.main);'

exit 0
