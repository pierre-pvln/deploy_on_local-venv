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

ECHO [%ME%] [INFO   ] running black ...
ECHO.
:: https://black.readthedocs.io/
::
call black --version
echo.
if exist CCF_black_output.txt (
	del CCF_black_output.txt
)
call black -v . >CCF_black_output.txt 2>&1
echo.

ECHO [%ME%] [INFO   ] running flake8 ...
ECHO.
:: https://flake8.pycqa.org/
::
call flake8 --version
echo.
if exist CCF_flake8_output.txt (
	del CCF_flake8_output.txt
)
call flake8 --output-file=CCF_flake8_output.txt .
echo.

ECHO [%ME%] [INFO   ] running isort ...
ECHO.
:: https://pycqa.github.io/isort/
::
call isort --version
echo.
::call isort -v .
call isort .
echo.

ECHO [%ME%] [INFO   ] running interrogate ...
ECHO.
:: https://interrogate.readthedocs.io/
::
call interrogate --version
echo.
if exist CCF_interrogate_output.txt (
	del CCF_interrogate_output.txt
)
call interrogate --output CCF_interrogate_output.txt .
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
