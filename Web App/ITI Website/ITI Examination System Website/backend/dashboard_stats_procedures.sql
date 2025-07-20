-- =============================================
-- Dashboard Statistics Stored Procedures
-- =============================================

USE ITI_Examination_System;
GO

-- =============================================
-- GetStudentDashboardStats - Get student dashboard statistics
-- =============================================
CREATE OR ALTER PROCEDURE GetStudentDashboardStats
    @Student_ID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @TotalExamsTaken INT = 0;
    DECLARE @AverageScore DECIMAL(5,2) = 0.0;
    DECLARE @AvailableExams INT = 0;
    
    PRINT 'GetStudentDashboardStats called for Student_ID: ' + CAST(@Student_ID AS VARCHAR);
    
    -- Get total exams taken by student
    SELECT @TotalExamsTaken = COUNT(*)
    FROM Student_Exam
    WHERE Student_ID = @Student_ID;
    
    PRINT 'Total exams taken: ' + CAST(@TotalExamsTaken AS VARCHAR);
    
    -- Get average score
    SELECT @AverageScore = AVG(CAST(se.Exam_Grade AS FLOAT) / CAST(e.Exam_Total_Marks AS FLOAT) * 100)
    FROM Student_Exam se
    INNER JOIN Exam e ON se.Exam_ID = e.Exam_ID
    WHERE se.Student_ID = @Student_ID 
      AND se.Exam_Grade IS NOT NULL 
      AND e.Exam_Total_Marks > 0;
    
    PRINT 'Average score: ' + CAST(@AverageScore AS VARCHAR);
    
    -- Get available exams (exams not taken by student)
    SELECT @AvailableExams = COUNT(*)
    FROM Exam e
    INNER JOIN Student s ON s.Student_ID = @Student_ID
    WHERE e.Branch_ID = s.Branch_ID 
      AND e.Track_ID = s.Track_ID
      AND e.Exam_ID NOT IN (
        SELECT Exam_ID 
        FROM Student_Exam 
        WHERE Student_ID = @Student_ID
      );
    
    PRINT 'Available exams: ' + CAST(@AvailableExams AS VARCHAR);
    
    SELECT 
        @TotalExamsTaken AS total_exams_taken,
        ISNULL(@AverageScore, 0.0) AS average_score,
        @AvailableExams AS available_exams;
END
GO

-- =============================================
-- GetInstructorExamsStats - Get instructor dashboard statistics
-- =============================================
CREATE OR ALTER PROCEDURE GetInstructorExamsStats
    @Instructor_ID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @TotalExams INT = 0;
    DECLARE @ActiveExams INT = 0;
    DECLARE @TotalStudents INT = 0;
    
    PRINT 'GetInstructorExamsStats called for Instructor_ID: ' + CAST(@Instructor_ID AS VARCHAR);
    
    -- Get total exams created by instructor
    SELECT @TotalExams = COUNT(*)
    FROM Exam
    WHERE Course_ID IN (
        SELECT Course_ID 
        FROM Instructor_Course 
        WHERE Instructor_ID = @Instructor_ID
    );
    
    PRINT 'Total exams: ' + CAST(@TotalExams AS VARCHAR);
    
    -- Get active exams (exams within date range)
    SELECT @ActiveExams = COUNT(*)
    FROM Exam
    WHERE Course_ID IN (
        SELECT Course_ID 
        FROM Instructor_Course 
        WHERE Instructor_ID = @Instructor_ID
    )
    AND Exam_Start_date <= GETDATE() 
    AND Exam_End_date >= GETDATE();
    
    PRINT 'Active exams: ' + CAST(@ActiveExams AS VARCHAR);
    
    -- Get total students who have taken exams (students who have actually participated in exams)
    SELECT @TotalStudents = COUNT(DISTINCT se.Student_ID)
    FROM Student_Exam se
    INNER JOIN Exam e ON se.Exam_ID = e.Exam_ID
    INNER JOIN Instructor_Course ic ON e.Course_ID = ic.Course_ID
    WHERE ic.Instructor_ID = @Instructor_ID;
    
    PRINT 'Total students who took exams: ' + CAST(@TotalStudents AS VARCHAR);
    
    SELECT 
        @TotalExams AS total_exams,
        @ActiveExams AS active_exams,
        @TotalStudents AS total_students;
END
GO

PRINT 'Dashboard statistics stored procedures created successfully!';
GO 