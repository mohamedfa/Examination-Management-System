-- Stored Procedures for Branch Table

-- Select all Branches


CREATE OR ALTER PROCEDURE sp_Select_Branch @Branch_ID INT
AS
BEGIN TRY
  SELECT * FROM Branch WHERE Branch_ID = @Branch_ID;
END TRY
BEGIN CATCH
  SELECT 'Branch Is Not Exists' AS ErrorMessage;
END CATCH;


GO

-- Insert a new Branch

CREATE OR ALTER PROCEDURE sp_Insert_Branch
  @Branch_Name NVARCHAR(50),
  @Branch_Email NVARCHAR(100) = NULL,
  @Branch_phone BIGINT = NULL,
  @Branch_location NVARCHAR(100) = NULL,
  @Manager_ID INT = NULL,
  @Manager_Name NVARCHAR(50) = NULL,
  @Manager_SSN BIGINT = NULL,
  @Manager_Email NVARCHAR(100) = NULL,
  @Manager_Phone BIGINT = NULL,
  @Manager_Gender NVARCHAR(20) = NULL,
  @Manager_DOB DATE = NULL
AS
BEGIN TRY
  INSERT INTO Branch (Branch_ID, Branch_Name, Branch_Email, Branch_phone, Branch_location,
			Manager_ID, Manager_Name, Manager_SSN, Manager_Email, Manager_Phone, Manager_Gender, Manager_DOB)
  VALUES (((SELECT MAX(Branch_ID) FROM Branch)+1),
			@Branch_Name, @Branch_Email, @Branch_phone, @Branch_location,
			@Manager_ID, @Manager_Name, @Manager_SSN, @Manager_Email, @Manager_Phone, @Manager_Gender, @Manager_DOB);
END TRY
BEGIN CATCH
  SELECT 'Branch Is Already Exists' AS ErrorMessage;
END CATCH;

GO

-- Update an existing Branch

CREATE OR ALTER PROCEDURE sp_Update_Branch
  @Branch_ID INT,
  @Branch_Name NVARCHAR(50),
  @Branch_Email NVARCHAR(100) = NULL,
  @Branch_phone BIGINT = NULL,
  @Branch_location NVARCHAR(100) = NULL,
  @Manager_ID INT = NULL,
  @Manager_Name NVARCHAR(50) = NULL,
  @Manager_SSN BIGINT = NULL,
  @Manager_Email NVARCHAR(100) = NULL,
  @Manager_Phone BIGINT = NULL,
  @Manager_Gender NVARCHAR(20) = NULL,
  @Manager_DOB DATE = NULL
AS
BEGIN TRY
  UPDATE Branch
  SET Branch_Name = @Branch_Name,
      Branch_Email = @Branch_Email,
      Branch_phone = @Branch_phone,
      Branch_location = @Branch_location,
      Manager_ID = @Manager_ID,
      Manager_Name = @Manager_Name,
      Manager_SSN = @Manager_SSN,
      Manager_Email = @Manager_Email,
      Manager_Phone = @Manager_Phone,
      Manager_Gender = @Manager_Gender,
      Manager_DOB = @Manager_DOB
  WHERE Branch_ID = @Branch_ID;
END TRY
BEGIN CATCH
  SELECT 'Branch Is Not Exists' AS ErrorMessage;
END CATCH;

GO

-- Delete a Branch

CREATE OR ALTER PROCEDURE sp_Delete_Branch @Branch_ID INT
AS
BEGIN TRY
  DELETE FROM Branch WHERE Branch_ID = @Branch_ID;
END TRY
BEGIN CATCH
  SELECT 'Branch Is Not Exists' AS ErrorMessage;
END CATCH;

GO

-- Stored Procedures for Program Table

-- Select all Programs
CREATE OR ALTER PROCEDURE sp_Select_Program @Program_ID int 
AS
BEGIN TRY
    SELECT * FROM Program WHERE Program_ID = @Program_ID;
END TRY
BEGIN CATCH
    SELECT 'Program Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Insert a new Program
CREATE OR ALTER PROCEDURE sp_Insert_Program  
    @Program_ID INT,
    @P_Name NVARCHAR(50),
    @P_Type NVARCHAR(50)
AS
BEGIN TRY
    INSERT INTO Program (Program_ID, P_Name, P_Type)
    VALUES (((SELECT MAX(Program_ID) FROM Program)+1), @P_Name, @P_Type);
END TRY
BEGIN CATCH
    SELECT 'Program Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing Program
CREATE OR ALTER PROCEDURE sp_Update_Program
    @P_ID INT,
    @P_Name NVARCHAR(50),
    @P_Type NVARCHAR(50)
AS
BEGIN TRY
    UPDATE Program
    SET P_Name = @P_Name,
        P_Type = @P_Type
    WHERE Program_ID = @P_ID;
END TRY
BEGIN CATCH
    SELECT 'Program Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a Program
CREATE OR ALTER PROCEDURE sp_Delete_Program @Program_ID INT
AS
BEGIN TRY
    DELETE FROM Program WHERE Program_ID = @Program_ID;
END TRY
BEGIN CATCH
    SELECT 'Program Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Stored Procedures for Batch Table

-- Select all Batches
CREATE OR ALTER PROCEDURE sp_Select_Batch @Batch_ID INT
AS
BEGIN TRY
    SELECT * FROM Batch WHERE Batch_ID = @Batch_ID;
END TRY
BEGIN CATCH
    SELECT 'Batch Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Insert a new Batch
CREATE OR ALTER PROCEDURE sp_Insert_Batch
    @Batch_Name NVARCHAR(50),
    @P_Start_Date DATE = NULL,
    @P_End_Date DATE = NULL,
    @Program_ID INT
AS
BEGIN TRY
    INSERT INTO Batch (Batch_ID, Batch_Name, P_Start_Date, P_End_Date, Program_ID)
    VALUES (((SELECT MAX(Batch_ID) FROM Batch)+1), @Batch_Name, @P_Start_Date, @P_End_Date, @Program_ID);
END TRY
BEGIN CATCH
    SELECT 'Batch Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing Batch
CREATE OR ALTER PROCEDURE sp_Update_Batch
    @Batch_ID INT,
    @Batch_Name NVARCHAR(50),
    @P_Start_Date DATE = NULL,
    @P_End_Date DATE = NULL,
    @Program_ID INT
