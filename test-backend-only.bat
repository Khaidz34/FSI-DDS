@echo off
echo ========================================
echo  TEST BACKEND ONLY
echo ========================================

echo.
echo Dung cac process tren cong 5000...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :5000') do (
    taskkill /f /pid %%a >nul 2>&1
)

echo.
echo Khoi dong test server...
cd backend
node test-server.js

pause