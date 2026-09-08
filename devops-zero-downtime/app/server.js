const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;
const APP_VERSION = process.env.APP_VERSION || "v1.0.0";

// Health check endpoint for ALB target group
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'UP', timestamp: new Date().toISOString() });
});

// Main traffic endpoint
app.get('/', (req, res) => {
  res.status(200).json({
    message: "Live from production cluster",
    version: APP_VERSION,
    host: require('os').hostname()
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Application running on port ${PORT} - Version: ${APP_VERSION}`);
});