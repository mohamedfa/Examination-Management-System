const { executeStoredProcedure, getPool } = require('../utils/db');

const createExam = async (req, res) => {
  try {
    const ssn = req.user.ssn;
    // Resolve Instructor_ID from SSN
    const instructorResult = await getPool().request()
      .input('SSN', ssn)
      .query('SELECT Instructor_ID FROM Instructor WHERE SSN = @SSN');
    const instructorId = instructorResult.recordset[0]?.Instructor_ID;
    if (!instructorId) {
      return res.status(403).json({ status: 'error', message: 'Instructor not found for this user.' });
    }
    const { exam_name, course_id, num_mcq, num_tf, start_date, end_date, branch_id, track_id } = req.body;

    // Validate required fields
    if (!exam_name || !course_id || !num_mcq || !num_tf || !start_date || !end_date || !branch_id || !track_id) {
      return res.status(400).json({
        status: 'error',
        message: 'All fields are required: exam_name, course_id, num_mcq, num_tf, start_date, end_date, branch_id, track_id'
      });
    }

    // Use GenerateExam stored procedure to auto-generate questions and create the exam
    const courseNameResult = await getPool().request()
      .input('Course_ID', course_id)
      .query('SELECT Course_Name FROM Course WHERE Course_ID = @Course_ID');
    const courseName = courseNameResult.recordset[0]?.Course_Name;
    if (!courseName) {
      return res.status(400).json({ status: 'error', message: 'Invalid course selected.' });
    }

    const num_mcq_int = parseInt(num_mcq);
    const num_tf_int = parseInt(num_tf);
    const formattedStartDate = start_date.replace('T', ' ') + ':00';
    const formattedEndDate = end_date.replace('T', ' ') + ':00';

    // Call GenerateExam
    const genResult = await getPool().request()
      .input('ExamName', exam_name)
      .input('Course', courseName)
      .input('NumOfMCQ', num_mcq_int)
      .input('NumOfTF', num_tf_int)
      .input('StartDate', formattedStartDate)
      .input('EndDate', formattedEndDate)
      .input('Branch_ID', branch_id)
      .input('Course_ID', course_id)
      .input('Track_ID', track_id)
      .execute('GenerateExam');

    // Get the exam ID from the result
    const exam_id = genResult.recordset[0]?.Exam_ID;
    if (!exam_id) {
      return res.status(500).json({ status: 'error', message: 'Exam created but could not retrieve Exam ID.' });
    }
    res.status(201).json({
      status: 'success',
      message: 'Exam created and questions generated successfully',
      data: { exam_id }
    });
  } catch (error) {
    console.error('Create exam error:', error);
    res.status(500).json({ status: 'error', message: 'Internal server error' });
  }
};

