-- Update ExamCorrection to handle exams with no answers
USE ITI_Examination_System;
GO

-- =============================================
-- ExamCorrection - Calculate total grade and update pass/fail status
-- =============================================
CREATE OR ALTER PROCEDURE ExamCorrection
    @Student_ID INT,
    @Exam_ID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @TotalGrade INT = 0;
    DECLARE @TotalMarks INT = 0;
    DECLARE @ISPass NVARCHAR(10) = 'Not Set';
    DECLARE @RowsAffected INT = 0;
    
    PRINT 'Starting ExamCorrection for Student_ID: ' + CAST(@Student_ID AS VARCHAR) + ', Exam_ID: ' + CAST(@Exam_ID AS VARCHAR);
    
    -- Check if student has answered questions
    IF NOT EXISTS (
        SELECT 1 FROM Student_Exam_Question
        WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID
    )
    BEGIN
        PRINT 'No answers found for student - creating exam status with 0 grade';
        
        -- Get total exam marks from the Exam table
        SELECT @TotalMarks = Exam_Total_Marks
        FROM Exam
        WHERE Exam_ID = @Exam_ID;
        
        PRINT 'Total exam marks: ' + CAST(@TotalMarks AS VARCHAR);
        
        -- Set grade to 0 and status to Fail for unanswered exam
        SET @TotalGrade = 0;
        SET @ISPass = 'Fail';
        
        -- Update or create the Student_Exam record
        IF EXISTS (SELECT 1 FROM Student_Exam WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID)
        BEGIN
            UPDATE Student_Exam
            SET IS_Pass = @ISPass, Exam_Grade = @TotalGrade
            WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID;
        END
        ELSE
        BEGIN
            INSERT INTO Student_Exam (Student_ID, Exam_ID, IS_Pass, Exam_Grade)
            VALUES (@Student_ID, @Exam_ID, @ISPass, @TotalGrade);
        END
        
        SELECT 1 AS Success, 'Exam status created with 0 grade (no answers provided)' AS Message, @TotalGrade AS TotalGrade, @ISPass AS Status;
        RETURN;
    END
    
    -- Calculate total grade from answered questions
    SELECT @TotalGrade = ISNULL(SUM(Point_Awarded), 0)
    FROM Student_Exam_Question
    WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID;
    
    PRINT 'Total grade calculated: ' + CAST(@TotalGrade AS VARCHAR);
    
    -- Get total exam marks from the Exam table
    SELECT @TotalMarks = Exam_Total_Marks
    FROM Exam
    WHERE Exam_ID = @Exam_ID;
    
    PRINT 'Total exam marks from Exam table: ' + CAST(@TotalMarks AS VARCHAR);
    
    -- If total marks is 0 or NULL, calculate it from the questions
    IF @TotalMarks IS NULL OR @TotalMarks = 0
    BEGIN
        SELECT @TotalMarks = ISNULL(SUM(q.Question_Mark), 0)
        FROM Question q
        INNER JOIN Exam_Question eq ON q.Question_ID = eq.Question_ID
        WHERE eq.Exam_ID = @Exam_ID;
        
        PRINT 'Recalculated total marks from questions: ' + CAST(@TotalMarks AS VARCHAR);
        
        -- Update the exam with the correct total marks
        UPDATE Exam 
        SET Exam_Total_Marks = @TotalMarks 
        WHERE Exam_ID = @Exam_ID;
    END
    
    -- Determine pass/fail (60% threshold)
    IF @TotalMarks > 0 AND (@TotalGrade * 100.0 / @TotalMarks) >= 60
        SET @ISPass = 'Pass';
    ELSE
        SET @ISPass = 'Fail';
    
    PRINT 'Pass/Fail status: ' + @ISPass;
    
    -- Update the Student_Exam record
    UPDATE Student_Exam
    SET IS_Pass = @ISPass, Exam_Grade = @TotalGrade
    WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID;
    
    SET @RowsAffected = @@ROWCOUNT;
    PRINT 'Rows affected by update: ' + CAST(@RowsAffected AS VARCHAR);
    
    -- Check if update was successful
    IF @RowsAffected = 0
    BEGIN
        PRINT 'No rows updated - checking if record exists';
        IF NOT EXISTS (SELECT 1 FROM Student_Exam WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID)
        BEGIN
            PRINT 'Student_Exam record does not exist - creating it';
            INSERT INTO Student_Exam (Student_ID, Exam_ID, IS_Pass, Exam_Grade)
            VALUES (@Student_ID, @Exam_ID, @ISPass, @TotalGrade);
        END
    END
    
    SELECT 1 AS Success, 'Exam corrected successfully' AS Message, @TotalGrade AS TotalGrade, @ISPass AS Status;
END
GO

PRINT 'ExamCorrection procedure updated successfully!';
GO 