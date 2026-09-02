const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('<h1>CI/CD Pipeline Live Deployment Working Automatically!</h1>');
});

app.listen(port, () => {
  console.log(`App running on port ${port}`);
});