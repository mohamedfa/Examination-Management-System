-- Missing Stored Procedures for ITI Examination System Backend API
-- These procedures are required by the Node.js backend

USE ITI_Examination_Sys;
GO


-- =============================================
-- AuthenticateUser - Return user data including hash for backend check
-- =============================================
CREATE OR ALTER PROCEDURE AuthenticateUser
    @username NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT SSN, Username, Email, Role, Password AS StoredHash
    FROM Users
    WHERE Username = @username;
END
GO

-- =============================================
-- GetUserProfile - Get user profile
-- =============================================
CREATE OR ALTER PROCEDURE GetUserProfile
    @userId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        UserId,
        Username,
        Email,
        Role,
        FullName,
        CreatedAt
    FROM Users 
    WHERE UserId = @userId;
END
GO

-- =============================================
-- UpdateUserProfile - Update user profile
-- =============================================
CREATE OR ALTER PROCEDURE UpdateUserProfile
    @userId INT,
    @fullName NVARCHAR(100),
    @email NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Success BIT = 0;
    DECLARE @Message NVARCHAR(255) = '';
    
    BEGIN TRY
        UPDATE Users 
        SET FullName = @fullName, Email = @email
        WHERE UserId = @userId;
        
        IF @@ROWCOUNT > 0
        BEGIN
            SET @Success = 1;
            SET @Message = 'Profile updated successfully';
        END
        ELSE
        BEGIN
            SET @Success = 0;
            SET @Message = 'User not found';
        END
    END TRY
    BEGIN CATCH
        SET @Success = 0;
        SET @Message = ERROR_MESSAGE();
    END CATCH
    
    SELECT @Success AS Success, @Message AS Message;
END
GO

-- =============================================
-- ChangePassword - Change user password
-- =============================================
CREATE OR ALTER PROCEDURE ChangePassword
    @userId INT,
    @currentPassword NVARCHAR(255),
    @newPassword NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Success BIT = 0;
    DECLARE @Message NVARCHAR(255) = '';
    
    BEGIN TRY
        -- Check if current password is correct
        IF EXISTS (SELECT 1 FROM Users WHERE UserId = @userId AND Password = @currentPassword)
        BEGIN
            UPDATE Users 
            SET Password = @newPassword
            WHERE UserId = @userId;
            
            SET @Success = 1;
            SET @Message = 'Password changed successfully';
        END
        ELSE
        BEGIN
            SET @Success = 0;
            SET @Message = 'Current password is incorrect';
        END
    END TRY
    BEGIN CATCH
        SET @Success = 0;
        SET @Message = ERROR_MESSAGE();
    END CATCH
    
    SELECT @Success AS Success, @Message AS Message;
END
GO

-- =============================================
-- CreateExam - Create a new exam
-- =============================================
CREATE OR ALTER PROCEDURE CreateExam
    @instructorId INT,
    @title NVARCHAR(200),
    @description NVARCHAR(500),
    @duration INT,
    @totalMarks INT,
    @isActive BIT = 1
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Success BIT = 0;
    DECLARE @Message NVARCHAR(255) = '';
    DECLARE @ExamId INT = 0;
    
    BEGIN TRY
        INSERT INTO Exams (Title, Description, Duration, TotalMarks, IsActive, CreatedBy, CreatedAt)
        VALUES (@title, @description, @duration, @totalMarks, @isActive, @instructorId, GETDATE());
        
        SET @ExamId = SCOPE_IDENTITY();
        SET @Success = 1;
        SET @Message = 'Exam created successfully';
    END TRY
    BEGIN CATCH
        SET @Success = 0;
        SET @Message = ERROR_MESSAGE();
    END CATCH
    
    SELECT @Success AS Success, @Message AS Message, @ExamId AS ExamId;
END
GO

-- =============================================
-- GetAllExams - Get all exams
-- =============================================
CREATE OR ALTER PROCEDURE GetAllExams
    @userId INT,
    @role NVARCHAR(20),
    @page INT = 1,
    @limit INT = 10,
    @search NVARCHAR(100) = ''
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @offset INT = (@page - 1) * @limit;
    
    SELECT 
        ExamId,
        Title,
        Description,
        Duration,
        TotalMarks,
        IsActive,
        CreatedAt
    FROM Exams
    WHERE (@search = '' OR Title LIKE '%' + @search + '%' OR Description LIKE '%' + @search + '%')
    ORDER BY CreatedAt DESC
    OFFSET @offset ROWS
    FETCH NEXT @limit ROWS ONLY;
