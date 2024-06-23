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

SET "CONDA_CONF_PATH=..\..\code\py_conf\_legion-2020-conda\"
SET "CONDA_ENV_NAME_FILE=%CONDA_CONF_PATH%_env_name.txt"
SET "CONDA_CONF_YML_FILE=%CONDA_CONF_PATH%environment.yml"
SET "SECRETS_FOLDER=..\"

:: set python / conda environment name
IF EXIST %CONDA_ENV_NAME_FILE% (
	SET /p conda_environment=<%CONDA_ENV_NAME_FILE%
)
IF "%conda_environment%" == "" (
	SET ERROR_MESSAGE=[%ME%] [ERROR  ] file %CONDA_ENV_NAME_FILE% does not exist or is empty ...
	GOTO ERROR_EXIT
)

:: set python / conda environment yml file
IF NOT EXIST %CONDA_ENV_NAME_FILE% (
	SET ERROR_MESSAGE=[%ME%] [ERROR  ] file %CONDA_CONF_YML_FILE% does not exist ...
	GOTO ERROR_EXIT
)

:: set any required environment variables

:: AWS_PROFILE_NAME in lowercase !
SET AWS_PROFILE_NAME=vandenherik
ECHO [%ME%] [INFO   ] AWS_PROFILE_NAME: %AWS_PROFILE_NAME%
:: Set the AWS_PROFILE environment variable to use. 
:: Boto3 uses this variable the determin the profile setting to use.
:: Otherwise default profile is used.
SET AWS_PROFILE=%AWS_PROFILE_NAME%

:: set 'SPATIALINDEX_C_LIBRARY' otherwise rtree / geopandas complains
SET SPATIALINDEX_C_LIBRARY=C:/myPrograms/anaconda3/envs/%conda_environment%/Library/bin

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

:: start IDE
CALL pycharm.cmd

GOTO CLEAN_EXIT

:ERROR_EXIT
ECHO %ERROR_MESSAGE%

:CLEAN_EXIT
CD %CMD_DIR%

PAUSE
