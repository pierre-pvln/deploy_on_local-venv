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

SET ERROR_MESSAGE=[%ME%] [INFO   ] No error

SET "APP_CONF_PATH=..\..\code\py_conf\_legion-2020-conda"
SET "APP_ENV_NAME_FILE=%APP_CONF_PATH%\_env_name.txt"
SET "APP_CONF_YML_FILE=%APP_CONF_PATH%\environment.yml"
SET "SECRETS_FOLDER=..\"

:: set python / conda environment name
IF EXIST %APP_ENV_NAME_FILE% (
	SET /p APP_ENVIRONMENT=<%APP_ENV_NAME_FILE%
)
IF "%APP_ENVIRONMENT%" == "" (
	SET ERROR_MESSAGE=[%ME%] [ERROR  ] file %APP_ENV_NAME_FILE% does not exist or is empty ...
	GOTO ERROR_EXIT
)

:: set python / conda environment yml file
IF NOT EXIST %APP_ENV_NAME_FILE% (
	SET ERROR_MESSAGE=[%ME%] [ERROR  ] file %APP_CONF_YML_FILE% does not exist ...
	GOTO ERROR_EXIT
)

:: set any required environment variables
SET AWS_PROFILE_NAME=ipheion

:: set 'SPATIALINDEX_C_LIBRARY' otherwise rtree / geopandas complains
SET SPATIALINDEX_C_LIBRARY=C:/myPrograms/anaconda3/envs/%APP_ENVIRONMENT%/Library/bin

:: set MAPBOX_ACCESS_TOKEN
:: 
IF EXIST %SECRETS_FOLDER%.mapbox_token (
	SET /p MAPBOX_ACCESS_TOKEN=<%SECRETS_FOLDER%.mapbox_token
)

:: GIT / GITHUB CHECK
:: ==================
CALL .\utils\check_github.cmd
ECHO.
timeout /T 5
CD %CMD_DIR%

:: reset variables
SET "PYTHON_RUN0="
SET "PYTHON_RUN1="
SET "PYTHON_RUN2="
SET "PYTHON_RUN3="

:: set pythonscript names
IF EXIST "%APP_CONF_PATH%\_python_run.txt" (
	SET /p PYTHON_RUN0=<"%APP_CONF_PATH%\_python_run.txt"
)

IF EXIST "%APP_CONF_PATH%\_python_run1.txt" (
	SET /p PYTHON_RUN1=<"%APP_CONF_PATH%\_python_run1.txt"
)

IF EXIST "%APP_CONF_PATH%\_python_run2.txt" (
	SET /p PYTHON_RUN2=<"%APP_CONF_PATH%\_python_run2.txt"
)

IF EXIST "%APP_CONF_PATH%\_python_runt3.txt" (
	SET /p PYTHON_RUN3=<"%APP_CONF_PATH%\_python_run3.txt"
)

:: start python script(s)
CALL python.cmd

GOTO CLEAN_EXIT

:ERROR_EXIT
ECHO %ERROR_MESSAGE%

:CLEAN_EXIT
CD %CMD_DIR%

PAUSE
