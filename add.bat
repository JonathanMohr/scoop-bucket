@echo off

set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"
set "SCRIPT_DIR=%SCRIPT_DIR:\=/%"

scoop bucket add local-bucket "file:///%SCRIPT_DIR%"
