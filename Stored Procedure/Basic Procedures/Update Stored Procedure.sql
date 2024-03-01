/*Update Stored Procedures*/
--1)Branches
create procedure updatebranch @branch_id int, @mngr_name varchar(100)
as
begin
    begin try
        -- Check if the branch exists
        if not exists (select 1 from branches where branch_id = @branch_id)
        begin
            throw 80001, 'Invalid branch ID. No record found for the provided branch ID.', 1;
        end
        -- Update branch information
        update branches
        set mngrname = @mngr_name
        where branch_id = @branch_id;
    end try
    begin catch
        print error_message();
    end catch
end;
-----test---
updatebranch 3, 'Ali';
select * from Branches
----------------------------------------------------------------
--2)Questions
create procedure updatequestion @question_id int, @new_correct_answer varchar(250), @new_question_level varchar(50) 
as
begin
    begin try
        -- Check if the question exists
        if not exists (select 1 from questions where question_id = @question_id)
        begin
            throw 80002, 'Invalid question ID. No record found for the provided question ID.', 1;
        end
        -- Update question information
        update questions
        set correctanswer = @new_correct_answer,
            question_level = @new_question_level
        where question_id = @question_id;
    end try
    begin catch
        print error_message();
    end catch
end;
-----test---
updatequestion @question_id = 1, @new_correct_answer = 'A unique', @new_question_level = 'Advanced';
SELECT * FROM questions WHERE question_id = 1;
------------------------------------------------------------------
--3)Question_Choices
create procedure updatequestionchoice @question_id int, @choice varchar(250), @new_choice varchar(250)
as
begin
    begin try
        -- Check if the question choice exists
        if not exists (select 1 from question_choices where question_id = @question_id and choice = @choice)
        begin
            throw 80003, 'Invalid question ID or choice. No record found for the provided question ID and choice.', 1;
        end
        -- Update question choice
        update question_choices
        set choice = @new_choice
        where question_id = @question_id and choice = @choice;
    end try
    begin catch
        print error_message();
    end catch
end;
-----test-----
updatequestionchoice @question_id = 1, @choice = 'A field in a table that stores numeric values', @new_choice = 'X';
SELECT * FROM question_choices WHERE question_id = 1;
----------------------------------------------------------------
--4)Faculty
create procedure updatefaculty @fcode varchar(200), @fname varchar(250) 
as
begin
    begin try
        -- Check if the faculty exists
        if not exists (select 1 from faculty where fcode = @fcode)
        begin
            throw 80004, 'Faculty not found. Unable to update.', 1;
        end
        -- Update faculty information
        update faculty
        set fname = @fname 
        where fcode = @fcode;
    end try
    begin catch
        print error_message();
    end catch
end;
----test---
updatefaculty @fcode = 'EGY-UNV002', @fname = 'Faculty of Engineering';
SELECT * FROM faculty WHERE fcode = 'EGY-UNV002';
-----------------------------------------------------------------
--5)/*Gradute_company*/
create PROCEDURE updategradutescompany  @company_code VARCHAR(250), @company_location VARCHAR(250)
AS
BEGIN
    BEGIN TRY
        -- Check if the company code exists
        IF NOT EXISTS (SELECT 1 FROM graduate_company WHERE company_code = @company_code)
        BEGIN
            THROW 80005, 'Company code does not exist.', 1;
        END
        -- Convert company location to lowercase for comparison
        SET @company_location = @company_location
        
        -- Check if the company location contains 'egypt'
        IF CHARINDEX('egypt', @company_location) > 0
        BEGIN
            -- Check if the company code starts with 'egy-cmp'
            IF LEFT(@company_code, 7) <> 'egy-cmp'
            BEGIN
                THROW 80006, 'Company location contains Egypt but company code does not start with ''egy-cmp''.', 1;
            END
        END
        ELSE
        BEGIN
            -- Check if the company code starts with 'intl-cmp'
            IF LEFT(@company_code, 8) <> 'intl-cmp'
            BEGIN
                THROW 80007, 'Company location does not contain Egypt but company code does not start with ''intl-cmp''.', 1;
            END
        END 
        -- Update graduate_company table
        UPDATE graduate_company
        SET company_location = @company_location
        WHERE company_code = @company_code;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
