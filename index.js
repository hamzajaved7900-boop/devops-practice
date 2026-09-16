const express = require('express');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Static landing page serve karein
app.use(express.static(path.join(__dirname, 'public')));

// Liveness & Readiness Health Endpoint for Docker/K8s
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'UP',
    uptime: process.uptime(),
    timestamp: new Date().toISOString()
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Production server running on port ${PORT}`);
});