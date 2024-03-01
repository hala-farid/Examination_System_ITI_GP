/*Insert Stored Procedures*/

--1)Branches
create procedure InsertBranches  @Branch_ID int, @b_name varchar(100), @b_location varchar(100),
                                 @founding_date date, @mngr_name varchar(100)
as
begin
    begin try
        -- Check if branch ID already exists
        if not exists (select 1 from Branches where B_Name = @b_name and B_Location = @b_location)
        begin
            -- Insert a new branch
            insert into Branches (Branch_ID,B_Name, B_Location, Founding_date, MngrName)
            values (@Branch_ID,@b_name, @b_location, @founding_date, @mngr_name);
        end
        else
        begin
            -- Branch ID already exists, raise an error
            throw 50001, 'Branch ID already exists.', 1;
        end
    end try
    begin catch
        print error_message();
    end catch
end;
-----test-----
InsertBranches @Branch_ID=16,@b_name = 'New Branchs', @b_location = 'Location A', @founding_date = '2024-02-20', @mngr_name = 'Manager A';
select *  from branches
---------------------------------------------------------
--2)Question
CREATE PROCEDURE insert_questions  @Question_ID INT, @question_text VARCHAR(250), 
                                   @correct_answer VARCHAR(250), @question_level VARCHAR(50), 
                                   @question_type VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        -- Check if the question ID already exists
        IF NOT EXISTS (SELECT 1 FROM Questions WHERE Question_ID = @Question_ID)
        BEGIN
            -- Security check for Question_Level
            IF @question_level NOT IN ('Basic', 'Intermediate', 'Advanced')
            BEGIN
                THROW 50002, 'Invalid Question Level. Please choose from: Easy, Intermediate, Advanced.', 1;
            END
            -- Security check for Question_Type
            IF @question_type NOT IN ('T or F', 'MCQ')
            BEGIN
                THROW 50003, 'Invalid Question Type. Please choose from: T/F, Choose.', 1;
            END
            -- Insert the question if it passes security checks
            INSERT INTO Questions (Question_ID, Question_Text, CorrectAnswer, Question_Level, Question_Type)
            VALUES (@Question_ID, @question_text, @correct_answer, @question_level, @question_type);
            PRINT 'Question inserted successfully.';
        END
        ELSE
        BEGIN
            -- Question ID already exists, raise an error
            THROW 50004, 'Question ID already exists.', 1;
        END
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
-----test----
insert_questions 
    @Question_ID = 217,
    @question_text = 'What is the capital of France?',
    @correct_answer = 'Paris',
    @question_level = 'Basic',
    @question_type = 'MCQ';
select *  from Questions
---------------------------------------------------------------------------
--3)/*Question_Choices*/
create or Alter proc InsertQuestionChoice  @Question_ID INT, @Choice VARCHAR(250)
as
begin
    begin try
        -- Check if Question_ID exists in the Questions table
        if  exists (select 1 from Questions where Question_ID = @Question_ID)
        begin
            throw 50005, 'Invalid Question_ID. Please provide a valid Question_ID.', 1;
        end
        -- Check if the choice already exists for the same Question_ID
        if exists (select 1 from Question_Choices where Question_ID = @Question_ID and Choice = @Choice)
        begin
            throw 50006, 'The choice already exists for this question.', 1;
        end
        -- Insert the choice
        insert into Question_Choices (Question_ID, Choice)
        values (@Question_ID, @Choice)  
        print 'Choice inserted successfully.';
    end try
    begin catch
        print error_message();
    end catch
end;


alter proc InsertQuestionChoice  @Question_ID INT, @Choice VARCHAR(250)
as
begin
    begin try
        -- Check if Question_ID exists in the Questions table
        if not exists (select 1 from Questions where Question_ID = @Question_ID)
        begin
            throw 50005, 'Invalid Question_ID. Please provide a valid Question_ID.', 1;
        end
        -- Check if the choice already exists for the same Question_ID
        if exists (select 1 from Question_Choices where Question_ID = @Question_ID and Choice = @Choice)
        begin
            throw 50006, 'The choice already exists for this question.', 1;
        end
        -- Insert the choice
        insert into Question_Choices (Question_ID, Choice)
        values (@Question_ID, @Choice);
        print 'Choice inserted successfully.';
    end try
    begin catch
        print error_message();
    end catch
