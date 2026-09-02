const express = require('express');
const app = express();
const PORT = 3000;
res.send("<h1>CI/CD Pipeline Live Deployment Working Automatically!</h1>");
app.get('/', (req, res) => {
    res.send('<h1>Docker App Version 2 - Running Successfully Allah is very great and be kind to human !</h1>');
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
