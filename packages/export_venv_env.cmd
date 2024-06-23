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

SET ERROR_MESSAGE=[INFO ] No error

SET "VENV_CONF_PATH=..\..\..\code\py_conf\_legion-2020-venv\"
SET "VENV_APP_PATH=..\..\..\code\py_app\"
SET "VENV_ENV_NAME_FILE=%VENV_CONF_PATH%_env_name.txt" 
SET "VENV_CONF_TXT_FILE=%VENV_CONF_PATH%requirements.txt"

:: set python / venv environment name
IF EXIST %VENV_ENV_NAME_FILE% (
	SET /p venv_environment=<%VENV_ENV_NAME_FILE%
)
IF "%venv_environment%" == "" (
	SET ERROR_MESSAGE=[ERROR] file %VENV_ENV_NAME_FILE% does not exist or is empty ...
	GOTO ERROR_EXIT
)

:: expand the environments path 
SET "venv_environment_path=%VENV_APP_PATH%%venv_environment%"


:: set python / venv environments.txt file
IF NOT EXIST %VENV_ENV_NAME_FILE% (
	SET ERROR_MESSAGE=[ERROR] file %VENV_CONF_TXT_FILE% does not exist ...
	GOTO ERROR_EXIT
)

:: Sets the proper date and time stamp with 24Hr Time for log file naming convention
:: source http://stackoverflow.com/questions/1192476/format-date-and-time-in-a-windows-batch-script
::
SET HOUR=%time:~0,2%
SET dtStamp9=%date:~6,4%%date:~3,2%%date:~0,2%_0%time:~1,1%%time:~3,2%%time:~6,2%
SET dtStamp24=%date:~6,4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%%time:~6,2%
IF "%HOUR:~0,1%" == " " (SET dtStamp=%dtStamp9%) ELSE (SET dtStamp=%dtStamp24%)

IF "%COMPUTERNAME%"=="LEGION-2020"     GOTO :LEGION-2020

:Default
SET ERROR_MESSAGE=[ERROR] Unknown settings for COMPUTERNAME: %COMPUTERNAME% ...
GOTO ERROR_EXIT

:LEGION-2020
IF "%USERNAME%"=="developer" (
   echo [INFO ] Commands for %USERNAME% on %COMPUTERNAME% ...
   echo [INFO ] Using %venv_environment_path%\Scripts\activate.bat as command
   call %venv_environment_path%\Scripts\activate.bat
   echo [INFO ] Exporting venv environment %venv_environment_path% ...
   call pip freeze > venv_env_as-built_LATEST.txt
   call pip freeze > venv_env_as-built_%dtStamp%.txt
   GOTO CLEAN_EXIT
)

IF "%USERNAME%"=="myAdm" (
   echo [INFO ] Commands for %USERNAME% on %COMPUTERNAME% ...
   echo [INFO ] Using %venv_environment_path%\Scripts\activate.bat as command
													
   call %venv_environment_path%\Scripts\activate.bat
   echo [INFO ] Exporting venv environment %venv_environment_path% ...
   call pip freeze > venv_env_as-built_LATEST.txt
   call pip freeze > venv_env_as-built_%dtStamp%.txt
   GOTO CLEAN_EXIT
)

SET ERROR_MESSAGE=[ERROR] Not a valid user (%USERNAME%) on %COMPUTERNAME% ...
GOTO ERROR_EXIT

:ERROR_EXIT
ECHO %ERROR_MESSAGE%

:CLEAN_EXIT
CD %CMD_DIR%
timeout /t 5