AS
BEGIN TRY
    UPDATE Batch
    SET Batch_Name = @Batch_Name,
        P_Start_Date = @P_Start_Date,
        P_End_Date = @P_End_Date,
        Program_ID = @Program_ID
    WHERE Batch_ID = @Batch_ID;
END TRY
BEGIN CATCH
    SELECT 'Batch Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a Batch
CREATE OR ALTER PROCEDURE sp_Delete_Batch @Batch_ID INT
AS
BEGIN TRY
    DELETE FROM Batch WHERE Batch_ID = @Batch_ID;
END TRY
BEGIN CATCH
    SELECT 'Batch Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Stored Procedures for Instructor Table

-- Select all Instructors
CREATE OR ALTER PROCEDURE sp_Select_Instructor @Instructor_ID INT
AS
BEGIN TRY
    SELECT * FROM Instructor WHERE Instructor_ID = @Instructor_ID;
END TRY
BEGIN CATCH
    SELECT 'Instructor Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Insert a new Instructor
CREATE OR ALTER PROCEDURE sp_Insert_Instructor
    @Instructor_ID INT,
    @SSN BIGINT,
    @Fname NVARCHAR(30),
    @Lname NVARCHAR(30),
    @Email NVARCHAR(100) = NULL,
    @DOB DATE = NULL,
	@Gender NVARCHAR(20) = NULL,
	@phone BIGINT = NULL,
	@street NVARCHAR(100) = NULL,
	@city NVARCHAR(50) = NULL,
	@Degree nvarchar(100) = NULL,
	@ITI_salary BIGINT = NULL
AS
BEGIN TRY
    INSERT INTO Instructor (Instructor_ID, SSN, Fname, Lname, Email, DOB, Gender, phone, street, city, Degree, ITI_salary)
    VALUES (((SELECT MAX(Instructor_ID) FROM Instructor)+1), @SSN, @Fname, @Lname, @Email, @DOB, @Gender, @phone, @street, @city, @Degree, @ITI_salary);
END TRY
BEGIN CATCH
    SELECT 'Instructor Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing Instructor
CREATE OR ALTER PROCEDURE sp_Update_Instructor
    @Instructor_ID INT,
    @SSN BIGINT,
    @Fname NVARCHAR(30),
    @Lname NVARCHAR(30),
    @Email NVARCHAR(100) = NULL,
    @DOB DATE = NULL,
    @Gender NVARCHAR(20) = NULL,
    @phone BIGINT = NULL,
    @street NVARCHAR(100) = NULL,
    @city NVARCHAR(50) = NULL,
    @Degree nvarchar(100) = NULL,
    @ITI_salary BIGINT = NULL
AS
BEGIN TRY
    UPDATE Instructor
    SET SSN = @SSN,
        Fname = @Fname,
        Lname = @Lname,
        Email = @Email,
        DOB = @DOB,
        Gender = @Gender,
        phone = @phone,
        street = @street,
        city = @city,
        Degree = @Degree,
        ITI_salary = @ITI_salary
    WHERE Instructor_ID = @Instructor_ID;
END TRY
BEGIN CATCH
    SELECT 'Instructor Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete an Instructor
CREATE OR ALTER PROCEDURE sp_Delete_Instructor @Instructor_ID INT
AS
BEGIN TRY
    DELETE FROM Instructor WHERE Instructor_ID = @Instructor_ID;
END TRY
BEGIN CATCH
    SELECT 'Instructor Is Not Exists' AS ErrorMessage;
END CATCH;
GO      

-- Stored Procedures for Track Table

-- Select all Tracks
CREATE OR ALTER PROCEDURE sp_Select_Track @Track_ID INT
AS
BEGIN TRY
    SELECT * FROM Track WHERE Track_ID = @Track_ID;
END TRY
BEGIN CATCH
    SELECT 'Track Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Insert a new Track
CREATE OR ALTER PROCEDURE sp_Insert_Track
    @Track_Name NVARCHAR(100),
    @Track_description NVARCHAR(200) = NULL,
    @Program_ID INT,
    @Instructor_ID INT
AS
BEGIN TRY
    INSERT INTO Track (Track_ID, Track_Name, Track_description, Program_ID, Instructor_ID)  
    VALUES (((SELECT MAX(Track_ID) FROM Track)+1), @Track_Name, @Track_description, @Program_ID, @Instructor_ID);
END TRY
BEGIN CATCH
    SELECT 'Track Is Already Exists' AS ErrorMessage;
END CATCH;
GO


-- Update an existing Track
CREATE OR ALTER PROCEDURE sp_Update_Track
    @Track_ID INT,
    @Track_Name NVARCHAR(100),
    @Track_description NVARCHAR(200) = NULL,
    @Program_ID INT,
    @Instructor_ID INT
AS
BEGIN TRY
    UPDATE Track
    SET Track_Name = @Track_Name,
        Track_description = @Track_description,
        Program_ID = @Program_ID,
        Instructor_ID = @Instructor_ID
    WHERE Track_ID = @Track_ID;
END TRY
BEGIN CATCH
    SELECT 'Track Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a Track
CREATE OR ALTER PROCEDURE sp_Delete_Track @Track_ID INT
AS
BEGIN TRY
    DELETE FROM Track WHERE Track_ID = @Track_ID;
END TRY
BEGIN CATCH
    SELECT 'Track Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Stored Procedures for Company Table

-- Select all Companies
CREATE OR ALTER PROCEDURE sp_Select_Company @Company_ID INT
AS
BEGIN TRY
    SELECT * FROM Company WHERE Company_ID = @Company_ID;
END TRY
BEGIN CATCH
    SELECT 'Company Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Insert a new Company
CREATE OR ALTER PROCEDURE sp_Insert_Company
    @Company_ID INT,
    @Name NVARCHAR(50),
    @Type NVARCHAR(50) = NULL,
    @Location NVARCHAR(100) = NULL
AS
BEGIN TRY
    INSERT INTO Company (Company_ID, Name, Type, Location)
    VALUES (((SELECT MAX(Company_ID) FROM Company)+1), @Name, @Type, @Location);
END TRY
BEGIN CATCH
    SELECT 'Company Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing Company
