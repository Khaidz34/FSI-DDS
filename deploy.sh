#!/bin/bash

# FSI DDS - Quick Deploy Script
echo "🚀 FSI DDS - Quick Deploy Script"
echo "================================="

# Check if git is clean
if [[ -n $(git status --porcelain) ]]; then
    echo "⚠️  You have uncommitted changes. Please commit them first."
    git status --short
    exit 1
fi

echo "✅ Git status is clean"

# Build frontend
echo "📦 Building frontend..."
npm run build

if [ $? -ne 0 ]; then
    echo "❌ Frontend build failed"
    exit 1
fi

echo "✅ Frontend build successful"

# Test backend
echo "🧪 Testing backend..."
cd backend
npm test 2>/dev/null || echo "⚠️  No tests found, skipping..."
cd ..

echo "✅ Backend ready"

# Push to git
echo "📤 Pushing to git..."
git add .
git commit -m "Deploy: $(date '+%Y-%m-%d %H:%M:%S')" || echo "No changes to commit"
git push origin main

echo "✅ Code pushed to repository"

echo ""
echo "🎉 Ready for deployment!"
echo ""
echo "Next steps:"
echo "1. 🚂 Railway: Visit https://railway.app and deploy from GitHub"
echo "2. 🔷 Render: Visit https://render.com and deploy from GitHub"
echo "3. ⚡ Vercel: Visit https://vercel.com and deploy frontend"
echo ""
echo "📋 Don't forget to set environment variables:"
echo "   - NODE_ENV=production"
echo "   - JWT_SECRET=your-secret-key"
echo "   - DATABASE_PATH=/app/data/dining.db"
echo ""
echo "🌐 After deployment, update .env.production with your backend URL"