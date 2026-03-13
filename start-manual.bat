@echo off
echo ========================================
echo  GOURMET GRID - KHOI DONG THU CONG
echo ========================================

echo.
echo Dung tat ca process...
taskkill /f /im node.exe >nul 2>&1
taskkill /f /im npm.exe >nul 2>&1
taskkill /f /im nodemon.exe >nul 2>&1

for /f "tokens=5" %%a in ('netstat -aon ^| findstr :5000') do taskkill /f /pid %%a >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :5173') do taskkill /f /pid %%a >nul 2>&1

timeout /t 2 /nobreak >nul

echo.
echo Khoi dong Backend (cong 5000)...
start "Backend - GourmetGrid" cmd /k "cd backend && nodemon server-sqlite.js"

echo Cho backend khoi dong...
timeout /t 5 /nobreak >nul

echo.
echo Khoi dong Frontend (cong 5173)...
start "Frontend - GourmetGrid" cmd /k "npm run dev"

echo.
echo ========================================
echo  UNG DUNG DA KHOI DONG
echo  Frontend: http://localhost:5173
echo  Backend: http://localhost:5000
echo ========================================

pause