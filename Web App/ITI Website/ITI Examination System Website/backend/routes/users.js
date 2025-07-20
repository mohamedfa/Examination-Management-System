const express = require('express');
const router = express.Router();
const { getProfile, updateProfile, changePassword, getUserStats, getDashboardStats } = require('../controllers/userController');
const { authenticateToken } = require('../middleware/authMiddleware');

// All user routes require authentication
router.use(authenticateToken);

// Profile management
router.get('/profile', getProfile);
router.put('/profile', updateProfile);
router.put('/change-password', changePassword);
router.get('/stats', getUserStats);
router.get('/dashboard', authenticateToken, getDashboardStats);

module.exports = router; 