@ECHO off
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

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

SET "VENV_CONF_PATH=..\..\code\py_conf\_legion-2020-venv\"
SET "VENV_APP_PATH=..\..\code\py_app\"
SET "VENV_ENV_NAME_FILE=%VENV_CONF_PATH%_env_name.txt"
SET "VENV_CONF_TXT_FILE=%VENV_CONF_PATH%requirements.txt"
SET "SECRETS_FOLDER=..\"

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

:: set python / venv requirements.txt file
IF NOT EXIST %VENV_ENV_NAME_FILE% (
	SET ERROR_MESSAGE=[ERROR] file %VENV_CONF_TXT_FILE% does not exist ...
	GOTO ERROR_EXIT
)

:: set any required environment variables

:: AWS_PROFILE_NAME in lowercase !
SET AWS_PROFILE_NAME=genericdev
ECHO [%ME%] [INFO   ] AWS_PROFILE_NAME: %AWS_PROFILE_NAME%

:: SHOULD CHECK THIS !! ALSO VALID FOR VENV ?
:: ==========================================
:: set 'SPATIALINDEX_C_LIBRARY' otherwise rtree / geopandas complains
SET SPATIALINDEX_C_LIBRARY=%venv_environment_path%/Library/bin

:: GIT / GITHUB CHECK
:: ==================
CALL .\utils\check_github.cmd
ECHO.
timeout /T 5
CD %CMD_DIR%

:: HEROKU CHECK
:: ==================
SET "DATABASE_URL="
CALL .\utils\check_heroku.cmd
IF EXIST "HEROKU_PG_DB.txt" (
	SET /P DATABASE_URL=<"HEROKU_PG_DB.txt"
	DEL HEROKU_PG_DB.txt
)
IF NOT "%DATABASE_URL%" == "" (
	ECHO [%ME%] [INFO   ] Database URL to use:
	ECHO %DATABASE_URL%
	ECHO.
	timeout /T 5
)
CD %CMD_DIR%

:: TOKENS AND AUTHENTICATION
:: =========================

:: set MAPBOX_ACCESS_TOKEN
:: 
IF EXIST %SECRETS_FOLDER%.mapbox_token (
	SET /p MAPBOX_ACCESS_TOKEN=<%SECRETS_FOLDER%.mapbox_token
	ECHO [%ME%] [INFO   ] MAPBOX_ACCESS_TOKEN environment variable set ...
	ECHO.
) ELSE (
	ECHO [%ME%] [INFO   ] MAPBOX_ACCESS_TOKEN environment variable not set ...    
	ECHO.
)

:: set GOOGLEMAPS_API_TOKEN
:: 
IF EXIST %SECRETS_FOLDER%.googlemaps_api_token (
	SET /p GOOGLEMAPS_API_TOKEN=<%SECRETS_FOLDER%.googlemaps_api_token
	ECHO [%ME%] [INFO   ] GOOGLEMAPS_API_TOKEN environment variable set ...
	ECHO.
) ELSE (
	ECHO [%ME%] [INFO   ] GOOGLEMAPS_API_TOKEN environment variable not set ...    
	ECHO.
)

:: set AWS_API_GATEWAY_KEY
:: 
IF EXIST %SECRETS_FOLDER%.aws_apigw_key (
	SET /p AWS_API_GATEWAY_KEY=<%SECRETS_FOLDER%.aws_apigw_key
	ECHO [%ME%] [INFO   ] AWS_API_GATEWAY_KEY environment variable set ...
	ECHO.
) ELSE (
	ECHO [%ME%] [INFO   ] AWS_API_GATEWAY_KEY environment variable not set ...    
	ECHO.
)

:: set OPENWEATHER_API_GATEWAY_KEY
:: 
IF EXIST %SECRETS_FOLDER%.openweather_apigw_key (
	SET /p OPENWEATHER_API_GATEWAY_KEY=<%SECRETS_FOLDER%.openweather_apigw_key
	ECHO [%ME%] [INFO   ] OPENWEATHER_API_GATEWAY_KEY environment variable set ...
	ECHO.
) ELSE (
	ECHO [%ME%] [INFO   ] OPENWEATHER_API_GATEWAY_KEY environment variable not set ...    
	ECHO.
)

:: set DSHM_API_KEY
:: 
IF EXIST %SECRETS_FOLDER%.dshm_api_key (
	SET /p DSHM_API_KEY=<%SECRETS_FOLDER%.DSHM_API_KEY
	ECHO [%ME%] [INFO   ] DSHM_API_KEY environment variable set ...
	ECHO.
) ELSE (
	ECHO [%ME%] [INFO   ] DSHM_API_KEY environment variable not set ...    
	ECHO.
)

:: set 1NCE_API_PAIR
:: 
IF EXIST %SECRETS_FOLDER%.1nce_api_pair (
	SET /p 1NCE_API_PAIR=<%SECRETS_FOLDER%.1nce_api_pair
	ECHO [%ME%] [INFO   ] 1NCE_API_PAIR environment variable set ...
	ECHO.
) ELSE (
	ECHO [%ME%] [INFO   ] 1NCE_API_PAIR environment variable not set ...    
	ECHO.
)

:: set RXM_AUTH_PAIR
:: 
IF EXIST %SECRETS_FOLDER%.rxm_auth_pair (
	SET /p RXM_AUTH_PAIR=<%SECRETS_FOLDER%.rxm_auth_pair
	ECHO [%ME%] [INFO   ] RXM_AUTH_PAIR environment variable set ...
	ECHO.
) ELSE (
	ECHO [%ME%] [INFO   ] RXM_AUTH_PAIR environment variable not set ...    
	ECHO.
)

:: start IDE
CALL vscode.cmd

GOTO CLEAN_EXIT

:ERROR_EXIT
ECHO %ERROR_MESSAGE%

:CLEAN_EXIT
CD %CMD_DIR%

PAUSE
