/*Exam System ITI Database*/

/*Entities Tables*/

/*Branches*/****************************Done_14 Records
create table Branches(
Branch_ID int  primary key,
B_Name  varchar(100),
B_Location  varchar(100),
Founding_date date,
MngrName varchar(100)
)
///////////////////////////////////

/*Question*/ ----Done by dalia 100 rows---
create table Questions(
Question_ID int primary key,
Question_Text  varchar(250),
CorrectAnswer  varchar(250),
Course_ID int,
Exam_ID int,
Question_Level varchar(50) check (Question_Level= 'Basic' or Question_Level= 'Intermediate' or Question_Level= 'Advanced'), 
Question_Type varchar(50) check (Question_Type= 'T or F' or Question_Type= 'MCQ'),
constraint course_fk foreign key(Course_ID) references Courses(Course_ID),
constraint exam_fk foreign key(Exam_ID) references Exams (Exam_ID)
)




/////////////////////////////////////////
/*Question_Choices*/ --done by dalia
create table Question_Choices(
Question_ID int,
Choice varchar(250),
constraint C23 foreign key(Question_ID) references Questions(Question_ID),
constraint C24 primary key (Choice,Question_ID),
constraint C25 unique (Choice, Question_ID)
)
//////////////////////////////////////////////////////////

/*Faculty*/**********************************Done_301 records
create table Faculty(
Fcode varchar(200)   primary key,
Fname  varchar(250),
FLocation varchar(250),
)


///////////////////////////////////////
/*Student_address*/*********************************Done_451 records
create table Student_address(
ZipCode int  primary key,
City varchar(250),
Street varchar(250)
)
///////////////////////
/*Instructor_address*/*************************************Done_200 records
create table Instructor_address(
ZipCode int   primary key,
City varchar(250),
Street varchar(250)
)
///////////////////////////
/*Gradute_company*/***********************************Done_163 records
create table Graduate_company(
Company_code varchar(250)  primary key,
Company_name  varchar(250),
Company_Location  varchar(250),
)

drop table gradute_company
////////////////////////////////////////////
/*Instructors*/****************************************Done_199 records
create table Instructors(
Inst_ID int  primary key,
Inst_Fname  varchar(250),
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
Manager_ID  int,
Branch_ID int,
ZipCode int,
constraint C4 foreign key(Manager_ID) references Instructors(Inst_ID),
constraint C5 foreign key(Branch_ID) references Branches(Branch_ID),
constraint C6 foreign key(ZipCode) references Instructor_address(ZipCode)

)
///////////////////////////////////////////////////////////////////
/*Instructor Phone*/************************************Done_199 records
create table Instructor_Phone(
Inst_ID int,
Phone varchar(20),
constraint C7 foreign key(Inst_ID) references Instructors(Inst_ID),
constraint C8 primary key (Inst_ID,Phone),
constraint C9 unique (Inst_ID,Phone)
)
/////////////////////////////////////////
/*Courses*/ --- done by sandra 199 rows
create table Courses(
Course_ID int primary key,
Course_Name  varchar(250),
Course_Status varchar(50) check (Course_Status = 'Offline' or Course_Status= 'Online'),
Course_Duration varchar(250),
Course_Evaluation varchar(250),
Inst_ID int,
constraint C12 foreign key(Inst_ID) references Instructors(Inst_ID)
)
///////////////////////////////////////////////
/*Exams*/
Create table Exams( ----done by dalia
Exam_ID int primary key,
Exam_Level varchar(50) check (Exam_Level= 'Basic' or Exam_Level= 'Intermediate' or Exam_Level= 'Advanced'),
Exam_Type varchar(50) check (Exam_Type = 'Offline' or Exam_Type= 'Online'),
Exam_Name varchar(50),
Exam_Date date,
Exam_Duration varchar(50),
Exam_FullMark varchar(50),
Course_ID int,
constraint C17 foreign key(Course_ID) references Courses(Course_ID)
)

//////////////////////////////////////////////////////////////
/*Topics*/************************************************Done_568 records
create table Topics(
Topic_ID int  primary key,
Course_ID int,
Topic_Name varchar(250),
constraint C45 foreign key(Course_ID) references Courses(Course_ID)
)
///////////////////////////////////////////////////////////*****//////////
/*Tracks*/*********************************Done_378 records
create table Tracks(
Track_ID int primary key,
Track_Name  varchar(250),
Track_Duration varchar(100) check (Track_Duration = '3 months' or Track_Duration = '9 months'),
Branch_ID  int,
Manager_ID  int,
constraint C10 foreign key(Branch_ID) references Branches(Branch_ID),
constraint C11 foreign key(Manager_ID) references Instructors(Inst_ID)
)
/////////////////////////////////////////////////////////
/*Intake*/*************************************Done_50 records
create table Intake(
Intake_ID int  primary key,
Intake_NO varchar(100)
)
////////////////////////////////////////////
/*Round*/*****************************************Done_150 records
create table Rounds(
Round_ID int  primary key,
Round_NO varchar(100)
)
/////////////////////////////////////

