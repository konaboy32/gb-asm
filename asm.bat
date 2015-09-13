@echo off
cls
color 02	
REM SIMPLE COMMAND.COM SCRIPT TO ASSEMBLE GAMEBOY FILES
REM REQUIRES MAKELNK.BAT
REM JOHN HARRISON
REM UPDATED 2008-01-28

if not exist obj mkdir obj
del obj\*.* /Q
REM IF THERE ARE SETTINGS WHICH NEED TO BE DONE ONLY ONCE, PUT THEM BELOW
rem if not %ASSEMBLE%1 == 1 goto begin
rem path=%path%;c:\gameboy\assembler\
rem doskey UNNECESSARY ON DESKTOP --- DOSKEY ALREADY INSTALLED
rem set dir=c:\gameboy\curren~1\
cmd /c makelnk %1 > obj\%1.link

:begin
set assemble=1
echo -------------- assembling ----------------------
asm\rgbasm95 -iinc\ -oobj\%1.obj src\%1.asm
if errorlevel 1 goto oops
echo -------------- linking -------------------------
asm\xlink95 -mobj\map obj\%1.link
if errorlevel 1 goto oops
echo -------------- fixing --------------------------
asm\rgbfix95 -v obj\%1
if errorlevel 1 goto oops
echo -------------- emulating -----------------------
set emuhome=C:\gameboy\emu\bgb
%emuhome%\bgb.exe obj\%1.gb
goto end

:oops
color 04
echo ============== error ===========================
goto :eof

:end
echo -------------- done ----------------------------
rem del *.obj