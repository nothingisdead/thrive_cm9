@setlocal
@echo off

set JDK_HOME=C:\Java\jdk1.6.0_25
set JAVA_EXE=%JDK_HOME%\bin\java.exe
set JAR_EXE=%JDK_HOME%\bin\jar.exe

set TODAY=%year%-%month%-%day%-%hour%-%minutes%

%JAR_EXE% cf %CD%\unsigned-update.zip -C %CD%\src\ .

%JAVA_EXE% -classpath %CD%\build\testsign.jar testsign %CD%\unsigned-update.zip update-%TODAY%.zip


