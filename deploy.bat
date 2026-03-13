@echo off
echo 🔷 FSI DDS - Render Deploy Script
echo ==================================

REM Check git status
git status --porcelain > nul 2>&1
if %errorlevel% neq 0 (
    echo ⚠️  Git not initialized or error checking status
    pause
    exit /b 1
)

echo ✅ Git status checked

REM Build frontend to test
echo 📦 Testing frontend build...
call npm run build
if %errorlevel% neq 0 (
    echo ❌ Frontend build failed
    pause
    exit /b 1
)

echo ✅ Frontend build test successful

REM Commit and push
echo 📤 Pushing to GitHub...
git add .
git commit -m "Deploy to Render: %date% %time%"
git push origin main

echo ✅ Code pushed to GitHub
echo.
echo 🎉 Ready for Render deployment!
echo.
echo 📋 Next steps:
echo 1. Go to https://render.com
echo 2. Sign up with GitHub
echo 3. New Web Service → Connect FSI DDS repo
echo 4. Render will auto-detect render.yaml
echo 5. Click "Create Web Service"
echo.
echo 🔗 After deployment:
echo - Backend URL: https://your-app.onrender.com
echo - Update .env.production with backend URL
echo - Deploy frontend (Render Static Site or Vercel)
echo.
echo 📖 Full guide: RENDER-DEPLOY-GUIDE.md
pause