CREATE OR ALTER PROCEDURE sp_Update_Company
    @Company_ID INT,
    @Name NVARCHAR(50),
    @Type NVARCHAR(50) = NULL,
    @Location NVARCHAR(100) = NULL
AS
BEGIN TRY
    UPDATE Company
    SET Name = @Name,
    Type = @Type,
    Location = @Location
    WHERE Company_ID = @Company_ID;
END TRY
BEGIN CATCH
    SELECT 'Company Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a Company
CREATE OR ALTER PROCEDURE sp_Delete_Company @Company_ID INT
AS
BEGIN TRY
    DELETE FROM Company WHERE Company_ID = @Company_ID;
END TRY
BEGIN CATCH
    SELECT 'Company Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Stored Procedures for Instructor_Company Table

-- Select all Instructor_Companies
CREATE OR ALTER PROCEDURE sp_Select_Instructor_Company @Instructor_ID INT, @Company_ID INT
AS
BEGIN TRY
    SELECT * FROM Instructor_Company WHERE Instructor_ID = @Instructor_ID AND Company_ID = @Company_ID;
END TRY
BEGIN CATCH
    SELECT 'Instructor_Company Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Insert a new Instructor_Company
CREATE OR ALTER PROCEDURE sp_Insert_Instructor_Company
    @Instructor_ID INT,
    @Company_ID INT,
    @Title NVARCHAR(50),
    @Salary BIGINT = NULL,
    @Hired_Date DATE = NULL
AS
BEGIN TRY
    INSERT INTO Instructor_Company (Instructor_ID, Company_ID, Title, Salary, Hired_Date)
    VALUES (@Instructor_ID, @Company_ID, @Title, @Salary, @Hired_Date);
END TRY
BEGIN CATCH
    SELECT 'Instructor_Company Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing Instructor_Company
CREATE OR ALTER PROCEDURE sp_Update_Instructor_Company
    @Instructor_ID INT,
    @Company_ID INT,
    @Title NVARCHAR(50),
    @Salary BIGINT = NULL,
    @Hired_Date DATE = NULL
AS
BEGIN TRY
    UPDATE Instructor_Company
    SET Company_ID = @Company_ID,
        Title = @Title,
        Salary = @Salary,
        Hired_Date = @Hired_Date
    WHERE Instructor_ID = @Instructor_ID;
END TRY
BEGIN CATCH
    SELECT 'Instructor_Company Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a Instructor_Company

CREATE OR ALTER PROCEDURE sp_Delete_Instructor_Company @Instructor_ID INT
AS
BEGIN TRY
    DELETE FROM Instructor_Company WHERE Instructor_ID = @Instructor_ID;
END TRY
BEGIN CATCH
    SELECT 'Instructor_Company Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Stored Procedures for GraduationProject Table

-- Select all GraduationProjects
CREATE OR ALTER PROCEDURE sp_Select_GraduationProject @GraduationProject_ID INT
AS
BEGIN TRY
    SELECT * FROM GraduationProject WHERE GraduationProject_ID = @GraduationProject_ID;
END TRY
BEGIN CATCH
    SELECT 'GraduationProject Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Insert a new GraduationProject
CREATE OR ALTER PROCEDURE sp_Insert_GraduationProject
    @GraduationProject_ID INT,
    @GraduationProject_Name NVARCHAR(200),
    @GraduationProject_Score INT
AS
BEGIN TRY
    INSERT INTO GraduationProject (GraduationProject_ID, GraduationProject_Name, GraduationProject_Score)
    VALUES (((SELECT MAX(GraduationProject_ID) FROM GraduationProject)+1), @GraduationProject_Name, @GraduationProject_Score);
END TRY
BEGIN CATCH
    SELECT 'GraduationProject Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing GraduationProject
CREATE OR ALTER PROCEDURE sp_Update_GraduationProject
    @GraduationProject_ID INT,
    @GraduationProject_Name NVARCHAR(200),
    @GraduationProject_Score INT
AS
BEGIN TRY
    UPDATE GraduationProject
    SET GraduationProject_Name = @GraduationProject_Name,
        GraduationProject_Score = @GraduationProject_Score
    WHERE GraduationProject_ID = @GraduationProject_ID;
END TRY
BEGIN CATCH
    SELECT 'GraduationProject Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a GraduationProject
CREATE OR ALTER PROCEDURE sp_Delete_GraduationProject @GraduationProject_ID INT
AS
BEGIN TRY
    DELETE FROM GraduationProject WHERE GraduationProject_ID = @GraduationProject_ID;
END TRY
BEGIN CATCH
    SELECT 'GraduationProject Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Stored Procedures for Student Table

-- Select all Students
CREATE OR ALTER PROCEDURE sp_Select_Student @Student_ID INT
AS
BEGIN TRY
    SELECT * FROM Student WHERE Student_ID = @Student_ID;
END TRY
BEGIN CATCH
    SELECT 'Student Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Insert a new Student
CREATE OR ALTER PROCEDURE sp_Insert_Student
    @Student_ID INT,
    @SSN BIGINT,
    @Fname NVARCHAR(30),
    @Lname NVARCHAR(30),
    @Email NVARCHAR(100) = NULL,
    @DOB DATE = NULL,
    @Gender NVARCHAR(20) = NULL,
    @phone BIGINT = NULL,
    @street NVARCHAR(100) = NULL,
    @city NVARCHAR(50) = NULL,
    @Faculty NVARCHAR(100) = NULL,
    @status nvarchar(100) = NULL,
    @Linked_In_URL nvarchar(100) = NULL,
	@Leader_ID Int = NULL,
	@Track_ID INT,
	@GraduationProject_ID INT = NULL,
	@Branch_ID INT,
	@Batch_ID INT
AS
BEGIN TRY
    INSERT INTO Student (Student_ID, SSN, Fname, Lname, Email, DOB, Gender, phone, street, city, Faculty, status, Linked_In_URL, Leader_ID, Track_ID, GraduationProject_ID, Branch_ID, Batch_ID)
    VALUES (((SELECT MAX(Student_ID) FROM Student)+1), @SSN, @Fname, @Lname, @Email, @DOB, @Gender, @phone, @street, @city, @Faculty, @status, @Linked_In_URL, @Leader_ID, @Track_ID, @GraduationProject_ID, @Branch_ID, @Batch_ID);
END TRY
BEGIN CATCH
    SELECT 'Student Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing Student
