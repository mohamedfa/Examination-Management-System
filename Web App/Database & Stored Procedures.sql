USE [ITI_Examination_Sys]
GO
/****** Object:  Table [dbo].[Batch]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Batch](
	[batch_ID] [int] NOT NULL,
	[Batch_Name] [nvarchar](50) NOT NULL,
	[P_Start_Date] [date] NULL,
	[P_End_Date] [date] NULL,
	[Program_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[batch_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Batch_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch](
	[Branch_ID] [int] NOT NULL,
	[Branch_Name] [nvarchar](50) NOT NULL,
	[Branch_Email] [nvarchar](100) NULL,
	[Branch_phone] [bigint] NULL,
	[Branch_location] [nvarchar](100) NULL,
	[Manager_ID] [int] NULL,
	[Manager_Name] [nvarchar](50) NULL,
	[Manager_SSN] [bigint] NULL,
	[Manager_Email] [nvarchar](100) NULL,
	[Manager_Phone] [bigint] NULL,
	[Manager_Gender] [nvarchar](20) NULL,
	[Manager_DOB] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Branch_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Branch_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Branch_Program]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch_Program](
	[Branch_ID] [int] NOT NULL,
	[Program_ID] [int] NOT NULL,
 CONSTRAINT [Branch_Program_PK] PRIMARY KEY CLUSTERED 
(
	[Branch_ID] ASC,
	[Program_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Certificate]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Certificate](
	[Certificate_ID] [int] NOT NULL,
	[Certificate_Name] [nvarchar](100) NOT NULL,
	[Certificate_Field] [nvarchar](100) NOT NULL,
	[Certificate_source] [nvarchar](50) NOT NULL,
	[Certificate_cost] [int] NULL,
	[Certificate_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Certificate_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Choice_Text]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Choice_Text](
	[Choices_ID] [int] NOT NULL,
	[Choice_Text] [nvarchar](100) NOT NULL,
 CONSTRAINT [Choice_Text_PK] PRIMARY KEY CLUSTERED 
(
	[Choices_ID] ASC,
	[Choice_Text] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Choices]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Choices](
	[Choices_ID] [int] NOT NULL,
	[right_choice] [nvarchar](100) NOT NULL,
	[Question_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Choices_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Company]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Company](
	[Company_ID] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](50) NULL,
	[Location] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Company_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[Course_ID] [int] NOT NULL,
	[Course_Name] [nvarchar](150) NOT NULL,
	[Course_Start_date] [datetime] NULL,
	[Course_end_date] [datetime] NULL,
	[Topic_ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Course_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Course_Track]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course_Track](
	[Course_ID] [int] NOT NULL,
	[Track_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Course_ID] ASC,
	[Track_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam](
	[Exam_ID] [int] NOT NULL,
	[Exam_Name] [nvarchar](100) NOT NULL,
	[Exam_Total_Marks] [int] NOT NULL,
	[Exam_Start_date] [datetime] NOT NULL,
	[Exam_End_date] [datetime] NOT NULL,
	[Branch_ID] [int] NOT NULL,
	[Track_ID] [int] NULL,
	[Course_ID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Exam_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exam_Question]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exam_Question](
	[Exam_ID] [int] NOT NULL,
	[Question_ID] [int] NOT NULL,
 CONSTRAINT [Exam_Question_PK] PRIMARY KEY CLUSTERED 
(
	[Exam_ID] ASC,
	[Question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExamSessions]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExamSessions](
	[SessionId] [int] IDENTITY(1,1) NOT NULL,
	[ExamId] [int] NULL,
	[StudentId] [int] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[Status] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[SessionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Freelance]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Freelance](
	[Freelance_ID] [int] NOT NULL,
	[Freelance_Field] [nvarchar](100) NOT NULL,
	[Freelance_Platform] [nvarchar](50) NOT NULL,
	[Freelance_Income] [bigint] NULL,
	[Freelance_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Freelance_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GraduationProject]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GraduationProject](
	[GraduationProject_ID] [int] NOT NULL,
	[GraduationProject_Name] [nvarchar](200) NOT NULL,
	[GraduationProject_Score] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GraduationProject_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor](
	[Instructor_ID] [int] NOT NULL,
	[SSN] [bigint] NOT NULL,
	[Fname] [nvarchar](30) NOT NULL,
	[Lname] [nvarchar](30) NOT NULL,
	[Email] [nvarchar](100) NULL,
	[DOB] [date] NULL,
	[Gender] [nvarchar](20) NULL,
	[phone] [bigint] NULL,
	[street] [nvarchar](100) NULL,
	[city] [nvarchar](50) NULL,
	[Degree] [nvarchar](100) NULL,
	[ITI_salary] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Instructor_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[SSN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor_Company]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor_Company](
	[Instructor_ID] [int] NOT NULL,
	[Company_ID] [int] NOT NULL,
	[title] [nvarchar](30) NOT NULL,
	[salary] [bigint] NULL,
	[Hired_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Instructor_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor_Course]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor_Course](
	[Instructor_ID] [int] NOT NULL,
	[Course_ID] [int] NOT NULL,
 CONSTRAINT [Instructor_Course_PK] PRIMARY KEY CLUSTERED 
(
	[Instructor_ID] ASC,
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Instructor_Exam_Question]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instructor_Exam_Question](
	[Instructor_ID] [int] NOT NULL,
	[Exam_ID] [int] NOT NULL,
	[Question_ID] [int] NOT NULL,
 CONSTRAINT [Instructor_Exam_Question_PK] PRIMARY KEY CLUSTERED 
(
	[Exam_ID] ASC,
	[Question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Program]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Program](
	[Program_ID] [int] NOT NULL,
	[P_Name] [nvarchar](50) NOT NULL,
	[P_Type] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Program_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Question]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Question](
	[Question_ID] [int] NOT NULL,
	[Question_Text] [nvarchar](500) NOT NULL,
	[type] [nvarchar](30) NOT NULL,
	[Question_Mark] [int] NOT NULL,
	[level] [nvarchar](20) NULL,
	[Course_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Question_Text] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[Student_ID] [int] NOT NULL,
	[SSN] [bigint] NOT NULL,
	[Fname] [nvarchar](50) NOT NULL,
	[Lname] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](100) NULL,
	[DOB] [date] NULL,
	[Gender] [nvarchar](20) NULL,
	[phone] [bigint] NULL,
	[street] [nvarchar](100) NULL,
	[city] [nvarchar](50) NULL,
	[Faculty] [nvarchar](100) NULL,
	[status] [nvarchar](100) NULL,
	[Linked_In_URL] [nvarchar](100) NULL,
	[Leader_ID] [int] NULL,
	[Track_ID] [int] NOT NULL,
	[GraduationProject_ID] [int] NULL,
	[Branch_ID] [int] NOT NULL,
	[Batch_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Student_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[SSN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student_Certificate]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student_Certificate](
	[Student_ID] [int] NOT NULL,
	[Certificate_ID] [int] NOT NULL,
 CONSTRAINT [Student_Certificate_PK] PRIMARY KEY CLUSTERED 
(
	[Student_ID] ASC,
	[Certificate_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student_Company]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student_Company](
	[Student_ID] [int] NOT NULL,
	[Company_ID] [int] NOT NULL,
	[title] [nvarchar](50) NOT NULL,
	[salary] [bigint] NULL,
	[Hired_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[Student_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student_Course]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student_Course](
	[Student_ID] [int] NOT NULL,
	[Course_ID] [int] NOT NULL,
 CONSTRAINT [Student_Course_PK] PRIMARY KEY CLUSTERED 
(
	[Student_ID] ASC,
	[Course_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student_Exam]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student_Exam](
	[Student_ID] [int] NOT NULL,
	[Exam_ID] [int] NOT NULL,
	[IS_Pass] [nvarchar](10) NOT NULL,
	[Exam_Grade] [int] NOT NULL,
 CONSTRAINT [Student_Exam_PK] PRIMARY KEY CLUSTERED 
(
	[Student_ID] ASC,
	[Exam_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student_Exam_Question]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student_Exam_Question](
	[Student_Exam_Question_ID] [int] NOT NULL,
	[Student_ID] [int] NOT NULL,
	[Exam_ID] [int] NOT NULL,
	[Question_ID] [int] NOT NULL,
	[ST_answer] [nvarchar](50) NOT NULL,
	[Point_Awarded] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Student_Exam_Question_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student_Freelance]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student_Freelance](
	[Student_ID] [int] NOT NULL,
	[Freelance_ID] [int] NOT NULL,
 CONSTRAINT [Student_Freelance_PK] PRIMARY KEY CLUSTERED 
(
	[Student_ID] ASC,
	[Freelance_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student_Instructor]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student_Instructor](
	[Student_ID] [int] NOT NULL,
	[Instructor_ID] [int] NOT NULL,
 CONSTRAINT [Student_Instructor_PK] PRIMARY KEY CLUSTERED 
(
	[Student_ID] ASC,
	[Instructor_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Topic]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Topic](
	[Topic_ID] [int] NOT NULL,
	[Topic_Name] [nvarchar](100) NOT NULL,
	[Topic_description] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[Topic_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Topic_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Track]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Track](
	[Track_ID] [int] NOT NULL,
	[Track_Name] [nvarchar](100) NOT NULL,
	[Track_description] [nvarchar](200) NULL,
	[Program_ID] [int] NOT NULL,
	[Instructor_ID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Track_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Track_Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[SSN] [bigint] NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Username] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[Role] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SSN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ExamSessions] ADD  DEFAULT (getdate()) FOR [StartTime]
GO
ALTER TABLE [dbo].[ExamSessions] ADD  DEFAULT ('started') FOR [Status]
GO
ALTER TABLE [dbo].[Batch]  WITH CHECK ADD  CONSTRAINT [FK_Program_Batch] FOREIGN KEY([Program_ID])
REFERENCES [dbo].[Program] ([Program_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Batch] CHECK CONSTRAINT [FK_Program_Batch]
GO
ALTER TABLE [dbo].[Branch_Program]  WITH CHECK ADD  CONSTRAINT [FK_Branch_Program_Branch] FOREIGN KEY([Branch_ID])
REFERENCES [dbo].[Branch] ([Branch_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Branch_Program] CHECK CONSTRAINT [FK_Branch_Program_Branch]
GO
ALTER TABLE [dbo].[Branch_Program]  WITH CHECK ADD  CONSTRAINT [FK_Branch_Program_Program] FOREIGN KEY([Program_ID])
REFERENCES [dbo].[Program] ([Program_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Branch_Program] CHECK CONSTRAINT [FK_Branch_Program_Program]
GO
ALTER TABLE [dbo].[Choice_Text]  WITH CHECK ADD  CONSTRAINT [FK_Choice_Text_Choices] FOREIGN KEY([Choices_ID])
REFERENCES [dbo].[Choices] ([Choices_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Choice_Text] CHECK CONSTRAINT [FK_Choice_Text_Choices]
GO
ALTER TABLE [dbo].[Choices]  WITH CHECK ADD  CONSTRAINT [FK_Choices_Question] FOREIGN KEY([Question_ID])
REFERENCES [dbo].[Question] ([Question_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Choices] CHECK CONSTRAINT [FK_Choices_Question]
GO
ALTER TABLE [dbo].[Course]  WITH CHECK ADD  CONSTRAINT [FK_Course_Topic] FOREIGN KEY([Topic_ID])
REFERENCES [dbo].[Topic] ([Topic_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Course] CHECK CONSTRAINT [FK_Course_Topic]
GO
ALTER TABLE [dbo].[Course_Track]  WITH CHECK ADD FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Course_ID])
GO
ALTER TABLE [dbo].[Course_Track]  WITH CHECK ADD FOREIGN KEY([Track_ID])
REFERENCES [dbo].[Track] ([Track_ID])
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [FK_Exam_Branch] FOREIGN KEY([Branch_ID])
REFERENCES [dbo].[Branch] ([Branch_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [FK_Exam_Branch]
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [FK_Exam_Course] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Course_ID])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [FK_Exam_Course]
GO
ALTER TABLE [dbo].[Exam]  WITH CHECK ADD  CONSTRAINT [FK_Exam_Track] FOREIGN KEY([Track_ID])
REFERENCES [dbo].[Track] ([Track_ID])
GO
ALTER TABLE [dbo].[Exam] CHECK CONSTRAINT [FK_Exam_Track]
GO
ALTER TABLE [dbo].[Exam_Question]  WITH CHECK ADD  CONSTRAINT [FK_Exam_Question_Exam] FOREIGN KEY([Exam_ID])
REFERENCES [dbo].[Exam] ([Exam_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Exam_Question] CHECK CONSTRAINT [FK_Exam_Question_Exam]
GO
ALTER TABLE [dbo].[Exam_Question]  WITH CHECK ADD  CONSTRAINT [FK_Exam_Question_Question] FOREIGN KEY([Question_ID])
REFERENCES [dbo].[Question] ([Question_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Exam_Question] CHECK CONSTRAINT [FK_Exam_Question_Question]
GO
ALTER TABLE [dbo].[Instructor_Company]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_Company_Company] FOREIGN KEY([Company_ID])
REFERENCES [dbo].[Company] ([Company_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Instructor_Company] CHECK CONSTRAINT [FK_Instructor_Company_Company]
GO
ALTER TABLE [dbo].[Instructor_Company]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_Company_Instructor] FOREIGN KEY([Instructor_ID])
REFERENCES [dbo].[Instructor] ([Instructor_ID])
GO
ALTER TABLE [dbo].[Instructor_Company] CHECK CONSTRAINT [FK_Instructor_Company_Instructor]
GO
ALTER TABLE [dbo].[Instructor_Course]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_Course_Course] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Course_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Instructor_Course] CHECK CONSTRAINT [FK_Instructor_Course_Course]
GO
ALTER TABLE [dbo].[Instructor_Course]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_Course_Instructor] FOREIGN KEY([Instructor_ID])
REFERENCES [dbo].[Instructor] ([Instructor_ID])
GO
ALTER TABLE [dbo].[Instructor_Course] CHECK CONSTRAINT [FK_Instructor_Course_Instructor]
GO
ALTER TABLE [dbo].[Instructor_Exam_Question]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_Exam_Question_Exam] FOREIGN KEY([Exam_ID])
REFERENCES [dbo].[Exam] ([Exam_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Instructor_Exam_Question] CHECK CONSTRAINT [FK_Instructor_Exam_Question_Exam]
GO
ALTER TABLE [dbo].[Instructor_Exam_Question]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_Exam_Question_Instructor] FOREIGN KEY([Instructor_ID])
REFERENCES [dbo].[Instructor] ([Instructor_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Instructor_Exam_Question] CHECK CONSTRAINT [FK_Instructor_Exam_Question_Instructor]
GO
ALTER TABLE [dbo].[Instructor_Exam_Question]  WITH CHECK ADD  CONSTRAINT [FK_Instructor_Exam_Question_Question] FOREIGN KEY([Question_ID])
REFERENCES [dbo].[Question] ([Question_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Instructor_Exam_Question] CHECK CONSTRAINT [FK_Instructor_Exam_Question_Question]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Course] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Course_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_Course]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Batch] FOREIGN KEY([Batch_ID])
REFERENCES [dbo].[Batch] ([batch_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Batch]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Branch] FOREIGN KEY([Branch_ID])
REFERENCES [dbo].[Branch] ([Branch_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Branch]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_GraduationProject] FOREIGN KEY([GraduationProject_ID])
REFERENCES [dbo].[GraduationProject] ([GraduationProject_ID])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_GraduationProject]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Leader] FOREIGN KEY([Leader_ID])
REFERENCES [dbo].[Student] ([Student_ID])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Leader]
GO
ALTER TABLE [dbo].[Student]  WITH CHECK ADD  CONSTRAINT [FK_Student_Track] FOREIGN KEY([Track_ID])
REFERENCES [dbo].[Track] ([Track_ID])
GO
ALTER TABLE [dbo].[Student] CHECK CONSTRAINT [FK_Student_Track]
GO
ALTER TABLE [dbo].[Student_Certificate]  WITH CHECK ADD  CONSTRAINT [FK_Student_Certificate_Certificate] FOREIGN KEY([Certificate_ID])
REFERENCES [dbo].[Certificate] ([Certificate_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Student_Certificate] CHECK CONSTRAINT [FK_Student_Certificate_Certificate]
GO
ALTER TABLE [dbo].[Student_Certificate]  WITH CHECK ADD  CONSTRAINT [FK_Student_Certificate_Student] FOREIGN KEY([Student_ID])
REFERENCES [dbo].[Student] ([Student_ID])
GO
ALTER TABLE [dbo].[Student_Certificate] CHECK CONSTRAINT [FK_Student_Certificate_Student]
GO
ALTER TABLE [dbo].[Student_Company]  WITH CHECK ADD  CONSTRAINT [FK_Student_Company_Company] FOREIGN KEY([Company_ID])
REFERENCES [dbo].[Company] ([Company_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Student_Company] CHECK CONSTRAINT [FK_Student_Company_Company]
GO
ALTER TABLE [dbo].[Student_Company]  WITH CHECK ADD  CONSTRAINT [FK_Student_Company_Student] FOREIGN KEY([Student_ID])
REFERENCES [dbo].[Student] ([Student_ID])
GO
ALTER TABLE [dbo].[Student_Company] CHECK CONSTRAINT [FK_Student_Company_Student]
GO
ALTER TABLE [dbo].[Student_Course]  WITH CHECK ADD  CONSTRAINT [FK_Student_Course_Course] FOREIGN KEY([Course_ID])
REFERENCES [dbo].[Course] ([Course_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Student_Course] CHECK CONSTRAINT [FK_Student_Course_Course]
GO
ALTER TABLE [dbo].[Student_Course]  WITH CHECK ADD  CONSTRAINT [FK_Student_Course_Student] FOREIGN KEY([Student_ID])
REFERENCES [dbo].[Student] ([Student_ID])
GO
ALTER TABLE [dbo].[Student_Course] CHECK CONSTRAINT [FK_Student_Course_Student]
GO
ALTER TABLE [dbo].[Student_Exam]  WITH CHECK ADD  CONSTRAINT [FK_Student_Exam_Exam] FOREIGN KEY([Exam_ID])
REFERENCES [dbo].[Exam] ([Exam_ID])
GO
ALTER TABLE [dbo].[Student_Exam] CHECK CONSTRAINT [FK_Student_Exam_Exam]
GO
ALTER TABLE [dbo].[Student_Exam]  WITH CHECK ADD  CONSTRAINT [FK_Student_Exam_Student] FOREIGN KEY([Student_ID])
REFERENCES [dbo].[Student] ([Student_ID])
GO
ALTER TABLE [dbo].[Student_Exam] CHECK CONSTRAINT [FK_Student_Exam_Student]
GO
ALTER TABLE [dbo].[Student_Exam_Question]  WITH CHECK ADD  CONSTRAINT [FK_Student_Exam_Question_Exam] FOREIGN KEY([Exam_ID])
REFERENCES [dbo].[Exam] ([Exam_ID])
GO
ALTER TABLE [dbo].[Student_Exam_Question] CHECK CONSTRAINT [FK_Student_Exam_Question_Exam]
GO
ALTER TABLE [dbo].[Student_Exam_Question]  WITH CHECK ADD  CONSTRAINT [FK_Student_Exam_Question_Question] FOREIGN KEY([Question_ID])
REFERENCES [dbo].[Question] ([Question_ID])
GO
ALTER TABLE [dbo].[Student_Exam_Question] CHECK CONSTRAINT [FK_Student_Exam_Question_Question]
GO
ALTER TABLE [dbo].[Student_Exam_Question]  WITH CHECK ADD  CONSTRAINT [FK_Student_Exam_Question_Student] FOREIGN KEY([Student_ID])
REFERENCES [dbo].[Student] ([Student_ID])
GO
ALTER TABLE [dbo].[Student_Exam_Question] CHECK CONSTRAINT [FK_Student_Exam_Question_Student]
GO
ALTER TABLE [dbo].[Student_Freelance]  WITH CHECK ADD  CONSTRAINT [FK_Student_Freelance_Freelance] FOREIGN KEY([Freelance_ID])
REFERENCES [dbo].[Freelance] ([Freelance_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Student_Freelance] CHECK CONSTRAINT [FK_Student_Freelance_Freelance]
GO
ALTER TABLE [dbo].[Student_Freelance]  WITH CHECK ADD  CONSTRAINT [FK_Student_Freelance_Student] FOREIGN KEY([Student_ID])
REFERENCES [dbo].[Student] ([Student_ID])
GO
ALTER TABLE [dbo].[Student_Freelance] CHECK CONSTRAINT [FK_Student_Freelance_Student]
GO
ALTER TABLE [dbo].[Student_Instructor]  WITH CHECK ADD  CONSTRAINT [FK_Student_Instructor_Instructor] FOREIGN KEY([Instructor_ID])
REFERENCES [dbo].[Instructor] ([Instructor_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Student_Instructor] CHECK CONSTRAINT [FK_Student_Instructor_Instructor]
GO
ALTER TABLE [dbo].[Student_Instructor]  WITH CHECK ADD  CONSTRAINT [FK_Student_Instructor_Student] FOREIGN KEY([Student_ID])
REFERENCES [dbo].[Student] ([Student_ID])
GO
ALTER TABLE [dbo].[Student_Instructor] CHECK CONSTRAINT [FK_Student_Instructor_Student]
GO
ALTER TABLE [dbo].[Track]  WITH CHECK ADD  CONSTRAINT [FK_Track_Instructor] FOREIGN KEY([Instructor_ID])
REFERENCES [dbo].[Instructor] ([Instructor_ID])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Track] CHECK CONSTRAINT [FK_Track_Instructor]
GO
ALTER TABLE [dbo].[Track]  WITH CHECK ADD  CONSTRAINT [FK_Track_Program] FOREIGN KEY([Program_ID])
REFERENCES [dbo].[Program] ([Program_ID])
GO
ALTER TABLE [dbo].[Track] CHECK CONSTRAINT [FK_Track_Program]
GO
/****** Object:  StoredProcedure [dbo].[AddQuestion]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- AddQuestion - Add question to exam
-- =============================================
CREATE   PROCEDURE [dbo].[AddQuestion]
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
/****** Object:  StoredProcedure [dbo].[AuthenticateUser]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[AuthenticateUser] @username NVARCHAR(100) AS BEGIN SET NOCOUNT ON; SELECT SSN, Username, Email, Role, Password AS StoredHash FROM Users WHERE Username = @username; END
GO
/****** Object:  StoredProcedure [dbo].[ChangePassword]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- ChangePassword - Change user password
-- =============================================
CREATE   PROCEDURE [dbo].[ChangePassword]
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
/****** Object:  StoredProcedure [dbo].[CreateExam]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- CreateExam - Create a new exam
-- =============================================
CREATE   PROCEDURE [dbo].[CreateExam]
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
/****** Object:  StoredProcedure [dbo].[ExamAnswer]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- ExamAnswer - Save student answer and calculate points (Fixed)
-- =============================================
CREATE   PROCEDURE [dbo].[ExamAnswer]
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
    
    -- Get the question mark
    SELECT @QuestionMark = Question_Mark FROM Question WHERE Question_ID = @Question_ID;
    
    -- Check if answer is correct
    IF @Student_Answer = (
        SELECT c.right_choice
        FROM Question q 
        INNER JOIN Choices c ON q.Question_ID = c.Question_ID
        WHERE q.Question_ID = @Question_ID
    )
        SET @ChoicePoint = @QuestionMark;
    
    -- Insert or update student answer
    IF EXISTS (
        SELECT 1 FROM Student_Exam_Question 
        WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID AND Question_ID = @Question_ID
    )
    BEGIN
        UPDATE Student_Exam_Question 
        SET ST_answer = @Student_Answer, Point_Awarded = @ChoicePoint
        WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID AND Question_ID = @Question_ID;
    END
    ELSE
    BEGIN
        -- Get the next available ID
        SELECT @NextID = ISNULL(MAX(Student_Exam_Question_ID), 0) + 1 FROM Student_Exam_Question;
        
        INSERT INTO Student_Exam_Question (Student_Exam_Question_ID, Student_ID, Exam_ID, Question_ID, ST_answer, Point_Awarded)
        VALUES (@NextID, @Student_ID, @Exam_ID, @Question_ID, @Student_Answer, @ChoicePoint);
    END
END

GO
/****** Object:  StoredProcedure [dbo].[ExamCorrection]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- ExamCorrection - Calculate total grade and update pass/fail status (Enhanced)
-- =============================================
CREATE   PROCEDURE [dbo].[ExamCorrection]
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
        PRINT 'No answers found for student';
        SELECT 0 AS Success, 'Student has not answered any questions' AS Message;
        RETURN;
    END
    
    -- Calculate total grade from answered questions
    SELECT @TotalGrade = ISNULL(SUM(Point_Awarded), 0)
    FROM Student_Exam_Question
    WHERE Student_ID = @Student_ID AND Exam_ID = @Exam_ID;
    
    PRINT 'Total grade calculated: ' + CAST(@TotalGrade AS VARCHAR);
    
    -- Get total exam marks
    SELECT @TotalMarks = Exam_Total_Marks
    FROM Exam
    WHERE Exam_ID = @Exam_ID;
    
    PRINT 'Total exam marks: ' + CAST(@TotalMarks AS VARCHAR);
    
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
/****** Object:  StoredProcedure [dbo].[GenerateExam]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GenerateExam]
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
/****** Object:  StoredProcedure [dbo].[GetAllExams]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- GetAllExams - Get all exams
-- =============================================
CREATE   PROCEDURE [dbo].[GetAllExams]
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
/****** Object:  StoredProcedure [dbo].[getCoursesGrade]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Calling
--GetStudentInfoAndTrack
-------------------------------------------------
--2--
CREATE   PROCEDURE [dbo].[getCoursesGrade] @Student_ID INT
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
/****** Object:  StoredProcedure [dbo].[GetExamById]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- GetExamById - Get exam by ID
-- =============================================
CREATE   PROCEDURE [dbo].[GetExamById]
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
/****** Object:  StoredProcedure [dbo].[GetExamQuestions]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- GetExamQuestions - Get questions for an exam (Updated)
-- =============================================
CREATE   PROCEDURE [dbo].[GetExamQuestions]
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
/****** Object:  StoredProcedure [dbo].[GetExamResults]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- GetExamResults - Get all results for an exam (instructor only)
-- =============================================
CREATE   PROCEDURE [dbo].[GetExamResults]
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
/****** Object:  StoredProcedure [dbo].[GetInstructorExamsStats]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetInstructorExamsStats]
    @instructorId INT
AS
BEGIN
    -- Exams where this instructor is the only instructor
    WITH InstructorExams AS (
        SELECT ieq.Exam_ID
        FROM Instructor_Exam_Question ieq
        GROUP BY ieq.Exam_ID
        HAVING COUNT(DISTINCT ieq.Instructor_ID) = 1
           AND MAX(ieq.Instructor_ID) = @instructorId
    )
    SELECT
        (SELECT COUNT(*) FROM InstructorExams) AS total_exams,

        (SELECT COUNT(*)
         FROM InstructorExams ie
         JOIN Exam e ON ie.Exam_ID = e.Exam_ID
         WHERE e.Exam_End_date > GETDATE()
        ) AS active_exams,

        (SELECT COUNT(DISTINCT se.Student_ID)
         FROM InstructorExams ie
         JOIN Student_Exam se ON ie.Exam_ID = se.Exam_ID
        ) AS total_students
END
GO
/****** Object:  StoredProcedure [dbo].[GetNumOfStudentsPerCourse]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Calling
--getCoursesGrade 8
-------------------------------------------------
--3--
CREATE   PROCEDURE [dbo].[GetNumOfStudentsPerCourse] @Instructor_ID INT 
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
/****** Object:  StoredProcedure [dbo].[GetQandCperExam]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Calling
--GetTopics 6
-------------------------------------------------
--5--
CREATE   PROCEDURE [dbo].[GetQandCperExam] @Exam_ID INT
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
/****** Object:  StoredProcedure [dbo].[GetQandStudentAnswers]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Calling
--GetQandCperExam 2
-------------------------------------------------
--6--
CREATE   PROCEDURE [dbo].[GetQandStudentAnswers] @Student_ID INT, @Exam_ID INT 
AS 
BEGIN 
	SELECT seq.Student_ID, s.Fname+' '+s.Lname as Fullname, q.Question_Text, seq.ST_answer
	FROM Student_Exam_Question seq
	INNER JOIN Question	q ON seq.Question_ID=q.Question_ID
	INNER JOIN Student s ON s.Student_ID=seq.Student_ID
	WHERE seq.Student_ID=@Student_ID and seq.Exam_ID=@Exam_ID
END 
GO
/****** Object:  StoredProcedure [dbo].[GetStudentDashboardStats]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[GetStudentDashboardStats]
    @studentId INT
AS
BEGIN
    SELECT
        (SELECT COUNT(*) FROM Student_Exam WHERE Student_ID = @studentId) AS total_exams_taken,
        (SELECT ISNULL(AVG(CAST(Exam_Grade AS FLOAT)), 0) FROM Student_Exam WHERE Student_ID = @studentId) AS average_score,
        (SELECT COUNT(*)
         FROM Exam e
         WHERE e.Exam_End_date > GETDATE()
           AND e.Exam_ID NOT IN (SELECT Exam_ID FROM Student_Exam WHERE Student_ID = @studentId)
        ) AS available_exams
END
GO
/****** Object:  StoredProcedure [dbo].[GetStudentInfoAndTrack]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---------------------------------------------------------------------------------------------------
-------------The 6 Stored Procedures-------------
-------------------------------------------------
--1--
CREATE   PROCEDURE [dbo].[GetStudentInfoAndTrack]
AS 
BEGIN
	SELECT s.*, t.Track_Name FROM Student s INNER JOIN Track t ON s.Track_ID = t.Track_ID
END
GO
/****** Object:  StoredProcedure [dbo].[GetTopics]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Calling
--GetNumOfStudentsPerCourse 32
-------------------------------------------------
--4--
CREATE   PROCEDURE [dbo].[GetTopics] @Course_ID INT 
AS 
BEGIN 
	SELECT c.Course_Name, t.Topic_Name FROM Course c INNER JOIN Topic t ON c.Topic_ID=t.Topic_ID WHERE c.Course_ID=@Course_ID
END 
GO
/****** Object:  StoredProcedure [dbo].[GetUserProfile]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetUserProfile] @username NVARCHAR(100) AS BEGIN SET NOCOUNT ON; SELECT SSN as userId, Username, Email, Role FROM Users WHERE Username = @username; END
GO
/****** Object:  StoredProcedure [dbo].[GetUserResults]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- GetUserResults - Get user's exam results
-- =============================================
CREATE   PROCEDURE [dbo].[GetUserResults]
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
/****** Object:  StoredProcedure [dbo].[isCourseListedForAllCoursesAllStudents]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Calling
---ExamCorrection 6, 21
-------------------------------------------------
CREATE   PROCEDURE [dbo].[isCourseListedForAllCoursesAllStudents]
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
	)
END
GO
/****** Object:  StoredProcedure [dbo].[RegenerateExamQuestions]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[RegenerateExamQuestions]
  @Exam_ID INT,
  @NumOfMCQ INT,
  @NumOfTF INT
AS
BEGIN
  DECLARE @Course_ID INT;
  DECLARE @TotalMarks INT;

  -- Get the course for this exam
  SELECT @Course_ID = Course_ID FROM Exam WHERE Exam_ID = @Exam_ID;

  -- Delete old questions
  DELETE FROM Exam_Question WHERE Exam_ID = @Exam_ID;

  -- Select new questions
  WITH first_CTE AS (
    SELECT TOP(@NumOfMCQ) q.Question_ID, q.Question_Mark
    FROM Question q
    WHERE q.Course_ID = @Course_ID AND q.type = 'MCQ'
    ORDER BY NEWID()
    UNION ALL
    SELECT TOP(@NumOfTF) q.Question_ID, q.Question_Mark
    FROM Question q
    WHERE q.Course_ID = @Course_ID AND q.type = 'True/False'
    ORDER BY NEWID()
  )
  SELECT * INTO #TempQuestions FROM first_CTE;

  -- Insert new questions
  INSERT INTO Exam_Question (Exam_ID, Question_ID)
  SELECT @Exam_ID, Question_ID FROM #TempQuestions;

  -- Update total marks
  SET @TotalMarks = (SELECT ISNULL(SUM(CAST(Question_Mark AS INT)), 0) FROM #TempQuestions);
  UPDATE Exam SET Exam_Total_Marks = @TotalMarks WHERE Exam_ID = @Exam_ID;

  DROP TABLE #TempQuestions;
END
GO
/****** Object:  StoredProcedure [dbo].[RegisterUser]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- RegisterUser - Register a new user
-- =============================================
CREATE   PROCEDURE [dbo].[RegisterUser]
    @username NVARCHAR(50),
    @email NVARCHAR(100),
    @password NVARCHAR(255),
    @role NVARCHAR(20),
    @fullName NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Success BIT = 0;
    DECLARE @Message NVARCHAR(255) = '';
    DECLARE @UserId INT = 0;
    
    BEGIN TRY
        -- Check if username already exists
        IF EXISTS (SELECT 1 FROM Users WHERE Username = @username)
        BEGIN
            SET @Success = 0;
            SET @Message = 'Username already exists';
        END
        -- Check if email already exists
        ELSE IF EXISTS (SELECT 1 FROM Users WHERE Email = @email)
        BEGIN
            SET @Success = 0;
            SET @Message = 'Email already exists';
        END
        ELSE
        BEGIN
            -- Insert new user
            INSERT INTO Users (Username, Email, Password, Role, FullName, CreatedAt)
            VALUES (@username, @email, @password, @role, @fullName, GETDATE());
            
            SET @UserId = SCOPE_IDENTITY();
            SET @Success = 1;
            SET @Message = 'User registered successfully';
        END
    END TRY
    BEGIN CATCH
        SET @Success = 0;
        SET @Message = ERROR_MESSAGE();
    END CATCH
    
    -- Return result
    SELECT @Success AS Success, @Message AS Message, @UserId AS UserId;
END
GO
/****** Object:  StoredProcedure [dbo].[report 1]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[report 1]
    @TrackID INT
AS 
BEGIN
    SELECT s.*, 
           t.Track_Name, 
           b.batch_name, 
           br.branch_name,
           gp.GraduationProject_Name
    FROM Student s
    INNER JOIN Track t ON s.Track_ID = t.Track_ID
    INNER JOIN Batch b ON s.Batch_ID = b.Batch_ID
    INNER JOIN Branch br ON s.Branch_ID = br.Branch_ID
    LEFT JOIN GraduationProject gp ON s.GraduationProject_ID = gp.GraduationProject_ID
    WHERE s.Track_ID = @TrackID
      AND s.status = 'student'
END
GO
/****** Object:  StoredProcedure [dbo].[report_1]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[report_1]
    @TrackID INT
AS 
BEGIN
    SELECT s.*, 
           t.Track_Name, 
           b.batch_name, 
           br.branch_name,
           gp.GraduationProject_Name
    FROM Student s
    INNER JOIN Track t ON s.Track_ID = t.Track_ID
    INNER JOIN Batch b ON s.Batch_ID = b.Batch_ID
    INNER JOIN Branch br ON s.Branch_ID = br.Branch_ID
    LEFT JOIN GraduationProject gp ON s.GraduationProject_ID = gp.GraduationProject_ID
    WHERE s.Track_ID = @TrackID
      AND s.status = 'student'
END
GO
/****** Object:  StoredProcedure [dbo].[report_6]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[report_6]
    @Student_ID INT,
    @Exam_ID INT 
AS 
BEGIN 
    SELECT 
        s.Student_ID,
        s.Fname + ' ' + s.Lname AS FullName,
        e.Exam_ID,
        e.Exam_Name,
        q.Question_ID,
        q.Question_Text,
        q.Question_Mark,
        seq.Point_Awarded,
        seq.ST_answer AS StudentAnswer
    FROM  Student_Exam_Question seq
    INNER JOIN Question q ON seq.Question_ID = q.Question_ID
    INNER JOIN Student s ON s.Student_ID = seq.Student_ID
    INNER JOIN Exam e ON seq.Exam_ID = e.Exam_ID
    WHERE seq.Student_ID = @Student_ID 
      AND seq.Exam_ID = @Exam_ID
    ORDER BY q.Question_ID
END


GO
/****** Object:  StoredProcedure [dbo].[report_66666666]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[report_66666666]
    @Student_ID INT,
    @Exam_ID INT 
AS 
BEGIN 
    SELECT 
        s.Student_ID,
        s.Fname + ' ' + s.Lname AS FullName,
        e.Exam_ID,
        e.Exam_Name,
        q.Question_ID,
        q.Question_Text,
        q.Question_Mark,
        seq.Point_Awarded,
        c.course_name,
        seq.ST_answer AS StudentAnswer
    FROM Student_Exam_Question seq
    INNER JOIN Question q ON seq.Question_ID = q.Question_ID
    INNER JOIN Student s ON s.Student_ID = seq.Student_ID
    INNER JOIN Exam e ON seq.Exam_ID = e.Exam_ID
    INNER JOIN Exam_Course ec ON ec.Exam_ID = e.Exam_ID
    INNER JOIN Course c ON c.Course_ID = ec.Course_ID
    WHERE seq.Student_ID = @Student_ID 
      AND seq.Exam_ID = @Exam_ID
    ORDER BY q.Question_ID
END
GO
/****** Object:  StoredProcedure [dbo].[report3]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[report3]
 @Instructor_ID INT
AS 
BEGIN
    SELECT 
        c.Course_Name AS [Course Name], i.Fname+' '+i.Lname as Fullname,
        COUNT(s.Student_ID) AS [Number of Students]
    FROM 
        Student s
    INNER JOIN Student_Course sc
        ON sc.Student_ID=s.Student_ID
    INNER JOIN Course c 
        ON c.Course_ID = sc.Course_ID
	INNER JOIN Instructor_Course ic
		on c.Course_ID = ic.Course_ID
	INNER JOIN Instructor i
		on i.Instructor_ID = ic.Instructor_ID
	 WHERE 
        i.Instructor_ID = @Instructor_ID
    GROUP BY 
        c.Course_Name,
		i.Fname+' '+i.Lname
END
GO
/****** Object:  StoredProcedure [dbo].[report33333333]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[report33333333]
    @Instructor_ID INT 
AS 
BEGIN
    SELECT 
        i.Fname + ' ' + i.Lname AS Fullname, 
        c.Course_Name AS [Course Name], 
        COUNT(DISTINCT si.Student_ID) AS [Number of Students]
    FROM 
        Instructor i
    INNER JOIN Instructor_Course ic 
        ON i.Instructor_ID = ic.Instructor_ID
    INNER JOIN Course c 
        ON ic.Course_ID = c.Course_ID
    INNER JOIN Student_Instructor si 
        ON si.Instructor_ID = i.Instructor_ID 
        AND si.Instructor_ID = ic.Instructor_ID  -- هذا هو المفتاح لحل المشكلة
    WHERE 
        i.Instructor_ID = @Instructor_ID
    GROUP BY 
        i.Fname + ' ' + i.Lname, 
        c.Course_Name
END
GO
/****** Object:  StoredProcedure [dbo].[report6]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[report6]
    @Student_ID INT,
    @Exam_ID INT 
AS 
BEGIN 
    SELECT 
        s.Student_ID,
        s.Fname + ' ' + s.Lname AS FullName,
        e.Exam_ID,
        e.Exam_Name,
        q.Question_ID,
        q.Question_Text,
        q.Question_Mark,
		seq.Point_Awarded,
        seq.ST_answer AS StudentAnswer
    FROM  Student_Exam_Question seq
    INNER JOIN Question q ON seq.Question_ID = q.Question_ID
    INNER JOIN Student s ON s.Student_ID = seq.Student_ID
    INNER JOIN Exam e ON seq.Exam_ID = e.Exam_ID
    LEFT JOIN Choices ch ON q.Question_ID = ch.Question_ID

    WHERE seq.Student_ID = @Student_ID 
      AND seq.Exam_ID = @Exam_ID
    ORDER BY q.Question_ID, ch.Choices_ID
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Batch]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a Batch
CREATE   PROCEDURE [dbo].[sp_Delete_Batch] @Batch_ID INT
AS
BEGIN TRY
    DELETE FROM Batch WHERE Batch_ID = @Batch_ID;
END TRY
BEGIN CATCH
    SELECT 'Batch Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Branch]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a Branch
CREATE   PROCEDURE [dbo].[sp_Delete_Branch] @Branch_ID INT
AS
BEGIN TRY
    DELETE FROM Branch WHERE Branch_ID = @Branch_ID;
END TRY
BEGIN CATCH
    SELECT 'Branch Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Certificate]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a Certificate
CREATE   PROCEDURE [dbo].[sp_Delete_Certificate] @Certificate_ID INT
AS
BEGIN TRY
    DELETE FROM Certificate WHERE Certificate_ID = @Certificate_ID;
END TRY
BEGIN CATCH
    SELECT 'Certificate Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Choice_Text]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a Choice_Text
CREATE   PROCEDURE [dbo].[sp_Delete_Choice_Text] @Choices_ID INT
AS
BEGIN TRY
    DELETE FROM Choice_Text WHERE Choices_ID = @Choices_ID;
END TRY
BEGIN CATCH
    SELECT 'Choice_Text Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Choices]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a Choices
CREATE   PROCEDURE [dbo].[sp_Delete_Choices] @Choices_ID INT  
AS
BEGIN TRY
    DELETE FROM Choices WHERE Choices_ID = @Choices_ID;
END TRY
BEGIN CATCH
    SELECT 'Choices Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Company]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a Company
CREATE   PROCEDURE [dbo].[sp_Delete_Company] @Company_ID INT
AS
BEGIN TRY
    DELETE FROM Company WHERE Company_ID = @Company_ID;
END TRY
BEGIN CATCH
    SELECT 'Company Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Course]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a Course

CREATE   PROCEDURE [dbo].[sp_Delete_Course] @Course_ID INT
AS
BEGIN TRY
    DELETE FROM Course WHERE Course_ID = @Course_ID;
END TRY
BEGIN CATCH
    SELECT 'Course Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Exam]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Delete_Exam]
    @Exam_ID INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Delete from child tables first
        DELETE FROM Student_Exam_Question WHERE Exam_ID = @Exam_ID;
        DELETE FROM Student_Exam WHERE Exam_ID = @Exam_ID;
        DELETE FROM Exam_Question WHERE Exam_ID = @Exam_ID;
        DELETE FROM ExamSessions WHERE ExamId = @Exam_ID;
        -- Add more DELETEs here if you have other related tables

        -- Finally, delete the exam itself
        DELETE FROM Exam WHERE Exam_ID = @Exam_ID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        SELECT 'Exam Is Not Exists or Could Not Be Deleted' AS ErrorMessage;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Freelance]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a Freelance
CREATE   PROCEDURE [dbo].[sp_Delete_Freelance] @Freelance_ID INT
AS
BEGIN TRY
    DELETE FROM Freelance WHERE Freelance_ID = @Freelance_ID;
END TRY 
BEGIN CATCH
    SELECT 'Freelance Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_GraduationProject]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a GraduationProject
CREATE   PROCEDURE [dbo].[sp_Delete_GraduationProject] @GraduationProject_ID INT
AS
BEGIN TRY
    DELETE FROM GraduationProject WHERE GraduationProject_ID = @GraduationProject_ID;
END TRY
BEGIN CATCH
    SELECT 'GraduationProject Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Instructor]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete an Instructor
CREATE   PROCEDURE [dbo].[sp_Delete_Instructor] @Instructor_ID INT
AS
BEGIN TRY
    DELETE FROM Instructor WHERE Instructor_ID = @Instructor_ID;
END TRY
BEGIN CATCH
    SELECT 'Instructor Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Instructor_Company]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a Instructor_Company

CREATE   PROCEDURE [dbo].[sp_Delete_Instructor_Company] @Instructor_ID INT
AS
BEGIN TRY
    DELETE FROM Instructor_Company WHERE Instructor_ID = @Instructor_ID;
END TRY
BEGIN CATCH
    SELECT 'Instructor_Company Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Program]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a Program
CREATE   PROCEDURE [dbo].[sp_Delete_Program] @Program_ID INT
AS
BEGIN TRY
    DELETE FROM Program WHERE Program_ID = @Program_ID;
END TRY
BEGIN CATCH
    SELECT 'Program Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Question]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a Question
CREATE   PROCEDURE [dbo].[sp_Delete_Question] @Question_ID INT
AS
BEGIN TRY
    DELETE FROM Question WHERE Question_ID = @Question_ID;
END TRY
BEGIN CATCH
    SELECT 'Question Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Student]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a Student
CREATE   PROCEDURE [dbo].[sp_Delete_Student] @Student_ID INT
AS
BEGIN TRY
    DELETE FROM Student WHERE Student_ID = @Student_ID;
END TRY
BEGIN CATCH 
    SELECT 'Student Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Student_Company]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a Student_Company
CREATE   PROCEDURE [dbo].[sp_Delete_Student_Company] @Student_ID INT
AS
BEGIN TRY
    DELETE FROM Student_Company WHERE Student_ID = @Student_ID;
END TRY
BEGIN CATCH
    SELECT 'Student_Company Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Student_Exam]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a Exam_Student
CREATE   PROCEDURE [dbo].[sp_Delete_Student_Exam] @Student_ID INT
AS
BEGIN TRY
    DELETE FROM Student_Exam WHERE Student_ID = @Student_ID;
END TRY
BEGIN CATCH
    SELECT 'Exam_Student Is Not Exists' AS ErrorMessage;
END CATCH;  
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Student_Exam_Question]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a Student_Exam_Question
CREATE   PROCEDURE [dbo].[sp_Delete_Student_Exam_Question] @Student_Exam_Question_ID INT
AS
BEGIN TRY
    DELETE FROM Student_Exam_Question WHERE Student_Exam_Question_ID = @Student_Exam_Question_ID;
END TRY
BEGIN CATCH
    SELECT 'Student_Exam_Question Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Topic]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a Topic
CREATE   PROCEDURE [dbo].[sp_Delete_Topic] @Topic_ID INT
AS
BEGIN TRY
    DELETE FROM Topic WHERE Topic_ID = @Topic_ID;
END TRY
BEGIN CATCH
    SELECT 'Topic Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Delete_Track]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Delete a Track
CREATE   PROCEDURE [dbo].[sp_Delete_Track] @Track_ID INT
AS
BEGIN TRY
    DELETE FROM Track WHERE Track_ID = @Track_ID;
END TRY
BEGIN CATCH
    SELECT 'Track Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_Batch]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Batch
CREATE   PROCEDURE [dbo].[sp_Insert_Batch]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Branch]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Branch
CREATE   PROCEDURE [dbo].[sp_Insert_Branch]
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
    INSERT INTO Branch (Branch_ID, Branch_Name, Branch_Email, Branch_phone, Branch_location, Manager_ID, Manager_Name, Manager_SSN, Manager_Email, Manager_Phone, Manager_Gender, Manager_DOB)
    VALUES (((SELECT MAX(Branch_ID) FROM Branch)+1), @Branch_Name, @Branch_Email, @Branch_phone, @Branch_location, @Manager_ID, @Manager_Name, @Manager_SSN, @Manager_Email, @Manager_Phone, @Manager_Gender, @Manager_DOB);
END TRY
BEGIN CATCH
    SELECT 'Branch Is Already Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Insert_Certificate]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Certificate 
CREATE   PROCEDURE [dbo].[sp_Insert_Certificate]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Choice_Text]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Choice_Text
CREATE   PROCEDURE [dbo].[sp_Insert_Choice_Text]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Choices]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Choices
CREATE   PROCEDURE [dbo].[sp_Insert_Choices]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Company]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Company
CREATE   PROCEDURE [dbo].[sp_Insert_Company]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Course]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Course  
CREATE   PROCEDURE [dbo].[sp_Insert_Course]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Exam]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_Insert_Exam]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Freelance]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Freelance
CREATE   PROCEDURE [dbo].[sp_Insert_Freelance]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_GraduationProject]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new GraduationProject
CREATE   PROCEDURE [dbo].[sp_Insert_GraduationProject]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Instructor]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Instructor
CREATE   PROCEDURE [dbo].[sp_Insert_Instructor]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Instructor_Company]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Instructor_Company
CREATE   PROCEDURE [dbo].[sp_Insert_Instructor_Company]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Program]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Program
CREATE   PROCEDURE [dbo].[sp_Insert_Program]  
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Question]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Question
CREATE   PROCEDURE [dbo].[sp_Insert_Question]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Student]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Student
CREATE   PROCEDURE [dbo].[sp_Insert_Student]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Student_Company]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Student_Company
CREATE   PROCEDURE [dbo].[sp_Insert_Student_Company]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Student_Exam]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Exam_Student
CREATE   PROCEDURE [dbo].[sp_Insert_Student_Exam]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Student_Exam_Question]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Student_Exam_Question
CREATE   PROCEDURE [dbo].[sp_Insert_Student_Exam_Question]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Topic]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Topic
CREATE   PROCEDURE [dbo].[sp_Insert_Topic]
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
/****** Object:  StoredProcedure [dbo].[sp_Insert_Track]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Insert a new Track
CREATE   PROCEDURE [dbo].[sp_Insert_Track]
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
/****** Object:  StoredProcedure [dbo].[sp_Select_Batch]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for Batch Table

-- Select all Batches
CREATE   PROCEDURE [dbo].[sp_Select_Batch] @Batch_ID INT
AS
BEGIN TRY
    SELECT * FROM Batch WHERE Batch_ID = @Batch_ID;
END TRY
BEGIN CATCH
    SELECT 'Batch Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Branch]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Stored Procedures for Branch Table

-- Select all Branches
CREATE   PROCEDURE [dbo].[sp_Select_Branch] @Branch_ID INT
AS
BEGIN TRY
    SELECT * FROM Branch WHERE Branch_ID = @Branch_ID;
END TRY
BEGIN CATCH
    SELECT 'Branch Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Certificate]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for Certificate Table

-- Select all Certificates
CREATE   PROCEDURE [dbo].[sp_Select_Certificate] @Certificate_ID INT
AS
BEGIN TRY
    SELECT * FROM Certificate WHERE Certificate_ID = @Certificate_ID;
END TRY
BEGIN CATCH
    SELECT 'Certificate Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Choice_Text]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for choice_text Table

-- Select all choice_texts
CREATE   PROCEDURE [dbo].[sp_Select_Choice_Text] @Choices_ID INT
AS
BEGIN TRY
    SELECT * FROM Choice_Text WHERE Choices_ID = @Choices_ID;
END TRY
BEGIN CATCH
    SELECT 'Choice_Text Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Choices]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for Choices Table

-- Select all Choices
CREATE   PROCEDURE [dbo].[sp_Select_Choices] @Choices_ID INT
AS
BEGIN TRY
    SELECT * FROM Choices WHERE Choices_ID = @Choices_ID;
END TRY
BEGIN CATCH
    SELECT 'Choices Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Company]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for Company Table

-- Select all Companies
CREATE   PROCEDURE [dbo].[sp_Select_Company] @Company_ID INT
AS
BEGIN TRY
    SELECT * FROM Company WHERE Company_ID = @Company_ID;
END TRY
BEGIN CATCH
    SELECT 'Company Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Course]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for Course Table

-- Select all Courses
CREATE   PROCEDURE [dbo].[sp_Select_Course] @Course_ID INT
AS
BEGIN TRY
    SELECT * FROM Course WHERE Course_ID = @Course_ID;
END TRY
BEGIN CATCH
    SELECT 'Course Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Exam]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for Exam Table

-- Select all Exams
CREATE   PROCEDURE [dbo].[sp_Select_Exam] @Exam_ID INT
AS
BEGIN TRY
    SELECT * FROM Exam WHERE Exam_ID = @Exam_ID;
END TRY
BEGIN CATCH
    SELECT 'Exam Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Freelance]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for Freelance Table

-- Select all Freelances
CREATE   PROCEDURE [dbo].[sp_Select_Freelance] @Freelance_ID INT
AS
BEGIN TRY
    SELECT * FROM Freelance WHERE Freelance_ID = @Freelance_ID;
END TRY
BEGIN CATCH
    SELECT 'Freelance Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_GraduationProject]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for GraduationProject Table

-- Select all GraduationProjects
CREATE   PROCEDURE [dbo].[sp_Select_GraduationProject] @GraduationProject_ID INT
AS
BEGIN TRY
    SELECT * FROM GraduationProject WHERE GraduationProject_ID = @GraduationProject_ID;
END TRY
BEGIN CATCH
    SELECT 'GraduationProject Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Instructor]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for Instructor Table

-- Select all Instructors
CREATE   PROCEDURE [dbo].[sp_Select_Instructor] @Instructor_ID INT
AS
BEGIN TRY
    SELECT * FROM Instructor WHERE Instructor_ID = @Instructor_ID;
END TRY
BEGIN CATCH
    SELECT 'Instructor Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Instructor_Company]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for Instructor_Company Table

-- Select all Instructor_Companies
CREATE   PROCEDURE [dbo].[sp_Select_Instructor_Company] @Instructor_ID INT, @Company_ID INT
AS
BEGIN TRY
    SELECT * FROM Instructor_Company WHERE Instructor_ID = @Instructor_ID AND Company_ID = @Company_ID;
END TRY
BEGIN CATCH
    SELECT 'Instructor_Company Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Program]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for Program Table

-- Select all Programs
CREATE   PROCEDURE [dbo].[sp_Select_Program] @Program_ID int 
AS
BEGIN TRY
    SELECT * FROM Program WHERE Program_ID = @Program_ID;
END TRY
BEGIN CATCH
    SELECT 'Program Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Question]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for Question Table 

-- Select all Questions
CREATE   PROCEDURE [dbo].[sp_Select_Question] @Question_ID INT
AS
BEGIN TRY
    SELECT * FROM Question WHERE Question_ID = @Question_ID;
END TRY
BEGIN CATCH
    SELECT 'Question Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Student]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for Student Table

-- Select all Students
CREATE   PROCEDURE [dbo].[sp_Select_Student] @Student_ID INT
AS
BEGIN TRY
    SELECT * FROM Student WHERE Student_ID = @Student_ID;
END TRY
BEGIN CATCH
    SELECT 'Student Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Student_Company]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for Student_Company Table

-- Select all Student_Companies
CREATE   PROCEDURE [dbo].[sp_Select_Student_Company] @Student_ID INT, @Company_ID INT
AS
BEGIN TRY
    SELECT * FROM Student_Company WHERE Student_ID = @Student_ID AND Company_ID = @Company_ID;
END TRY
BEGIN CATCH
    SELECT 'Student_Company Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Student_Exam]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for student_exam Table

-- Select all student_exams
CREATE   PROCEDURE [dbo].[sp_Select_Student_Exam] @Student_ID INT
AS
BEGIN TRY
    SELECT * FROM Student_Exam WHERE Student_ID = @Student_ID;
END TRY
BEGIN CATCH
    SELECT 'Exam_Student Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Student_Exam_Question]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for student_exam_question Table

-- Select all student_exam_questions
CREATE   PROCEDURE [dbo].[sp_Select_Student_Exam_Question] @Student_Exam_Question_ID INT
AS
BEGIN TRY
    SELECT * FROM Student_Exam_Question WHERE Student_Exam_Question_ID = @Student_Exam_Question_ID;
END TRY
BEGIN CATCH
    SELECT 'Student_Exam_Question Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Topic]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for Topic Table

-- Select all Topics
CREATE   PROCEDURE [dbo].[sp_Select_Topic] @Topic_ID INT
AS
BEGIN TRY
    SELECT * FROM Topic WHERE Topic_ID = @Topic_ID;
END TRY
BEGIN CATCH
    SELECT 'Topic Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Select_Track]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedures for Track Table

-- Select all Tracks
CREATE   PROCEDURE [dbo].[sp_Select_Track] @Track_ID INT
AS
BEGIN TRY
    SELECT * FROM Track WHERE Track_ID = @Track_ID;
END TRY
BEGIN CATCH
    SELECT 'Track Is Not Exists' AS ErrorMessage;
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_Batch]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Batch
CREATE   PROCEDURE [dbo].[sp_Update_Batch]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Branch]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Branch
CREATE   PROCEDURE [dbo].[sp_Update_Branch]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Certificate]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Certificate

CREATE   PROCEDURE [dbo].[sp_Update_Certificate]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Choice_Text]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Choice_Text
CREATE   PROCEDURE [dbo].[sp_Update_Choice_Text]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Choices]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Choices
CREATE   PROCEDURE [dbo].[sp_Update_Choices]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Company]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Company
CREATE   PROCEDURE [dbo].[sp_Update_Company]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Course]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Course
CREATE   PROCEDURE [dbo].[sp_Update_Course]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Exam]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Exam
CREATE   PROCEDURE [dbo].[sp_Update_Exam]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Freelance]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Freelance
CREATE   PROCEDURE [dbo].[sp_Update_Freelance]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_GraduationProject]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing GraduationProject
CREATE   PROCEDURE [dbo].[sp_Update_GraduationProject]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Instructor]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Instructor
CREATE   PROCEDURE [dbo].[sp_Update_Instructor]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Instructor_Company]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Instructor_Company
CREATE   PROCEDURE [dbo].[sp_Update_Instructor_Company]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Program]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Program
CREATE   PROCEDURE [dbo].[sp_Update_Program]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Question]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Question
CREATE   PROCEDURE [dbo].[sp_Update_Question]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Student]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Student
CREATE   PROCEDURE [dbo].[sp_Update_Student]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Student_Company]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Student_Company
CREATE   PROCEDURE [dbo].[sp_Update_Student_Company]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Student_Exam]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Exam_Student
CREATE   PROCEDURE [dbo].[sp_Update_Student_Exam]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Student_Exam_Question]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Student_Exam_Question
CREATE   PROCEDURE [dbo].[sp_Update_Student_Exam_Question]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Topic]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Update an existing Topic
CREATE   PROCEDURE [dbo].[sp_Update_Topic]
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
/****** Object:  StoredProcedure [dbo].[sp_Update_Track]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- Update an existing Track
CREATE   PROCEDURE [dbo].[sp_Update_Track]
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
/****** Object:  StoredProcedure [dbo].[StartExam]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Create the corrected StartExam procedure
CREATE PROCEDURE [dbo].[StartExam]
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
/****** Object:  StoredProcedure [dbo].[SubmitExam]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- SubmitExam - Submit exam answers
-- =============================================
CREATE   PROCEDURE [dbo].[SubmitExam]
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
/****** Object:  StoredProcedure [dbo].[UpdateUserProfile]    Script Date: 7/19/2025 3:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- =============================================
-- UpdateUserProfile - Update user profile
-- =============================================
CREATE   PROCEDURE [dbo].[UpdateUserProfile]
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
