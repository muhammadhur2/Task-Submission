const express = require('express');
const router = express.Router();
const { createVisitor, getAllVisitors } = require('../controllers/visitorController');

router.post('/', createVisitor);

router.get('/', getAllVisitors);

module.exports = router;