CREATE OR ALTER PROCEDURE sp_Update_Student
    @Student_ID INT,
    @SSN BIGINT,
    @Fname NVARCHAR(30),
    @Lname NVARCHAR(30),
    @Email NVARCHAR(100) = NULL,
    @DOB DATE = NULL,
    @Gender NVARCHAR(20) = NULL,
    @phone BIGINT = NULL,
    @street NVARCHAR(100) = NULL,
    @city NVARCHAR(50) = NULL,
    @Faculty NVARCHAR(100) = NULL,
    @status nvarchar(100) = NULL,
	@Linked_In_URL nvarchar(100) = NULL,
	@Leader_ID Int = NULL,
	@Track_ID INT,
	@GraduationProject_ID INT = NULL,
	@Branch_ID INT,
	@Batch_ID INT
AS      
BEGIN TRY
    UPDATE Student
    SET SSN = @SSN,
        Fname = @Fname,
        Lname = @Lname,
        Email = @Email,
        DOB = @DOB,
        Gender = @Gender,
        phone = @phone,
        street = @street,
        city = @city,
        Faculty = @Faculty,
        status = @status,
        Linked_In_URL = @Linked_In_URL,
        Leader_ID = @Leader_ID,
        Track_ID = @Track_ID,
        GraduationProject_ID = @GraduationProject_ID,
        Branch_ID = @Branch_ID,
        Batch_ID = @Batch_ID
    WHERE Student_ID = @Student_ID;
END TRY
BEGIN CATCH
    SELECT 'Student Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a Student
CREATE OR ALTER PROCEDURE sp_Delete_Student @Student_ID INT
AS
BEGIN TRY
    DELETE FROM Student WHERE Student_ID = @Student_ID;
END TRY
BEGIN CATCH 
    SELECT 'Student Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Stored Procedures for Student_Company Table

-- Select all Student_Companies
CREATE OR ALTER PROCEDURE sp_Select_Student_Company @Student_ID INT, @Company_ID INT
AS
BEGIN TRY
    SELECT * FROM Student_Company WHERE Student_ID = @Student_ID AND Company_ID = @Company_ID;
END TRY
BEGIN CATCH
    SELECT 'Student_Company Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Insert a new Student_Company
CREATE OR ALTER PROCEDURE sp_Insert_Student_Company
    @Student_ID INT,
    @Company_ID INT,
    @Title NVARCHAR(50),
    @Salary BIGINT = NULL,
    @Hired_Date DATE = NULL
AS
BEGIN TRY
    INSERT INTO Student_Company (Student_ID, Company_ID, Title, Salary, Hired_Date)
    VALUES (@Student_ID, @Company_ID, @Title, @Salary, @Hired_Date);
END TRY
BEGIN CATCH
    SELECT 'Student_Company Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing Student_Company
CREATE OR ALTER PROCEDURE sp_Update_Student_Company
    @Student_ID INT,
    @Company_ID INT,
    @Title NVARCHAR(50),
    @Salary BIGINT = NULL,
    @Hired_Date DATE = NULL
AS
BEGIN TRY
    UPDATE Student_Company
    SET Company_ID = @Company_ID,
        Title = @Title,
        Salary = @Salary,
        Hired_Date = @Hired_Date
    WHERE Student_ID = @Student_ID;
END TRY
BEGIN CATCH
    SELECT 'Student_Company Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a Student_Company
CREATE OR ALTER PROCEDURE sp_Delete_Student_Company @Student_ID INT
AS
BEGIN TRY
    DELETE FROM Student_Company WHERE Student_ID = @Student_ID;
END TRY
BEGIN CATCH
    SELECT 'Student_Company Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Stored Procedures for Freelance Table

-- Select all Freelances
CREATE OR ALTER PROCEDURE sp_Select_Freelance @Freelance_ID INT
AS
BEGIN TRY
    SELECT * FROM Freelance WHERE Freelance_ID = @Freelance_ID;
END TRY
BEGIN CATCH
    SELECT 'Freelance Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Insert a new Freelance
CREATE OR ALTER PROCEDURE sp_Insert_Freelance
    @Freelance_ID INT,
    @Freelance_Field NVARCHAR(100),
    @Freelance_Platform NVARCHAR(50),
    @Freelance_Income BIGINT = NULL,
    @Freelance_Date DATE = NULL
AS
BEGIN TRY
    INSERT INTO Freelance (Freelance_ID, Freelance_Field, Freelance_Platform, Freelance_Income, Freelance_Date)
    VALUES (((SELECT MAX(Freelance_ID) FROM Freelance)+1), @Freelance_Field, @Freelance_Platform, @Freelance_Income, @Freelance_Date);
END TRY
BEGIN CATCH
    SELECT 'Freelance Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing Freelance
CREATE OR ALTER PROCEDURE sp_Update_Freelance
    @Freelance_ID INT,
    @Freelance_Field NVARCHAR(100),
    @Freelance_Platform NVARCHAR(50),
    @Freelance_Income BIGINT = NULL,
    @Freelance_Date DATE = NULL
AS
BEGIN TRY
    UPDATE Freelance
    SET Freelance_Field = @Freelance_Field,
        Freelance_Platform = @Freelance_Platform,
        Freelance_Income = @Freelance_Income,
        Freelance_Date = @Freelance_Date
    WHERE Freelance_ID = @Freelance_ID;
END TRY
BEGIN CATCH
    SELECT 'Freelance Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a Freelance
CREATE OR ALTER PROCEDURE sp_Delete_Freelance @Freelance_ID INT
AS
BEGIN TRY
    DELETE FROM Freelance WHERE Freelance_ID = @Freelance_ID;
END TRY 
BEGIN CATCH
    SELECT 'Freelance Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Stored Procedures for Certificate Table

-- Select all Certificates
CREATE OR ALTER PROCEDURE sp_Select_Certificate @Certificate_ID INT
AS
BEGIN TRY
    SELECT * FROM Certificate WHERE Certificate_ID = @Certificate_ID;
END TRY
BEGIN CATCH
    SELECT 'Certificate Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Insert a new Certificate 
CREATE OR ALTER PROCEDURE sp_Insert_Certificate
    @Certificate_Name NVARCHAR(200),
    @Certificate_Field NVARCHAR(100),
    @Certificate_Source NVARCHAR(100),
    @Certificate_cost INT = NULL,
    @Certificate_Date DATE = NULL
