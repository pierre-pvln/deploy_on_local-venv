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

:: goto to correct startpoint/directory for the IDE
CD ..\..\code
SET "IDE_START_DIR=%CD%"

IF "%COMPUTERNAME%"=="LEGION-2020"     GOTO :LEGION-2020

:Default
SET ERROR_MESSAGE=[ERROR] Unknown settings for COMPUTERNAME: %COMPUTERNAME% ...
GOTO ERROR_EXIT

:LEGION-2020
IF "%USERNAME%"=="developer" (
   echo Running VS Code IDE for %USERNAME% on %COMPUTERNAME%
   echo for the %venv_environment% environment
::   cd .\py_app
   cd .\

   if not exist .\.vscode (
      mkdir .\.vscode
   )
   if not exist .\.vscode\settings.json (
      echo Creating .\.vscode\settings.json for VSCode IDE
      (
	  echo { 
      echo    	"python.defaultInterpreterPath": ".\\py_app\\.venv\\Scripts\\python.exe",  
      echo		"python.terminal.activateEnvironment": true,
      echo		"terminal.integrated.profiles.windows": {
      echo			"PowerShell": {
      echo			"source": "PowerShell",
      echo			"icon": "terminal-powershell"
      echo		},
      echo		"Command Prompt": {
      echo			"path": [
      echo				"${env:windir}\\Sysnative\\cmd.exe",
	  echo				"${env:windir}\\System32\\cmd.exe"
      echo			],
      echo			"args": [],
      echo			"icon": "terminal-cmd"
      echo		},
      echo		"Git Bash": {
      echo			"source": "Git Bash"
      echo		}
      echo		},
      echo		"terminal.integrated.defaultProfile.windows": "Command Prompt",
      echo	} 
      )>.\.vscode\settings.json
   ) 
   call .\py_app\\%venv_environment%\Scripts\activate.bat
   call "C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\Code.exe" . 
   GOTO CLEAN_EXIT
)

IF "%USERNAME%"=="pierre" (
   echo Running VS Code IDE for %USERNAME% on %COMPUTERNAME%
   echo for the %venv_environment% environment
   cd .\py_app
   if not exist .\.vscode (
      mkdir .\.vscode
   )
   if not exist .\.vscode\settings.json (
      echo Creating .\.vscode\settings.json for VS Code IDE
      (
	  echo { 
      echo    	"python.pythonPath": "..\\%venv_environment%\\python.exe",  
      echo		"python.terminal.activateEnvironment": true,
      echo		"terminal.integrated.profiles.windows": {
      echo			"PowerShell": {
      echo			"source": "PowerShell",
      echo			"icon": "terminal-powershell"
      echo		},
      echo		"Command Prompt": {
      echo			"path": [
      echo				"${env:windir}\\Sysnative\\cmd.exe",
	  echo				"${env:windir}\\System32\\cmd.exe"
      echo			],
      echo			"args": [],
      echo			"icon": "terminal-cmd"
      echo		},
      echo		"Git Bash": {
      echo			"source": "Git Bash"
      echo		}
      echo		},
      echo		"terminal.integrated.defaultProfile.windows": "Command Prompt",
      echo	} 
      )>.\.vscode\settings.json
   )  
   call %venv_environment%\Scripts\activate.bat
   call "C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\Code.exe" . 
   GOTO CLEAN_EXIT
)

SET ERROR_MESSAGE=[ERROR] Not a valid user (%USERNAME%) on %COMPUTERNAME% ...
GOTO ERROR_EXIT

:ERROR_EXIT
ECHO %ERROR_MESSAGE%

:CLEAN_EXIT
CD %CMD_DIR%
