:: =============================================================================
::
:: @package    ipheion deployment scripts
:: @container  Local deployment scripts
:: @name       set_git_local_user_config.cmd
:: @purpose    Script to set local username for git
:: @version    v0.0.2  2022-08-13
:: @author     pierre@ipheion.eu
:: @copyright  (C) 2020-2022 Pierre Veelen
::
:: =============================================================================
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

:: get projectname (cd ..\..\PROJECT)
:: http://www.robvanderwoude.com/ntfor.php
cd ..\..
for %%I in (.) do set CurrDirName=%%~nxI

CD %CMD_DIR%
IF EXIST ".git\" (
    IF "%USERNAME%"=="developer" (
	    ECHO [%ME%] [INFO ] Setting git for user: developer and project: %CurrDirName%  ...
        git config user.name "Pierre Veelen | aMultis.dev | %CurrDirName%"
        git config user.email "pierre@amultis.dev"
        GOTO CLEAN_EXIT
    )
    IF "%USERNAME%"=="pierre" (
	    ECHO [%ME%] [INFO ] Setting git for user: pierre and project: %CurrDirName% ...
        git config user.name "Pierre Veelen | aMultis.eu | %CurrDirName%"
        git config user.email "pierre@amultis.eu"
        GOTO CLEAN_EXIT
    )
    rem for all other cases
    ECHO [%ME%] [INFO ] Setting git for user: UNKOWN and project: %CurrDirName% ...
    git config user.name "Pierre Veelen | VEELEN.NET | %CurrDirName%"
    git config user.email "pierre@veelen.net"
    GOTO CLEAN_EXIT
)
ECHO [%ME%] [INFO ] .git folder not found ...
GOTO CLEAN_EXIT

:ERROR_EXIT
ECHO %ERROR_MESSAGE%

:CLEAN_EXIT
CD %CMD_DIR%