AS
BEGIN TRY
    INSERT INTO Certificate (Certificate_ID, Certificate_Name, Certificate_Field, Certificate_Source, Certificate_cost, Certificate_Date)
    VALUES (((SELECT MAX(Certificate_ID) FROM Certificate)+1), @Certificate_Name, @Certificate_Field, @Certificate_Source, @Certificate_cost, @Certificate_Date);
END TRY
BEGIN CATCH
    SELECT 'Certificate Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing Certificate

CREATE OR ALTER PROCEDURE sp_Update_Certificate
    @Certificate_ID INT,
    @Certificate_Name NVARCHAR(200),
    @Certificate_Field NVARCHAR(100),
    @Certificate_Source NVARCHAR(100),
    @Certificate_cost INT = NULL,
    @Certificate_Date DATE = NULL
AS
BEGIN TRY
    UPDATE Certificate
    SET Certificate_Name = @Certificate_Name,
        Certificate_Field = @Certificate_Field,
        Certificate_Source = @Certificate_Source,
        Certificate_cost = @Certificate_cost,
        Certificate_Date = @Certificate_Date
    WHERE Certificate_ID = @Certificate_ID;
END TRY
BEGIN CATCH
    SELECT 'Certificate Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a Certificate
CREATE OR ALTER PROCEDURE sp_Delete_Certificate @Certificate_ID INT
AS
BEGIN TRY
    DELETE FROM Certificate WHERE Certificate_ID = @Certificate_ID;
END TRY
BEGIN CATCH
    SELECT 'Certificate Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Stored Procedures for Topic Table

-- Select all Topics
CREATE OR ALTER PROCEDURE sp_Select_Topic @Topic_ID INT
AS
BEGIN TRY
    SELECT * FROM Topic WHERE Topic_ID = @Topic_ID;
END TRY
BEGIN CATCH
    SELECT 'Topic Is Not Exists' AS ErrorMessage;
END CATCH;
GO  

-- Insert a new Topic
CREATE OR ALTER PROCEDURE sp_Insert_Topic
    @Topic_Name NVARCHAR(200),
    @Topic_description NVARCHAR(250) = NULL
AS
BEGIN TRY
    INSERT INTO Topic (Topic_ID, Topic_Name, Topic_description)
    VALUES (((SELECT MAX(Topic_ID) FROM Topic)+1), @Topic_Name, @Topic_description);
END TRY
BEGIN CATCH
    SELECT 'Topic Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing Topic
CREATE OR ALTER PROCEDURE sp_Update_Topic
    @Topic_ID INT,
    @Topic_Name NVARCHAR(200),
    @Topic_description NVARCHAR(250) = NULL
AS
BEGIN TRY
    UPDATE Topic
    SET Topic_Name = @Topic_Name,
        Topic_description = @Topic_description
    WHERE Topic_ID = @Topic_ID;
END TRY
BEGIN CATCH
    SELECT 'Topic Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a Topic
CREATE OR ALTER PROCEDURE sp_Delete_Topic @Topic_ID INT
AS
BEGIN TRY
    DELETE FROM Topic WHERE Topic_ID = @Topic_ID;
END TRY
BEGIN CATCH
    SELECT 'Topic Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Stored Procedures for Course Table

-- Select all Courses
CREATE OR ALTER PROCEDURE sp_Select_Course @Course_ID INT
AS
BEGIN TRY
    SELECT * FROM Course WHERE Course_ID = @Course_ID;
END TRY
BEGIN CATCH
    SELECT 'Course Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Insert a new Course  
CREATE OR ALTER PROCEDURE sp_Insert_Course
    @Course_Name NVARCHAR(200),
    @Course_Start_date DATETIME = NULL,
    @Course_end_date DATETIME = NULL,
    @Topic_ID INT = NULL
AS
BEGIN TRY
    INSERT INTO Course (Course_ID, Course_Name, Course_Start_date, Course_end_date, Topic_ID)
    VALUES (((SELECT MAX(Course_ID) FROM Course)+1), @Course_Name, @Course_Start_date, @Course_end_date, @Topic_ID);
END TRY
BEGIN CATCH
    SELECT 'Course Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing Course
CREATE OR ALTER PROCEDURE sp_Update_Course
    @Course_ID INT,
    @Course_Name NVARCHAR(200),
    @Course_Start_date DATETIME = NULL,
    @Course_end_date DATETIME = NULL,
    @Topic_ID INT
AS
BEGIN TRY
    UPDATE Course
    SET Course_Name = @Course_Name,
        Course_Start_date = @Course_Start_date,
        Course_end_date = @Course_end_date,
        Topic_ID = @Topic_ID
    WHERE Course_ID = @Course_ID;
END TRY
BEGIN CATCH
    SELECT 'Course Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a Course

CREATE OR ALTER PROCEDURE sp_Delete_Course @Course_ID INT
AS
BEGIN TRY
    DELETE FROM Course WHERE Course_ID = @Course_ID;
END TRY
BEGIN CATCH
    SELECT 'Course Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Stored Procedures for Question Table 

-- Select all Questions
CREATE OR ALTER PROCEDURE sp_Select_Question @Question_ID INT
AS
BEGIN TRY
    SELECT * FROM Question WHERE Question_ID = @Question_ID;
END TRY
BEGIN CATCH
    SELECT 'Question Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Insert a new Question
CREATE OR ALTER PROCEDURE sp_Insert_Question
    @Question_Text NVARCHAR(500),
    @type NVARCHAR(30),
    @Question_Mark Int,
    @Level NVARCHAR(30) = NULL,
    @Course_ID INT
AS
BEGIN TRY
    INSERT INTO Question (Question_ID, Question_Text, type, Question_Mark, Level, Course_ID)
    VALUES (((SELECT MAX(Question_ID) FROM Question)+1), @Question_Text, @type, @Question_Mark, @Level, @Course_ID);
END TRY
BEGIN CATCH
    SELECT 'Question Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing Question
CREATE OR ALTER PROCEDURE sp_Update_Question
    @Question_ID INT,
    @Question_Text NVARCHAR(500),
    @type NVARCHAR(30),
    @Question_Mark Int,
    @Level NVARCHAR(30) = NULL,
    @Course_ID INT
