@setlocal
@echo off
rem This script assumes that you have the JAVA_HOME environment variable set
rem in Windows to the location of your JDK.  If you do not this script will not run correctly.

rem Set up all of the java variables
set JDK_HOME=%JAVA_HOME%
set JAVA_EXE=%JDK_HOME%\bin\java.exe
set JAR_EXE=%JDK_HOME%\bin\jar.exe

rem DO NOT CHANGE ANYTHING BELOW THIS LINE

rem Date & Time variables for the build number and file name
set year=%date:~-4%
set month=%date:~7,2%
set day=%date:~4,2%
set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%
set secs=%time:~6,2%
if "%secs:~0,1%" == " " set secs=0%secs:~1,1%

set BUILDSTAMP=%year%-%day%-%month%_%hour%%min%%secs%

rem Create the unsigned zip file in the dir that we are currently in
%JAR_EXE% cf %CD%\..\unsigned-update.zip -C %CD%\..\src\ .

rem Sign the build file
%JAVA_EXE% -classpath %CD%\testsign.jar testsign %CD%\..\unsigned-update.zip %CD%\..\update-%BUILDSTAMP%.zip

rem Delete the unsigned zip file as we no longer need it
del %CD%\..\unsigned-update.zip