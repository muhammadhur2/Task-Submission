const express = require('express');
const router = express.Router();
const { createVisitor, getAllVisitors } = require('../controllers/visitorController');

// POST /api/visitors -> Add a new visitor
router.post('/', createVisitor);

// GET /api/visitors -> Retrieve all visitors
router.get('/', getAllVisitors);

module.exports = router;
