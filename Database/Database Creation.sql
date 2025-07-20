CREATE TABLE Branch (
	Branch_ID INT PRIMARY KEY, 
	Branch_Name NVARCHAR(50) NOT NULL UNIQUE,
	Branch_Email NVARCHAR(100), 
	Branch_phone BIGINT, 
	Branch_location NVARCHAR(100), 
	Manager_ID INT, 
	Manager_Name NVARCHAR(50), 
	Manager_SSN BIGINT, 
	Manager_Email NVARCHAR(100), 
	Manager_Phone BIGINT,
	Manager_Gender NVARCHAR(20), 
	Manager_DOB DATE 
);

CREATE TABLE Program (
	Program_ID INT PRIMARY KEY, 
	P_Name NVARCHAR(50) NOT NULL, 
	P_Type NVARCHAR(100) Not null,
);

CREATE TABLE Branch_Program (
	Branch_ID INT,
	Program_ID INT,
	CONSTRAINT Branch_Program_PK PRIMARY KEY (Branch_ID, Program_ID),
	CONSTRAINT FK_Branch_Program_Branch FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID) on update cascade,
	CONSTRAINT FK_Branch_Program_Program FOREIGN KEY (Program_ID) REFERENCES Program(Program_ID) on update cascade
);

CREATE TABLE Batch (
	batch_ID INT PRIMARY KEY,
	Batch_Name NVARCHAR(50) NOT NULL UNIQUE, 
	P_Start_Date DATE, 
	P_End_Date DATE,
	Program_ID INT NOT NULL,
	CONSTRAINT FK_Program_Batch FOREIGN KEY (Program_ID) REFERENCES Program(Program_ID) on update cascade
);

CREATE TABLE Instructor (
	Instructor_ID INT PRIMARY KEY,
	SSN BIGINT NOT NULL UNIQUE, 
	Fname NVARCHAR(30) NOT NULL, 
	Lname NVARCHAR(30) NOT NULL, 
	Email NVARCHAR(100), 
	DOB DATE,
	Gender NVARCHAR(20),
	phone BIGINT,
	street NVARCHAR(100),
	city NVARCHAR(50),
	Degree nvarchar(100),
	ITI_salary BIGINT
);

CREATE TABLE Track (
	Track_ID INT PRIMARY KEY, 
	Track_Name NVARCHAR(100) NOT NULL UNIQUE, 
	Track_description NVARCHAR(200), 
	Program_ID INT Not null, 
	Instructor_ID INT Not null,
	CONSTRAINT FK_Track_Program FOREIGN KEY (Program_ID) REFERENCES Program(Program_ID),
	CONSTRAINT FK_Track_Instructor FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID) on update cascade
);

Create Table Company (
	Company_ID INT PRIMARY KEY,
	Name nvarchar(50) NOT NULL, 
	Type nvarchar(50), 
	Location nvarchar(100)
);

Create Table Instructor_Company (
	Instructor_ID INT PRIMARY KEY,
	Company_ID INT NOT NULL,
	title NVARCHAR(30) NOT NULL,
	salary BIGINT,
	Hired_date DATE,
	CONSTRAINT FK_Instructor_Company_Instructor FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID),
	CONSTRAINT FK_Instructor_Company_Company FOREIGN KEY (Company_ID) REFERENCES Company(Company_ID) on update cascade
);

Create Table GraduationProject (
	GraduationProject_ID INT PRIMARY KEY, 
	GraduationProject_Name nvarchar(200) NOT NULL, 
	GraduationProject_Score INT NOT NULL
);

Create Table Student (
	Student_ID INT PRIMARY KEY,	
	SSN	BIGINT NOT NULL UNIQUE, 
	Fname nvarchar(50) NOT NULL, 
	Lname nvarchar(50) NOT NULL, 
	Email nvarchar(100), 
	DOB	Date,
	Gender nvarchar(20),
	phone BIGINT,
	street nvarchar(100),
	city nvarchar(50),
	Faculty nvarchar(100),
	status nvarchar(100),
	Linked_In_URL nvarchar(100),
	Leader_ID Int,
	Track_ID INT NOT NULL,
	GraduationProject_ID INT,
	Branch_ID INT NOT NULL,
	Batch_ID INT NOT NULL,
	CONSTRAINT FK_Student_Leader FOREIGN KEY (Leader_ID) REFERENCES Student(Student_ID),
	CONSTRAINT FK_Student_Track FOREIGN KEY (Track_ID) REFERENCES Track(Track_ID),
	CONSTRAINT FK_Student_GraduationProject FOREIGN KEY (GraduationProject_ID) REFERENCES GraduationProject(GraduationProject_ID),
	CONSTRAINT FK_Student_Branch FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID) on update cascade,
	CONSTRAINT FK_Student_Batch FOREIGN KEY (Batch_ID) REFERENCES Batch(Batch_ID) on update cascade
);

