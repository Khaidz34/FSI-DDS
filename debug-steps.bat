@echo off
echo ========================================
echo  DEBUG BACKEND CONNECTION
echo ========================================

echo.
echo Step 1: Kill all processes
taskkill /f /im node.exe >nul 2>&1
taskkill /f /im npm.exe >nul 2>&1
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :5000') do taskkill /f /pid %%a >nul 2>&1

echo.
echo Step 2: Test simple backend
echo Starting test server on port 5000...
cd backend
start "Test Backend" cmd /k "node test-server.js"

echo.
echo Step 3: Wait 3 seconds then test connection
timeout /t 3 /nobreak >nul

echo.
echo Step 4: Open test page
start test-connection.html

echo.
echo ========================================
echo  INSTRUCTIONS:
echo  1. Check if "Test Backend" window shows server running
echo  2. Click "Test Connection" button in the browser
echo  3. If test works, close test server and run main server
echo ========================================

pause