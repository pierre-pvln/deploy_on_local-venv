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

SET ERROR_MESSAGE=[%ME%] [INFO ] No error

SET "VENV_CONF_PATH=..\..\..\code\py_conf\_legion-2020-venv\"
SET "VENV_APP_PATH=..\..\..\code\py_app\"
SET "VENV_ENV_NAME_FILE=%VENV_CONF_PATH%_env_name.txt"
SET "VENV_CONF_TXT_FILE=%VENV_CONF_PATH%requirements.txt"

:: set python / venv environment name
IF EXIST %VENV_ENV_NAME_FILE% (
	SET /p venv_environment=<%VENV_ENV_NAME_FILE%
)
IF "%venv_environment%" == "" (
	SET ERROR_MESSAGE=[%ME%] [ERROR] file %VENV_ENV_NAME_FILE% does not exist or is empty ...
	GOTO ERROR_EXIT
)

:: expand the environments path 
SET "venv_environment_path=%VENV_APP_PATH%%venv_environment%"

IF NOT EXIST %VENV_APP_PATH%%venv_environment% (
	SET ERROR_MESSAGE=[%ME%] [ERROR] %VENV_APP_PATH%%venv_environment% does not exist, so nothing to do ...
	GOTO ERROR_EXIT
)

IF "%COMPUTERNAME%"=="LEGION-2020"     GOTO :LEGION-2020

:Default
SET ERROR_MESSAGE=[%ME%] [ERROR] Unknown settings for COMPUTERNAME: %COMPUTERNAME% ...
GOTO ERROR_EXIT

:LEGION-2020
IF "%USERNAME%"=="developer" (
   echo [%ME%] [INFO ] Commands for %USERNAME% on %COMPUTERNAME% ...
   echo [%ME%] [INFO ] Purging %venv_environment_path% ...
   echo.
   
   echo [%ME%] [INFO ] Exporting the latest settings ...
   call export_venv_env.cmd
   echo.
   
   echo [%ME%][INFO ] Removing %venv_environment_path% ...
   cd %VENV_APP_PATH%
   rmdir /S %venv_environment% 
   echo.
   
   cd %CMD_DIR%
   echo [%ME%] [INFO ] Creating new %venv_environment_path% ...
   call create_py313_venv_env_from_file
   echo.
   
   GOTO CLEAN_EXIT
)

IF "%USERNAME%"=="myAdm" (
   echo [%ME%] [INFO ] Commands for %USERNAME% on %COMPUTERNAME% ...
   echo [%ME%] [INFO ] Purging %venv_environment_path% ...
   echo.
   
   echo [%ME%] [INFO ] Exporting the latest settings ...
   call export_venv_env.cmd
   echo.
   
   echo [%ME%][INFO ] Removing %venv_environment_path% ...
   cd %VENV_APP_PATH%
   rmdir /S %venv_environment% 
   echo.
   
   cd %CMD_DIR%
   echo [%ME%] [INFO ] Creating new %venv_environment_path% ...
   call create_py313_venv_env_from_file
   echo.

   GOTO CLEAN_EXIT
)
SET ERROR_MESSAGE=[%ME%] [ERROR] Not a valid user (%USERNAME%) on %COMPUTERNAME% ...
GOTO ERROR_EXIT

:ERROR_EXIT
ECHO %ERROR_MESSAGE%

:CLEAN_EXIT
CD %CMD_DIR%
::timeout /t 10
PAUSE
