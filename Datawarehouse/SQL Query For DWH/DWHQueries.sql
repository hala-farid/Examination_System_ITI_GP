/*Dim_Sudent*/
create table Dim_Students(
StudentID_SK int identity(1,1) primary key,
StudentID_BK int  ,
St_Fname  varchar(50),
St_Lname  varchar(50),
St_Email  varchar(100),
St_Password varchar(100),
St_Gender  varchar(50) check (St_Gender = 'M' or St_Gender= 'F'),
St_Birthdate date,
St_Age as(year(getdate())-year(St_Birthdate)),
St_Faculty_GraduationYear  int,
FacebookURL  varchar(400),
St_NumFreelanceJobs  int,
Phone_BK varchar(20),
Branch_ID int,
Track_ID int,

ZipCode_BK int,
City varchar(250),
Street varchar(250),

Fcode_BK varchar(200),
Fname  varchar(250),
FLocation varchar(250),

Intake_ID_BK int ,
Intake_NO varchar(100),

Round_ID_BK int  ,
Round_NO varchar(100),

Certificate_ID_BK int ,
certificate_Provider_Name varchar(250),
certificate_issue_date date,
 
start_date datetime,
end_date datetime,
is_current tinyint,
source_system_code tinyint

)


-----------------------------------------------
/*Dim_StudentGrades*/
create table Dim_StudentGrades(
StudentGrades_ID_SK int identity(1,1) primary key,
StudentID_FK int ,
Exam_ID int,
Exam_Percentage decimal(5,1),
St_Status varchar(50) check (St_Status = 'Passed' or St_Status='Failed'),


start_date datetime,
end_date datetime,
is_current tinyint,
source_system_code tinyint,

constraint C1 foreign key(StudentID_FK) references Dim_Students(StudentID_SK),

)
-----------------------------------------------
/*Dim_Branches*/

create table Dim_Branches(
Branch_ID_SK int identity(1,1) primary key,
Branch_ID_BK int  ,
B_Name  varchar(100),
B_Location  varchar(100),
Founding_date date,
MngrName varchar(100),

start_date datetime,
end_date datetime,
is_current tinyint,
source_system_code tinyint
)
-----------------------------------------------

/*Dim_Instructors*/
create table Dim_Instructors(
Inst_ID_SK int identity(1,1) primary key,
Inst_ID_BK int ,
Inst_Fname varchar(250),
Inst_Lname  varchar(50),
Inst_Salary money check (Inst_Salary>5000),
Inst_Gender  varchar(50) check (Inst_Gender = 'M' or Inst_Gender= 'F'),
Inst_Birthdate date,
Inst_Age as(year(getdate())-year(Inst_Birthdate)),
Inst_HiringDate date,
Inst_Position varchar(50) check (Inst_Position= 'Instructor' or Inst_Position= 'Freelancer'),
Inst_Degree varchar(50) check (Inst_Degree = 'Bachelor' or Inst_Degree= 'Master' or Inst_Degree= 'PHD'),
Inst_Experience_Year  int,
Inst_Email  varchar(250),
Phone_BK varchar(20),

Manager_ID  int,
Branch_ID_FK int,

ZipCode_BK int,
City varchar(250),
Street varchar(250),

start_date datetime,
end_date datetime,
is_current tinyint,
source_system_code tinyint,

constraint C2 foreign key(Branch_ID_FK) references Dim_Branches(Branch_ID_SK),
)


----------------------------------------
/*Dim_Graduates*/
create table Dim_Graduates(
Graduate_ID_SK int identity(1,1) primary key,
Graduate_ID_BK int,
Graduate_Fname VARCHAR(50),
Graduate_Lname varchar(50),
Graduate_Gender varchar(10),
Graduate_Certification  varchar(50) check (Graduate_Certification = 'Completed' or Graduate_Certification = 'Not completed'),
Graduate_Job_Title  varchar(250),
Graduate_Job_Type  varchar(100) check (Graduate_Job_Type = 'Onsite' or Graduate_Job_Type = 'Freelance'),
Graduate_Hired_Date date,
Graduate_Salary money,
Graduate_Phone_BK varchar(20),
ITI_Graduation_Year int,
Track_ID int,
FailReasons varchar(250),

Company_code_BK varchar(250)  ,
Company_name  varchar(250),
Company_Location  varchar(250),


start_date datetime,
end_date datetime,
is_current tinyint,
source_system_code tinyint

)


------------------------------------
/*Dim_Courses*/
create table Dim_Courses(
Course_ID_SK int identity(1,1) primary key,
Course_ID_BK int,
Course_Name  varchar(250),
Course_Status varchar(50) check (Course_Status = 'Offline' or Course_Status= 'Online'),
Course_Duration varchar(250),
Course_Evaluation varchar(250),
Inst_ID_FK int,
Topic_ID_BK int,

Topic_Name varchar(250),

start_date datetime,
end_date datetime,
is_current tinyint,
source_system_code tinyint,

constraint C3 foreign key(Inst_ID_FK) references Dim_Instructors(Inst_ID_SK),

)




