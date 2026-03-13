@echo off
echo ========================================
echo  GOURMET GRID - WORKING VERSION
echo ========================================

echo.
echo [1/4] Cleanup processes...
taskkill /f /im node.exe >nul 2>&1
taskkill /f /im npm.exe >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :5000') do taskkill /f /pid %%a >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :5173') do taskkill /f /pid %%a >nul 2>&1

timeout /t 2 /nobreak >nul

echo.
echo [2/4] Install dependencies...
call npm install >nul

echo.
echo [3/4] Start backend server...
start "Backend - Port 5000" cmd /k "cd backend && echo Starting backend on port 5000... && node server-sqlite.js"

echo.
echo [4/4] Wait and start frontend...
echo Waiting 5 seconds for backend to start...
timeout /t 5 /nobreak >nul

start "Frontend - Port 5173" cmd /k "echo Starting frontend on port 5173... && npm run dev"

echo.
echo ========================================
echo  SERVERS STARTING...
echo  Backend: http://localhost:5000
echo  Frontend: http://localhost:5173
echo  
echo  Wait a few seconds then open:
echo  http://localhost:5173
echo ========================================

pause