end;
-----test----
select *  from Questions where Question_ID = 217
select *  from Question_Choices where Question_ID = 217
EXEC InsertQuestionChoice @Question_ID = 217, @Choice = 'Choice B';
------------------------------------------------------------
--4)/*Faculty*/
create procedure InsertFaculty  @Fcode varchar(200), @Fname varchar(250), @FLocation varchar(250)
as
begin
    begin try
	    -- Check if Fcode starts with EGY-UNV
        if left(@Fcode, 7) != 'EGY-UNV'
        begin
            throw 50007, 'Faculty code must start with EGY-UNV.', 1;
        end
        -- Check if Fcode already exists
        if exists (select 1 from Faculty where Fcode = @Fcode)
        begin
            throw 50008, 'Faculty code already exists.', 1;
        end
        -- Insert the faculty
        insert into Faculty (Fcode, Fname, Flocation)
        values (@Fcode, @Fname, @Flocation);
        print 'Faculty inserted successfully.';
    end try
    begin catch
        print error_message();
    end catch
end;
-----test-----
EXEC InsertFaculty @Fcode = 'EGY-UNV900', @Fname = 'Faculty of Engineering', @FLocation = 'Cairo, Egypt';

--------------------------------------------------
--5)/*Student_address*/
create proc InsertStudentaddress @Zipcode int, @City varchar(250), @Street varchar(250)
as
begin
    begin try
        -- Check if zipcode already exists
        if exists (select 1 from Student_address where Zipcode = @Zipcode)
        begin
            throw 50009, 'Zip code already exists.', 1;
        end
		-- Check if street already exists
        if exists (select 1 from Student_address where Street = @Street)
        begin
            throw 50010, 'Street already exists.', 1;
        end
        -- Insert the student address
        insert into Student_address (Zipcode, City, Street)
        values (@Zipcode, @City, @Street);
        print 'Student address inserted successfully.';
    end try
    begin catch
        print error_message();
    end catch
end;
-----test----
EXEC InsertStudentaddress @Zipcode = 666666, @City = 'Example City', @Street = 'Example Street';
select * from Student_address
----------------------------------------------------------
--6)/*Instructor_address*/
create proc InsertInstructoraddress @Zipcode int, @City varchar(250), @Street varchar(250)
as
begin
    begin try
        -- Check if zipcode already exists
        if exists (select 1 from Student_address where Zipcode = @Zipcode)
        begin
            throw 50011, 'Zip code already exists.', 1;
        end
		-- Check if street already exists
        if exists (select 1 from Student_address where Street = @Street)
        begin
            throw 50012, 'Street already exists.', 1;
        end
        -- Insert the student address
        insert into Instructor_address (Zipcode, City, Street)
        values (@Zipcode, @City, @Street);
        print 'Instructor address inserted successfully.';
    end try
    begin catch
        print error_message();
    end catch
end;
-----test----
EXEC InsertInstructoraddress @Zipcode = 67899550, @City = 'Example City', @Street = 'Examp11le Street';

-----------------------------------------------------------
--7)/*Gradute_company*/
create or alter proc InsertGraduteCompany @company_code varchar(250), @company_name varchar(250),
                                @company_location varchar(250)
as
begin
    begin try
        -- Check if Company_location contains 'egypt'
        if charindex('egypt', lower(@company_location)) > 0
        begin
            -- Company Location contains 'egypt', so Company code should start with 'EGY-CMP'
            if left(@company_code, 7) != 'egy-cmp'
            begin
                throw 50013, 'Company code must start with EGY-CMP for companies located in Egypt.', 1;
            end
        end
        else
        begin
            -- Company Location does not contain 'egypt', so Company code should start with 'INTL-CMP'
            if left(@company_code, 7) != 'intl-cmp'
            begin
                throw 50014, 'Company code must start with INTL-CMP for companies located outside Egypt.', 1;
            end
        end
        -- Check if Company_code already exists
        if exists (select 1 from Graduate_company where company_code = @company_code)
        begin
            throw 50015, 'Company code already exists.', 1;
        end
        -- Insert the graduate company
        insert into Graduate_company (company_code, company_name, company_location)
        values (@company_code, @company_name, @company_location);
        print 'Graduate company inserted successfully.';
    end try
    begin catch
        print error_message();
    end catch
end;
-----test---
EXEC InsertGraduteCompany @company_code = 'EGY-CMP1', @company_name = 'Duplicate Company', @company_location = 'Alexandria, Egypt';

------------------------------------------------------------------
--8)/*Instructors*/
CREATE PROCEDURE InsertInstructor @Inst_ID INT, @inst_fname VARCHAR(250), @inst_lname VARCHAR(50),@inst_salary MONEY, 
                                  @inst_gender VARCHAR(50),@inst_birthdate DATE, @inst_hiringdate DATE,
                                  @inst_position VARCHAR(50), @inst_degree VARCHAR(50),@inst_experience_year INT, 
                                  @inst_email VARCHAR(250), @manager_id INT, @branch_id INT, @zipcode INT
