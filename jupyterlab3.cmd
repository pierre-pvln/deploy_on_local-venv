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
SET ERROR_MESSAGE=[%ME%] [ERROR] Unknown settings for COMPUTERNAME: %COMPUTERNAME% ...
GOTO ERROR_EXIT

:LEGION-2020
::ECHO debug jupyter
::dir %APPDATA%\jupyter\kernels
::ECHO ==============
::dir %APPDATA%\jupyter\kernels\%venv_environment%
::ECHO ==============
::dir %APPDATA%\jupyter\kernels\%venv_environment%\kernel.json
::ECHO ==============

:: https://medium.com/@royce963/setting-up-jupyterlab-and-a-virtual-environment-c79002e0e5f7
:: C:\Users\developer\AppData\Roaming\jupyter\kernels\.venv
IF NOT EXIST %APPDATA%\jupyter\kernels\%venv_environment%\kernel.json (
	SET ERROR_MESSAGE=[%ME%] [ERROR] %APPDATA%\jupyter\kernels\%venv_environment%\kernel.json not found ...
	ECHO [%ME%] Activate the virtual environment %venv_environment%
    ECHO [%ME%] and	execute command:
	ECHO [%ME%] python -m ipykernel install --user --name=%venv_environment%
	GOTO ERROR_EXIT
)
IF "%USERNAME%"=="developer" (
   echo Running jupyter lab for %USERNAME% on %COMPUTERNAME%
   echo for the %venv_environment% environment
   cd .\py_app
   call %venv_environment%\Scripts\activate.bat
   
   call jupyter lab
   GOTO CLEAN_EXIT
)

IF "%USERNAME%"=="pierre" (
   echo Running jupyter lab for %USERNAME% on %COMPUTERNAME%
   echo for the %venv_environment% environment
   cd .\py_app
   call %venv_environment%\Scripts\activate.bat
   call jupyter lab
   GOTO CLEAN_EXIT
)

SET ERROR_MESSAGE=[%ME%] [ERROR] Not a valid user (%USERNAME%) on %COMPUTERNAME% ...
GOTO ERROR_EXIT

:ERROR_EXIT
ECHO %ERROR_MESSAGE%

:CLEAN_EXIT
CD %CMD_DIR%
