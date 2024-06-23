:: =============================================================================
::
:: @package    ipheion deployment scripts
:: @container  heroku
:: @name       check_heroku.cmd
:: @purpose    Check if scripts are in sync with github version
:: @version    v0.0.1  2022-07-16
:: @author     pierre@ipheion.eu
:: @copyright  (C) 2020-2021 Pierre Veelen
::
:: =============================================================================

:: Check Heroku settings 
:: =====================
ECHO [%ME%] [INFO   ] Checking the Heroku settings ...

:: set heroku_app_name
IF EXIST "..\..\deploy_on\_heroku_app_name.txt" (
	SET /p HEROKU_APP_NAME=<"..\..\deploy_on\_heroku_app_name.txt"
)

SET heroku_cli="C:\Program Files\heroku\bin\heroku"

IF NOT "%HEROKU_APP_NAME%" == "" (
	call %heroku_cli% config:get DATABASE_URL -a %HEROKU_APP_NAME%>HEROKU_PG_DB.txt
)
GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO.
ECHO %ERROR_MESSAGE%
ECHO.
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT
ECHO.
EXIT /B 0
