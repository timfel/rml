echo Fixing the stack size!
editbin /stack:100000000 Debug\RML.exe
editbin /stack:100000000 Release\RML.exe
copy Release\RML.exe \bin\rml.sml.net\rml.exe
copy Release\RML.exe \bin\rml.sml.net\rml.net.exe
copy Debug\RML.exe \bin\rml.sml.net\rml.net.debug.exe
copy Release\RML.exe ..\x86-cygwin-gcc\bin\rml.exe
copy Release\RML.exe ..\x86-cygwin-gcc\bin\rml.net.exe
copy Debug\RML.exe ..\x86-cygwin-gcc\bin\rml.net.debug.exe
pause