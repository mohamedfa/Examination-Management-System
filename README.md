
# Examination Management System – ITI Graduation Project

<img width="230" height="150" alt="ColoredLogo" src="https://github.com/user-attachments/assets/14b91daa-469c-449a-b798-d58f66f81bc6" />


A complete, end-to-end **Examination Management System** built as part of the ITI 4-Month Graduation Project. The solution covers everything from a robust relational database to a dynamic web application and integrated dashboards and reporting.

---

## Project Structure

The repository is organized into the following key folders:

| Folder         | Description |
|----------------|-------------|
| `Database`      | SQL scripts for schema creation, table design, relations, stored procedures, and CRUD operations |
| `Data Warehouse`| Star schema model and ETL scripts for historical and analytical reporting |
| `Documentation` | Full documentation including ERDs, schema diagrams, stored procedure logic, and website features |
| `Dashboards`    | Power BI dashboards for visual insights into students, exams, results, and performance metrics |
| `SSRS`          | SQL Server Reporting Services reports for printable reports and tabular analytics |
| `Web App`       | Website source code (front-end and back-end) for both student and instructor portals |

---

## 1. Database Design

A fully normalized relational database built using **SQL Server**.

### Key Components:
- **Core Entities**: Students, Instructors, Branches, Courses, Exams, Questions, Tracks
- **Support Tables**: Exam Questions, Student Exam Answers, Exam Results
- **Data Constraints**: Primary Keys, Foreign Keys, Unique Constraints, Defaults
- **Procedures**:  
  - `GenerateExam` – Auto-generates a new exam with randomized questions  
  - `ExamAnswer` – Stores student answers and calculates partial scores  
  - `ExamCorrection` – Grades full exams and determines pass/fail  
  - `isCourseListedForAllCoursesAllStudents` – Flags students failing a course multiple times  
  - Full CRUD operations implemented for **all tables**  
    > See sample CRUD operations for the `Branch` table in the documentation.

See full scripts and details in [`/Database`](./Database)

---

## 2. Data Warehouse

For business intelligence and trend analysis, we built a **Data Warehouse** using a **Star Schema** design.

### Features:
- Fact Table: `Fact_Exams`
- Dimensions: `Dim_Student`, `Dim_Course`, `Dim_Date`, `Dim_Track`, `Dim_Instructor`, etc.
- ETL Logic using SQL procedures and views
- Supports historical performance tracking and trends over time

Scripts and diagrams available in [`/Data Warehouse`](./Data%20Warehouse)

---

## 3. Web Application

A user-friendly web portal built for both **Students** and **Instructors**.

### Role-Based Access:
- **Student Pages**:
  - Dashboard  
  - Available Exams  
  - Take Exam Page  
- **Instructor Pages**:
  - Dashboard  
  - Create Exam (select course and question count)  
  - Manage Exams (Edit, View, Delete)

### Pages:
- Home
- Login
- Instructor Dashboard
- Create Exam
- Manage Exams
- Student Dashboard
- Available Exams
- Take Exam

All page screenshots are included in the `/Web App/screenshots` folder.  
Source code is inside [`/Web App`](./Web%20App)

---

## 4. Dashboards

Interactive reports and dashboards created using **Power BI** to give stakeholders quick insight into:

- Pass/Fail Rates
- Average Grades by Course
- Top Performing Students
- Exam Participation by Track & Branch

PBIX files and screenshots are included in [`/Dashboards`](./Dashboards)

---

## 📈 5. SSRS Reports

Formal tabular reports generated using **SQL Server Reporting Services (SSRS)** for:

- Exam Listings
- Student Performance Sheets
- Course-wise Success Rates

RDL files and sample exports in [`/SSRS`](./SSRS)

---

## 6. Documentation

Extensive documentation for the entire system including:

- Entity Relationship Diagrams (ERD)
- Schema Design
- Stored Procedure Descriptions
- Web Application Flow & UI Guide
- Insights on Business Logic & DWH ETL Process

Find the full documentation PDF inside [`/Documentation`](./Documentation)

---

## Contributors

This project was built collaboratively by our team of five ITI students:

- [Ahmed Mostafa](https://github.com/AhmedMostafa-30)
- [Amany Saeed](https://github.com/amany-saeed99)
- [Amir El Sayed](https://github.com/AmirElsayed117)
- [Bassant Samy](https://github.com/BassantEl-emem)
- [Mohamed Fatouh](https://github.com/mohamedfa) *(me)*
