const { executeStoredProcedure, getPool } = require('../utils/db');

const addQuestion = async (req, res) => {
  try {
    const ssn = req.user.ssn;
    const instructorResult = await getPool().request()
      .input('SSN', ssn)
      .query('SELECT Instructor_ID FROM Instructor WHERE SSN = @SSN');
    const instructorId = instructorResult.recordset[0]?.Instructor_ID;
    if (!instructorId) {
      return res.status(403).json({ status: 'error', message: 'Instructor not found for this user.' });
    }
    const { examId } = req.params;
    const { questionText, questionType, options, correctAnswer, marks } = req.body;

    // Validate required fields
    if (!questionText || !questionType || !marks) {
      return res.status(400).json({
        status: 'error',
        message: 'Question text, type, and marks are required'
      });
    }

    // Validate question type
    if (!['multiple_choice', 'true_false', 'essay'].includes(questionType)) {
      return res.status(400).json({
        status: 'error',
        message: 'Question type must be multiple_choice, true_false, or essay'
      });
    }

    const result = await executeStoredProcedure('sp_Insert_Question', {
      Exam_ID: parseInt(examId),
      Instructor_ID: instructorId,
      Question_Text: questionText,
      Question_Type: questionType,
      Options: options ? JSON.stringify(options) : null,
      Correct_Answer: correctAnswer,
      Marks: marks
    });

    if (result.recordset[0].Success === 0) {
      return res.status(400).json({
        status: 'error',
        message: result.recordset[0].Message || 'Failed to add question'
      });
    }

    res.status(201).json({
      status: 'success',
      message: 'Question added successfully',
      data: {
        questionId: result.recordset[0].QuestionId
      }
    });

  } catch (error) {
    console.error('Add question error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const getExamQuestions = async (req, res) => {
  try {
    const { examId } = req.params;
    const { role, userId } = req.user;

    const result = await executeStoredProcedure('sp_Select_Question', {
      Exam_ID: parseInt(examId)
    });

    res.status(200).json({
      status: 'success',
      data: {
        questions: result.recordset
      }
    });

  } catch (error) {
    console.error('Get questions error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const updateQuestion = async (req, res) => {
  try {
    const ssn = req.user.ssn;
    const instructorResult = await getPool().request()
      .input('SSN', ssn)
      .query('SELECT Instructor_ID FROM Instructor WHERE SSN = @SSN');
    const instructorId = instructorResult.recordset[0]?.Instructor_ID;
    if (!instructorId) {
      return res.status(403).json({ status: 'error', message: 'Instructor not found for this user.' });
    }
    const { questionId } = req.params;
    const { questionText, questionType, options, correctAnswer, marks } = req.body;

    const result = await executeStoredProcedure('sp_Update_Question', {
      Question_ID: parseInt(questionId),
      Instructor_ID: instructorId,
      Question_Text: questionText,
      Question_Type: questionType,
      Options: options ? JSON.stringify(options) : null,
      Correct_Answer: correctAnswer,
      Marks: marks
    });

    if (result.recordset[0].Success === 0) {
      return res.status(400).json({
        status: 'error',
        message: result.recordset[0].Message || 'Failed to update question'
      });
    }

    res.status(200).json({
      status: 'success',
      message: 'Question updated successfully'
    });

  } catch (error) {
    console.error('Update question error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const deleteQuestion = async (req, res) => {
  try {
    const ssn = req.user.ssn;
    const instructorResult = await getPool().request()
      .input('SSN', ssn)
      .query('SELECT Instructor_ID FROM Instructor WHERE SSN = @SSN');
    const instructorId = instructorResult.recordset[0]?.Instructor_ID;
    if (!instructorId) {
      return res.status(403).json({ status: 'error', message: 'Instructor not found for this user.' });
    }
    const { questionId } = req.params;

    const result = await executeStoredProcedure('sp_Delete_Question', {
      Question_ID: parseInt(questionId),
      Instructor_ID: instructorId
    });

    if (result.recordset[0].Success === 0) {
      return res.status(400).json({
        status: 'error',
        message: result.recordset[0].Message || 'Failed to delete question'
      });
    }

    res.status(200).json({
      status: 'success',
      message: 'Question deleted successfully'
    });

  } catch (error) {
    console.error('Delete question error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const getQuestionById = async (req, res) => {
  try {
    const { questionId } = req.params;
    const { role, userId } = req.user;

    const result = await executeStoredProcedure('GetQuestionById', {
      questionId: parseInt(questionId),
      userId,
      role
    });

    if (result.recordset.length === 0) {
      return res.status(404).json({
        status: 'error',
        message: 'Question not found'
      });
    }

    res.status(200).json({
      status: 'success',
      data: {
        question: result.recordset[0]
      }
    });

  } catch (error) {
    console.error('Get question error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

module.exports = {
  addQuestion,
  getExamQuestions,
  updateQuestion,
  deleteQuestion,
  getQuestionById
}; 