----test----
updategradutescompany @company_code = 'EGY-CMP004', @company_location = 'Giza, Egypt';
SELECT * FROM graduate_company WHERE company_code = 'EGY-CMP004';
----------------------------------------------------------------
--6)Instructors
CREATE PROCEDURE update_instructor @inst_id INT, @new_inst_salary MONEY, @new_inst_degree VARCHAR(50), @new_inst_experience_year INT 
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists
        IF NOT EXISTS (SELECT 1 FROM instructors WHERE inst_id = @inst_id)
        BEGIN
            THROW 80006, 'Instructor ID does not exist.', 1;
        END

        -- Check if the new instructor salary is more than 5000
        IF @new_inst_salary <= 5000
        BEGIN
            THROW 80008, 'Instructor salary must be more than 5000.', 1;
        END

        -- Update instructors table
        UPDATE instructors
        SET 
            inst_salary = @new_inst_salary,
            inst_degree = @new_inst_degree,
            inst_experience_year = @new_inst_experience_year
            
        WHERE inst_id = @inst_id;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
----test----
update_instructor @inst_id = 1, @new_inst_salary = 6000, @new_inst_degree = 'PhD', @new_inst_experience_year = 6;
SELECT * FROM instructors WHERE inst_id = 1;
--------------------------------------------------------------------
--7)Instructor Phone
create procedure update_instructor_phone @inst_id int,@new_phone varchar(20)
as
begin
    begin try
        -- Check if the instructor exists
        if not exists (select 1 from instructor_phone where inst_id = @inst_id)
        begin
            throw 80007, 'Instructor ID does not exist.', 1;
        end
        -- Update instructor_phone table
        update instructor_phone
        set phone = @new_phone
        where inst_id = @inst_id;
    end try
    begin catch
        print error_message();
    end catch
end;
-----test----
update_instructor_phone @inst_id = 2, @new_phone = '01201369874';
select * from Instructor_Phone where Inst_ID= 2
----------------------------------------------------------
--8)Courses
create procedure update_course  @course_id int, @new_course_status varchar(50), @new_inst_id int
as
begin
    begin try
        -- Check if the course exists
        if not exists (select 1 from courses where course_id = @course_id)
        begin
            throw 80009, 'Course ID does not exist.', 1;
        end
        -- Update the course
        update courses
        set 
            course_status = @new_course_status,
            inst_id = @new_inst_id
        where course_id = @course_id;
    end try
    begin catch
        print error_message();
    end catch
end;
----test-----
update_course @course_id = 1, @new_course_status = 'Offline', @new_inst_id = 5;
select * from courses
--------------------------------------------------
--9)Exams
create procedure update_exam @exam_id int,  @new_exam_date date 
as
begin
    begin try
        -- Check if the exam exists
        if not exists (select 1 from exams where exam_id = @exam_id)
        begin
            throw 80010, 'Exam ID does not exist.', 1;
        end
        -- Update the exam
        update exams
        set
            exam_date = @new_exam_date
        where exam_id = @exam_id;
    end try
    begin catch
        print error_message();
    end catch
end;
----test----
update_exam @exam_id = 1, @new_exam_date = '2024-03-15';
select * from exams where exam_id=1
------------------------------------------------
--10)/*Topics*/
create procedure update_topic  @topic_id int,  @new_topic_name varchar(250)
as
begin
    begin try
        -- Check if the topic exists
        if not exists (select 1 from topics where topic_id = @topic_id)
        begin
            throw 80011, 'Topic ID does not exist.', 1;
        end
        -- Update the topic
        update topics
        set topic_name =  @new_topic_name 
        where topic_id = @topic_id;
    end try
    begin catch
        print error_message();
    end catch