-----------------------------------
/*Dim-Tracks*/
create table Dim_Tracks(
Track_ID_SK int identity(1,1) primary key,
Track_ID_BK int  ,
Course_ID_FK int,
Graduate_ID_FK int,
Track_Name  varchar(250),
Track_Duration varchar(100) check (Track_Duration = '3 months' or Track_Duration = '9 months'),
Branch_ID  int,
Manager_ID  int,

start_date datetime,
end_date datetime,
is_current tinyint,
source_system_code tinyint,

constraint C4 foreign key(Course_ID_FK) references Dim_Courses(Course_ID_SK),
constraint C5 foreign key(Graduate_ID_FK) references Dim_Graduates(Graduate_ID_SK),

)
--------------------------------------------------------------
/*Dim_Exams*/
Create table Dim_Exams( 
Exam_ID_SK int identity(1,1) primary key,
Exam_ID_BK int,

Exam_Level varchar(50) check (Exam_Level= 'Basic' or Exam_Level= 'Intermediate' or Exam_Level= 'Advanced'),
Exam_Type varchar(50) check (Exam_Type = 'Offline' or Exam_Type= 'Online'),
Exam_Name varchar(50),
Exam_Date date,
Exam_Duration varchar(50),
Exam_FullMark varchar(50),
Course_ID int,


start_date datetime,
end_date datetime,
is_current tinyint,
source_system_code tinyint
)


------------------------------------------
/*Dim_Questions*/
create table Dim_Questions(
Question_ID_SK int identity(1,1) primary key,
Question_ID_BK int, 
Question_Text  varchar(250),
CorrectAnswer  varchar(250),
Course_ID int,
Exam_ID_FK int,
Question_Level varchar(50) check (Question_Level= 'Basic' or Question_Level= 'Intermediate' or Question_Level= 'Advanced'), 
Question_Type varchar(50) check (Question_Type= 'T or F' or Question_Type= 'MCQ'),
Choice varchar(250),
start_date datetime,
end_date datetime,
is_current tinyint,
source_system_code tinyint,
constraint c6 foreign key(Exam_ID_FK) references Dim_Exams (Exam_ID_SK)
)


-------------------------------------------------------------

/*Fact_Students*/

create table Fact_Students(
Fact_Transaction_PK_SK int identity(1,1) primary key,
StudentID_FK int ,
Track_ID_FK int ,
Branch_ID_FK int ,
Exam_ID_FK int,
DateFK int,
Total_Grade decimal(10,1) ,


create_at datetime,
source_system_code tinyint,
constraint C7 foreign key(StudentID_FK) references Dim_Students(StudentID_SK),
constraint C8 foreign key(Track_ID_FK  ) references Dim_Tracks(Track_ID_SK),
constraint C9 foreign key(Branch_ID_FK) references Dim_Branches(Branch_ID_SK),
constraint C10 foreign key(DateFK ) references DimDate(DateSK ),
constraint C11 foreign key(Exam_ID_FK) references Dim_Exams(Exam_ID_SK),
)
-------------------------------------------------------------------------
/*Control_table*/
create table Meta_Control_Fact_Students_Load(
id int identity(1,1) primary key,
ExamsID nvarchar(100),
Last_load_date datetime,
Last_Load_ExamsID_BK int
)