AS
BEGIN
    BEGIN TRY
        -- Check if the inst_id already exists
        IF EXISTS (SELECT 1 FROM instructors WHERE inst_id = @Inst_ID)
        BEGIN
            PRINT 'Instructor ID already exists.';
            RETURN; -- Exit the stored procedure
        END
        -- Check if inst_salary is greater than 5000
        IF @inst_salary <= 5000
        BEGIN
            THROW 50016, 'Instructor salary must be greater than 5000.', 1;
        END
        -- Check if inst_gender is 'm' or 'f'
        IF @inst_gender NOT IN ('m', 'f')
        BEGIN
            THROW 50017, 'Invalid gender. Gender must be "m" or "f".', 1;
        END
        -- Check if inst_position is 'instructor' or 'freelancer'
        IF @inst_position NOT IN ('instructor', 'freelancer')
        BEGIN
            THROW 50018, 'Invalid position. Position must be "instructor" or "freelancer".', 1;
        END
        -- Check if inst_degree is 'bachelor', 'master', or 'phd'
        IF @inst_degree NOT IN ('bachelor', 'master', 'phd')
        BEGIN
            THROW 50019, 'Invalid degree. Degree must be "bachelor", "master", or "phd".', 1;
        END
        -- Check if manager_id is valid (foreign key reference to inst_id)
        IF NOT EXISTS (SELECT 1 FROM instructors WHERE inst_id = @manager_id)
        BEGIN
            THROW 50020, 'Invalid manager ID.', 1;
        END
        -- Check if branch_id is valid (foreign key reference to branches)
        IF NOT EXISTS (SELECT 1 FROM branches WHERE branch_id = @branch_id)
        BEGIN
            THROW 50021, 'Invalid branch ID.', 1;
        END
        -- Check if zipcode is valid (foreign key reference to instructor_address)
        IF NOT EXISTS (SELECT 1 FROM instructor_address WHERE zipcode = @zipcode)
        BEGIN
            THROW 50022, 'Invalid zip code.', 1;
        END
        -- Insert the instructor
        INSERT INTO instructors (inst_id, inst_fname, inst_lname, inst_salary, inst_gender, inst_birthdate, inst_hiringdate, inst_position, inst_degree, inst_experience_year, inst_email, manager_id, branch_id, zipcode)
        VALUES (@Inst_ID, @inst_fname, @inst_lname, @inst_salary, @inst_gender, @inst_birthdate, @inst_hiringdate, @inst_position, @inst_degree, @inst_experience_year, @inst_email, @manager_id, @branch_id, @zipcode);

        PRINT 'Instructor inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
-------test--------
EXEC InsertInstructor
   @Inst_ID =200,
    @inst_fname = 'Michael', 
    @inst_lname = 'Taylor', 
    @inst_salary = 9000, 
    @inst_gender = 'm', 
    @inst_birthdate = '1975-12-25', 
    @inst_hiringdate = '2020-03-01', 
    @inst_position = 'instructor', 
    @inst_degree = 'Master',  -- Invalid degree
    @inst_experience_year = 15, 
    @inst_email = 'michael.taylor@example.com', 
    @manager_id = 1, 
    @branch_id = 1, 
    @zipcode = 54321;
	select * from Instructors
---------------------------------------------------------------------------------------
--9)/*Instructor Phone*/
create proc InsertInstructorPhone @inst_id int,@phone varchar(20)
as
begin
    begin try
        -- Check if inst_id exists in the instructors table
        if  not exists (select 1 from instructors where inst_id = @inst_id)
        begin
            throw 50023, 'Invalid instructor ID. Please provide a valid instructor ID.', 1;
        end
        -- Check if the phone number is valid
        if len(@phone) < 11 or len(@phone) > 11
        begin
            throw 50024, 'Invalid phone number. Phone number must be between 7 and 20 characters.', 1;
        end
		-- Check if the phone number already exists for the instructor
        if exists (select 1 from Instructor_Phone where Inst_ID = @inst_id and Phone = @phone)
        begin
            throw 50025, 'Phone number already exists for this instructor.', 1;
        end
        -- Insert the instructor phone number
        insert into instructor_phone (inst_id, phone)
        values (@inst_id, @phone);
        print 'Instructor phone number inserted successfully.';
    end try
    begin catch
        print error_message();
    end catch
