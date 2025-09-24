@ECHO off
SETLOCAL ENABLEEXTENSIONS

:: BASIC SETTINGS
:: ==============
:: Setting the name of the script
SET ME=%~n0

:: Check if script is run as subscript. If so add IDENT_TEXT to ECHO
SET INDENT_TEXT=
:: FIND command returns errorlevel 1 if string not found
:: in this case if ME is not in CMDCMDLINE 
ECHO %CMDCMDLINE% | FIND /i "%ME%" >nul
IF %ERRORLEVEL%==1 (
   SET "INDENT_TEXT=[SUBSCRIPT] "
)

ECHO.
ECHO ==============================================
ECHO %INDENT_TEXT%[%ME%] [INFO ] Script started ...

:: Setting the name of the directory
SET PARENT=%~p0
SET PDRIVE=%~d0
:: Setting the directory and drive of this commandfile
SET CMD_DIR=%~dp0

SET ERROR_MESSAGE=[%ME%] [INFO ] No error

SET "VENV_CONF_PATH=..\..\..\code\py_conf\_legion-2020-venv\"
SET "VENV_APP_PATH=..\..\..\code\py_app\"
SET "VENV_ENV_NAME_FILE=%VENV_CONF_PATH%_env_name.txt"

SET "VENV_CONF_TXT_FILE=%VENV_CONF_PATH%\requirements.txt"
IF EXIST "%VENV_CONF_PATH%\requirements\" (
   SET "VENV_CONF_TXT_FILE=%VENV_CONF_PATH%\requirements\requirements.txt"
)

SET "PYTHON_VERSION=Python311"
SET "PYTHON_EXCUTABLE=C:\Users\%USERNAME%\AppData\Local\Programs\Python\%PYTHON_VERSION%\python"

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


:: set python / venv requirements.txt file
IF NOT EXIST %VENV_ENV_NAME_FILE% (
	SET ERROR_MESSAGE=[%ME%] [ERROR] file %VENV_CONF_TXT_FILE% does not exist ...
	GOTO ERROR_EXIT
)

IF "%COMPUTERNAME%"=="LEGION-2020"     GOTO :LEGION-2020

:Default
SET ERROR_MESSAGE=[%ME%] [ERROR] Unknown settings for COMPUTERNAME: %COMPUTERNAME% ...
GOTO ERROR_EXIT

:LEGION-2020
IF "%USERNAME%"=="developer" (
   ECHO %INDENT_TEXT%[%ME%] [INFO ] Commands for %USERNAME% on %COMPUTERNAME% ...
   ECHO %INDENT_TEXT%[%ME%] [INFO ] Creating new venv at %venv_environment_path% 
   ECHO %INDENT_TEXT%[%ME%] [INFO ] Using python version:
   %PYTHON_EXCUTABLE% -V
   echo.
   
   IF EXIST %venv_environment_path% (
       SET ERROR_MESSAGE=[%ME%] [ERROR] %venv_environment_path% already exists ...
       GOTO ERROR_EXIT
   )
   %PYTHON_EXCUTABLE% -m venv %venv_environment_path%
   echo .   
   cd %CMD_DIR%
   ECHO %INDENT_TEXT%[%ME%] [INFO ] Creating %venv_environment_path% ...
   call  update_venv_env_from_file
   echo.

   GOTO CLEAN_EXIT
)

IF "%USERNAME%"=="myAdm" (
   ECHO %INDENT_TEXT%[%ME%] [INFO ] Commands for %USERNAME% on %COMPUTERNAME% ...
   ECHO %INDENT_TEXT%[%ME%] [INFO ] Creating new venv at %venv_environment_path% 
   ECHO %INDENT_TEXT%[%ME%] [INFO ] Using python version:
   %PYTHON_EXCUTABLE% -V
 
   ECHO %INDENT_TEXT%[%ME%] [INFO ] Creating structure for %venv_environment_path% ...
   IF EXIST %venv_environment_path% (
       SET ERROR_MESSAGE=[%ME%] [ERROR] %venv_environment_path% already exists ...
       GOTO ERROR_EXIT
   )
   %PYTHON_EXCUTABLE% -m venv %venv_environment_path%
   
   cd %CMD_DIR%
   ECHO %INDENT_TEXT%[%ME%] [INFO ] Creating %venv_environment_path% ...
   call  update_venv_env_from_file
   echo.
   
   GOTO CLEAN_EXIT
)

SET ERROR_MESSAGE=[%ME%] [ERROR] Not a valid user (%USERNAME%) on %COMPUTERNAME% ...
GOTO ERROR_EXIT

:ERROR_EXIT
ECHO %ERROR_MESSAGE%

:CLEAN_EXIT
CD %CMD_DIR%
ECHO.
ECHO %INDENT_TEXT%[%ME%] [INFO ] Script ended ...
ECHO ==============================================
::timeout /t 10
PAUSE
