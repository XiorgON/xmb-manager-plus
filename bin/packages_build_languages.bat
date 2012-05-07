@echo off
title Build Languages
for /f "tokens=1,2 delims==" %%G in (settings.ini) do set %%G=%%H
if [%encoding_prep%]==[yes] goto :first
if [%encoding_prep%]==[no] call "%bindir%\global_encoding.bat" %0
goto :end

:first
if not exist %pkgsource%\core-hdd0\XMBMANPLS goto :error_source
call "%bindir%\global_messages.bat" "BUILDING"
for /f "tokens=1,2 delims=." %%X IN ('dir /b %languageinisdir%\*.ini') DO (
%external%\%packager% package.conf %pkgsource%\languagepacks\%%X\XMBMANPLS
rename UP0001-XMBMANPLS_00-0000000000000000.pkg XMBM+v%working_version%-LANGUAGEPACK-%%X.pkg
)
if not exist "%pkgoutput%" mkdir "%pkgoutput%"
move %bindir%\*.pkg "%pkgoutput%\"

:done
call "%bindir%\global_messages.bat" "BUILD-OK"
goto :end

:error_source
call "%bindir%\global_messages.bat" "ERROR-NO-SOURCE"
goto :end

:end
exit