END
GO

-- =============================================
-- GetExamById - Get exam by ID
-- =============================================
CREATE OR ALTER PROCEDURE GetExamById
    @examId INT,
    @userId INT,
    @role NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        ExamId,
        Title,
        Description,
        Duration,
        TotalMarks,
        IsActive,
        CreatedAt
    FROM Exams
    WHERE ExamId = @examId;
END
GO

-- =============================================
-- AddQuestion - Add question to exam
-- =============================================
CREATE OR ALTER PROCEDURE AddQuestion
    @examId INT,
    @instructorId INT,
    @questionText NVARCHAR(500),
    @questionType NVARCHAR(20),
    @options NVARCHAR(MAX) = NULL,
    @correctAnswer NVARCHAR(500) = NULL,
    @marks INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Success BIT = 0;
    DECLARE @Message NVARCHAR(255) = '';
    DECLARE @QuestionId INT = 0;
    
    BEGIN TRY
        INSERT INTO Questions (ExamId, QuestionText, QuestionType, Options, CorrectAnswer, Marks, CreatedAt)
        VALUES (@examId, @questionText, @questionType, @options, @correctAnswer, @marks, GETDATE());
        
        SET @QuestionId = SCOPE_IDENTITY();
        SET @Success = 1;
        SET @Message = 'Question added successfully';
    END TRY
    BEGIN CATCH
        SET @Success = 0;
        SET @Message = ERROR_MESSAGE();
    END CATCH
    
    SELECT @Success AS Success, @Message AS Message, @QuestionId AS QuestionId;
END
GO

-- =============================================
-- GetExamQuestions - Get questions for an exam
-- =============================================
CREATE OR ALTER PROCEDURE GetExamQuestions
    @examId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        q.Question_ID as id,
        q.Question_Text as question_text,
        q.type as question_type,
        q.Question_Mark as marks,
        q.level,
        c.right_choice as correct_answer,
        -- For MCQ questions, get choices using FOR XML PATH (works in older SQL Server versions)
        CASE 
            WHEN q.type = 'MCQ' THEN (
                SELECT ct.Choice_Text + '|'
                FROM Choice_Text ct
                INNER JOIN Choices c2 ON ct.Choices_ID = c2.Choices_ID
                WHERE c2.Question_ID = q.Question_ID
                FOR XML PATH('')
            )
            ELSE NULL
        END as choices
    FROM Question q
    INNER JOIN Exam_Question eq ON q.Question_ID = eq.Question_ID
    LEFT JOIN Choices c ON q.Question_ID = c.Question_ID
    WHERE eq.Exam_ID = @examId
    ORDER BY q.Question_ID;
END
GO

-- =============================================
-- StartExam - Start exam session
-- =============================================
CREATE OR ALTER PROCEDURE StartExam
    @examId INT,
    @studentId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Success BIT = 0;
    DECLARE @Message NVARCHAR(255) = '';
    DECLARE @Student_Exam_ID INT = 0;
    
    BEGIN TRY
        -- Check if exam exists and is within the time window
        IF EXISTS (SELECT 1 FROM Exam WHERE Exam_ID = @examId 
                   AND Exam_Start_date <= GETDATE() 
                   AND Exam_End_date >= GETDATE())
        BEGIN
            -- Check if student already has a record for this exam
            IF NOT EXISTS (SELECT 1 FROM Student_Exam WHERE Exam_ID = @examId AND Student_ID = @studentId)
            BEGIN
                -- Insert student exam record with default values
                INSERT INTO Student_Exam (Student_ID, Exam_ID, IS_Pass, Exam_Grade)
                VALUES (@studentId, @examId, 'Not Set', 0);
                
                SET @Student_Exam_ID = @studentId; -- Use student ID as identifier
                SET @Success = 1;
                SET @Message = 'Exam started successfully';
            END
            ELSE
            BEGIN
                SET @Success = 0;
                SET @Message = 'Exam already started';
            END
        END
        ELSE
        BEGIN
            SET @Success = 0;
            SET @Message = 'Exam not found or not available at this time';
        END
    END TRY
    BEGIN CATCH
        SET @Success = 0;
        SET @Message = ERROR_MESSAGE();
    END CATCH
    
    SELECT @Success AS Success, @Message AS Message, @Student_Exam_ID AS Student_Exam_ID;
END
GO

