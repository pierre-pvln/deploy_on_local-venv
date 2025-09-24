@ECHO off
SETLOCAL ENABLEEXTENSIONS enabledelayedexpansion

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


:: set python / venv environments.txt file
IF NOT EXIST %VENV_ENV_NAME_FILE% (
	SET ERROR_MESSAGE=[%ME%] [ERROR] file %VENV_CONF_TXT_FILE% does not exist ...
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
SET ERROR_MESSAGE=%INDENT_TEXT%[%ME%] [ERROR] Unknown settings for COMPUTERNAME: %COMPUTERNAME% ...
GOTO ERROR_EXIT

:LEGION-2020
IF "%USERNAME%"=="developer" (
   echo %INDENT_TEXT%[%ME%] [INFO ] Commands for %USERNAME% on %COMPUTERNAME% ...
   echo %INDENT_TEXT%[%ME%] [INFO ] Using %venv_environment_path%\Scripts\activate.bat as command
   call %venv_environment_path%\Scripts\activate.bat
   echo %INDENT_TEXT%[%ME%] [INFO ] Exporting venv environment %venv_environment_path% ...

   FOR /F "tokens=*" %%g IN ('python --version') DO (
       SET THIS_PYTHON_VERSION=# For %%g
   )
   ECHO #=================================================== > venv_env_as-built_LATEST.txt
   ECHO # >> venv_env_as-built_LATEST.txt
   ECHO !THIS_PYTHON_VERSION! >> venv_env_as-built_LATEST.txt
   ECHO # >> venv_env_as-built_LATEST.txt
   ECHO #=================================================== >> venv_env_as-built_LATEST.txt
   call pip freeze >> venv_env_as-built_LATEST.txt

   ECHO #=================================================== > venv_env_as-built_%dtStamp%.txt
   ECHO # >> venv_env_as-built_%dtStamp%.txt
   ECHO !THIS_PYTHON_VERSION! >> venv_env_as-built_%dtStamp%.txt
   ECHO # >> venv_env_as-built_%dtStamp%.txt
   ECHO #=================================================== >> venv_env_as-built_%dtStamp%.txt
   call pip freeze >> venv_env_as-built_%dtStamp%.txt
   GOTO CLEAN_EXIT
)

IF "%USERNAME%"=="myAdm" (
   echo %INDENT_TEXT%[%ME%] [INFO ] Commands for %USERNAME% on %COMPUTERNAME% ...
   echo %INDENT_TEXT%[%ME%] [INFO ] Using %venv_environment_path%\Scripts\activate.bat as command
   call %venv_environment_path%\Scripts\activate.bat
   echo %INDENT_TEXT%[%ME%] [INFO ] Exporting venv environment %venv_environment_path% ...

   FOR /F "tokens=*" %%g IN ('python --version') DO (
       SET THIS_PYTHON_VERSION=# For %%g
   )
   ECHO #=================================================== > venv_env_as-built_LATEST.txt
   ECHO # >> venv_env_as-built_LATEST.txt
   ECHO !THIS_PYTHON_VERSION! >> venv_env_as-built_LATEST.txt
   ECHO # >> venv_env_as-built_LATEST.txt
   ECHO #=================================================== >> venv_env_as-built_LATEST.txt
   call pip freeze >> venv_env_as-built_LATEST.txt

   ECHO #=================================================== > venv_env_as-built_%dtStamp%.txt
   ECHO # >> venv_env_as-built_%dtStamp%.txt
   ECHO !THIS_PYTHON_VERSION! >> venv_env_as-built_%dtStamp%.txt
   ECHO # >> venv_env_as-built_%dtStamp%.txt
   ECHO #=================================================== >> venv_env_as-built_%dtStamp%.txt
   call pip freeze >> venv_env_as-built_%dtStamp%.txt
   GOTO CLEAN_EXIT
)

SET ERROR_MESSAGE=%INDENT_TEXT%[%ME%] [ERROR] Not a valid user (%USERNAME%) on %COMPUTERNAME% ...
GOTO ERROR_EXIT

:ERROR_EXIT
ECHO %ERROR_MESSAGE%

:CLEAN_EXIT
CD %CMD_DIR%
ECHO.
ECHO %INDENT_TEXT%[%ME%] [INFO ] Script ended ...
ECHO ==============================================
timeout /t 5
