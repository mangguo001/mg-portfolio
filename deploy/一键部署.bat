@echo off
chcp 65001 >nul
cd /d "%~dp0"
call deploy-to-github.bat
pause
