const { executeStoredProcedure } = require('../utils/db');
const { getPool } = require('../utils/db'); // Added this import for the new getUserResults function

const getUserResults = async (req, res) => {
  try {
    const ssn = req.user.ssn;
    const { page = 1, limit = 10 } = req.query;

    // Get student ID from SSN
    const studentResult = await getPool().request()
      .input('SSN', ssn)
      .query('SELECT Student_ID FROM Student WHERE SSN = @SSN');
    
    if (studentResult.recordset.length === 0) {
      return res.status(404).json({ status: 'error', message: 'Student not found' });
    }
    
    const studentId = studentResult.recordset[0].Student_ID;

    // Get student's exam results
    const result = await getPool().request()
      .input('Student_ID', studentId)
      .query(`
        SELECT 
          se.Student_ID,
          se.Exam_ID,
          se.IS_Pass,
          se.Exam_Grade,
          e.Exam_Name,
          e.Exam_Total_Marks,
          e.Exam_Start_date,
          e.Exam_End_date
        FROM Student_Exam se
        INNER JOIN Exam e ON se.Exam_ID = e.Exam_ID
        WHERE se.Student_ID = @Student_ID
        ORDER BY e.Exam_Start_date DESC
      `);

    res.status(200).json({
      status: 'success',
      data: {
        results: result.recordset,
        pagination: {
          page: parseInt(page),
          limit: parseInt(limit),
          total: result.recordset.length
        }
      }
    });

  } catch (error) {
    console.error('Get user results error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const getExamResult = async (req, res) => {
  try {
    const userId = req.user.userId;
    const { examId } = req.params;

    const result = await executeStoredProcedure('GetExamResult', {
      userId,
      examId: parseInt(examId)
    });

    if (result.recordset.length === 0) {
      return res.status(404).json({
        status: 'error',
        message: 'Result not found'
      });
    }

    res.status(200).json({
      status: 'success',
      data: {
        result: result.recordset[0]
      }
    });

  } catch (error) {
    console.error('Get exam result error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const getExamResults = async (req, res) => {
  try {
    const instructorId = req.user.userId;
    const { examId } = req.params;
    const { page = 1, limit = 10 } = req.query;

    const result = await executeStoredProcedure('GetExamResults', {
      examId: parseInt(examId),
      instructorId,
      page: parseInt(page),
      limit: parseInt(limit)
    });

    res.status(200).json({
      status: 'success',
      data: {
        results: result.recordset,
        pagination: {
          page: parseInt(page),
          limit: parseInt(limit),
          total: result.recordset.length
        }
      }
    });

  } catch (error) {
    console.error('Get exam results error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const gradeEssayQuestion = async (req, res) => {
  try {
    const instructorId = req.user.userId;
    const { resultId, questionId } = req.params;
    const { score, feedback } = req.body;

    if (!score || score < 0) {
      return res.status(400).json({
        status: 'error',
        message: 'Valid score is required'
      });
    }

    const result = await executeStoredProcedure('GradeEssayQuestion', {
      resultId: parseInt(resultId),
      questionId: parseInt(questionId),
      instructorId,
      score,
      feedback: feedback || ''
    });

    if (result.recordset[0].Success === 0) {
      return res.status(400).json({
        status: 'error',
        message: result.recordset[0].Message || 'Failed to grade question'
      });
    }

    res.status(200).json({
      status: 'success',
      message: 'Question graded successfully'
    });

  } catch (error) {
    console.error('Grade essay question error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const getResultDetails = async (req, res) => {
  try {
    const { resultId } = req.params;
    const { role, userId } = req.user;

    const result = await executeStoredProcedure('GetResultDetails', {
      resultId: parseInt(resultId),
      userId,
      role
    });

    if (result.recordset.length === 0) {
      return res.status(404).json({
        status: 'error',
        message: 'Result not found'
      });
    }

    res.status(200).json({
      status: 'success',
      data: {
        result: result.recordset[0]
      }
    });

  } catch (error) {
    console.error('Get result details error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const exportResults = async (req, res) => {
  try {
    const instructorId = req.user.userId;
    const { examId } = req.params;
    const { format = 'json' } = req.query;

    const result = await executeStoredProcedure('ExportExamResults', {
      examId: parseInt(examId),
      instructorId,
      format
    });

    if (format === 'csv') {
      res.setHeader('Content-Type', 'text/csv');
      res.setHeader('Content-Disposition', `attachment; filename=exam_${examId}_results.csv`);
      return res.send(result.recordset[0].CSVData);
    }

    res.status(200).json({
      status: 'success',
      data: {
        results: result.recordset
      }
    });

  } catch (error) {
    console.error('Export results error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const getRecentResults = async (req, res) => {
  // Dummy data for dashboard
  res.json({
    status: 'success',
    data: [
      { id: 1, exam: 'Math Exam', score: 90, date: '2024-05-01' },
      { id: 2, exam: 'Physics Exam', score: 80, date: '2024-05-10' }
    ]
  });
};

module.exports = {
  getUserResults,
  getExamResult,
  getExamResults,
  gradeEssayQuestion,
  getResultDetails,
  exportResults,
  getRecentResults
}; 