end;
----test----
update_topic @topic_id = 1, @new_topic_name = 'Data Analysis Basic';
select * from topics  where topic_id=1
------------------------------------------------------------
--11)Tracks
create procedure update_track @track_id int, @track_name varchar(250),  @branch_id int, @manager_id int
as
begin
    begin try
        -- Check if the track exists
        if not exists (select 1 from tracks where track_id = @track_id)
        begin
            throw 80012, 'Track ID does not exist.', 1;
        end
        -- Check if the branch ID exists
        if not exists (select 1 from branches where branch_id = @branch_id)
        begin
            throw 80013, 'Branch ID does not exist.', 1;
        end
        -- Check if the manager ID exists
        if not exists (select 1 from instructors where inst_id = @manager_id)
        begin
            throw 80014, 'Manager ID does not exist.', 1;
        end
        -- Update the track
        update tracks
        set track_name = @track_name,
            branch_id = @branch_id,
            manager_id = @manager_id
        where track_id = @track_id;
    end try
    begin catch
        print error_message();
    end catch
end;
-----test-------
update_track @track_id = 1, @track_name = 'Data Engineering', @branch_id =4, @manager_id = 2;
select * from Tracks where track_id = 1
--------------------------------------------------------------
--12)Students
create procedure update_student_info @st_id int, @zipcode int
as
begin
    begin try
        -- Check if the student exists
        if not exists (select 1 from StudentsInfo where St_ID = @st_id)
        begin
            throw 80015, 'Student ID does not exist.', 1;
        end
        -- Check if the ZIP code exists
        if not exists (select 1 from Student_address where ZipCode = @zipcode)
        begin
            throw 80016, 'ZIP code does not exist.', 1;
        end
        -- Update the student information
        update StudentsInfo
        set ZipCode = @zipcode
        where St_ID = @st_id;
    end try
    begin catch
        print error_message();
    end catch
end;
----test----
update_student_info @st_id = 1, @zipcode = 12345;
select * from StudentsInfo where St_ID= 1
------------------------------------------------------------
--13)Student Phone
create procedure update_student_phone @st_id int, @new_phone varchar(20)
as
begin
    begin try
        -- Check if the student ID exists
        if not exists (select 1 from StudentsInfo where St_ID = @st_id)
        begin
            throw 80017, 'Student ID does not exist.', 1;
        end
        -- Update the student phone number
        update Student_Phone
        set Phone = @new_phone
        where St_ID = @st_id;
    end try
    begin catch
        print error_message();
    end catch
end;
----test----
update_student_phone @st_id = 1, @new_phone = '01136598756';
select * from Student_Phone where St_ID =1
------------------------------------------------------------------------
--14)/*Track_Contains_Courses*/
create procedure update_trackcontainscourses @track_id int, @course_id int,@new_course_id int
as
begin
    begin try
        -- Check if the track ID exists
        if not exists (select 1 from Tracks where Track_ID = @track_id)
        begin
            throw 80018, 'Track ID does not exist.', 1;
        end
        -- Check if the course ID exists
        if not exists (select 1 from Courses where Course_ID = @course_id)
        begin
            throw 80019, 'Course ID does not exist.', 1;
        end
        -- Update the student phone number
        update Track_Contains_Courses
        set course_id = @new_course_id
        where track_id  = @track_id and course_id= @course_id ;
    end try
    begin catch
        print error_message();
    end catch
