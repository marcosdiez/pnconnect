@echo off
::Set Environments for X86_64 build
cd %~dp0
call "%ProgramFiles(x86)%\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
where cl.exe link.exe

::Set Environment Variables
set NAME=pnconnect
set BINDIR=bin
set SRCDIR=src
set CFLAGS=/c /nologo /O1 /MD /W4 /Fo%BINDIR%\\
set LFLAGS=/nologo /MACHINE:X64
set LIBS=Ntdll.lib Ole32.lib lib\p9np.lib

:: Disable MSVC warnings
set CCOPT=/wd"4201" /wd"4214"

::Build
rd /s /q %BINDIR%
mkdir %BINDIR%
cl.exe %CFLAGS% %CCOPT% %SRCDIR%\*.c
link.exe %LFLAGS% %LIBS% %BINDIR%\*.obj /OUT:%BINDIR%\%NAME%.exe

dir /B %BINDIR%\*.exe
:: pause
exit /b

::END#