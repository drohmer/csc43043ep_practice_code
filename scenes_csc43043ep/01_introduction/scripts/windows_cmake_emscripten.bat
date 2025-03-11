@ECHO OFF


Rem Make sure we are in the directory containing the .bat script
cd %~dp0

Rem Go to the root directory
cd ..

WHERE emcmake >nul 2>nul
IF %ERRORLEVEL% NEQ 0 GOTO :LocateEmsdk
GOTO :RunCMake

:LocateEmsdk
ECHO Command 'emcmake' from emsdk was not found automatically.
SET /P EmsdkRoot="Please enter the path to your emsdk root: "
@call %EmsdkRoot%/emsdk_env.bat
GOTO :RunCMake

:RunCMake
ECHO Run CMake (into build-web/ directory)
ECHO ===============================

emcmake cmake -B build-web && (
    ECHO.
    ECHO ===============================
    ECHO CMAKE Generated with success
    ECHO You may now compile using 'ninja' in the build-web/ directory
    ECHO.
) || (
    ECHO.
    ECHO ===============================
    ECHO CMAKE Failed to generate the project
    ECHO Please check the error indicated by CMAKE
    ECHO If 'emcmake' is not recognized, make sure to run emsdk/emsdk_env.bat
    ECHO -- from emscripten installation directory -- before running this script.
    ECHO.
)
Rem The previous command call cmake with the default target project
Rem   Specific targets use -G option from cmake
Rem   ex. cmake -G "Visual Studio 17 2020" ..



PAUSE