end;
----test---
update_trackcontainscourses @track_id = 1,  @course_id= 22, @new_course_id = 200;
select * from Track_Contains_Courses
-----------------------------------------------------------------------
--15)Graduates
create PROCEDURE update_graduates_status @graduate_id INT, @graduate_certification VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        -- Check if the graduate ID exists in Graduate_Fail_Reasons
        IF EXISTS (SELECT 1 FROM Graduate_Fail_Reasons WHERE Graduate_ID = @graduate_id)
        BEGIN
            -- Update the graduates table
            UPDATE Graduates
            SET Graduate_Certification = @graduate_certification
            WHERE Graduate_ID = @graduate_id;

            -- Remove the graduate from the Student_Fail_Reasons table
            DELETE FROM Graduate_Fail_Reasons
            WHERE Graduate_ID = @graduate_id;
        END
        ELSE
        BEGIN
            -- Handle the case where the graduate ID does not exist in Graduate_Fail_Reasons
            THROW 80020, 'Graduate ID does not exist in Graduate_Fail_Reasons.', 1;
        END;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
------test-----
update_graduates_status @graduate_id = 4, @graduate_certification = 'Completed';
select * from Graduates where Graduate_ID =4
----------------------------------------------------------
--16)Graduates
create PROCEDURE update_graduates_info @graduate_id INT,  @graduate_job_title VARCHAR(250),@graduate_job_type VARCHAR(100),
                                       @graduate_hired_date DATE, @graduate_salary MONEY
AS
BEGIN
    BEGIN TRY
        -- Check if the graduate ID exists
        IF EXISTS (SELECT 1 FROM Graduates WHERE Graduate_ID = @graduate_id)
        BEGIN
            -- Update the graduates table
            UPDATE Graduates
            SET 
                Graduate_Job_Title = @graduate_job_title,
                Graduate_Job_Type = @graduate_job_type,
                Graduate_Hired_Date = @graduate_hired_date,
                Graduate_Salary = @graduate_salary
            WHERE Graduate_ID = @graduate_id;
        END
        ELSE
        BEGIN
            -- Handle the case where the graduate ID does not exist
            THROW 80021, 'Graduate ID does not exist.', 1;
        END;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;
-----test-----
update_graduates_info 
    @graduate_id = 999, 
    @graduate_job_title = 'Software Engineer',
    @graduate_job_type = 'Freelance',
    @graduate_hired_date = '2024-02-20',
    @graduate_salary = 60000.00;
select * from Graduates where Graduate_ID = 999
--------------------------------------------------------------
--17)Graduate_Fail_Reasons
CREATE PROCEDURE update_Graduate_fail_reasons @graduate_id INT, @fail_reasons VARCHAR(250)
AS
BEGIN
    BEGIN TRY
        -- Check if the graduate ID exists
        IF EXISTS (SELECT 1 FROM Graduates WHERE Graduate_ID = @graduate_id)
        BEGIN
            -- Update the fail reasons for the specified graduate
            UPDATE Graduate_Fail_Reasons
            SET FailReasons = @fail_reasons
            WHERE Graduate_ID = @graduate_id;
        END
        ELSE
        BEGIN
            -- Handle the case where the graduate ID does not exist
            THROW 80023, 'Graduate ID does not exist.', 1;
        END;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
-----test-------
update_Graduate_fail_reasons @graduate_id = 54, @fail_reasons = 'Failed due to attendance issues';
select * from Graduate_Fail_Reasons where Graduate_ID = 54
-----------------------------------------------------------------
--18)/*Graduates_work_at_company*/
create PROCEDURE update_graduatesworkcompany  @graduate_id INT,  @company_code VARCHAR(250)
AS
BEGIN
    BEGIN TRY
        -- Check if the graduate ID exists
        IF EXISTS (SELECT 1 FROM Graduates WHERE Graduate_ID = @graduate_id)
        BEGIN
            -- Update the company code for the specified graduate
            UPDATE Graduatesworkcompany
            SET Company_code = @company_code
            WHERE Graduate_ID = @graduate_id;
        END
        ELSE
        BEGIN
            -- Handle the case where the graduate ID does not exist
            THROW 80024, 'Graduate ID does not exist.', 1;
        END;
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH;
END;
------test------
update_graduatesworkcompany @graduate_id = 2, @company_code = 'INTL-CMP001';
select * from GraduatesWorkCompany where Graduate_ID = 2
-------------------------------------------------------------------------
//Good Luck! :)



