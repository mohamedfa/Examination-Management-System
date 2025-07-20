const express = require('express');
const router = express.Router();
const { 
  addQuestion, 
  getExamQuestions, 
  updateQuestion, 
  deleteQuestion,
  getQuestionById
} = require('../controllers/questionController');
const { authenticateToken } = require('../middleware/authMiddleware');
const { requireInstructor, requireAnyRole } = require('../middleware/roleMiddleware');

// All question routes require authentication
router.use(authenticateToken);

// Routes accessible by both students and instructors
router.get('/exams/:examId/questions', requireAnyRole, getExamQuestions);
router.get('/questions/:questionId', requireAnyRole, getQuestionById);

// Instructor-only routes
router.post('/exams/:examId/questions', requireInstructor, addQuestion);
router.put('/questions/:questionId', requireInstructor, updateQuestion);
router.delete('/questions/:questionId', requireInstructor, deleteQuestion);

module.exports = router; 