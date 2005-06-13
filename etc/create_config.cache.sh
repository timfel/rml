#!/bin/sh
# install script for binary rml

PATH="/bin:/usr/bin:$PATH"

T=`etc/config.guess`

TARGET=`echo $T | cut -f 2 -d =`

RML_PREFIX_DIR=`pwd`
RML_PREFIX="$RML_PREFIX_DIR"

(echo $T ; echo PREFIX=\"$RML_PREFIX/$TARGET\" ; echo DEBUGLIB=librml_g.a ; echo PROFLIB=librml_p.a) > config.cache
(echo PATH=\"$RML_PREFIX/$TARGET/bin\":\$PATH) > set_rml_path
rm -f \"$RML_PREFIX/$TARGET/bin/rml.bat\"
CYG_RML_PATH=`cygpath -w "$RML_PREFIX/$TARGET/bin/"`
(echo \"$CYG_RML_PATH\\run.x86-win32.exe\" @SMLquiet @SMLload=\"$CYG_RML_PATH\\rml.x86-win32\" %1 %2 %3 %4 %5 %6 %7 %8 %9) > "$RML_PREFIX/$TARGET/bin/rml.bat"
chmod +x "$RML_PREFIX/$TARGET/bin/rml.bat"
cd etc
make install-rmlc
cd ..

