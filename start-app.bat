@echo off
echo ========================================
echo  GOURMET GRID - KHOI DONG UNG DUNG
echo ========================================

echo.
echo [1/3] Dung tat ca cac process...

REM Dung Node.js processes
taskkill /f /im node.exe >nul 2>&1
taskkill /f /im npm.exe >nul 2>&1
taskkill /f /im nodemon.exe >nul 2>&1

REM Dung cac cong
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :3000') do taskkill /f /pid %%a >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :5000') do taskkill /f /pid %%a >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :5173') do taskkill /f /pid %%a >nul 2>&1

echo Cho 3 giay...
timeout /t 3 /nobreak >nul

echo.
echo [2/3] Cai dat dependencies...
call npm install

echo.
echo [3/3] Khoi dong ung dung...
echo.
echo Frontend: http://localhost:5173
echo Backend: http://localhost:5000
echo.
echo Nhan Ctrl+C de dung ung dung
echo.

REM Su dung script dev:full de chay ca hai
npm run dev:full

pause