AS
BEGIN TRY
    UPDATE Question
    SET Question_Text = @Question_Text,
        type = @type,
        Question_Mark = @Question_Mark,
        Level = @Level,
        Course_ID = @Course_ID
    WHERE Question_ID = @Question_ID;
END TRY
BEGIN CATCH
    SELECT 'Question Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a Question
CREATE OR ALTER PROCEDURE sp_Delete_Question @Question_ID INT
AS
BEGIN TRY
    DELETE FROM Question WHERE Question_ID = @Question_ID;
END TRY
BEGIN CATCH
    SELECT 'Question Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Stored Procedures for Choices Table

-- Select all Choices
CREATE OR ALTER PROCEDURE sp_Select_Choices @Choices_ID INT
AS
BEGIN TRY
    SELECT * FROM Choices WHERE Choices_ID = @Choices_ID;
END TRY
BEGIN CATCH
    SELECT 'Choices Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Insert a new Choices
CREATE OR ALTER PROCEDURE sp_Insert_Choices
    @right_choice NVARCHAR(100),
    @Question_ID INT
AS
BEGIN TRY
    INSERT INTO Choices (Choices_ID, right_choice, Question_ID)
    VALUES (((SELECT MAX(Choices_ID) FROM Choices)+1), @right_choice, @Question_ID);
END TRY
BEGIN CATCH
    SELECT 'Choices Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing Choices
CREATE OR ALTER PROCEDURE sp_Update_Choices
    @Choices_ID INT,
    @right_choice NVARCHAR(100),
    @Question_ID INT
AS
BEGIN TRY
    UPDATE Choices
    SET right_choice = @right_choice,
        Question_ID = @Question_ID  
    WHERE Choices_ID = @Choices_ID;
END TRY
BEGIN CATCH
    SELECT 'Choices Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a Choices
CREATE OR ALTER PROCEDURE sp_Delete_Choices @Choices_ID INT  
AS
BEGIN TRY
    DELETE FROM Choices WHERE Choices_ID = @Choices_ID;
END TRY
BEGIN CATCH
    SELECT 'Choices Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Stored Procedures for choice_text Table

-- Select all choice_texts
CREATE OR ALTER PROCEDURE sp_Select_Choice_Text @Choices_ID INT
AS
BEGIN TRY
    SELECT * FROM Choice_Text WHERE Choices_ID = @Choices_ID;
END TRY
BEGIN CATCH
    SELECT 'Choice_Text Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Insert a new Choice_Text
CREATE OR ALTER PROCEDURE sp_Insert_Choice_Text
    @Choices_ID INT,
    @Choice_Text NVARCHAR(100)
AS
BEGIN TRY
    INSERT INTO Choice_Text (Choices_ID, Choice_Text)
    VALUES (@Choices_ID, @Choice_Text);
END TRY
BEGIN CATCH
    SELECT 'Choice_Text Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing Choice_Text
CREATE OR ALTER PROCEDURE sp_Update_Choice_Text
    @Choices_ID INT,
    @Choice_Text NVARCHAR(100)
AS
BEGIN TRY
    UPDATE Choice_Text
    SET Choice_Text = @Choice_Text
    WHERE Choices_ID = @Choices_ID;
END TRY
BEGIN CATCH
    SELECT 'Choice_Text Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a Choice_Text
CREATE OR ALTER PROCEDURE sp_Delete_Choice_Text @Choices_ID INT
AS
BEGIN TRY
    DELETE FROM Choice_Text WHERE Choices_ID = @Choices_ID;
END TRY
BEGIN CATCH
    SELECT 'Choice_Text Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Stored Procedures for Exam Table

-- Select all Exams
CREATE OR ALTER PROCEDURE sp_Select_Exam @Exam_ID INT
AS
BEGIN TRY
    SELECT * FROM Exam WHERE Exam_ID = @Exam_ID;
END TRY
BEGIN CATCH
    SELECT 'Exam Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Insert a new Exam
CREATE OR ALTER PROCEDURE sp_Insert_Exam
    @Exam_Name NVARCHAR(100),
    @Exam_Total_Marks INT,
    @Exam_Start_date DATETIME = NULL,
    @Exam_End_date DATETIME = NULL,
    @Branch_ID INT
AS
BEGIN TRY
    INSERT INTO Exam (Exam_ID, Exam_Name, Exam_Total_Marks, Exam_Start_date, Exam_End_date, Branch_ID)
    VALUES (((SELECT MAX(Exam_ID) FROM Exam)+1), @Exam_Name, @Exam_Total_Marks, @Exam_Start_date, @Exam_End_date, @Branch_ID);
END TRY
BEGIN CATCH
    SELECT 'Exam Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing Exam
CREATE OR ALTER PROCEDURE sp_Update_Exam
    @Exam_ID INT,
    @Exam_Name NVARCHAR(100),
    @Exam_Total_Marks INT,
    @Exam_Start_date DATETIME = NULL,
    @Exam_End_date DATETIME = NULL,
    @Branch_ID INT
AS
BEGIN TRY   
    UPDATE Exam
    SET Exam_Name = @Exam_Name,
        Exam_Total_Marks = @Exam_Total_Marks,
        Exam_Start_date = @Exam_Start_date,
        Exam_End_date = @Exam_End_date,
        Branch_ID = @Branch_ID
    WHERE Exam_ID = @Exam_ID;
END TRY
BEGIN CATCH
    SELECT 'Exam Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a Exam
CREATE OR ALTER PROCEDURE sp_Delete_Exam @Exam_ID INT
AS
BEGIN TRY
    DELETE FROM Exam WHERE Exam_ID = @Exam_ID;
END TRY
BEGIN CATCH
    SELECT 'Exam Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Stored Procedures for student_exam Table

-- Select all student_exams
CREATE OR ALTER PROCEDURE sp_Select_Student_Exam @Student_ID INT
AS
BEGIN TRY
    SELECT * FROM Student_Exam WHERE Student_ID = @Student_ID;
END TRY
BEGIN CATCH
    SELECT 'Exam_Student Is Not Exists' AS ErrorMessage;
END CATCH;
GO  

-- Insert a new Exam_Student
CREATE OR ALTER PROCEDURE sp_Insert_Student_Exam
    @Student_ID INT,
    @Exam_ID INT,
    @IS_Pass NVARCHAR(10),
    @Exam_Grade INT
