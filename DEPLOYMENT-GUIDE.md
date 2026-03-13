# 🚀 FSI DDS - Hướng dẫn Deploy miễn phí lên Cloud

## 📋 Tổng quan Project
- **Frontend**: React + Vite + TypeScript
- **Backend**: Node.js + Express + SQLite
- **Database**: SQLite (file-based)
- **Architecture**: Full-stack web application

## 🆓 Các Platform miễn phí được đề xuất

### 1. 🚂 **Railway** (Đề xuất #1)
**✅ Ưu điểm:**
- Miễn phí $5/tháng credit
- Hỗ trợ SQLite persistent storage
- Auto-deploy từ GitHub
- Đã có sẵn `railway.json` config

**📝 Cách deploy:**
1. Tạo tài khoản tại [railway.app](https://railway.app)
2. Connect GitHub repository
3. Deploy tự động với config có sẵn

### 2. 🔷 **Render** (Đề xuất #2)
**✅ Ưu điểm:**
- Hoàn toàn miễn phí
- Hỗ trợ persistent disk
- Auto-deploy từ GitHub

### 3. ⚡ **Vercel + Railway** (Hybrid)
**✅ Ưu điểm:**
- Frontend trên Vercel (miễn phí)
- Backend trên Railway (miễn phí)
- Performance tốt nhất

### 4. 🐳 **Fly.io**
**✅ Ưu điểm:**
- Miễn phí với resource limits
- Hỗ trợ Docker
- Global deployment

## 🚀 Deploy với Railway (Khuyến nghị)

### Bước 1: Chuẩn bị Repository
```bash
# Đảm bảo code đã được commit
git add .
git commit -m "Ready for deployment"
git push origin main
```

### Bước 2: Deploy trên Railway
1. Truy cập [railway.app](https://railway.app)
2. Đăng nhập bằng GitHub
3. Click "New Project" → "Deploy from GitHub repo"
4. Chọn repository FSI DDS
5. Railway sẽ tự động detect và deploy

### Bước 3: Cấu hình Environment Variables
Trong Railway dashboard, thêm:
```
NODE_ENV=production
JWT_SECRET=your-super-secret-jwt-key-here
DATABASE_PATH=/app/data/dining.db
BACKUP_ENABLED=true
```

### Bước 4: Kiểm tra Deployment
- Railway sẽ cung cấp URL public
- Truy cập để test ứng dụng

## 🔧 Cấu hình cho các Platform khác

### Render Deployment
### Render Deployment
Tạo file `render.yaml`:
```yaml
services:
  - type: web
    name: fsi-dds
    env: node
    plan: free
    buildCommand: cd backend && npm install
    startCommand: cd backend && npm run start:sqlite
    envVars:
      - key: NODE_ENV
        value: production
      - key: JWT_SECRET
        generateValue: true
      - key: DATABASE_PATH
        value: /opt/render/project/src/data/dining.db
```

### Vercel + Railway Hybrid
**Frontend (Vercel):**
```json
// vercel.json
{
  "builds": [
    {
      "src": "package.json",
      "use": "@vercel/static-build",
      "config": {
        "distDir": "dist"
      }
    }
  ],
  "routes": [
    {
      "src": "/api/(.*)",
      "dest": "https://your-railway-backend.railway.app/api/$1"
    },
    {
      "src": "/(.*)",
      "dest": "/index.html"
    }
  ]
}
```

**Backend (Railway):** Sử dụng config có sẵn

## 📦 Chuẩn bị Production Build

### 1. Tối ưu Frontend
```bash
# Build production
npm run build

# Test production build locally
npm run preview
```

### 2. Cấu hình API URLs
Cập nhật `src/services/api.ts`:
```typescript
const API_BASE_URL = process.env.NODE_ENV === 'production' 
  ? 'https://your-backend-url.railway.app'
  : 'http://localhost:3000';
```

### 3. Environment Variables
Tạo `.env.production`:
```
VITE_API_URL=https://your-backend-url.railway.app
VITE_APP_NAME=FSI DDS
VITE_APP_VERSION=1.0.0
```

## 🔒 Security Checklist

### Backend Security
- ✅ JWT_SECRET được set random
- ✅ CORS được cấu hình đúng
- ✅ Rate limiting (nếu cần)
- ✅ Input validation

### Database Security
- ✅ SQLite file permissions
- ✅ Backup strategy
- ✅ Data encryption (nếu cần)

## 📊 Monitoring & Maintenance

### Health Checks
Backend đã có endpoint `/health`:
```javascript
app.get('/health', (req, res) => {
  res.status(200).json({ 
    status: 'OK', 
    timestamp: new Date().toISOString() 
  });
});
```

### Backup Strategy
```javascript
// Tự động backup SQLite (đã có trong code)
const backupDatabase = () => {
  // Logic backup database
};
```

## 🚀 Quick Deploy Commands

### Railway (Nhanh nhất)
```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Deploy
railway up
```

### Manual Deploy Steps
1. **Push code lên GitHub**
2. **Connect với Railway/Render**
3. **Set environment variables**
4. **Deploy & test**

## 🌐 Custom Domain (Tùy chọn)

### Railway
1. Vào Project Settings
2. Add Custom Domain
3. Cấu hình DNS records

### Render
1. Vào Service Settings
2. Add Custom Domain
3. Verify domain ownership

## 🔧 Troubleshooting

### Common Issues
1. **Build fails**: Check Node.js version compatibility
2. **Database errors**: Verify SQLite file permissions
3. **CORS errors**: Update CORS configuration
4. **Environment variables**: Double-check all required vars

### Debug Commands
```bash
# Check logs
railway logs

# Connect to service
railway shell
```

## 📈 Performance Tips

### Frontend Optimization
- ✅ Code splitting đã có
- ✅ Lazy loading components
- ✅ Image optimization
- ✅ Bundle size optimization

### Backend Optimization
- ✅ SQLite WAL mode
- ✅ Connection pooling
- ✅ Caching strategies
- ✅ Compression middleware

## 💰 Cost Estimation

### Railway (Recommended for Performance)
- **$5/month credit** miễn phí
- **Estimated usage**: ~$2-3/month cho FSI DDS
- **Result**: Hoàn toàn miễn phí (credit > usage)
- **Pros**: Không sleep, performance tốt, setup nhanh

### Render (100% Free)
- **Hoàn toàn miễn phí** - không cần credit
- **750 hours/month** execution time
- **Limitation**: App sleep sau 15 phút không dùng
- **Pros**: Thực sự miễn phí, không cần thẻ tín dụng

### Fly.io (Free Tier)
- **3 machines miễn phí**
- **3GB storage miễn phí**
- **160GB bandwidth/month**
- **Pros**: Generous free tier, global deployment

## 🎯 Recommended Approach

**Cho internal company app (FSI DDS):**
1. **Render** - Hoàn toàn miễn phí, đủ dùng
2. **Railway** - Nếu muốn performance tốt hơn
3. **Fly.io** - Nếu cần global deployment

## 🚀 Ready to Deploy!

Project FSI DDS đã sẵn sàng deploy với:
- ✅ Railway config (`railway.json`)
- ✅ Docker config (`Dockerfile`)
- ✅ Production-ready code
- ✅ Responsive mobile design
- ✅ Full feature set

**Chọn platform và bắt đầu deploy ngay!**