const getAllExams = async (req, res) => {
  try {
    const ssn = req.user.ssn;
    const { role } = req.user;
    let result;
    if (role === 'instructor') {
      // Get all exams for this instructor (optionally filter by instructor)
      result = await getPool().request()
        .query(`
          SELECT 
            e.Exam_ID as id,
            e.Exam_Name as name,
            e.Exam_Total_Marks as total_marks,
            e.Exam_Start_date as start_date,
            e.Exam_End_date as end_date,
            e.Branch_ID as branch_id,
            b.Branch_Name as branch_name,
            t.Track_Name as track_name,
            c.Course_Name as course_name,
            (SELECT COUNT(*) FROM Exam_Question eq JOIN Question q ON eq.Question_ID = q.Question_ID WHERE eq.Exam_ID = e.Exam_ID AND q.type = 'mcq') as mcq_count,
            (SELECT COUNT(*) FROM Exam_Question eq JOIN Question q ON eq.Question_ID = q.Question_ID WHERE eq.Exam_ID = e.Exam_ID AND (q.type = 'tf' OR q.type = 'True/False')) as tf_count
          FROM Exam e
          JOIN Branch b ON e.Branch_ID = b.Branch_ID
          JOIN Course c ON e.Course_ID = c.Course_ID
          JOIN Track t ON e.Track_ID = t.Track_ID
          ORDER BY e.Exam_Start_date DESC
        `);
    } else {
      // For students, return available exams for their branch and track
      const studentResult = await getPool().request()
        .input('SSN', ssn)
        .query('SELECT Student_ID, Branch_ID, Track_ID FROM Student WHERE SSN = @SSN');
      const student = studentResult.recordset[0];
      if (!student) {
        return res.status(403).json({ status: 'error', message: 'Student not found for this user.' });
      }
      result = await getPool().request()
        .input('Branch_ID', student.Branch_ID)
        .input('Track_ID', student.Track_ID)
        .query(`
          SELECT 
            e.Exam_ID as id,
            e.Exam_Name as name,
            e.Exam_Total_Marks as total_marks,
            e.Exam_Start_date as start_date,
            e.Exam_End_date as end_date,
            b.Branch_Name as branch_name,
            t.Track_Name as track_name,
            c.Course_Name as course_name
          FROM Exam e
          JOIN Branch b ON e.Branch_ID = b.Branch_ID
          JOIN Course c ON e.Course_ID = c.Course_ID
          JOIN Track t ON e.Track_ID = t.Track_ID
          WHERE e.Branch_ID = @Branch_ID AND e.Track_ID = @Track_ID
          ORDER BY e.Exam_Start_date DESC
        `);
    }
      res.status(200).json({
        status: 'success',
      data: { exams: result.recordset }
      });
  } catch (error) {
    console.error('Get exams error:', error);
    res.status(500).json({ status: 'error', message: 'Internal server error' });
  }
};

