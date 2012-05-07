@echo off
title Manual Packager
for /f "tokens=1,2 delims==" %%G in (settings.ini) do set %%G=%%H
if [%encoding_prep%]==[yes] goto :first
if [%encoding_prep%]==[no] call "%bindir%\global_encoding.bat" %0
goto :end

:first
cls
echo        лллллллллллллллллллллллллллллллллллллллллллллллллллллл
echo        л                                                    л
echo        л             "%packager%" command line              л
echo        л                                                    л
echo        л                    (0 to exit)                     л
echo        л                                                    л
echo        лллллллллллллллллллллллллллллллллллллллллллллллллллллл
%packager% --informal-help
:ask_command
set /p command= %packager% 
if ["%command%"]==["0"] goto :done
if ["%command%"]==[""] goto :ask_command
%external%\%packager% %command%
%external%\wait 2
goto :first

:done
call "%bindir%\global_messages.bat" "END"
goto :end

:end
exit
