@echo off
echo.
echo ========================================
echo   FSI DDS - Mobile Responsive Test
echo ========================================
echo.

echo 🔧 Starting responsive test...
echo.

echo 📱 Step 1: Starting backend server...
cd backend
start "Backend Server" cmd /k "npm start"
cd ..

echo ⏳ Waiting for backend to start...
timeout /t 3 /nobreak >nul

echo 🌐 Step 2: Starting frontend dev server...
start "Frontend Dev" cmd /k "npm run dev"

echo ⏳ Waiting for frontend to start...
timeout /t 5 /nobreak >nul

echo 🧪 Step 3: Opening test tools...
start "" "test-responsive.html"

echo ⏳ Waiting a moment...
timeout /t 2 /nobreak >nul

echo 🚀 Step 4: Opening FSI DDS App...
start "" "http://localhost:5173"

echo.
echo ✅ Responsive test setup complete!
echo.
echo 📋 Test checklist:
echo   ☐ Mobile header visible on small screens
echo   ☐ Bottom navigation working
echo   ☐ Hamburger menu functional
echo   ☐ Touch targets 44px minimum
echo   ☐ Content not covered by navigation
echo   ☐ Smooth scrolling on mobile
echo   ☐ Language switcher working
echo   ☐ All tabs accessible
echo.
echo 🔧 Test tools opened:
echo   - Responsive test dashboard
echo   - FSI DDS application
echo.
echo Press any key to close this window...
pause >nul