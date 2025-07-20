const express = require('express');
const router = express.Router();
const { getNotifications } = require('../controllers/notificationsController');
const { authenticateToken } = require('../middleware/authMiddleware');

// All notification routes require authentication
router.use(authenticateToken);

router.get('/notifications', getNotifications);

module.exports = router; 