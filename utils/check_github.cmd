:: =============================================================================
::
:: @package    ipheion deployment scripts
:: @container  AWS lambda functions
:: @name       check_github.cmd
:: @purpose    Check if scripts are in sync with github version
:: @version    v0.0.1  2022-01-26
:: @author     pierre@ipheion.eu
:: @copyright  (C) 2020-2021 Pierre Veelen
::
:: =============================================================================

:: Check AWS lambda dev scripts with github 
:: ========================================
ECHO [%ME%] [INFO ] Are we up to date with the Local venv scripts? ...
git remote update
ECHO.
::    -s, --short           show status concisely
::    -b, --branch          show branch information
git status -s -b
ECHO.

GOTO CLEAN_EXIT_SUBSCRIPT

:ERROR_EXIT_SUBSCRIPT
ECHO.
ECHO %ERROR_MESSAGE%
ECHO.
EXIT /B 1

:CLEAN_EXIT_SUBSCRIPT
ECHO.
EXIT /B 0
