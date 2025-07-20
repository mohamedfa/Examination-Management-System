-- Update GetInstructorExamsStats to count only students who took exams
USE ITI_Examination_System;
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

PRINT 'GetInstructorExamsStats procedure updated successfully!';
GO 