-- =============================================
-- SubmitExam - Submit exam answers
-- =============================================
CREATE OR ALTER PROCEDURE SubmitExam
    @examId INT,
    @studentId INT,
    @answers NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Success BIT = 0;
    DECLARE @Message NVARCHAR(255) = '';
    DECLARE @ResultId INT = 0;
    
    BEGIN TRY
        -- Update exam session
        UPDATE ExamSessions 
        SET EndTime = GETDATE(), Status = 'completed'
        WHERE ExamId = @examId AND StudentId = @studentId;
        
        -- Insert exam result
        INSERT INTO ExamResults (ExamId, StudentId, Answers, SubmittedAt)
        VALUES (@examId, @studentId, @answers, GETDATE());
        
        SET @ResultId = SCOPE_IDENTITY();
        SET @Success = 1;
        SET @Message = 'Exam submitted successfully';
    END TRY
    BEGIN CATCH
        SET @Success = 0;
        SET @Message = ERROR_MESSAGE();
    END CATCH
    
    SELECT @Success AS Success, @Message AS Message, @ResultId AS ResultId;
END
GO

-- =============================================
-- GetUserResults - Get user's exam results
-- =============================================
CREATE OR ALTER PROCEDURE GetUserResults
    @userId INT,
    @page INT = 1,
    @limit INT = 10
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @offset INT = (@page - 1) * @limit;
    
    SELECT 
        er.ResultId,
        er.ExamId,
        e.Title AS ExamTitle,
        er.SubmittedAt,
        er.Score,
        e.TotalMarks
    FROM ExamResults er
    JOIN Exams e ON er.ExamId = e.ExamId
    WHERE er.StudentId = @userId
    ORDER BY er.SubmittedAt DESC
    OFFSET @offset ROWS
    FETCH NEXT @limit ROWS ONLY;
END
GO

-- =============================================
-- GetExamResults - Get all results for an exam (instructor only)
-- =============================================
CREATE OR ALTER PROCEDURE GetExamResults
    @examId INT,
    @instructorId INT,
    @page INT = 1,
    @limit INT = 10
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @offset INT = (@page - 1) * @limit;
    
    SELECT 
        er.ResultId,
        er.StudentId,
        u.Username,
        u.FullName,
        er.SubmittedAt,
        er.Score,
        e.TotalMarks
    FROM ExamResults er
    JOIN Users u ON er.StudentId = u.UserId
    JOIN Exams e ON er.ExamId = e.ExamId
    WHERE er.ExamId = @examId AND e.CreatedBy = @instructorId
    ORDER BY er.SubmittedAt DESC
    OFFSET @offset ROWS
    FETCH NEXT @limit ROWS ONLY;
END
GO

-- =============================================
-- ExamAnswer - Save student answer and calculate points
-- =============================================
CREATE OR ALTER PROCEDURE ExamAnswer
    @Exam_ID INT,
    @Student_ID INT,
    @Question_ID INT,
    @Student_Answer NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ChoicePoint INT = 0;
    DECLARE @QuestionMark INT;
    DECLARE @NextID INT;
    DECLARE @CorrectAnswer NVARCHAR(100);
    
    PRINT 'ExamAnswer called with: Exam_ID=' + CAST(@Exam_ID AS VARCHAR) + ', Student_ID=' + CAST(@Student_ID AS VARCHAR) + ', Question_ID=' + CAST(@Question_ID AS VARCHAR) + ', Student_Answer=' + @Student_Answer;
    
    -- Get the question mark
    SELECT @QuestionMark = Question_Mark FROM Question WHERE Question_ID = @Question_ID;
    PRINT 'Question mark: ' + CAST(@QuestionMark AS VARCHAR);
    
    -- Check if answer is correct
    SELECT @CorrectAnswer = c.right_choice
    FROM Question q 
    INNER JOIN Choices c ON q.Question_ID = c.Question_ID
    WHERE q.Question_ID = @Question_ID;
    
    PRINT 'Correct answer: ' + ISNULL(@CorrectAnswer, 'NULL');
    PRINT 'Student answer: ' + @Student_Answer;
    
    IF @Student_Answer = @CorrectAnswer
    BEGIN
        SET @ChoicePoint = @QuestionMark;
        PRINT 'Answer is CORRECT - Awarding ' + CAST(@ChoicePoint AS VARCHAR) + ' points';
    END
    ELSE
    BEGIN
        PRINT 'Answer is INCORRECT - Awarding 0 points';
    END
    
    -- Insert or update student answer
    IF EXISTS (
        SELECT 1 FROM Student_Exam_Question 
        WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID AND Question_ID = @Question_ID
    )
    BEGIN
        UPDATE Student_Exam_Question 
        SET ST_answer = @Student_Answer, Point_Awarded = @ChoicePoint
        WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID AND Question_ID = @Question_ID;
        PRINT 'Updated existing answer record';
    END
    ELSE
    BEGIN
        -- Get the next available ID
        SELECT @NextID = ISNULL(MAX(Student_Exam_Question_ID), 0) + 1 FROM Student_Exam_Question;
        
        INSERT INTO Student_Exam_Question (Student_Exam_Question_ID, Student_ID, Exam_ID, Question_ID, ST_answer, Point_Awarded)
        VALUES (@NextID, @Student_ID, @Exam_ID, @Question_ID, @Student_Answer, @ChoicePoint);
        PRINT 'Inserted new answer record with ID: ' + CAST(@NextID AS VARCHAR);
    END