/*Students*/***********************************Done_400 records
create table StudentsInfo(
St_ID int  primary key,
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
Branch_ID int,
ZipCode int,
Fcode varchar(200),
Track_ID int,
constraint C1 foreign key(Branch_ID) references Branches(Branch_ID),
constraint C2 foreign key(ZipCode) references Student_address(ZipCode),
constraint C3 foreign key(Fcode) references Faculty(Fcode),
constraint C44 foreign key(Track_ID) references Tracks(Track_ID)

)
//////////////////////////////////
/*Student Phone*/***********************************Done_400 records
create table Student_Phone(
St_ID int,
Phone varchar(20),
constraint C31 foreign key(St_ID) references StudentsInfo(St_ID),
constraint C32 primary key (St_ID,Phone),
constraint C33 unique (St_ID,Phone)
)
//////////////////////////////////////////
/*Track_Contains_Courses*/***********************************Done_90 records
create table Track_Contains_Courses(
Track_ID int,
Course_ID int,
constraint C13 foreign key(Course_ID) references Courses(Course_ID),
constraint C14 foreign key(Track_ID) references Tracks(Track_ID),
constraint C15 primary key (Track_ID,Course_ID)

)
////////////////////////////////
/*Student_enroll_in_intake*/
create table Student_enroll_intake(
St_ID int primary key ,
Intake_ID int,
constraint C41 foreign key(St_ID) references StudentsInfo(St_ID),
constraint C42 foreign key(Intake_ID) references Intake(Intake_ID),
)





/////////////////////////////////////
/*Student_enroll_in_Round*/
create table Student_enroll_Round(
St_ID int primary key ,
Round_ID int,
constraint C61 foreign key(St_ID) references StudentsInfo(St_ID),
constraint C62 foreign key(Round_ID) references Rounds(Round_ID)
)

drop table student_enroll_round

///////////////////////////////


/*Student_Answers_Exam*/
create table Student_Answers_Exam(
St_ID int,
Exam_ID int,
Question_ID int,
St_Answer varchar(250),
Grade int,
constraint C18 foreign key(St_ID) references StudentsInfo(St_ID),
constraint C19 foreign key(Exam_ID) references Exams(Exam_ID),
constraint C20 foreign key(Question_ID) references Questions(Question_ID),
constraint C21 primary key (St_ID,Question_ID),

)



///////////////////////////////////////////
/*Graduates*/
create table Graduates(
Graduate_ID int   primary key,
Graduate_Fname VARCHAR(50),
Graduate_Lname varchar(50),
G_Gender varchar(10),
Graduate_Certification  varchar(50) check (Graduate_Certification = 'Completed' or
Graduate_Certification = 'Not completed'),
Graduate_Job_Title  varchar(250),
Graduate_Job_Type  varchar(100) check (Graduate_Job_Type = 'Onsite' or
Graduate_Job_Type = 'Freelance'),
Graduate_Hired_Date date,
Graduate_Salary money,
Track_ID int,
constraint C_track foreign key(Track_ID) references Tracks(Track_ID)
)

drop table graduates
alter table Graduates
add ITI_Graduation_Year int

//////////////////////////////////////////////////////
create table Graduate_Phone
(
Graduate_ID int,
Phone varchar(20),
constraint Cfkkk foreign key(Graduate_ID) references Graduates(Graduate_ID),
constraint Cpkkkk primary key (Graduate_ID,Phone),
constraint Cfkkkk1 unique (Graduate_ID,Phone)
)
//////////////////////////////////////////////////////
/*Graduate_Fail_Reasons*/
create table Graduate_Fail_Reasons(
Graduate_ID int,
FailReasons varchar(250),
constraint C28 foreign key(Graduate_ID) references Graduates(Graduate_ID),
constraint C29 primary key (FailReasons,Graduate_ID),

)

/////////////////////////////////////////////////

/*Student_Certificates*/
create table Student_Certificates(
Certificate_ID int primary key,
St_ID int,
certificate_Provider_Name varchar(250),
certificate_issue_date date,
constraint C38 foreign key(St_ID) references StudentsInfo(St_ID)

)
///////////////////////////////////////////////////

/*GraduatesWorkCompany*/
create table GraduatesWorkCompany(
Graduate_ID int  primary key,
Company_code varchar(250),
constraint C39 foreign key(Company_code) references Graduate_company(Company_code),
constraint C40 foreign key(Graduate_ID) references Graduates(Graduate_ID)
)
//////////////////////////////////////////////////////

/*ExamQuestionGeneration*/
CREATE TABLE Exam_Quest_Generation
( 
Exam_ID INT,
Question_ID INT ,
PRIMARY KEY (Exam_ID,Question_ID),

constraint C100 foreign key(Exam_ID) references Exams(Exam_ID),
constraint C101 foreign key(Question_ID) references Questions(Question_ID)
);

/*Student_Takes_Exam*/
create table Student_Takes_Exam
(St_ID int,
Exam_ID int,
Exam_Percentage decimal(5,1),
constraint fk_St_ID foreign key(St_ID) references StudentsInfo(St_ID),
constraint fk_Exam_ID foreign key(Exam_ID) references Exams(Exam_ID),
constraint pk_St_Exam primary key(St_ID,Exam_ID))

alter table Student_Takes_Exam
add St_Status varchar(50) check (St_Status = 'Passed' or
St_Status = 'Failed')



//////////////////////////////////////////////////////



//////////////////////////////////////////////////////

//Good Luck! :)