--------------------------------------------
/*Notes*/
/*
students birthdates
min 1992-01-01
max 2002-12-31


Graduates hired date
min 1988-08-20
max 2023-12-25

exams
min 2023-01-01
max 2023-12-26
*/
------------------------------------------------------------
/*Queries For Dimension*/
------------------------
/*Dim_Students*/
SELECT s.[St_ID]
      ,s.[St_Fname]
      ,s.[St_Lname]
	  ,s.[St_Email]
	  ,s.[St_Password]
	  ,s.[St_Gender]
	  ,s.[St_Birthdate]
	  ,s.[St_Faculty_GraduationYear]
	  ,s.[FacebookURL]
	  ,s.[St_NumFreelanceJobs]
	  ,p.[Phone]
	  ,t.[Track_ID]
	  ,b.[Branch_ID]
	  ,z.[ZipCode]
	  ,z.[Street]
	  ,z.[City]
	  ,f.[Fcode]
	  ,f.[Fname]
	  ,f.[FLocation]
	  ,i.[Intake_ID]
	  ,it.[Intake_NO]
	  ,r.[Round_ID]
	  ,ro.[Round_NO]
	  ,c.[Certificate_ID]
	  ,c.[certificate_Provider_Name]
	  ,c.[certificate_issue_date]
      --,p.[LastModifiedDate]
      --,p.[is_current]
	  

  FROM [Exam_System_OLTP].[dbo].[StudentsInfo] as s

  left join [Exam_System_OLTP].[dbo].[Student_Phone] as p
  on(s.St_ID=p.St_ID)


  left join [Exam_System_OLTP].[dbo].[Tracks] as t
  on(s.Track_ID=t.Track_ID)

  left join [Exam_System_OLTP].[dbo].[Branches] as b
  on(s.Branch_ID=b.Branch_ID)

  left join [Exam_System_OLTP].[dbo].[Student_address] as z
  on(s.ZipCode=z.ZipCode)

  left join [Exam_System_OLTP].[dbo].[Faculty] as f
  on(s.Fcode=f.Fcode)

  left join [Exam_System_OLTP].[dbo].[Student_enroll_intake] as i
  on(s.St_ID=i.St_ID)

  left join [Exam_System_OLTP].[dbo].[Intake] as it
  on(i.Intake_ID=it.Intake_ID)


  left join [Exam_System_OLTP].[dbo].[Student_enroll_Round] as r
  on(s.St_ID=r.St_ID)

  left join [Exam_System_OLTP].[dbo].[Rounds] as ro
  on(r.Round_ID=ro.Round_ID)
  
  left join [Exam_System_OLTP].[dbo].[Student_Certificates] as c
  on(s.St_ID=c.St_ID)
-----------------------------------------------------------------------
/*Dim_StudentGrades*/

SELECT s.[St_ID]
      ,s.[Exam_ID]
      ,s.[Exam_Percentage]
	  ,s.[St_Status]
	  
  FROM [Exam_System_OLTP].[dbo].[Student_Takes_Exam] as s
-----------------------------------------------------------------------
/*Dim_Branches*/
SELECT b.[Branch_ID]
       ,b.[B_Name]
	   ,b.[B_Location]
	   ,b.[Founding_date]
	   ,b.[MngrName]

 
  FROM [Exam_System_OLTP].[dbo].[Branches] as b

 ---------------------------------------------------------
/*Dim_Instructors*/
SELECT i.[Inst_ID]
      ,i.[Inst_Fname]
      ,i.[Inst_Lname]
	  ,i.[Inst_Salary]
	  ,i.[Inst_Gender]
	  ,i.[Inst_Birthdate]
	  ,i.[Inst_HiringDate]
	  ,i.[Inst_Position]
	  ,i.[Inst_Degree]
	  ,i.[Inst_Experience_Year]
	  ,i.[Inst_Email]
	  ,i.[Manager_ID]
	  ,i.[Branch_ID]
	  ,p.[Phone]
	  ,z.[ZipCode]
	  ,z.[City]
	  ,z.[Street]
	  
  FROM [Exam_System_OLTP].[dbo].[Instructors] as i

  left join [Exam_System_OLTP].[dbo].[Instructor_Phone] as p
  on(i.Inst_ID=p.Inst_ID)

  left join [Exam_System_OLTP].[dbo].[Instructor_address] as z
  on(i.ZipCode=z.ZipCode)
 ---------------------------------------------------------------
 /*Dim_Graduates*/
 SELECT g.[Graduate_ID]
       ,g.[Graduate_Fname]
	   ,g.[Graduate_Lname]
	   ,g.[G_Gender]
       ,g.[Graduate_Certification]
	   ,g.[Graduate_Job_Title]
	   ,g.[Graduate_Job_Type]
	   ,g.[Graduate_Hired_Date]
	   ,g.[Graduate_Salary]
	   ,p.[Phone]
	   ,g.[ITI_Graduation_Year]
	   ,g.[Track_ID]
	   ,f.[FailReasons]
	   ,c.[Company_code]
	   ,c.[Company_name]
	   ,c.[Company_Location]

  FROM [Exam_System_OLTP].[dbo].[Graduates] as g

  left join [Exam_System_OLTP].[dbo].[Graduate_Phone] as p
  on(g.Graduate_ID=p.Graduate_ID)


  left join [Exam_System_OLTP].[dbo].[Graduate_Fail_Reasons] as f
  on(g.Graduate_ID=f.Graduate_ID)

  left join [Exam_System_OLTP].[dbo].[GraduatesWorkCompany] as w
  on(g.Graduate_ID=w.Graduate_ID)

  left join [Exam_System_OLTP].[dbo].[Graduate_company] as c
  on(w.Company_code=c.Company_code)

 ---------------------------------------------------------------------------
 /*Dim_Courses*/
 SELECT c.[Course_ID]
        ,c.[Course_Name]
		,c.[Course_Status]
        ,c.[Course_Duration]
		,c.[Course_Evaluation]
		,c.[Inst_ID]
		,t.[Topic_ID]
		,t.[Topic_Name]

  FROM [Exam_System_OLTP].[dbo].[Courses] as c

  left join [Exam_System_OLTP].[dbo].[Topics] as t
  on(c.Course_ID=t.Course_ID)