end;
-----test----
EXEC InsertInstructorPhone @inst_id = 1, @phone = '01234567890';
-------------------------------------------------------------------------------
--10)/*Courses*/
CREATE PROCEDURE InsertCourse @course_id INT,@course_name VARCHAR(250),@course_status VARCHAR(50),
                              @course_duration VARCHAR(250),@course_evaluation VARCHAR(250),@inst_id INT
AS
BEGIN
    BEGIN TRY
        -- Check if the course ID already exists
        IF EXISTS (SELECT 1 FROM Courses WHERE Course_ID = @course_id)
        BEGIN
            THROW 50029, 'Course with the same ID already exists.', 1;
        END
        -- Check if course_status is valid
        IF @course_status NOT IN ('offline', 'online')
        BEGIN
            THROW 50026, 'Invalid course status. Course status must be "offline" or "online".', 1;
        END
        -- Check if inst_id exists in the instructors table
        IF NOT EXISTS (SELECT 1 FROM instructors WHERE inst_id = @inst_id)
        BEGIN
            THROW 50027, 'Invalid instructor ID. Please provide a valid instructor ID.', 1;
        END
        -- Insert the course
        INSERT INTO courses (course_id, course_name, course_status, course_duration, course_evaluation, inst_id)
        VALUES (@course_id, @course_name, @course_status, @course_duration, @course_evaluation, @inst_id);
        PRINT 'Course inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
------test-----
EXEC InsertCourse 
    @course_id = 201,
    @course_name = 'Introduction to SQL',
    @course_status = 'online',
    @course_duration = '8 weeks',
    @course_evaluation = 'Final exam',
    @inst_id = 101;
	select * from Courses
----------------------------------------------------------------------------------
--11)Topics
create PROCEDURE InsertTopic @topic_Id INT, @course_id INT, @topic_name VARCHAR(250)
AS
BEGIN
    BEGIN TRY
        -- Check if topic_id already exists
        IF EXISTS (SELECT 1 FROM topics WHERE topic_Id = @topic_Id)
        BEGIN
            THROW 50036, 'Topic ID already exists. Please provide a unique topic ID.', 1;
        END
        -- Check if course_id exists in the courses table
        IF NOT EXISTS (SELECT 1 FROM courses WHERE course_id = @course_id)
        BEGIN
            THROW 50033, 'Invalid course ID. Please provide a valid course ID.', 1;
        END
        -- Check if the topic already exists for the given course
        IF EXISTS (SELECT 1 FROM topics WHERE course_id = @course_id AND topic_name = @topic_name)
        BEGIN
            THROW 50034, 'Topic already exists for this course.', 1;
        END
        -- Insert the topic
        INSERT INTO topics (topic_Id, course_id, topic_name)
        VALUES (@topic_Id, @course_id, @topic_name);
        PRINT 'Topic inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;

------test----
EXEC InsertTopic 
@topic_Id=569,
    @course_id = 1,
    @topic_name = 'Data Types'; 
	select * from Topics
-----------------------------------------------------------
--12)/*Tracks*/
create PROCEDURE InsertTrack @Track_Id INT,@track_name VARCHAR(250),@track_duration VARCHAR(100),
                             @branch_id INT,@manager_id INT
AS
BEGIN
    BEGIN TRY
        -- Check if the provided Track_Id already exists
        IF EXISTS (SELECT 1 FROM tracks WHERE Track_Id = @Track_Id)
        BEGIN
            THROW 50038, 'Track ID already exists. Please provide a unique Track ID.', 1;
        END
        -- Check if track_duration is valid
        IF @track_duration NOT IN ('3 months', '9 months')
        BEGIN
            THROW 50035, 'Invalid track duration. Track duration must be "3 months" or "9 months".', 1;
        END
        -- Check if branch_id exists in the branches table
        IF NOT EXISTS (SELECT 1 FROM branches WHERE branch_id = @branch_id)
        BEGIN
            THROW 50036, 'Invalid branch ID. Please provide a valid branch ID.', 1;
        END
        -- Check if manager_id exists in the instructors table
        IF @manager_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM instructors WHERE inst_id = @manager_id)
        BEGIN
            THROW 50037, 'Invalid manager ID. Please provide a valid manager ID.', 1;
        END
        -- Insert the track
        INSERT INTO tracks (Track_Id, track_name, track_duration, branch_id, manager_id)
        VALUES (@Track_Id, @track_name, @track_duration, @branch_id, @manager_id);
        PRINT 'Track inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