AS
BEGIN TRY
    INSERT INTO Student_Exam (Student_ID, Exam_ID, IS_Pass, Exam_Grade)
    VALUES (@Student_ID, @Exam_ID, @IS_Pass, @Exam_Grade);
END TRY
BEGIN CATCH
    SELECT 'Exam_Student Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing Exam_Student
CREATE OR ALTER PROCEDURE sp_Update_Student_Exam
    @Student_ID INT,
    @Exam_ID INT,
    @IS_Pass NVARCHAR(10),
    @Exam_Grade INT
AS
BEGIN TRY
    UPDATE Student_Exam
    SET IS_Pass = @IS_Pass,
        Exam_Grade = @Exam_Grade
    WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID;
END TRY
BEGIN CATCH
    SELECT 'Exam_Student Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a Exam_Student
CREATE OR ALTER PROCEDURE sp_Delete_Student_Exam @Student_ID INT
AS
BEGIN TRY
    DELETE FROM Student_Exam WHERE Student_ID = @Student_ID;
END TRY
BEGIN CATCH
    SELECT 'Exam_Student Is Not Exists' AS ErrorMessage;
END CATCH;  
GO

-- Stored Procedures for student_exam_question Table

-- Select all student_exam_questions
CREATE OR ALTER PROCEDURE sp_Select_Student_Exam_Question @Student_Exam_Question_ID INT
AS
BEGIN TRY
    SELECT * FROM Student_Exam_Question WHERE Student_Exam_Question_ID = @Student_Exam_Question_ID;
END TRY
BEGIN CATCH
    SELECT 'Student_Exam_Question Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Insert a new Student_Exam_Question
CREATE OR ALTER PROCEDURE sp_Insert_Student_Exam_Question
    @Student_ID INT,
    @Exam_ID INT,
    @Question_ID INT,
    @ST_answer NVARCHAR(50),
    @Point_Awarded INT
AS
BEGIN TRY
    INSERT INTO Student_Exam_Question (Student_Exam_Question_ID, Student_ID, Exam_ID, Question_ID, ST_answer, Point_Awarded)
    VALUES (((SELECT MAX(Student_Exam_Question_ID) FROM Student_Exam_Question)+1), @Student_ID, @Exam_ID, @Question_ID, @ST_answer, @Point_Awarded);
END TRY
BEGIN CATCH
    SELECT 'Student_Exam_Question Is Already Exists' AS ErrorMessage;
END CATCH;
GO

-- Update an existing Student_Exam_Question
CREATE OR ALTER PROCEDURE sp_Update_Student_Exam_Question
    @Student_Exam_Question_ID INT,
    @Student_ID INT,
    @Exam_ID INT,
    @Question_ID INT,
    @ST_answer NVARCHAR(50),
    @Point_Awarded INT
AS
BEGIN TRY
    UPDATE Student_Exam_Question
    SET Student_ID = @Student_ID,
        Exam_ID = @Exam_ID,
        Question_ID = @Question_ID,
        ST_answer = @ST_answer,
        Point_Awarded = @Point_Awarded
    WHERE Student_Exam_Question_ID = @Student_Exam_Question_ID;
END TRY
BEGIN CATCH
    SELECT 'Student_Exam_Question Is Not Exists' AS ErrorMessage;
END CATCH;
GO

-- Delete a Student_Exam_Question
CREATE OR ALTER PROCEDURE sp_Delete_Student_Exam_Question @Student_Exam_Question_ID INT
AS
BEGIN TRY
    DELETE FROM Student_Exam_Question WHERE Student_Exam_Question_ID = @Student_Exam_Question_ID;
END TRY
BEGIN CATCH
    SELECT 'Student_Exam_Question Is Not Exists' AS ErrorMessage;
END CATCH;
GO

---------------------------------------------------------------------------------------------------
-------------The 6 Stored Procedures-------------
-------------------------------------------------
--1--
CREATE or ALTER PROCEDURE GetStudentInfoAndTrack
AS 
BEGIN
	SELECT s.*, t.Track_Name FROM Student s INNER JOIN Track t ON s.Track_ID = t.Track_ID
END
GO
--Calling
--GetStudentInfoAndTrack
-------------------------------------------------
--2--
CREATE OR ALTER PROCEDURE getCoursesGrade @Student_ID INT
AS
BEGIN
	SELECT s.Fname+' '+s.Lname as Fulname, c.Course_Name as [Course Name], concat('%',cast(se.Exam_Grade as float)/cast(e.Exam_Total_Marks as float)*100) as [Course Grade]
    FROM Student s
    INNER JOIN Student_Exam se ON s.Student_ID = se.Student_ID
    INNER JOIN Exam e ON se.Exam_ID = e.Exam_ID
    INNER JOIN Exam_Course ec ON e.Exam_ID = ec.Exam_ID
    INNER JOIN Course c ON ec.Course_ID = c.Course_ID
    WHERE s.Student_ID = @Student_ID
END
GO
--Calling
--getCoursesGrade 8
-------------------------------------------------
--3--
CREATE OR ALTER PROCEDURE GetNumOfStudentsPerCourse @Instructor_ID INT 
AS 
BEGIN
	SELECT i.Fname+' '+i.Lname as Fullname, c.Course_Name as [Course Name], t.Track_Name, COUNT(si.Student_ID) as [Number of Students]
	FROM Student_Instructor si
	INNER JOIN Instructor i ON si.Instructor_ID = i.Instructor_ID
	INNER JOIN Instructor_Course ic ON i.Instructor_ID = ic.Instructor_ID
	INNER JOIN Course c ON ic.Course_ID = c.Course_ID
	INNER JOIN Student s ON s.Student_ID = si.Student_ID
	INNER JOIN Track t ON s.Track_ID = t.Track_ID
	WHERE i.Instructor_ID = @Instructor_ID
	GROUP BY i.Fname+' '+i.Lname, c.Course_Name, t.Track_Name
END
GO
--Calling
--GetNumOfStudentsPerCourse 32
-------------------------------------------------
--4--
CREATE OR ALTER PROCEDURE GetTopics @Course_ID INT 
AS 
BEGIN 
	SELECT c.Course_Name, t.Topic_Name FROM Course c INNER JOIN Topic t ON c.Topic_ID=t.Topic_ID WHERE c.Course_ID=@Course_ID
