# Scripts for python development

## Install in folder (which might hold additional files).
```
git init
git remote add origin git@github.com:pierre-pvln/deploy_on_local-venv.git
git remote -v
git fetch --all
git reset --hard origin/master
```

# Run options:
__To run for development with pycharm__
```
 run_pycharm_for_ipheon.cmd
```  

__To run for development with jupyter__
```
 run_jupyter_for_ipheon.cmd
```  

__To run for development with jupyterlab__
```
 run_jupyterlab_for_ipheon.cmd
```  

__To run for development with visual studio code__
```
 run_vscode_for_ipheion.cmd
```  

__To run for production__
```
 NOT WOKRING YET
 run_python_for_ipheon.cmd
```  

## Requirements

Requires the following folder structure
```
THE PROJECT
+---code
|   +---.idea
|   +---py_app
|   |   +---.venv
|   |   |   the_app.py
|   |   +---build
|   |   +---dist
|   |   +---input
|   |   \---output
|   |
|   \---py_conf
|       +---_aws_lambda
|       +---_heroku
|       +---_legion-2020-conda 
|       \---_legion-2020-venv                         << FOLDER USED HERE 
|               requirements.txt.EXAMPLE              << FILE USED HERE
|               _env_name.txt                         << FILE USED HERE
|
+---deploy_on
|   +---create_exe
|   |       
|   +---identities
|   |       ipheion_AWS-profile_lambda.txt            << FILE USED HERE (ARE YOU SURE?)
|   |       ipheion_AWS-region_lambda.txt             << FILE USED HERE (ARE YOU SURE?)
|   |       
|   +---_AWS_EC2
|   +---_AWS_lambda                                   
|   +---_heroku
|   |       
|   +---_legion-2020-venv                            << FOLDER USED HERE (THIS SCRIPT)
|   |   |   .gitattributes
|   |   |   .gitignore
|   |   |   CHANGELOG.md
|   |   |   Command Prompt.lnk
|   |   |   jupyter3.cmd
|   |   |   jupyterlab3.cmd
|   |   |   pycharm.cmd
|   |   |   python.cmd
|   |   |   README.md
|   |   |   run_jupyterlab_for_ipheion.cmd
|   |   |   run_jupyter_for_ipheion.cmd
|   |   |   run_pycharm_for_ipheion.cmd
|   |   |   run_python_for_ipheion.cmd
|   |   |   run_vscode_for_ipheion.cmd
|   |   |   set_git_local_user_config.cmd
|   |   |   vscode.cmd
|   |   |   
|   |   +---packages
|   |   |       .gitignore
|   |   |       Command Prompt.lnk
|   |   |       venv_env_as-built.yml
|   |   |       create_venv_env_from_file.cmd
|   |   |       export_venv_env.cmd
|   |   |       remove_venv_env.cmd
|   |   |       update_venv_env_from_file.cmd
|   |   |       
|   |   \---utils
|   |           check_github.cmd
|   |           
|   \---_rpi4_NAME
|
+---info
|           
\---overview

```
