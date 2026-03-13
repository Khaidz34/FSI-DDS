@echo off
echo ========================================
echo  START MAIN SERVER
echo ========================================

echo.
echo Killing processes...
taskkill /f /im node.exe >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :5000') do taskkill /f /pid %%a >nul 2>&1

echo.
echo Starting main backend server...
cd backend
node server-sqlite.js

pause