const express = require('express');
const router = express.Router();
const { 
  createExam, 
  getAllExams, 
  getExamById, 
  updateExam, 
  deleteExam,
  startExam,
  submitExam,
  getUpcomingExams,
  getAvailableExams,
  getExamQuestions,
  generateExamQuestions,
  getStudentExamResult,
  getExamQuestionsForView
} = require('../controllers/examController');
const { authenticateToken } = require('../middleware/authMiddleware');
const { requireInstructor, requireStudent, requireAnyRole } = require('../middleware/roleMiddleware');

// All exam routes require authentication
router.use(authenticateToken);

// Public exam routes (for both students and instructors)
router.get('/exams', requireAnyRole, getAllExams);
router.get('/exams/upcoming', requireAnyRole, getUpcomingExams);
router.get('/exams/available', requireStudent, getAvailableExams);
router.get('/exams/:examId', requireAnyRole, getExamById);

// Instructor-only routes
router.post('/exams', requireInstructor, createExam);
router.put('/exams/:examId', requireInstructor, updateExam);
router.delete('/exams/:examId', requireInstructor, deleteExam);
router.get('/exams/:examId/view', requireInstructor, getExamQuestionsForView);

// Student-only routes
router.post('/exams/:examId/start', requireStudent, startExam);
router.post('/exams/:examId/submit', requireStudent, submitExam);

// Student-only endpoints
router.get('/exams/:examId/questions', requireStudent, getExamQuestions);
router.get('/results/:examId', requireStudent, getStudentExamResult);
// Instructor-only endpoint
router.post('/exams/:examId/generate-questions', requireInstructor, generateExamQuestions);

module.exports = router; 