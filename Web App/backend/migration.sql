-- Updated migration script to simplify Users table, handle unique usernames, and include Role

USE ITI_Examination_Sys;
GO

-- Drop existing Users table if exists
IF OBJECT_ID('Users', 'U') IS NOT NULL
    DROP TABLE Users;
GO

-- Create simplified Users table with Role
CREATE TABLE Users (
    SSN BIGINT PRIMARY KEY,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Username NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) NOT NULL
);
GO

-- Migrate from Instructor
INSERT INTO Users (SSN, Email, Username, Password, Role)
SELECT SSN, Email, Fname + Lname + CAST(Instructor_ID AS NVARCHAR),
    '$2a$12$Z.23Jt9qBEUkZmoLJxg6gOJXmGxkYWQ9fJdbc/cuwwDaqg5gmVE7q', -- default bcrypt hash for all
    'instructor'
FROM Instructor
WHERE SSN IS NOT NULL AND Email IS NOT NULL AND Fname IS NOT NULL AND Lname IS NOT NULL AND Instructor_ID IS NOT NULL;
GO

-- Migrate from Student, avoiding duplicate SSN
INSERT INTO Users (SSN, Email, Username, Password, Role)
SELECT SSN, Email, Fname + Lname + CAST(Student_ID AS NVARCHAR),
    '$2a$12$Z.23Jt9qBEUkZmoLJxg6gOJXmGxkYWQ9fJdbc/cuwwDaqg5gmVE7q', -- default bcrypt hash for all
    'student'
FROM Student
WHERE SSN IS NOT NULL AND Email IS NOT NULL AND Fname IS NOT NULL AND Lname IS NOT NULL AND Student_ID IS NOT NULL
AND SSN NOT IN (SELECT SSN FROM Users);
GO

-- Add Course_Track junction table for many-to-many relationship
IF OBJECT_ID('Course_Track', 'U') IS NULL
BEGIN
    CREATE TABLE Course_Track (
        Course_ID INT NOT NULL,
        Track_ID INT NOT NULL,
        PRIMARY KEY (Course_ID, Track_ID),
        FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID),
        FOREIGN KEY (Track_ID) REFERENCES Track(Track_ID)
    );
END
GO

-- Add Course_ID and Track_ID columns to Exam table if not exist
IF COL_LENGTH('Exam', 'Course_ID') IS NULL
BEGIN
    ALTER TABLE Exam ADD Course_ID INT;
    ALTER TABLE Exam ADD CONSTRAINT FK_Exam_Course FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID);
END
GO
IF COL_LENGTH('Exam', 'Track_ID') IS NULL
BEGIN
    ALTER TABLE Exam ADD Track_ID INT;
    ALTER TABLE Exam ADD CONSTRAINT FK_Exam_Track FOREIGN KEY (Track_ID) REFERENCES Track(Track_ID);
END
GO

-- Update sp_Insert_Exam to return the new Exam_ID after insert
IF OBJECT_ID('sp_Insert_Exam', 'P') IS NOT NULL
    DROP PROCEDURE sp_Insert_Exam;
GO
CREATE OR ALTER PROCEDURE sp_Insert_Exam
    @Exam_Name NVARCHAR(100),
    @Exam_Total_Marks INT,
    @Exam_Start_date DATETIME = NULL,
    @Exam_End_date DATETIME = NULL,
    @Branch_ID INT,
    @Course_ID INT,
    @Track_ID INT
AS
BEGIN TRY
    DECLARE @NewExamID INT;
    SET @NewExamID = (SELECT ISNULL(MAX(Exam_ID),0) + 1 FROM Exam);
    INSERT INTO Exam (Exam_ID, Exam_Name, Exam_Total_Marks, Exam_Start_date, Exam_End_date, Branch_ID, Course_ID, Track_ID)
    VALUES (@NewExamID, @Exam_Name, @Exam_Total_Marks, @Exam_Start_date, @Exam_End_date, @Branch_ID, @Course_ID, @Track_ID);
    SELECT @NewExamID AS Exam_ID;
END TRY
BEGIN CATCH
    SELECT 'Exam Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update GenerateExam stored procedure to handle Exam_ID properly and include new parameters
IF OBJECT_ID('GenerateExam', 'P') IS NOT NULL
    DROP PROCEDURE GenerateExam;
GO
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
    WHERE c.Course_Name = @Course AND q.type = 'MCQ'
    ORDER BY NEWID()
    UNION ALL
    SELECT TOP(@NumOfTF) q.Question_ID, q.Question_Mark
    FROM Question q INNER JOIN Course c ON q.Course_ID = c.Course_ID
    WHERE c.Course_Name = @Course AND q.type = 'True/False'
    ORDER BY NEWID()
  )
  SELECT * INTO #TempQuestions FROM first_CTE;

  -- Calculate total marks
  SET @TotalMarks = (SELECT ISNULL(SUM(CAST(Question_Mark AS INT)), 0) FROM #TempQuestions);

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