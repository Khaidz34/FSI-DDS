# 🚀 FSI DDS - Ready to Deploy!

## ⚡ Quick Start (Khuyến nghị)

### 1. Railway (Nhanh nhất - 5 phút)
```bash
# Chạy script deploy
./deploy.sh        # Linux/Mac
deploy.bat         # Windows

# Sau đó:
# 1. Vào https://railway.app
# 2. Login với GitHub
# 3. Deploy from GitHub repo
# 4. Set environment variables
```

### 2. Render (Miễn phí hoàn toàn)
```bash
# Push code lên GitHub
git push origin main

# Sau đó:
# 1. Vào https://render.com
# 2. New Web Service
# 3. Connect GitHub repo
# 4. Render sẽ dùng render.yaml tự động
```

## 📋 Environment Variables cần thiết

```bash
NODE_ENV=production
JWT_SECRET=your-super-secret-key-here-make-it-long-and-random
DATABASE_PATH=/app/data/dining.db
BACKUP_ENABLED=true
PORT=3000
```

## 🔧 Files đã chuẩn bị sẵn

- ✅ `railway.json` - Railway config
- ✅ `render.yaml` - Render config  
- ✅ `vercel.json` - Vercel config
- ✅ `Dockerfile` - Docker config
- ✅ `.env.production` - Production env template
- ✅ `deploy.sh` / `deploy.bat` - Deploy scripts

## 🌐 Sau khi deploy

1. **Lấy backend URL** từ platform
2. **Cập nhật `.env.production`**:
   ```
   VITE_API_URL=https://your-backend-url.railway.app
   ```
3. **Redeploy frontend** (nếu tách biệt)

## 💡 Platform so sánh

| Platform | Miễn phí | Persistent Storage | Auto-deploy | Khuyến nghị |
|----------|----------|-------------------|-------------|-------------|
| Railway  | $5/tháng | ✅ | ✅ | ⭐⭐⭐⭐⭐ |
| Render   | 100% | ✅ | ✅ | ⭐⭐⭐⭐ |
| Vercel   | Frontend only | ❌ | ✅ | ⭐⭐⭐ |
| Fly.io   | Limited | ✅ | ✅ | ⭐⭐⭐ |

## 🎯 Recommended: Railway

**Tại sao chọn Railway:**
- Setup nhanh nhất (5 phút)
- Config đã có sẵn
- Persistent SQLite storage
- Auto-deploy từ GitHub
- $5 credit miễn phí/tháng

**Deploy ngay:**
1. https://railway.app
2. "New Project" → "Deploy from GitHub"
3. Chọn repo FSI DDS
4. Set environment variables
5. Done! 🎉

## 🆘 Troubleshooting

**Build fails?**
- Check Node.js version (cần >=18)
- Verify all dependencies installed

**Database errors?**
- Ensure DATABASE_PATH is correct
- Check file permissions

**API connection fails?**
- Verify VITE_API_URL in frontend
- Check CORS settings in backend

## 📞 Support

Nếu gặp vấn đề, check:
1. Platform logs (Railway/Render dashboard)
2. Browser console (F12)
3. Network tab for API calls

**FSI DDS sẵn sàng phục vụ trên cloud! 🚀**