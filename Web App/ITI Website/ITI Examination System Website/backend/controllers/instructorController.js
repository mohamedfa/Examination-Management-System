const { getPool } = require('../utils/db');

// Get all branches where the instructor teaches or supervises
const getInstructorBranches = async (req, res) => {
  try {
    const ssn = req.user.ssn;
    // Find Instructor_ID from SSN
    const instructorResult = await getPool().request()
      .input('SSN', ssn)
      .query('SELECT Instructor_ID FROM Instructor WHERE SSN = @SSN');
    const instructorId = instructorResult.recordset[0]?.Instructor_ID;
    if (!instructorId) {
      return res.status(403).json({ success: false, message: 'Instructor not found.' });
    }
    // Branches where instructor teaches a course or supervises a track
    const result = await getPool().request()
      .input('Instructor_ID', instructorId)
      .query(`
        SELECT DISTINCT b.Branch_ID, b.Branch_Name
        FROM Branch b
        JOIN Track t ON t.Instructor_ID = @Instructor_ID
        JOIN Program p ON t.Program_ID = p.Program_ID
        JOIN Branch_Program bp ON bp.Program_ID = p.Program_ID AND bp.Branch_ID = b.Branch_ID
        UNION
        SELECT DISTINCT b.Branch_ID, b.Branch_Name
        FROM Branch b
        JOIN Instructor_Course ic ON ic.Instructor_ID = @Instructor_ID
        JOIN Course c ON ic.Course_ID = c.Course_ID
        JOIN Track tr ON tr.Instructor_ID = @Instructor_ID
        JOIN Program p ON tr.Program_ID = p.Program_ID
        JOIN Branch_Program bp ON bp.Program_ID = p.Program_ID AND bp.Branch_ID = b.Branch_ID
      `);
    res.json({ success: true, branches: result.recordset });
  } catch (error) {
    console.error('getInstructorBranches error:', error);
    res.status(500).json({ success: false, message: 'Failed to fetch branches.' });
  }
};

// Get all tracks for the instructor in a branch
const getInstructorTracks = async (req, res) => {
  try {
    const ssn = req.user.ssn;
    const branchId = req.query.branchId;
    const instructorResult = await getPool().request()
      .input('SSN', ssn)
      .query('SELECT Instructor_ID FROM Instructor WHERE SSN = @SSN');
    const instructorId = instructorResult.recordset[0]?.Instructor_ID;
    if (!instructorId) {
      return res.status(403).json({ success: false, message: 'Instructor not found.' });
    }
    const result = await getPool().request()
      .input('Instructor_ID', instructorId)
      .input('Branch_ID', branchId)
      .query(`
        SELECT DISTINCT t.Track_ID, t.Track_Name
        FROM Track t
        JOIN Program p ON t.Program_ID = p.Program_ID
        JOIN Branch_Program bp ON bp.Program_ID = p.Program_ID AND bp.Branch_ID = @Branch_ID
        WHERE t.Instructor_ID = @Instructor_ID
      `);
    res.json({ success: true, tracks: result.recordset });
  } catch (error) {
    console.error('getInstructorTracks error:', error);
    res.status(500).json({ success: false, message: 'Failed to fetch tracks.' });
  }
};

// Get all courses for the instructor in a track
const getInstructorCourses = async (req, res) => {
  try {
    const ssn = req.user.ssn;
    const trackId = req.query.trackId;
    const instructorResult = await getPool().request()
      .input('SSN', ssn)
      .query('SELECT Instructor_ID FROM Instructor WHERE SSN = @SSN');
    const instructorId = instructorResult.recordset[0]?.Instructor_ID;
    if (!instructorId) {
      return res.status(403).json({ success: false, message: 'Instructor not found.' });
    }
    const result = await getPool().request()
      .input('Instructor_ID', instructorId)
      .input('Track_ID', trackId)
      .query(`
        SELECT DISTINCT c.Course_ID, c.Course_Name
        FROM Course c
        JOIN Instructor_Course ic ON ic.Course_ID = c.Course_ID
        WHERE ic.Instructor_ID = @Instructor_ID
      `);
    res.json({ success: true, courses: result.recordset });
  } catch (error) {
    console.error('getInstructorCourses error:', error);
    res.status(500).json({ success: false, message: 'Failed to fetch courses.' });
  }
};

module.exports = {
  getInstructorBranches,
  getInstructorTracks,
  getInstructorCourses
}; 