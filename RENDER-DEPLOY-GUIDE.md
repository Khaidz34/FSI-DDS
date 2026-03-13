# 🔷 Deploy FSI DDS lên Render - Hướng dẫn từng bước

## 📋 Chuẩn bị trước khi deploy

### ✅ Checklist:
- [x] Code đã được cập nhật cho production
- [x] CORS đã hỗ trợ Render domains
- [x] Health check endpoint có sẵn
- [x] render.yaml đã được tạo
- [x] PORT environment variable được sử dụng

## 🚀 Bước 1: Push code lên GitHub

```bash
# Commit tất cả thay đổi
git add .
git commit -m "Ready for Render deployment"
git push origin main
```

## 🔷 Bước 2: Tạo tài khoản Render

1. Truy cập [render.com](https://render.com)
2. Click **"Get Started for Free"**
3. Đăng ký bằng **GitHub account** (khuyến nghị)
4. Authorize Render truy cập GitHub repositories

## 🌐 Bước 3: Deploy Web Service

### 3.1 Tạo Web Service
1. Trong Render Dashboard, click **"New +"**
2. Chọn **"Web Service"**
3. Connect GitHub repository **FSI DDS**
4. Render sẽ tự động detect `render.yaml`

### 3.2 Cấu hình Service
Render sẽ tự động điền từ `render.yaml`, verify:

```yaml
Name: fsi-dds-backend
Environment: Node
Region: Singapore
Branch: main
Build Command: cd backend && npm install --production
Start Command: cd backend && npm run start:sqlite
```

### 3.3 Environment Variables
Render sẽ tự động tạo từ `render.yaml`:
- `NODE_ENV`: production
- `JWT_SECRET`: (auto-generated)
- `DATABASE_PATH`: /opt/render/project/src/data/dining.db
- `BACKUP_ENABLED`: true
- `PORT`: 10000

### 3.4 Persistent Disk
- **Name**: fsi-dds-data
- **Mount Path**: /opt/render/project/src/data
- **Size**: 1GB (miễn phí)

## ⏳ Bước 4: Deploy Process

1. Click **"Create Web Service"**
2. Render sẽ bắt đầu build:
   ```
   ⏳ Cloning repository...
   📦 Installing dependencies...
   🚀 Starting application...
   ✅ Deploy successful!
   ```
3. Quá trình này mất ~3-5 phút

## 🔗 Bước 5: Lấy Backend URL

Sau khi deploy thành công:
1. Render sẽ cung cấp URL: `https://fsi-dds-backend.onrender.com`
2. Copy URL này để cấu hình frontend

## 🎨 Bước 6: Deploy Frontend (Option 1 - Render Static Site)

### 6.1 Cập nhật Frontend Config
```bash
# Cập nhật .env.production
echo "VITE_API_URL=https://fsi-dds-backend.onrender.com" > .env.production
```

### 6.2 Tạo Frontend Service
1. Render Dashboard → **"New +"** → **"Static Site"**
2. Connect same GitHub repository
3. Cấu hình:
   ```
   Name: fsi-dds-frontend
   Branch: main
   Build Command: npm run build
   Publish Directory: dist
   ```

### 6.3 Environment Variables cho Frontend
```
VITE_API_URL=https://fsi-dds-backend.onrender.com
```

## 🎨 Bước 6: Deploy Frontend (Option 2 - Vercel)

### 6.1 Cập nhật vercel.json
```json
{
  "routes": [
    {
      "src": "/api/(.*)",
      "dest": "https://fsi-dds-backend.onrender.com/api/$1"
    }
  ]
}
```

### 6.2 Deploy lên Vercel
1. Truy cập [vercel.com](https://vercel.com)
2. Import GitHub repository
3. Deploy tự động

## 🧪 Bước 7: Test Deployment

### 7.1 Test Backend
```bash
# Health check
curl https://fsi-dds-backend.onrender.com/health

# Expected response:
{
  "status": "OK",
  "database": "connected",
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

### 7.2 Test Frontend
1. Truy cập frontend URL
2. Test login functionality
3. Test đặt món
4. Verify responsive design

## ⚙️ Bước 8: Cấu hình Production

### 8.1 Custom Domain (Optional)
1. Render Dashboard → Service → Settings
2. Add Custom Domain
3. Configure DNS records

### 8.2 SSL Certificate
- Render tự động cung cấp SSL certificate
- HTTPS được enable mặc định

### 8.3 Monitoring
- Render Dashboard có built-in monitoring
- Logs, metrics, uptime tracking

## 🔧 Troubleshooting

### Build Fails
```bash
# Common issues:
1. Node.js version mismatch
2. Missing dependencies
3. Environment variables

# Solutions:
- Check build logs in Render Dashboard
- Verify package.json engines field
- Ensure all env vars are set
```

### App Sleeps
```bash
# Render free tier sleeps after 15 minutes
# Solutions:
1. Use uptime monitoring service (UptimeRobot)
2. Implement keep-alive ping
3. Upgrade to paid plan ($7/month)
```

### Database Issues
```bash
# SQLite file permissions
# Solutions:
- Ensure DATABASE_PATH is correct
- Check persistent disk mount
- Verify write permissions
```

## 📊 Monitoring & Maintenance

### 8.1 Uptime Monitoring
Tạo free uptime monitor:
1. [UptimeRobot](https://uptimerobot.com) - miễn phí
2. Monitor: `https://fsi-dds-backend.onrender.com/health`
3. Ping every 5 minutes để tránh sleep

### 8.2 Backup Strategy
```javascript
// Backend đã có auto-backup
// Backup files sẽ được lưu trong persistent disk
```

### 8.3 Logs Monitoring
```bash
# Render Dashboard → Service → Logs
# Real-time logs và error tracking
```

## 🎉 Deployment Complete!

### ✅ Kết quả:
- **Backend**: `https://fsi-dds-backend.onrender.com`
- **Frontend**: `https://fsi-dds-frontend.onrender.com`
- **Database**: SQLite với persistent storage
- **SSL**: Tự động enable
- **Cost**: 100% miễn phí

### 🔗 URLs quan trọng:
- **App URL**: Frontend URL
- **API URL**: Backend URL + `/api`
- **Health Check**: Backend URL + `/health`
- **Admin Panel**: App URL (login với admin account)

## 📱 Mobile Testing

1. Truy cập app URL trên mobile
2. Test responsive design
3. Test tất cả tính năng:
   - Login/Register
   - Chọn món
   - Đặt cho người khác
   - Theme switching
   - Language switching

**FSI DDS đã sẵn sàng phục vụ trên cloud! 🚀**