------------test----
EXEC InsertTrack 
    @Track_Id = 425, 
    @track_name = 'Track 30', 
    @track_duration = '9 months', 
    @branch_id = 2, 
    @manager_id = 3; -- Assuming this manager_id does not exist
	select * from Tracks
---------------------------------------------------------
--13)/*Intake*/
CREATE PROCEDURE InsertIntake @Intake_ID INT, @intake_no VARCHAR(100)
AS
BEGIN
    BEGIN TRY
        -- Check if the provided Intake_ID already exists
        IF EXISTS (SELECT 1 FROM intake WHERE Intake_ID = @Intake_ID)
        BEGIN
            THROW 50039, 'Intake with the provided ID already exists. Please provide a unique ID.', 1;
        END
        -- Check if Intake_No starts with 'Intake_'
        IF LEFT(@intake_no, 7) != 'intake_'
        BEGIN
            THROW 50038, 'Invalid Intake_No format. Intake_No must start with "Intake_".', 1;
        END
        -- Insert the intake
        INSERT INTO intake (Intake_ID, intake_no)
        VALUES (@Intake_ID, @intake_no);
        PRINT 'Intake inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;

----test----
EXEC InsertIntake @Intake_ID = 45, @intake_no = 'Intake_2024';
select * from Intake
-------------------------------------------------------------------
--14)/*Round*/
create PROCEDURE InsertRound @Round_ID int, @round_no varchar(100)
AS
BEGIN
    BEGIN TRY
        -- Check if Round_ID already exists
        IF EXISTS (SELECT 1 FROM rounds WHERE Round_ID = @Round_ID)
        BEGIN
            THROW 50040, 'Round ID already exists. Please provide a different Round ID.', 1;
        END
        -- Check if Round_NO starts with 'Round_'
        IF LEFT(@round_no, 6) != 'round_'
        BEGIN
            THROW 50039, 'Invalid Round_NO format. Round_NO must start with "Round_".', 1;
        END
        -- Insert the round
        INSERT INTO rounds (Round_ID, round_no)
        VALUES (@Round_ID, @round_no);
        PRINT 'Round inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
---------test----
EXEC InsertRound @Round_ID = 151, @round_no = 'round_002';
select * from Rounds
------------------------------------------------------------
--15)/*Students*/
CREATE PROCEDURE InsertStudentsInfo  @St_ID INT,@st_fname VARCHAR(50),@st_lname VARCHAR(50),@st_email VARCHAR(100),
                                     @st_gender VARCHAR(50),@st_birthdate DATE,@st_faculty_graduationyear INT,
                                     @facebookurl VARCHAR(400),@st_numfreelancejobs INT,@branch_id INT,
                                     @zipcode INT,@fcode VARCHAR(200),@track_id INT
AS
BEGIN
    BEGIN TRY
        -- Check if St_ID already exists
        IF EXISTS (SELECT 1 FROM studentsinfo WHERE St_ID = @St_ID)
        BEGIN
            THROW 50045, 'Student ID already exists. Please provide a unique student ID.', 1;
        END
        -- Check if st_gender is 'M' or 'F'
        IF @st_gender NOT IN ('M', 'F')
        BEGIN
            THROW 50040, 'Invalid gender. Gender must be "M" or "F".', 1;
        END
        -- Check if branch_id exists in the branches table
        IF NOT EXISTS (SELECT 1 FROM branches WHERE branch_id = @branch_id)
        BEGIN
            THROW 50041, 'Invalid branch ID. Please provide a valid branch ID.', 1;
        END
        -- Check if zipcode exists in the student_address table
        IF NOT EXISTS (SELECT 1 FROM student_address WHERE zipcode = @zipcode)
        BEGIN
            THROW 50042, 'Invalid zip code. Please provide a valid zip code.', 1;
        END
        -- Check if fcode exists in the faculty table
        IF NOT EXISTS (SELECT 1 FROM faculty WHERE fcode = @fcode)
        BEGIN
            THROW 50043, 'Invalid faculty code. Please provide a valid faculty code.', 1;
        END
        -- Check if track_id exists in the tracks table
        IF NOT EXISTS (SELECT 1 FROM tracks WHERE track_id = @track_id)
        BEGIN
            THROW 50044, 'Invalid track ID. Please provide a valid track ID.', 1;
        END
        -- Insert the student info
        INSERT INTO studentsinfo (St_ID, st_fname, st_lname, st_email, st_gender, st_birthdate, st_faculty_graduationyear, facebookurl, st_numfreelancejobs, branch_id, zipcode, fcode, track_id)
        VALUES (@St_ID, @st_fname, @st_lname, @st_email, @st_gender, @st_birthdate, @st_faculty_graduationyear, @facebookurl, @st_numfreelancejobs, @branch_id, @zipcode, @fcode, @track_id);
        PRINT 'Student info inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;

