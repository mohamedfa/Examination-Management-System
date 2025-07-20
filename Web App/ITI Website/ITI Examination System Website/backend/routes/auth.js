const express = require('express');
const router = express.Router();
const { login, logout, validateToken } = require('../controllers/authController');
const { authenticateToken } = require('../middleware/authMiddleware');

// Public routes
router.post('/login', login);

// Protected routes
router.post('/logout', authenticateToken, logout);
router.get('/validate', authenticateToken, validateToken);

module.exports = router;