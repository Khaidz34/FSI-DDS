// Test script to verify markdown cleanup functionality
const fetch = require('node-fetch');

const API_BASE_URL = 'http://localhost:5000/api';

// Test login and cleanup
async function testCleanup() {
  try {
    console.log('🧪 Testing markdown cleanup...');
    
    // Login as admin
    const loginResponse = await fetch(`${API_BASE_URL}/auth/login`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ username: 'admin', password: 'admin123' })
    });
    
    if (!loginResponse.ok) {
      throw new Error('Login failed');
    }
    
    const { token } = await loginResponse.json();
    console.log('✅ Login successful');
    
    // Call cleanup endpoint
    const cleanupResponse = await fetch(`${API_BASE_URL}/admin/cleanup-markdown`, {
      method: 'POST',
      headers: { 
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${token}`
      }
    });
    
    if (!cleanupResponse.ok) {
      throw new Error('Cleanup failed');
    }
    
    const result = await cleanupResponse.json();
    console.log('✅ Cleanup result:', result);
    
  } catch (error) {
    console.error('❌ Test failed:', error.message);
  }
}

// Run test if this file is executed directly
if (require.main === module) {
  testCleanup();
}

module.exports = { testCleanup };