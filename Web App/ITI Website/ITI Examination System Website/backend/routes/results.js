const express = require('express');
const router = express.Router();
const { 
  getUserResults, 
  getExamResult, 
  getExamResults, 
  gradeEssayQuestion,
  getResultDetails,
  exportResults,
  getRecentResults
} = require('../controllers/resultController');
const { authenticateToken } = require('../middleware/authMiddleware');
const { requireInstructor, requireStudent, requireAnyRole } = require('../middleware/roleMiddleware');

// All result routes require authentication
router.use(authenticateToken);

// Student routes
router.get('/results', requireStudent, getUserResults);
router.get('/results/:examId', requireStudent, getExamResult);
router.get('/results/recent', requireStudent, getRecentResults);

// Instructor routes
router.get('/exams/:examId/results', requireInstructor, getExamResults);
router.get('/results/:resultId/details', requireAnyRole, getResultDetails);
router.put('/results/:resultId/questions/:questionId/grade', requireInstructor, gradeEssayQuestion);
router.get('/exams/:examId/results/export', requireInstructor, exportResults);

module.exports = router; 