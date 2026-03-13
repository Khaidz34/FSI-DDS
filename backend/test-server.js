// Simple test server to verify basic functionality
const express = require('express');
const cors = require('cors');

const app = express();
const PORT = 5000;

// Enable CORS
app.use(cors({
  origin: ['http://localhost:5173', 'http://localhost:3001'],
  credentials: true
}));

app.use(express.json());

// Test route
app.get('/api/test', (req, res) => {
  res.json({ 
    message: 'Backend is working!', 
    timestamp: new Date().toISOString(),
    port: PORT 
  });
});

// Menu test route
app.get('/api/menu/today', (req, res) => {
  res.json({
    date: new Date().toISOString().split('T')[0],
    dishes: [
      { id: 1, name: 'Test Dish 1' },
      { id: 2, name: 'Test Dish 2' }
    ]
  });
});

app.listen(PORT, () => {
  console.log(`🚀 Test server running on http://localhost:${PORT}`);
  console.log(`📊 Test endpoint: http://localhost:${PORT}/api/test`);
  console.log(`🍽️ Menu endpoint: http://localhost:${PORT}/api/menu/today`);
});