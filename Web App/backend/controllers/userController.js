const { executeStoredProcedure, getPool } = require('../utils/db');

const getProfile = async (req, res) => {
  try {
    const username = req.user.username;

    const result = await executeStoredProcedure('GetUserProfile', {
      username
    });

    if (result.recordset.length === 0) {
      return res.status(404).json({
        status: 'error',
        message: 'User not found'
      });
    }

    const user = result.recordset[0];

    res.status(200).json({
      status: 'success',
      data: {
        user: {
          id: user.userId,
          username: user.Username,
          email: user.Email,
          role: user.Role
        }
      }
    });

  } catch (error) {
    console.error('Get profile error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const updateProfile = async (req, res) => {
  try {
    const userId = req.user.userId;
    const { fullName, email } = req.body;

    // Validate required fields
    if (!fullName || !email) {
      return res.status(400).json({
        status: 'error',
        message: 'Full name and email are required'
      });
    }

    const result = await executeStoredProcedure('UpdateUserProfile', {
      userId,
      fullName,
      email
    });

    if (result.recordset[0].Success === 0) {
      return res.status(400).json({
        status: 'error',
        message: result.recordset[0].Message || 'Update failed'
      });
    }

    res.status(200).json({
      status: 'success',
      message: 'Profile updated successfully',
      data: {
        user: {
          id: userId,
          fullName,
          email
        }
      }
    });

  } catch (error) {
    console.error('Update profile error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const changePassword = async (req, res) => {
  try {
    const userId = req.user.userId;
    const { currentPassword, newPassword } = req.body;

    // Validate required fields
    if (!currentPassword || !newPassword) {
      return res.status(400).json({
        status: 'error',
        message: 'Current password and new password are required'
      });
    }

    const result = await executeStoredProcedure('ChangePassword', {
      userId,
      currentPassword,
      newPassword
    });

    if (result.recordset[0].Success === 0) {
      return res.status(400).json({
        status: 'error',
        message: result.recordset[0].Message || 'Password change failed'
      });
    }

    res.status(200).json({
      status: 'success',
      message: 'Password changed successfully'
    });

  } catch (error) {
    console.error('Change password error:', error);
    res.status(500).json({
      status: 'error',
      message: 'Internal server error'
    });
  }
};

const getUserStats = async (req, res) => {
  // Dummy data for dashboard
  res.json({
    status: 'success',
    data: {
      totalExams: 5,
      completedExams: 3,
      pendingExams: 2,
      averageScore: 85
    }
  });
};

// Dashboard stats for instructor and student
const getDashboardStats = async (req, res) => {
  try {
    console.log('getDashboardStats called with user:', req.user);
    const { role, ssn } = req.user;
    let stats = {};
    
    if (role === 'instructor') {
      console.log('Processing instructor stats for SSN:', ssn);
      
      // Get instructor ID from SSN
      const instructorResult = await getPool().request()
        .input('SSN', ssn)
        .query('SELECT Instructor_ID FROM Instructor WHERE SSN = @SSN');
      
      console.log('Instructor query result:', instructorResult.recordset);
      
      if (instructorResult.recordset.length === 0) {
        console.log('Instructor not found for SSN:', ssn);
        return res.status(404).json({ success: false, message: 'Instructor not found' });
      }
      
      const instructorId = instructorResult.recordset[0].Instructor_ID;
      console.log('Found instructor ID:', instructorId);
      
      // Get instructor stats
      const examsResult = await executeStoredProcedure('GetInstructorExamsStats', { 
        Instructor_ID: instructorId 
      });
      
      console.log('Instructor stats result:', examsResult.recordset);
      
      stats.total_exams = examsResult.recordset[0]?.total_exams || 0;
      stats.active_exams = examsResult.recordset[0]?.active_exams || 0;
      stats.total_students = examsResult.recordset[0]?.total_students || 0;
      
    } else {
      console.log('Processing student stats for SSN:', ssn);
      
      // Get student ID from SSN
      const studentResult = await getPool().request()
        .input('SSN', ssn)
        .query('SELECT Student_ID FROM Student WHERE SSN = @SSN');
      
      console.log('Student query result:', studentResult.recordset);
      
      if (studentResult.recordset.length === 0) {
        console.log('Student not found for SSN:', ssn);
        return res.status(404).json({ success: false, message: 'Student not found' });
      }
      
      const studentId = studentResult.recordset[0].Student_ID;
      console.log('Found student ID:', studentId);
      
      // Get student stats
      const statsResult = await executeStoredProcedure('GetStudentDashboardStats', { 
        Student_ID: studentId 
      });
      
      console.log('Student stats result:', statsResult.recordset);
      
      stats.total_exams_taken = statsResult.recordset[0]?.total_exams_taken || 0;
      stats.average_score = statsResult.recordset[0]?.average_score || 0.0;
      stats.available_exams = statsResult.recordset[0]?.available_exams || 0;
    }
    
    console.log('Final stats object:', stats);
    res.status(200).json({ success: true, stats });
  } catch (error) {
    console.error('Dashboard stats error:', error);
    console.error('Error stack:', error.stack);
    res.status(500).json({ success: false, message: 'Failed to load dashboard stats: ' + error.message });
  }
};

module.exports = {
  getProfile,
  updateProfile,
  changePassword,
  getUserStats,
  getDashboardStats
};