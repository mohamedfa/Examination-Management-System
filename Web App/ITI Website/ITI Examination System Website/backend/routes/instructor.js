const express = require('express');
const router = express.Router();
const { getInstructorBranches, getInstructorTracks, getInstructorCourses } = require('../controllers/instructorController');
const { authenticateToken } = require('../middleware/authMiddleware');
const { requireInstructor } = require('../middleware/roleMiddleware');

router.get('/branches', authenticateToken, requireInstructor, getInstructorBranches);
router.get('/tracks', authenticateToken, requireInstructor, getInstructorTracks);
router.get('/courses', authenticateToken, requireInstructor, getInstructorCourses);

module.exports = router; 