----test---
EXEC InsertStudentsInfo 
        @St_ID = 1181,  -- Use an St_ID that already exists in the studentsinfo table
        @st_fname = 'John',
        @st_lname = 'Doe',
        @st_email = 'john.doe@example.com',
        @st_gender = 'M',
        @st_birthdate = '2000-01-01',
        @st_faculty_graduationyear = 2023,
      
        @facebookurl = 'http://facebook.com/johndoe',
        @st_numfreelancejobs = 2,
        @branch_id = 1,
        @zipcode = 12345,
        @fcode = 'EGY-UNV001',
        @track_id = 1;

EXEC InsertStudentsInfo 
        @St_ID = 1182,  -- Use an St_ID that already exists in the studentsinfo table
        @st_fname = 'Doe',
        @st_lname = 'John',
        @st_email = 'doe.john@example.com',
        @st_gender = 'M',
        @st_birthdate = '2000-01-01',
        @st_faculty_graduationyear = 2023,
      
        @facebookurl = 'http://facebook.com/doejohn',
        @st_numfreelancejobs = 2,
        @branch_id = 1,
        @zipcode = 12345,
        @fcode = 'EGY-UNV001',
        @track_id = 1;
		select * from StudentsInfo
---------------------------------------------------------------------------------
--16)/*Student Phone*/
create proc InsertStudentPhone @st_id int,@phone varchar(20)
as
begin
    begin try
        -- Check if St_ID exists in the StudentsInfo table
        if not exists (select 1 from studentsinfo where st_id = @st_id)
        begin
            throw 50045, 'Invalid student ID. Please provide a valid student ID.', 1;
        end
        -- Check if the phone number is valid
        if len(@phone) < 11 or len(@phone) > 11
        begin
            throw 50046, 'Invalid phone number. Phone number must be 11', 1;
        end
        -- Insert the student phone number
        insert into student_phone (st_id, phone)
        values (@st_id, @phone);
        print 'Student phone number inserted successfully.';
    end try
    begin catch
        print error_message();
    end catch
end;
----test---
EXEC InsertStudentPhone 
        @st_id = 1181,  -- Use an st_id that does not exist in the studentsinfo table
        @phone = '12345678901';


		select * from Student_Phone
--------------------------------------------------------
--17)/*Track_Contains_Courses*/
create proc InserttrackContainsCourse @track_id int,@course_id int
as
begin
    begin try
        -- Check if Track_ID exists in the Tracks table
        if not exists (select 1 from tracks where track_id = @track_id)
        begin
            throw 50047, 'Invalid track ID. Please provide a valid track ID.', 1;
        end
        -- Check if Course_ID exists in the Courses table
        if not exists (select 1 from courses where course_id = @course_id)
        begin
            throw 50048, 'Invalid course ID. Please provide a valid course ID.', 1;
        end
        -- Check if the combination of Track_ID and Course_ID already exists
        if exists (select 1 from track_contains_courses where track_id = @track_id and course_id = @course_id)
        begin
            throw 50049, 'The specified course is already associated with the track.', 1;
        end
        -- Insert the track-course association
        insert into track_contains_courses (track_id, course_id)
        values (@track_id, @course_id);
        print 'Track-course association inserted successfully.';
    end try
    begin catch
        print error_message();
    end catch
end;
-----test----
EXEC InserttrackContainsCourse 
        @track_id = 1,  -- Use a valid track_id that exists in the tracks table
        @course_id = 1;

select * from Track_Contains_Courses
---------------------------------------------------------
--18)/*Student_enroll_in_intake*/
create proc InsertStudentenrollIntake @st_id int,@intake_id int
as
begin
    begin try
        -- Check if St_ID exists in the StudentsInfo table
        if not exists (select 1 from studentsinfo where st_id = @st_id)
        begin
            throw 50050, 'Invalid student ID. Please provide a valid student ID.', 1;
        end
        -- Check if Intake_ID exists in the Intake table
        if not exists (select 1 from intake where intake_id = @intake_id)
        begin
            throw 50051, 'Invalid intake ID. Please provide a valid intake ID.', 1;
        end
		-- Check if student is already enrolled in a round
        if exists (select 1 from student_enroll_round where st_id = @st_id)
        begin
            throw 50052, 'Student is already enrolled in a round.', 1;
        end
        -- Insert the student enrollment for intake
        insert into student_enroll_intake (st_id, intake_id)
        values (@st_id, @intake_id);
        print 'Student enrollment for intake inserted successfully.';
    end try
    begin catch
        print error_message();
    end catch
