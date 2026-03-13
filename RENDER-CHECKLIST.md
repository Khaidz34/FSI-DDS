# ✅ Render Deployment Checklist

## 🚀 Quick Deploy Steps

### ☐ 1. Chuẩn bị Code
```bash
# Chạy script deploy
deploy.bat
```

### ☐ 2. Tạo Render Account
- Truy cập: https://render.com
- Sign up với GitHub
- Authorize repository access

### ☐ 3. Deploy Backend
- New → Web Service
- Connect FSI DDS repository
- Render auto-detect `render.yaml`
- Click "Create Web Service"
- Wait 3-5 minutes

### ☐ 4. Lấy Backend URL
- Copy URL: `https://your-app.onrender.com`
- Test health: `https://your-app.onrender.com/health`

### ☐ 5. Deploy Frontend (Option A - Render)
- New → Static Site
- Same repository
- Build: `npm run build`
- Publish: `dist`
- Env: `VITE_API_URL=https://your-backend.onrender.com`

### ☐ 6. Deploy Frontend (Option B - Vercel)
- Go to vercel.com
- Import GitHub repo
- Auto-deploy

### ☐ 7. Test Everything
- [ ] Login works
- [ ] Menu loads
- [ ] Order placement
- [ ] Mobile responsive
- [ ] Theme switching
- [ ] Language switching

## 🔧 Environment Variables

### Backend (Auto from render.yaml):
```
NODE_ENV=production
JWT_SECRET=(auto-generated)
DATABASE_PATH=/opt/render/project/src/data/dining.db
BACKUP_ENABLED=true
PORT=10000
```

### Frontend:
```
VITE_API_URL=https://your-backend.onrender.com
VITE_APP_NAME=FSI DDS
VITE_APP_VERSION=1.0.0
```

## 🆘 Common Issues

### ❌ Build Fails
- Check Node.js version in logs
- Verify all dependencies installed
- Check environment variables

### ❌ CORS Errors
- Backend CORS đã được cập nhật
- Verify frontend URL in CORS config

### ❌ Database Errors
- Check persistent disk mount
- Verify DATABASE_PATH
- Check file permissions

### ❌ App Sleeps (After 15 min)
- Normal for free tier
- Use UptimeRobot để ping
- Or upgrade to paid ($7/month)

## 📱 Mobile Testing URLs

After deployment, test these on mobile:
- **Main App**: https://your-frontend.onrender.com
- **API Health**: https://your-backend.onrender.com/health
- **Login**: https://your-frontend.onrender.com (test login form)

## 🎯 Success Criteria

### ✅ Backend Working:
- Health check returns 200
- API endpoints respond
- Database connected
- CORS allows frontend

### ✅ Frontend Working:
- App loads on mobile/desktop
- Login/register works
- Menu displays
- Orders can be placed
- Responsive design works

### ✅ Integration Working:
- Frontend calls backend APIs
- Authentication flows
- Data persistence
- Real-time updates

## 🔗 Important URLs

After deployment, save these:
- **Frontend**: https://fsi-dds-frontend.onrender.com
- **Backend**: https://fsi-dds-backend.onrender.com
- **API Base**: https://fsi-dds-backend.onrender.com/api
- **Health Check**: https://fsi-dds-backend.onrender.com/health
- **Admin Login**: Frontend URL (use admin credentials)

## 📞 Support

If issues occur:
1. Check Render Dashboard logs
2. Test API endpoints manually
3. Verify environment variables
4. Check browser console (F12)

**Ready to deploy! 🚀**