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

cd ..\..\code\py_app
SET continue=true

call C:\myPrograms\anaconda3\Scripts\activate.bat
call conda activate %APP_environment%
echo call conda activate %APP_environment%

SET RUN_THE_SCRIPT=false
IF "%continue%"=="true"	IF NOT "%PYTHON_RUN0%"=="" SET RUN_THE_SCRIPT=true

IF "%RUN_THE_SCRIPT%"=="true" (
	echo [INFO   ] Running %PYTHON_RUN0%
	echo [INFO   ] ==========================
	python %PYTHON_RUN0%
	if %ERRORLEVEL% NEQ 0 (
		SET continue=false
		SET ERROR_MESSAGE=[ERROR ] Ending script [%ME%] %PYTHON_RUN0%
	)
)

SET RUN_THE_SCRIPT=false
IF "%continue%"=="true"	IF NOT "%PYTHON_RUN1%"=="" SET RUN_THE_SCRIPT=true

IF "%RUN_THE_SCRIPT%"=="true" (
	echo [INFO   ] Running %PYTHON_RUN1%
	echo [INFO   ] ==========================
	python %PYTHON_RUN1%
	if %ERRORLEVEL% NEQ 0 (
		SET continue=false
		SET ERROR_MESSAGE=[ERROR ] Ending script [%ME%] %PYTHON_RUN1%
	)
)

SET RUN_THE_SCRIPT=false
IF "%continue%"=="true" IF NOT "%PYTHON_RUN2%"=="" SET RUN_THE_SCRIPT=true

IF "%RUN_THE_SCRIPT%"=="true" (
	echo [INFO   ] Running %PYTHON_RUN2%
	echo [INFO   ] ==========================
	python %PYTHON_RUN2%
	if %ERRORLEVEL% NEQ 0 (
		SET continue=false
		SET ERROR_MESSAGE=[ERROR ] Ending script [%ME%] %PYTHON_RUN2%
	)
)

SET RUN_THE_SCRIPT=false
IF "%continue%"=="true" IF NOT "%PYTHON_RUN3%"=="" SET RUN_THE_SCRIPT=true

IF "%RUN_THE_SCRIPT%"=="true" (
	echo [INFO   ] Running %PYTHON_RUN3%
	echo [INFO   ] ==========================
	python %PYTHON_RUN3%
	if %ERRORLEVEL% NEQ 0 (
		SET continue=false
		SET ERROR_MESSAGE=[ERROR ] Ending script [%ME%] %PYTHON_RUN3%
	)
)

conda deactivate
GOTO :CLEAN_EXIT

:ERROR_EXIT
ECHO %ERROR_MESSAGE%
conda deactivate

:CLEAN_EXIT
CD %CMD_DIR%

PAUSE