Create Table Student_Company (
	Student_ID INT PRIMARY KEY,
	Company_ID Int NOT NULL,
	title nvarchar(50) NOT NULL,
	salary bigInt,
	Hired_date date,
	CONSTRAINT FK_Student_Company_Student FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
	CONSTRAINT FK_Student_Company_Company FOREIGN KEY (Company_ID) REFERENCES Company(Company_ID) on update cascade
);

Create Table Student_Instructor (
	Student_ID Int,
	Instructor_ID INT,
	CONSTRAINT Student_Instructor_PK PRIMARY KEY (Student_ID, Instructor_ID),
	CONSTRAINT FK_Student_Instructor_Student FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
	CONSTRAINT FK_Student_Instructor_Instructor FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID) on update cascade
);

Create Table Freelance (
	Freelance_ID INT PRIMARY KEY, 
	Freelance_Field nvarchar(100) NOT NULL, 
	Freelance_Platform nvarchar(50) NOT NULL, 
	Freelance_Income BIGINT, 
	Freelance_date date
);

Create Table Student_Freelance (
	Student_ID Int,
	Freelance_ID INT,
	CONSTRAINT Student_Freelance_PK PRIMARY KEY(Student_ID,Freelance_ID),
	CONSTRAINT FK_Student_Freelance_Student FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
	CONSTRAINT FK_Student_Freelance_Freelance FOREIGN KEY (Freelance_ID) REFERENCES Freelance(Freelance_ID) on update cascade
);

Create Table Certificate (
	Certificate_ID INT PRIMARY KEY, 
	Certificate_Name nvarchar(100) NOT NULL,	
	Certificate_Field nvarchar(100) NOT NULL, 
	Certificate_source nvarchar(50) NOT NULL, 
	Certificate_cost Int, 
	Certificate_date date
);

Create Table Student_Certificate (
	Student_ID Int,
	Certificate_ID INT,
	CONSTRAINT Student_Certificate_PK PRIMARY KEY(Student_ID,Certificate_ID),
	CONSTRAINT FK_Student_Certificate_Student FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
	CONSTRAINT FK_Student_Certificate_Certificate FOREIGN KEY (Certificate_ID) REFERENCES Certificate(Certificate_ID) on update cascade
);

Create Table Topic (
	Topic_ID INT PRIMARY KEY, 
	Topic_Name nvarchar(100) NOT NULL UNIQUE, 
	Topic_description nvarchar(250)
);

CREATE TABLE Course (
	Course_ID INT PRIMARY KEY, 
	Course_Name NVARCHAR(150) NOT NULL UNIQUE, 
	Course_Start_date DATETIME, 
	Course_end_date DATETIME, 
	Topic_ID INT,
	CONSTRAINT FK_Course_Topic FOREIGN KEY (Topic_ID) REFERENCES Topic(Topic_ID) on update cascade
);
 
Create Table Student_Course (
	Student_ID Int, 
	Course_ID INT, 
	CONSTRAINT Student_Course_PK PRIMARY KEY(Student_ID,Course_ID),
	CONSTRAINT FK_Student_Course_Student FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
	CONSTRAINT FK_Student_Course_Course FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) on update cascade
);

Create Table Instructor_Course (
	Instructor_ID Int, 
	Course_ID INT, 
	CONSTRAINT Instructor_Course_PK PRIMARY KEY(Instructor_ID,Course_ID),
	CONSTRAINT FK_Instructor_Course_Instructor FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID),
	CONSTRAINT FK_Instructor_Course_Course FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) on update cascade
);