END 
GO
--Calling
--GetTopics 6
-------------------------------------------------
--5--
CREATE OR ALTER PROCEDURE GetQandCperExam @Exam_ID INT
AS 
BEGIN 
	SELECT q.Question_ID, q.Question_Text, ct.Choice_Text
	from Exam e
	INNER JOIN Exam_Question eq ON e.Exam_ID=eq.Exam_ID
	INNER JOIN Question q ON eq.Question_ID=q.Question_ID
	INNER JOIN Choices c ON c.Question_ID=q.Question_ID
	INNER JOIN Choice_Text ct ON c.Choices_ID=ct.Choices_ID
	WHERE e.Exam_ID=@Exam_ID
END 
GO
--Calling
--GetQandCperExam 2
-------------------------------------------------
--6--
CREATE OR ALTER PROCEDURE GetQandStudentAnswers @Student_ID INT, @Exam_ID INT 
AS 
BEGIN 
	SELECT seq.Student_ID, s.Fname+' '+s.Lname as Fullname, q.Question_Text, seq.ST_answer
	FROM Student_Exam_Question seq
	INNER JOIN Question	q ON seq.Question_ID=q.Question_ID
	INNER JOIN Student s ON s.Student_ID=seq.Student_ID
	WHERE seq.Student_ID=@Student_ID and seq.Exam_ID=@Exam_ID
END 
GO
--Calling
--GetQandStudentAnswers 8, 21
---------------------------------------------------------------------------------------------------
--The 3, Exam generation, Exam Answers, Exam Correction--
-------------------
--Exam generation--
-------------------


CREATE or alter PROCEDURE GenerateExam
  @ExamName VARCHAR(50),
  @Course VARCHAR(30),
  @NumOfMCQ INT,
  @NumOfTF INT,
  @StartDate DATETIME,
  @EndDate DATETIME
AS
BEGIN
  DECLARE @id INT;

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

  INSERT INTO Exam (Exam_Name, Exam_Total_Marks, Exam_Start_date, Exam_End_date)
  VALUES (@ExamName, (SELECT SUM(CAST(Question_Mark AS INT)) FROM #TempQuestions), @StartDate, @EndDate);

  SELECT @id = SCOPE_IDENTITY();

  INSERT INTO Exam_Question (Exam_ID, Question_ID)
  SELECT @id, Question_ID FROM #TempQuestions;
  DROP TABLE #TempQuestions;
  SELECT 'Exam Generated Successfully'
END


GO
--Calling
--GenerateExam 'My Second Exam', 'Android with Kotlin Basics', 7, 3, '2025-07-01 12:00:00', '2025-07-01 02:00:00'
-------------------------------------------------
----------------
--Exam Answers--
----------------


CREATE or alter PROCEDURE ExamAnswer
  @Exam_ID INT,
  @Student_ID INT,
  @Question_ID INT,
  @Student_Answer NVARCHAR(50)
AS
BEGIN
  DECLARE @ChoicePoint INT;

  IF @Student_Answer = (
    SELECT MAX(c.right_choice)
    FROM Question q INNER JOIN Choices c ON q.Question_ID = c.Question_ID
    WHERE q.Question_ID = @Question_ID)
    SET @ChoicePoint = (SELECT MAX(Question_Mark) FROM Question WHERE Question_ID = @Question_ID)
  ELSE
    SET @ChoicePoint = 0;

  INSERT INTO Student_Exam_Question (Student_Exam_Question_ID, Exam_ID, Student_ID, Question_ID, ST_answer, Point_Awarded)
  VALUES ((SELECT MAX(Student_Exam_Question_ID)+1 FROM Student_Exam_Question), @Student_ID, @Exam_ID, @Question_ID, @Student_Answer, @ChoicePoint);
END


GO
--Calling
--ExamAnswer 23, 3, 4, 'Pandas'
-------------------------------------------------
-------------------
--Exam Correction--
-------------------


CREATE or alter PROCEDURE ExamCorrection
  @Student_ID INT,
  @Exam_ID INT
AS
BEGIN
  DECLARE @ISPass VARCHAR(30);

  IF NOT EXISTS (
    SELECT * FROM Student_Exam_Question
    WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID)
    SELECT 'This student didnt attend the exam';
  ELSE
  BEGIN
    WITH ExamGrade_CTE AS (
      SELECT SUM(Point_Awarded) AS ExamGrade
      FROM Student_Exam_Question
      WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID
    )
    SELECT * INTO #TempExamGrade FROM ExamGrade_CTE;

    IF (SELECT SUM(ExamGrade) FROM #TempExamGrade) / (SELECT SUM(Exam_Total_Marks) FROM Exam WHERE Exam_ID = @Exam_ID) >= 0.6
      SET @ISPass = 'Pass';
    ELSE
      SET @ISPass = 'Fail';

    INSERT INTO Student_Exam(Student_ID, Exam_ID, IS_Pass, Exam_Grade)
    VALUES(@Student_ID, @Exam_ID, @ISPass, (SELECT SUM(ExamGrade) FROM #TempExamGrade));

    DROP TABLE #TempExamGrade;
  END
END


GO
--Calling
---ExamCorrection 6, 21
-------------------------------------------------


CREATE OR ALTER PROCEDURE isCourseListedForAllCoursesAllStudents
AS
BEGIN
  UPDATE s
  SET [status] = 'Course Listed'
  FROM Student s
  WHERE [status] = 'student'
  AND EXISTS (
    SELECT 1
    FROM (
      SELECT c.Course_ID, se.Student_ID
      FROM Student_Exam se
      INNER JOIN Exam e ON se.Exam_ID = e.Exam_ID
      INNER JOIN Exam_Course ec ON e.Exam_ID = ec.Exam_ID
      INNER JOIN Course c ON ec.Course_ID = c.Course_ID
      WHERE se.Student_ID = s.Student_ID
      GROUP BY c.Course_ID, se.Student_ID
      HAVING COUNT(e.Exam_ID) >= 2 AND SUM(CASE WHEN se.IS_Pass = 'Fail' THEN 1 ELSE 0 END) >= 2
    ) t
    WHERE t.Student_ID = s.Student_ID
  );
END


GO
--Calling
--isCourseListedForAllCoursesAllStudents
---------------------------------------------------------------------------------------------------