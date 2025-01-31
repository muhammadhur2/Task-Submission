require('dotenv').config();
const express = require('express');
const cors = require('cors');
const path = require('path');
const visitorRoutes = require('./routes/visitorRoutes');  // Our visitors route

const app = express();

app.use(cors());
app.use(express.json()); 

app.use(express.static(path.join(__dirname, 'public')));

app.use('/api/visitors', visitorRoutes);


app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

module.exports = app;

