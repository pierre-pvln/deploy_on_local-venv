@ECHO off
SETLOCAL ENABLEEXTENSIONS

:: BASIC SETTINGS
:: ==============
:: Setting the name of the script
SET ME=%~n0
:: Setting the name of the directory
SET PARENT=%~p0
SET PDRIVE=%~d0
:: Setting the directory and drive of this commandfile
SET CMD_DIR=%~dp0

:: goto to correct startpoint/directory for the IDE
CD ..\..\code
SET "IDE_START_DIR=%CD%"

IF "%COMPUTERNAME%"=="LEGION-2020"     GOTO :LEGION-2020

:Default
SET ERROR_MESSAGE=[ERROR] Unknown settings for COMPUTERNAME: %COMPUTERNAME% ...
GOTO ERROR_EXIT

:LEGION-2020
IF "%USERNAME%"=="developer" (
   echo Running PyCharm IDE for %USERNAME% on %COMPUTERNAME%
   echo for the %venv_environment% environment    
   cd .\py_app
   call %venv_environment%\Scripts\activate.bat
   call "C:\Program Files\JetBrains\PyCharm Community Edition 2023.2.3\bin\pycharm64.exe" "%IDE_START_DIR%"
   GOTO CLEAN_EXIT
)

IF "%USERNAME%"=="pierre" (
   echo Running PyCharm IDE for %USERNAME% on %COMPUTERNAME%
   echo for the %venv_environment% environment    
   cd .\py_app
   call %venv_environment%\Scripts\activate.bat
   call "C:\Program Files\JetBrains\PyCharm Community Edition 2023.2.3\bin\pycharm64.exe" "%IDE_START_DIR%"
   GOTO CLEAN_EXIT
)

SET ERROR_MESSAGE=[ERROR] Not a valid user (%USERNAME%) on %COMPUTERNAME% ...
GOTO ERROR_EXIT

:ERROR_EXIT
ECHO %ERROR_MESSAGE%

:CLEAN_EXIT
CD %CMD_DIR%
