# Mobile "Đặt cơm cho người khác" Fix

## 🚨 Vấn đề được báo cáo:
> "phần dặt cơm cho người khác trên moblie đang không hoạt động"

## ✅ Đã sửa thành công!

### 🔍 **Nguyên nhân:**
Khi tối ưu mobile cart để giải quyết vấn đề "chiếm hết màn hình", tôi đã tạo phiên bản mobile gọn gàng nhưng **quên thêm phần chọn "đặt cho ai"**. Điều này khiến mobile chỉ có thể đặt cho bản thân.

### 🔧 **Giải pháp:**

#### **Thêm dropdown "Đặt món cho" vào Mobile Cart**

```tsx
{/* Mobile: Order for selection */}
<div className="mb-3">
  <label className="block text-xs font-semibold text-[#1C1917] mb-1">Đặt món cho:</label>
  <select
    value={orderForUserId || user?.id || ''}
    onChange={(e) => {
      const value = e.target.value ? Number(e.target.value) : null;
      setOrderForUserId(value);
    }}
    className="w-full px-3 py-2 border-2 border-[#E5E1D1] rounded-lg focus:outline-none focus:border-[#DA251D] bg-white text-[#1C1917] font-medium text-sm"
  >
    <option value={user?.id || ''}>{user?.fullname} (Bản thân)</option>
    {allUsers.filter(u => u.id !== user?.id).map(u => (
      <option key={u.id} value={u.id}>{u.fullname}</option>
    ))}
  </select>
</div>
```

### 📱 **Mobile Cart Layout mới:**

```
┌─────────────────────────────────────┐
│ 🛒 Món đã chọn (2/2)    40,000đ  ❌ │
├─────────────────────────────────────┤
│ [1] Gà ủ muối    [2] Sườn mọc ôm... │
├─────────────────────────────────────┤
│ Đặt món cho: [Nguyễn Tiến Toàn ▼]   │ ← ✅ MỚI THÊM
├─────────────────────────────────────┤
│           [✓ Đặt món]               │
└─────────────────────────────────────┘
```

### 🔄 **Workflow hoàn chỉnh:**

#### **Mobile:**
1. **Chọn món** → Mobile cart xuất hiện
2. **Chọn người nhận** từ dropdown "Đặt món cho"
3. **Nhấn "Đặt món"** → OrderSummary hiển thị đúng tên người nhận
4. **Hoàn tất** với đầy đủ tùy chọn

#### **Desktop:**
- Vẫn giữ nguyên layout đầy đủ với tất cả tùy chọn

### 🎯 **Tính năng đã hoạt động:**

| Feature | Mobile | Desktop |
|---------|--------|---------|
| **Chọn món** | ✅ | ✅ |
| **Đặt cho bản thân** | ✅ | ✅ |
| **Đặt cho người khác** | ✅ (Đã sửa) | ✅ |
| **Tùy chọn thêm** | ✅ (Trong OrderSummary) | ✅ (Trong Cart) |
| **Ghi chú** | ✅ (Trong OrderSummary) | ✅ (Trong Cart) |

### 🔧 **Technical Details:**

#### **State Management:**
- `orderForUserId` state đã tồn tại và hoạt động đúng
- OrderSummary đã được cấu hình để nhận đúng `customerName`
- Logic đặt món đã xử lý đúng `orderedFor` field

#### **UI Components:**
- **Label**: "Đặt món cho:" (gọn gàng cho mobile)
- **Dropdown**: Responsive, focus state đúng theme
- **Options**: "Tên (Bản thân)" cho chính mình, "Tên đầy đủ" cho người khác

#### **Integration:**
```tsx
// OrderSummary nhận đúng thông tin
<OrderSummary
  customerName={orderForUserId ? allUsers.find(u => u.id === orderForUserId)?.fullname || '' : user?.fullname || ''}
  isForSelf={!orderForUserId || orderForUserId === user?.id}
  // ... other props
/>

// API call với đúng orderedFor
const orderData = {
  dish1Id: selectedDishes[0],
  dish2Id: selectedDishes[1] || undefined,
  orderedFor: orderForUserId || user.id, // ✅ Đúng logic
  // ... other fields
};
```

### 📁 **Files Modified:**
- `src/App.tsx` - Thêm dropdown vào mobile cart
- `test-mobile-order-for-others.html` - Test file

### 🧪 **Testing Steps:**
1. Đăng nhập với account có quyền đặt cho người khác
2. Chọn 1-2 món ăn
3. Trong mobile cart, chọn người khác từ dropdown
4. Nhấn "Đặt món" và verify OrderSummary hiển thị đúng tên
5. Hoàn tất đặt món và kiểm tra trong lịch sử

## ✅ **Kết quả:**

### **Vấn đề đã được giải quyết:**
- ❌ **Trước**: Mobile không thể đặt cho người khác
- ✅ **Sau**: Mobile có đầy đủ tính năng đặt cho người khác

### **UX Improvements:**
- 📱 **Mobile**: Gọn gàng nhưng đầy đủ tính năng
- 🖥️ **Desktop**: Không thay đổi, vẫn hoạt động tốt
- 🔄 **Consistency**: Cả mobile và desktop đều có cùng tính năng

**Tính năng "đặt cơm cho người khác" giờ đây hoạt động hoàn hảo trên cả mobile và desktop!**