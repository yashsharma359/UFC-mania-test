@echo off
cd /d "%~dp0"
echo ===================================================
echo Pushing UFC Mania to GitHub...
echo ===================================================
powershell -ExecutionPolicy Bypass -File "%~dp0git_push.ps1"
echo ===================================================
pause