END
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

-- =============================================
-- GenerateExam - Generate exam with questions
-- =============================================
CREATE OR ALTER PROCEDURE GenerateExam
  @ExamName VARCHAR(50),
  @Course VARCHAR(30),
  @NumOfMCQ INT,
  @NumOfTF INT,
  @StartDate DATETIME,
  @EndDate DATETIME,
  @Branch_ID INT = NULL,
  @Course_ID INT = NULL,
  @Track_ID INT = NULL
AS
BEGIN
  DECLARE @NewExamID INT;
  DECLARE @TotalMarks INT;

  -- Get the next Exam_ID
  SET @NewExamID = (SELECT ISNULL(MAX(Exam_ID), 0) + 1 FROM Exam);

  WITH first_CTE AS (
    SELECT TOP(@NumOfMCQ) q.Question_ID, q.Question_Mark
    FROM Question q INNER JOIN Course c ON q.Course_ID = c.Course_ID
    WHERE c.Course_Name = @Course AND (q.type = 'MCQ' OR q.type = 'multiple_choice' OR q.type = 'mcq')
    ORDER BY NEWID()
    UNION ALL
    SELECT TOP(@NumOfTF) q.Question_ID, q.Question_Mark
    FROM Question q INNER JOIN Course c ON q.Course_ID = c.Course_ID
    WHERE c.Course_Name = @Course AND (q.type = 'True/False' OR q.type = 'true_false' OR q.type = 'tf')
    ORDER BY NEWID()
  )
  SELECT * INTO #TempQuestions FROM first_CTE;

  -- Calculate total marks
  SET @TotalMarks = (SELECT ISNULL(SUM(CAST(Question_Mark AS INT)), 0) FROM #TempQuestions);

  PRINT 'Generated exam with ' + CAST(@NumOfMCQ AS VARCHAR) + ' MCQ and ' + CAST(@NumOfTF AS VARCHAR) + ' TF questions';
  PRINT 'Total marks calculated: ' + CAST(@TotalMarks AS VARCHAR);

  -- Insert the exam with proper Exam_ID
  INSERT INTO Exam (Exam_ID, Exam_Name, Exam_Total_Marks, Exam_Start_date, Exam_End_date, Branch_ID, Course_ID, Track_ID)
  VALUES (@NewExamID, @ExamName, @TotalMarks, @StartDate, @EndDate, @Branch_ID, @Course_ID, @Track_ID);

  -- Insert exam-question relationships
  INSERT INTO Exam_Question (Exam_ID, Question_ID)
  SELECT @NewExamID, Question_ID FROM #TempQuestions;

  DROP TABLE #TempQuestions;
  
  SELECT 'Exam Generated Successfully' AS Result, @NewExamID AS Exam_ID;
END
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
    
    -- Get total students (students in courses taught by instructor)
    SELECT @TotalStudents = COUNT(DISTINCT s.Student_ID)
    FROM Student s
    INNER JOIN Course_Track ct ON s.Track_ID = ct.Track_ID
    INNER JOIN Instructor_Course ic ON ct.Course_ID = ic.Course_ID
    WHERE ic.Instructor_ID = @Instructor_ID;
    
    PRINT 'Total students: ' + CAST(@TotalStudents AS VARCHAR);
    
    SELECT 
        @TotalExams AS total_exams,
        @ActiveExams AS active_exams,
        @TotalStudents AS total_students;
END
GO

PRINT 'All missing stored procedures created successfully!';
GO