end;

----test----
EXEC InsertStudentenrollIntake 
        @st_id = 1181,       -- Use an invalid st_id that does not exist in the studentsinfo table
        @intake_id = 1;   

select* from Student_enroll_intake

--------------------------------------------------------------
--19)/*Student_enroll_in_Round*/
CREATE PROCEDURE InsertStudentenrollRound @st_id INT,@round_id INT
AS
BEGIN
    BEGIN TRY
        -- Check if St_ID exists in the StudentsInfo table
        IF NOT EXISTS (SELECT 1 FROM studentsinfo WHERE st_id = @st_id)
        BEGIN
            THROW 50053, 'Invalid student ID. Please provide a valid student ID.', 1;
        END
        -- Check if Round_ID exists in the Rounds table
        IF NOT EXISTS (SELECT 1 FROM rounds WHERE round_id = @round_id)
        BEGIN
            THROW 50054, 'Invalid round ID. Please provide a valid round ID.', 1;
        END
        -- Check if the student is already enrolled in an intake
        IF EXISTS (SELECT 1 FROM student_enroll_intake WHERE st_id = @st_id)
        BEGIN
            THROW 50055, 'Student is already enrolled in an intake. Cannot enroll in a round.', 1;
        END
        -- Insert the student enrollment for round
        INSERT INTO student_enroll_round (st_id, round_id)
        VALUES (@st_id, @round_id);
        PRINT 'Student enrollment for round inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;

-----test---
EXEC InsertStudentenrollRound @st_id = 1182, @round_id = 130;
select * from Student_enroll_Round
--------------------------------------------------------------------
--20)/*Graduates*/
create or alter proc InsertGraduate @Graduate_ID int,@Grade_Fname varchar(50),@Grade_Lname varchar(50),@Grade_Gender varchar(10),@graduate_certification varchar(50),@graduate_job_title varchar(250),
                           @graduate_job_type varchar(100),@graduate_hired_date date,@graduate_salary money,
                           @track_id int, @iti_graduation_year int
as
begin
    begin try
        -- Check if Graduate_Certification is 'Completed' or 'Not completed'
        if @graduate_certification not in ('completed', 'not completed')
        begin
            throw 50058, 'Invalid graduate certification. Certification must be "Completed" or "Not completed".', 1;
        end
        -- Check if Graduate_Job_Type is 'Onsite' or 'Freelance'
        if @graduate_job_type not in ('onsite', 'freelance')
        begin
            throw 50059, 'Invalid job type. Job type must be "Onsite" or "Freelance".', 1;
        end
        -- Check if St_ID exists in the StudentsInfo table
        if not exists (select 1 from Tracks where track_id = @track_id)
        begin
            throw 50060, 'Invalid track ID. Please provide a valid track ID.', 1;
        end
        -- Insert the graduate
        insert into graduates (Graduate_ID,Graduate_Fname,Graduate_Lname,G_Gender ,graduate_certification, graduate_job_title, graduate_job_type, graduate_hired_date, graduate_salary, track_id,ITI_Graduation_Year)
        values (@Graduate_ID,@Grade_Fname,@Grade_Lname,@Grade_Gender,@graduate_certification, @graduate_job_title, @graduate_job_type, @graduate_hired_date, @graduate_salary, @track_id,@iti_graduation_year);
        print 'Graduate inserted successfully.';
    end try
    begin catch
        print error_message();
    end catch
end;
--------test---
EXEC InsertGraduate
    @Graduate_ID = 1002,
	@Grade_Fname='Reda',
	@Grade_Lname='Rady',
	@Grade_Gender='Male',
    @graduate_certification = 'completed',
    @graduate_job_title = 'Software Developer',
    @graduate_job_type = 'freelance',
    @graduate_hired_date = '2024-03-01',
    @graduate_salary = 75000,
    @track_id = 84, -- Invalid Track ID
	@iti_graduation_year= 2022;
	-- for fail resaons insert new graduate with @graduate_certification = 'Not Completed'
EXEC InsertGraduate
    @Graduate_ID = 1003,
	@Grade_Fname='Saly',
	@Grade_Lname='Rady',
	@Grade_Gender='Female',
    @graduate_certification ='Not Completed',
    @graduate_job_title = 'Software Developer',
    @graduate_job_type = 'freelance',
    @graduate_hired_date = '2024-03-01',
    @graduate_salary = 2500,
    @track_id = 84, -- Invalid Track ID
	@iti_graduation_year= 2022;
	select * from Tracks
	select * from Graduates
