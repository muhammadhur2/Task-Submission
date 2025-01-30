require('dotenv').config();
const express = require('express');
const cors = require('cors');
const path = require('path');
const visitorRoutes = require('./routes/visitorRoutes');  // Our visitors route

const app = express();

// Middleware
app.use(cors());
app.use(express.json()); // For parsing JSON bodies

// Serve static files from public folder
app.use(express.static(path.join(__dirname, 'public')));

// Routes
app.use('/api/visitors', visitorRoutes);

// Catch-all to serve index.html for non-API routes (if using SPA style)
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

module.exports = app; // <-- Export the app for testing

