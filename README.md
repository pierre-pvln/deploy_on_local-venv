# Scripts for python development

## Install in folder (which might hold additional files).
```
git init
git remote add origin git@github.com:pierre-pvln/deploy_on_local-conda.git
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
|   +---app
|   |   |   the_app.py
|   |   +---build
|   |   +---dist
|   |   +---input
|   |   \---output
|   |
|   +---conf
|   |   +---_aws_lambda
|   |   +---_heroku
|   |   +---_legion-2020-conda                        << FOLDER USED HERE 
|   |   |       environment.yml.EXAMPLE               << FILE USED HERE
|   |   |       _env_name.txt                         << FILE USED HERE
|   |   \---_legion-2020-venv
|   |           
|   \---venv
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
|   +---_legion-2020-conda                            << FOLDER USED HERE (THIS SCRIPT)
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
|   |   |       conda_env_as-built.yml
|   |   |       create_conda_env_from_file.cmd
|   |   |       export_conda_env.cmd
|   |   |       remove_conda_env.cmd
|   |   |       update_conda_env_from_file.cmd
|   |   |       update_conda_in_base.cmd
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