-------------------------------------------------
/*Dim_Tracks*/

SELECT t.[Track_ID]
       ,tc.[Course_ID]
	   ,g.[Graduate_ID]
	   ,t.[Track_Name]
	   ,t.[Track_Duration]
	   ,t.[Branch_ID]
	   ,t.[Manager_ID]
       
        

  FROM [Exam_System_OLTP].[dbo].[Tracks] as t

  left join [Exam_System_OLTP].[dbo].[Track_Contains_Courses] as tc
  on(t.Track_ID=tc.Track_ID)

  left join [Exam_System_OLTP].[dbo].[Courses] as c
  on(tc.Course_ID=c.Course_ID)

  left join [Exam_System_OLTP].[dbo].[Graduates] as g
  on(t.Track_ID=g.Track_ID)
---------------------------------------------------------------- 
/*Dim_Exams*/

SELECT e.[Exam_ID]
       ,e.[Exam_Level]
	   ,e.[Exam_Type]
	   ,e.[Exam_Name]
	   ,e.[Exam_Date]
	   ,e.[Exam_Duration]
	   ,e.[Exam_FullMark]
	   ,e.[Course_ID]
       
  FROM [Exam_System_OLTP].[dbo].[Exams] as e
-----------------------------------------------------------
/*Dim_Questions*/

SELECT q.[Question_ID]
       ,q.[Question_Text]
	   ,q.[CorrectAnswer]
	   ,q.[Course_ID]
	   ,q.[Exam_ID]
	   ,q.[Question_Level]
	   ,q.[Question_Type]
	   ,qc.[Choice]
       
        

  FROM [Exam_System_OLTP].[dbo].[Questions] as q

  left join [Exam_System_OLTP].[dbo].[Question_Choices] as qc
  on(q.Question_ID=qc.Question_ID)
------------------------------------------------------------
/*Fact_Student*/
SELECT 
       s.[St_ID]
	   ,s.[Branch_ID]
	   ,s.[Track_ID]
	   ,te.[Exam_ID]
	   ,e.[Exam_Date]
	   ,SUM(te.[Exam_Percentage]) AS Total_Grade
	  
FROM [Exam_System_OLTP].[dbo].[StudentsInfo] as s
INNER JOIN [Exam_System_OLTP].[dbo].[Student_Takes_Exam] as te
ON s.St_ID = te.St_ID
INNER JOIN [Exam_System_OLTP].[dbo].[Exams] as e
ON te.Exam_ID = e.Exam_ID

/*WHERE te.[Exam_ID] > ?  --System variable startTime*/

GROUP BY s.St_ID, s.Branch_ID, s.Track_ID, te.Exam_ID, e.Exam_Date;

       
  
----------------------------------------------------------
SELECT  
      [Last_Load_ExamsID_BK]
  FROM [Exam_System_DWH].[dbo].[Meta_Control_Fact_Students_Load]
  where [ExamsID]='Exam_ID'
-----------------------------------------------
SELECT  Last_load_date
     
  FROM [Exam_System_DWH].[dbo].[Meta_Control_Fact_Students_Load]
  where [ExamsID]='Exam_ID'
---------------------------------------------------------

/*Look Up Date*/
SELECT  DateSK, [Date]
FROM    DimDate
--------------------------------------------------------
/*Look Up Students*/
SELECT [StudentID_SK]
      ,[StudentID_BK]
      
  FROM [Exam_System_DWH].[dbo].[Dim_Students]
  WHERE is_current = 1
---------------------------------------------------
/*Look Up Branches*/

SELECT [Branch_ID_SK]
      ,[Branch_ID_BK]
      
  FROM [Exam_System_DWH].[dbo].[Dim_Branches]
  WHERE is_current = 1
--------------------------------------------
/*Look Up Tracks*/

SELECT [Track_ID_SK]
      ,[Track_ID_BK]
      
  FROM [Exam_System_DWH].[dbo].[Dim_Tracks]
  WHERE is_current = 1
---------------------------------------------------
/*Look Up Exam*/

SELECT [Exam_ID_SK]
      ,[Exam_ID_BK]
      
  FROM [Exam_System_DWH].[dbo].[Dim_Exams]
  WHERE is_current = 1
----------------------------------------------------
/*Update*/
select max(Exam_ID_FK) as update_last_load_Exam_ID
from[Exam_system_DWH].[dbo].[Fact_Students]
------------------------------------
update [dbo].[Meta_Control_Fact_Students_Load]
set [Last_load_date]=?
,[Last_Load_ExamsID_BK]=?

where [ExamsID]='Exam_ID'
------------------------------------------
--Done :)