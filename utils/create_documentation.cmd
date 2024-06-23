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

CD "%IDE_START_DIR%\py_app"

ECHO [%ME%] [INFO   ] running pydoc3 ...
ECHO.
::
:: https://docs.python.org/3/library/pydoc.html
::
call python -m pydoc --version
echo.
call python -m pydoc . -o ./docs
echo.

ECHO [%ME%] [INFO   ] running mkdocs ...
ECHO.
::
:: https://www.mkdocs.org/
::
call python -m mkdocs --version
echo.
call mkdocs build
echo.

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO.
ECHO %ERROR_MESSAGE%
ECHO.
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT
ECHO.
EXIT /B 0