--------------------------------------------------------------------
--21)/*Graduate_Fail_Reasons*/

create or ALTER PROCEDURE InsertGraduatefailReason 
    @Graduate_ID int,
    @failreasons varchar(250)
AS
BEGIN
    BEGIN TRY
        -- Check if Graduate_ID exists in the Graduates table
        IF NOT EXISTS (SELECT 1 FROM Graduates WHERE Graduate_ID = @Graduate_ID)
        BEGIN
            THROW 50061, 'Invalid Graduate_ID. Please provide a valid Graduate_ID.', 1;
        END
        
        -- Check if the graduate's certification status is "Not Completed"
        IF NOT EXISTS (SELECT 1 FROM Graduates WHERE Graduate_ID = @Graduate_ID AND Graduate_Certification = 'Not Completed')
        BEGIN
            THROW 50062, 'Graduate has completed the certification. Fail reasons can only be recorded for students with "Not completed" certification.', 1;
        END
        
        -- Insert the graduate's fail reasons
        INSERT INTO Graduate_Fail_Reasons (Graduate_ID, FailReasons)
        VALUES (@Graduate_ID, @failreasons);
        
        PRINT 'Graduate fail reasons inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
----test----
EXEC InsertGraduatefailReason
    @Graduate_ID = 1003, -- Assuming 1003 is an existing Graduate ID with a "Not completed" certification
    @failreasons = 'Failed final exam';
EXEC InsertGraduatefailReason
    @Graduate_ID = 1003, -- Assuming 1003 is an existing Graduate ID with a "Not completed" certification with diffrent fail reason
    @failreasons = 'exceed the absence limit';
	
select * from Graduate_Fail_Reasons  where Graduate_ID = 1003
----------------------------------------------------------------
--22)/*Student_Certificates*/
create PROCEDURE InsertStudentCertificate @Certificate_ID int, @st_id int,@certificate_provider_name varchar(250),
                                          @certificate_issue_date date
AS
BEGIN
    BEGIN TRY
        -- Check if St_ID exists in the StudentsInfo table
        IF NOT EXISTS (SELECT 1 FROM studentsinfo WHERE st_id = @st_id)
        BEGIN
            THROW 50063, 'Invalid student ID. Please provide a valid student ID.', 1;
        END
        -- Check if Certificate_ID exists in the student_certificates table
        IF EXISTS (SELECT 1 FROM student_certificates WHERE Certificate_ID = @Certificate_ID)
        BEGIN
            THROW 50064, 'Certificate ID already exists. Please provide a unique Certificate ID.', 1;
        END
        -- Insert the student certificate
        INSERT INTO student_certificates (Certificate_ID, st_id, certificate_provider_name, certificate_issue_date)
        VALUES (@Certificate_ID, @st_id, @certificate_provider_name, @certificate_issue_date);
        PRINT 'Student certificate inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
-----test------
EXEC InsertStudentCertificate 
    @Certificate_ID = 1001,
    @st_id = 123,
    @certificate_provider_name = 'Example Provider',
    @certificate_issue_date = '2023-01-15';

	select * from student_certificates
----------------------------------------------------------
--23)/*Graduates_work_at_company*/
create PROC InsertGraduateworkatCompany @Graduate_ID INT, @company_code VARCHAR(250)
AS
BEGIN
    BEGIN TRY
        -- Check if Graduate_ID exists in the Graduates table
        IF NOT EXISTS (SELECT 1 FROM Graduates WHERE Graduate_ID = @Graduate_ID)
        BEGIN
            THROW 50064, 'Invalid graduate ID. Please provide a valid graduate ID.', 1;
        END
        -- Check if Company_code exists in the Gradute_company table
        IF NOT EXISTS (SELECT 1 FROM Graduate_company WHERE company_code = @company_code)
        BEGIN
            THROW 50065, 'Invalid company code. Please provide a valid company code.', 1;
        END
        -- Insert the graduate's work at company record
        INSERT INTO graduatesworkcompany (Graduate_ID, company_code)
        VALUES (@Graduate_ID, @company_code);
        PRINT 'Graduate work at company record inserted successfully.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;

------test----

EXEC InsertGraduateworkatCompany @Graduate_ID = 1001, @company_code = 'EGY-CMP001';

select * from graduatesworkcompany
----------------------------------------------------------------------------------
//Good Luck! :)