const getExamById = async (req, res) => {
  try {
    const { examId } = req.params;
    const { role, userId } = req.user;

    const result = await executeStoredProcedure('sp_Select_Exam', {
      Exam_ID: parseInt(examId)
    });

    if (result.recordset.length === 0) {
      return res.status(404).json({
        status: 'error',
        message: 'Exam not found'
      });
    }

    res.status(200).json({
      status: 'success',
      data: {
        exam: result.recordset[0]
      }
    });

  } catch (error) {
    console.error('Get exam error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const updateExam = async (req, res) => {
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
    // Infer field names from request body
    const { exam_name, exam_total_marks, exam_start_date, exam_end_date, branch_id } = req.body;

    const params = {
      Exam_ID: parseInt(examId),
      Exam_Name: exam_name,
      Exam_Total_Marks: exam_total_marks,
      Exam_Start_date: exam_start_date,
      Exam_End_date: exam_end_date
    };
    if (branch_id !== undefined && branch_id !== null && branch_id !== '') {
      params.Branch_ID = branch_id;
    }
    console.log('sp_Update_Exam params:', params);
    const result = await executeStoredProcedure('sp_Update_Exam', params);

    // If the stored procedure returns an error message
    if (result.recordset && result.recordset[0] && result.recordset[0].ErrorMessage) {
      return res.status(400).json({
        status: 'error',
        message: result.recordset[0].ErrorMessage || 'Failed to update exam'
      });
    }

    // After updating the exam, regenerate questions if counts are provided
    const { num_mcq, num_tf } = req.body;
    if (typeof num_mcq !== 'undefined' && typeof num_tf !== 'undefined') {
      try {
        await executeStoredProcedure('RegenerateExamQuestions', {
          Exam_ID: parseInt(examId),
          NumOfMCQ: parseInt(num_mcq),
          NumOfTF: parseInt(num_tf)
        });
      } catch (genErr) {
        console.error('Error generating questions after exam update:', genErr);
        return res.status(500).json({
          status: 'error',
          message: 'Exam updated but failed to regenerate questions.'
        });
      }
    }

    res.status(200).json({
      status: 'success',
      message: 'Exam updated successfully'
    });

  } catch (error) {
    console.error('Update exam error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const deleteExam = async (req, res) => {
  try {
    const ssn = req.user.ssn;
    const instructorResult = await getPool().request()
      .input('SSN', ssn)
      .query('SELECT Instructor_ID FROM Instructor WHERE SSN = @SSN');
    const instructorId = instructorResult.recordset[0]?.Instructor_ID;
    console.log('DeleteExam: instructorId:', instructorId, 'examId:', req.params.examId);
    if (!instructorId) {
      return res.status(403).json({ status: 'error', message: 'Instructor not found for this user.' });
    }
    const { examId } = req.params;

    const result = await executeStoredProcedure('sp_Delete_Exam', {
      Exam_ID: parseInt(examId)
    });
    console.log('DeleteExam: sp_Delete_Exam result:', result.recordset);

    if (result.recordset && result.recordset[0] && result.recordset[0].ErrorMessage) {
      return res.status(400).json({
        status: 'error',
        message: result.recordset[0].ErrorMessage || 'Failed to delete exam'
      });
    }

    res.status(200).json({
      status: 'success',
      message: 'Exam deleted successfully'
    });

  } catch (error) {
    console.error('Delete exam error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const startExam = async (req, res) => {
  try {
    const ssn = req.user.ssn;
    const studentResult = await getPool().request()
      .input('SSN', ssn)
      .query('SELECT Student_ID FROM Student WHERE SSN = @SSN');
    const studentId = studentResult.recordset[0]?.Student_ID;
    if (!studentId) {
      return res.status(403).json({ status: 'error', message: 'Student not found for this user.' });
    }
    const { examId } = req.params;

    // Check if student has already taken this exam
    const existingResult = await getPool().request()
      .input('Student_ID', studentId)
      .input('Exam_ID', parseInt(examId))
      .query(`
        SELECT Exam_ID, IS_Pass, Exam_Grade
        FROM Student_Exam
        WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID
      `);

    if (existingResult.recordset.length > 0) {
      return res.status(400).json({
        status: 'error',
        message: 'You have already taken this exam. You cannot take it again.'
      });
    }

    const result = await executeStoredProcedure('StartExam', {
      examId: parseInt(examId),
      studentId
    });

    if (result.recordset[0].Success === 0) {
      return res.status(400).json({
        status: 'error',
        message: result.recordset[0].Message || 'Failed to start exam'
      });
    }

    res.status(200).json({
      status: 'success',
      message: 'Exam started successfully',
      data: {
        examSession: result.recordset[0]
      }
    });

  } catch (error) {
    console.error('Start exam error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const submitExam = async (req, res) => {
  try {
    console.log('Submit exam request body:', req.body);
    console.log('Submit exam params:', req.params);
    
    const ssn = req.user.ssn;
    const studentResult = await getPool().request()
      .input('SSN', ssn)
      .query('SELECT Student_ID FROM Student WHERE SSN = @SSN');
    const studentId = studentResult.recordset[0]?.Student_ID;
    
    console.log('Student ID:', studentId);
    
    if (!studentId) {
      return res.status(403).json({ status: 'error', message: 'Student not found for this user.' });
    }
    
    const { examId } = req.params;
    const { answers } = req.body;

    console.log('Exam ID:', examId);
    console.log('Answers:', answers);

    if (!answers || !Array.isArray(answers)) {
      console.log('Invalid answers format:', answers);
      return res.status(400).json({
        status: 'error',
        message: 'Answers array is required'
      });
    }

    // Allow empty answers array - student didn't answer any questions
    if (answers.length === 0) {
      console.log('No answers provided - creating exam status with 0 grade');
      
      // Create exam status record with 0 grade for unanswered exam
      const emptyExamResult = await executeStoredProcedure('ExamCorrection', {
        Student_ID: studentId,
        Exam_ID: parseInt(examId)
      });

      if (emptyExamResult.recordset[0].Success === 0) {
        return res.status(400).json({
          status: 'error',
          message: emptyExamResult.recordset[0].Message || 'Failed to create exam status'
        });
      }

      res.status(200).json({
        status: 'success',
        message: 'Exam submitted successfully (no answers provided)',
        data: {
          grade: 0,
          isPass: false,
          message: 'Exam completed with no answers'
        }
      });
      return;
    }

    // Process each answer
    for (const ans of answers) {
      const question_id = ans.questionId || ans.question_id;
      const student_answer = ans.answer || ans.student_answer;
      console.log(`Processing answer: Question ${question_id}, Answer: ${student_answer}`);
      
      // Debug: Check what the correct answer should be
      const correctAnswerResult = await getPool().request()
        .input('Question_ID', question_id)
        .query(`
          SELECT c.right_choice, q.Question_Mark
          FROM Question q 
          INNER JOIN Choices c ON q.Question_ID = c.Question_ID 
          WHERE q.Question_ID = @Question_ID
        `);
      
      if (correctAnswerResult.recordset.length > 0) {
        const correctAnswer = correctAnswerResult.recordset[0].right_choice;
        const questionMark = correctAnswerResult.recordset[0].Question_Mark;
        console.log(`Question ${question_id} - Correct answer: "${correctAnswer}", Student answer: "${student_answer}", Mark: ${questionMark}`);
        console.log(`Answer match: ${student_answer === correctAnswer ? 'YES' : 'NO'}`);
      } else {
        console.log(`Question ${question_id} - No correct answer found in database`);
      }
      
      await executeStoredProcedure('ExamAnswer', {
        Exam_ID: parseInt(examId),
        Student_ID: studentId,
        Question_ID: question_id,
        Student_Answer: student_answer
      });
    }

    // Correct the exam
    console.log('Starting exam correction...');
    const correctionResult = await executeStoredProcedure('ExamCorrection', {
      Student_ID: studentId,
      Exam_ID: parseInt(examId)
    });

    console.log('Correction result:', correctionResult.recordset[0]);
    
    // Check the current state of Student_Exam table
    const checkResult = await getPool().request()
      .input('Student_ID', studentId)
      .input('Exam_ID', parseInt(examId))
      .query(`
        SELECT IS_Pass, Exam_Grade, Exam_Total_Marks
        FROM Student_Exam se
        INNER JOIN Exam e ON se.Exam_ID = e.Exam_ID
        WHERE se.Student_ID = @Student_ID AND se.Exam_ID = @Exam_ID
      `);
    
    console.log('Current Student_Exam state:', checkResult.recordset[0]);
    
    // Check the answers that were saved
    const answersCheck = await getPool().request()
      .input('Student_ID', studentId)
      .input('Exam_ID', parseInt(examId))
      .query(`
        SELECT Question_ID, ST_answer, Point_Awarded
        FROM Student_Exam_Question
        WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID
      `);
    
    console.log('Saved answers:', answersCheck.recordset);

    // Debug: Check the exam total marks
    const examMarksCheck = await getPool().request()
      .input('Exam_ID', parseInt(examId))
      .query(`
        SELECT Exam_Total_Marks, Exam_Name
        FROM Exam
        WHERE Exam_ID = @Exam_ID
      `);
    
    console.log('Exam marks check:', examMarksCheck.recordset[0]);

    // Debug: Check the questions and their marks
    const questionsMarksCheck = await getPool().request()
      .input('Exam_ID', parseInt(examId))
      .query(`
        SELECT q.Question_ID, q.Question_Mark, q.type
        FROM Question q
        INNER JOIN Exam_Question eq ON q.Question_ID = eq.Question_ID
        WHERE eq.Exam_ID = @Exam_ID
      `);
    
    console.log('Questions and marks:', questionsMarksCheck.recordset);

    // Debug: Check what question types exist in the database
    const questionTypesCheck = await getPool().request()
      .query(`
        SELECT DISTINCT type, COUNT(*) as count
        FROM Question
        GROUP BY type
      `);
    
    console.log('Question types in database:', questionTypesCheck.recordset);

    if (correctionResult.recordset[0].Success === 0) {
      return res.status(400).json({
        status: 'error',
        message: correctionResult.recordset[0].Message || 'Failed to correct exam'
      });
    }

    res.status(200).json({
      status: 'success',
      message: 'Exam submitted and corrected successfully',
      data: correctionResult.recordset[0]
    });

  } catch (error) {
    console.error('Submit exam error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const getUpcomingExams = async (req, res) => {
  // Dummy data for dashboard
  res.json({
    status: 'success',
    data: [
      { id: 1, title: 'Math Exam', date: '2024-06-10', time: '10:00 AM' },
      { id: 2, title: 'Physics Exam', date: '2024-06-15', time: '2:00 PM' }
    ]
  });
};

const getAvailableExams = async (req, res) => {
  console.log('getAvailableExams called for user:', req.user);
  try {
    const ssn = req.user.ssn;
    
    // Get student's information including Branch_ID and Track_ID
    const studentResult = await getPool().request()
      .input('SSN', ssn)
      .query('SELECT Student_ID, Branch_ID, Track_ID FROM Student WHERE SSN = @SSN');
    
    if (studentResult.recordset.length === 0) {
      return res.status(404).json({ status: 'error', message: 'Student not found' });
    }
    
    const student = studentResult.recordset[0];
    
    // Get available exams for this student's branch and track, excluding exams they've already taken
    const examsResult = await getPool().request()
      .input('Branch_ID', student.Branch_ID)
      .input('Track_ID', student.Track_ID)
      .input('Student_ID', student.Student_ID)
      .query(`
        SELECT 
          e.Exam_ID as id,
          e.Exam_Name as name,
          e.Exam_Total_Marks as total_marks,
          e.Exam_Start_date as start_date,
          e.Exam_End_date as end_date,
          b.Branch_Name as branch_name,
          t.Track_Name as track_name,
          c.Course_Name as course_name,
          (SELECT COUNT(*) FROM Question q 
           INNER JOIN Exam_Question eq ON q.Question_ID = eq.Question_ID 
           WHERE eq.Exam_ID = e.Exam_ID AND (q.type = 'MCQ' OR q.type = 'mcq' OR q.type = 'multiple_choice')) as mcq_count,
          (SELECT COUNT(*) FROM Question q 
           INNER JOIN Exam_Question eq ON q.Question_ID = eq.Question_ID 
           WHERE eq.Exam_ID = e.Exam_ID AND (q.type = 'TF' OR q.type = 'tf' OR q.type = 'True/False' OR q.type = 'true_false')) as tf_count
        FROM Exam e
        LEFT JOIN Branch b ON e.Branch_ID = b.Branch_ID
        LEFT JOIN Course c ON e.Course_ID = c.Course_ID
        LEFT JOIN Track t ON e.Track_ID = t.Track_ID
        WHERE e.Branch_ID = @Branch_ID 
          AND e.Track_ID = @Track_ID
          AND e.Exam_ID NOT IN (
            SELECT Exam_ID 
            FROM Student_Exam 
            WHERE Student_ID = @Student_ID
          )
        -- Removed date conditions for debugging: AND e.Exam_Start_date <= GETDATE() AND e.Exam_End_date >= GETDATE()
        ORDER BY e.Exam_Start_date DESC
      `);
    
    console.log(`Found ${examsResult.recordset.length} available exams for student ${student.Student_ID}`);
    
    // Debug: Log the exam data with question counts
    examsResult.recordset.forEach((exam, index) => {
      console.log(`Exam ${index + 1}: ${exam.name} - MCQ: ${exam.mcq_count}, TF: ${exam.tf_count}, Total: ${(exam.mcq_count || 0) + (exam.tf_count || 0)}`);
    });
    
    res.status(200).json({
      status: 'success',
      data: { exams: examsResult.recordset }
    });
  } catch (error) {
    console.error('Get available exams error:', error);
    res.status(500).json({ status: 'error', message: 'Internal server error' });
  }
};

const getExamQuestions = async (req, res) => {
  try {
    const { examId } = req.params;
    const questions = await executeStoredProcedure('GetExamQuestions', { examId: parseInt(examId) });
    res.json({ status: 'success', data: questions.recordset });
  } catch (error) {
    console.error('Get exam questions error:', error);
    res.status(500).json({ status: 'error', message: 'Internal server error' });
  }
};

const generateExamQuestions = async (req, res) => {
  try {
    const { examId } = req.params;
    // Call your exam generation stored procedure
    const result = await executeStoredProcedure('GenerateExamQuestions', { examId: parseInt(examId) });
    res.json({ status: 'success', message: 'Questions generated', data: result.recordset });
  } catch (error) {
    console.error('Generate exam questions error:', error);
    res.status(500).json({ status: 'error', message: 'Internal server error' });
  }
};

const getStudentExamResult = async (req, res) => {
  try {
    const ssn = req.user.ssn;
    const { examId } = req.params;
    
    // Get student ID from SSN
    const studentResult = await getPool().request()
      .input('SSN', ssn)
      .query('SELECT Student_ID FROM Student WHERE SSN = @SSN');
    
    if (studentResult.recordset.length === 0) {
      return res.status(404).json({ status: 'error', message: 'Student not found' });
    }
    
    const studentId = studentResult.recordset[0].Student_ID;
    
    // Get student's exam result
    const result = await getPool().request()
      .input('Student_ID', studentId)
      .input('Exam_ID', parseInt(examId))
      .query(`
        SELECT 
          se.Student_ID,
          se.Exam_ID,
          se.IS_Pass,
          se.Exam_Grade,
          e.Exam_Name,
          e.Exam_Total_Marks
        FROM Student_Exam se
        INNER JOIN Exam e ON se.Exam_ID = e.Exam_ID
        WHERE se.Student_ID = @Student_ID AND se.Exam_ID = @Exam_ID
      `);
    
    if (result.recordset.length === 0) {
      return res.status(404).json({ status: 'error', message: 'Result not found' });
    }
    
    res.status(200).json({ 
      status: 'success', 
      data: result.recordset[0] 
    });
  } catch (error) {
    console.error('Get student exam result error:', error);
    res.status(500).json({ status: 'error', message: 'Internal server error' });
  }
};

const getExamQuestionsForView = async (req, res) => {
  try {
    const { examId } = req.params;
    const ssn = req.user.ssn;
    
    // Verify instructor has access to this exam
    const instructorResult = await getPool().request()
      .input('SSN', ssn)
      .query('SELECT Instructor_ID FROM Instructor WHERE SSN = @SSN');
    const instructorId = instructorResult.recordset[0]?.Instructor_ID;
    
    if (!instructorId) {
      return res.status(403).json({ status: 'error', message: 'Instructor not found for this user.' });
    }

    // Get exam details
    const examResult = await getPool().request()
      .input('Exam_ID', examId)
      .query(`
        SELECT 
          Exam_ID as id,
          Exam_Name as name,
          Exam_Total_Marks as total_marks,
          Exam_Start_date as start_date,
          Exam_End_date as end_date,
          Branch_ID as branch_id
        FROM Exam
        WHERE Exam_ID = @Exam_ID
      `);

    if (examResult.recordset.length === 0) {
      return res.status(404).json({ status: 'error', message: 'Exam not found' });
    }

    const exam = examResult.recordset[0];

    // Get questions for this exam
    const questionsResult = await getPool().request()
      .input('Exam_ID', examId)
      .query(`
        SELECT 
          q.Question_ID as id,
          q.Question_Text as question_text,
          q.type as question_type,
          q.Question_Mark as marks,
          q.Level as level,
          c.right_choice as correct_answer
        FROM Question q
        INNER JOIN Exam_Question eq ON q.Question_ID = eq.Question_ID
        LEFT JOIN Choices c ON q.Question_ID = c.Question_ID
        WHERE eq.Exam_ID = @Exam_ID
        ORDER BY q.Question_ID
      `);

    const questions = questionsResult.recordset;

    // For MCQ questions, get all choices
    for (let question of questions) {
      if (question.question_type === 'MCQ') {
        const choicesResult = await getPool().request()
          .input('Question_ID', question.id)
          .query(`
            SELECT Choice_Text as choice_text
            FROM Choice_Text ct
            INNER JOIN Choices c ON ct.Choices_ID = c.Choices_ID
            WHERE c.Question_ID = @Question_ID
            ORDER BY ct.Choice_Text
          `);
        question.choices = choicesResult.recordset.map(c => c.choice_text);
      }
    }

    console.log('Questions for view:', questions);

    res.status(200).json({
      status: 'success',
      data: {
        exam: exam,
        questions: questions
      }
    });

  } catch (error) {
    console.error('Get exam questions for view error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

module.exports = {
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
};