Create Table Question (
	Question_ID INT PRIMARY KEY, 
	Question_Text NVARCHAR(500) NOT NULL UNIQUE, 
	type NVARCHAR(30) NOT NULL, 
	Question_Mark Int NOT NULL, 
	level NVARCHAR(20), 
	Course_ID INT NOT NULL,
	CONSTRAINT FK_Question_Course FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) on update cascade
);

Create Table Choices (
	Choices_ID INT PRIMARY KEY, 
	right_choice NVARCHAR(100) NOT NULL,
	Question_ID INT NOT NULL,
	CONSTRAINT FK_Choices_Question FOREIGN KEY (Question_ID) REFERENCES Question(Question_ID) on update cascade
);

Create Table Choice_Text (
	Choices_ID INT,
	Choice_Text NVARCHAR(100),
	CONSTRAINT Choice_Text_PK PRIMARY KEY(Choices_ID, Choice_Text),
	CONSTRAINT FK_Choice_Text_Choices FOREIGN KEY (Choices_ID) REFERENCES Choices(Choices_ID) on update cascade
);

Create Table Exam (
	Exam_ID	INT PRIMARY KEY, 
	Exam_Name nvarchar(100) NOT NULL, 
	Exam_Total_Marks Int NOT NULL, 
	Exam_Start_date	DATETIME NOT NULL, 
	Exam_End_date DATETIME NOT NULL,
	Branch_ID INT NOT NULL,
	CONSTRAINT FK_Exam_Branch FOREIGN KEY (Branch_ID) REFERENCES Branch(Branch_ID) on update cascade
);

Create Table Exam_Question (
	Exam_ID INT,
	Question_ID INT,
	CONSTRAINT Exam_Question_PK PRIMARY KEY(Exam_ID, Question_ID),
	CONSTRAINT FK_Exam_Question_Exam FOREIGN KEY (Exam_ID) REFERENCES Exam(Exam_ID) on update cascade,
	CONSTRAINT FK_Exam_Question_Question FOREIGN KEY (Question_ID) REFERENCES Question(Question_ID) on update cascade
);

Create Table Exam_Course (
	Exam_ID INT,
	Course_ID INT,
	CONSTRAINT Exam_Course_PK PRIMARY KEY (Exam_ID, Course_ID),
	CONSTRAINT FK_Exam_Course_Exam FOREIGN KEY (Exam_ID) REFERENCES Exam(Exam_ID) on update cascade,
	CONSTRAINT FK_Exam_Course_Course FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID) on update cascade
);

Create Table Student_Exam (
	Student_ID INT,
	Exam_ID INT,
	IS_Pass NVARCHAR(10) NOT NULL,
	Exam_Grade INT NOT NULL,
	CONSTRAINT Student_Exam_PK PRIMARY KEY (Student_ID, Exam_ID),
	CONSTRAINT FK_Student_Exam_Student FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
	CONSTRAINT FK_Student_Exam_Exam FOREIGN KEY (Exam_ID) REFERENCES Exam(Exam_ID)
);

Create Table Student_Exam_Question (
	Student_Exam_Question_ID INT PRIMARY KEY,
	Student_ID INT NOT NULL,
	Exam_ID INT NOT NULL,
	Question_ID INT NOT NULL,
	ST_answer NVARCHAR(50) NOT NULL,
	Point_Awarded INT NOT NULL,
	CONSTRAINT FK_Student_Exam_Question_Student FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
	CONSTRAINT FK_Student_Exam_Question_Exam FOREIGN KEY (Exam_ID) REFERENCES Exam(Exam_ID),
	CONSTRAINT FK_Student_Exam_Question_Question FOREIGN KEY (Question_ID) REFERENCES Question(Question_ID)
);

Create Table Instructor_Exam_Question (
	Instructor_ID INT NOT NULL,
	Exam_ID INT,
	Question_ID INT,
	CONSTRAINT Instructor_Exam_Question_PK PRIMARY KEY (Exam_ID, Question_ID),
	CONSTRAINT FK_Instructor_Exam_Question_Instructor FOREIGN KEY (Instructor_ID) REFERENCES Instructor(Instructor_ID) on update cascade,
	CONSTRAINT FK_Instructor_Exam_Question_Exam FOREIGN KEY (Exam_ID) REFERENCES Exam(Exam_ID) on update cascade,
	CONSTRAINT FK_Instructor_Exam_Question_Question FOREIGN KEY (Question_ID) REFERENCES Question(Question_ID) on update cascade
);


