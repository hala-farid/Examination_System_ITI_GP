/*Delete Stored Procedures*/
--1)Branches
--assingn instructors and tracks in this branch to branch number 1 "Smart Village_Main branch"
--Cannot delete branch number 1
--when delete branch, assign instructors to main branch

create PROCEDURE deletebranch @branch_id INT
AS
BEGIN
    BEGIN TRY
        -- Check if the branch exists
        IF NOT EXISTS (SELECT 1 FROM Branches WHERE Branch_ID = @branch_id)
        BEGIN
            THROW 60001, 'Invalid branch ID. Please provide a valid branch ID.', 1;
        END
        -- Check if the branch is Branch number 1
        IF @branch_id = 1
        BEGIN
            THROW 60002, 'Branch number 1 cannot be deleted. This is the main branch.', 1;
        END
		-- Delete student certificates associated with the branch
        DELETE FROM Student_Certificates WHERE St_ID IN (SELECT St_ID FROM StudentsInfo WHERE Branch_ID = @branch_id);

		-- Delete students' phone records associated with the branch
        DELETE FROM Student_Phone WHERE St_ID IN (SELECT St_ID FROM StudentsInfo WHERE Branch_ID = @branch_id);

        -- Delete students' round enrollment records associated with the branch
        DELETE FROM Student_enroll_Round WHERE St_ID IN (SELECT St_ID FROM StudentsInfo WHERE Branch_ID = @branch_id);

		-- Delete student intake enrollment records associated with the branch
        DELETE FROM Student_enroll_intake WHERE St_ID IN (SELECT St_ID FROM StudentsInfo WHERE Branch_ID = @branch_id);

		-- Delete students' exam records associated with the branch
        DELETE FROM Student_Takes_Exam WHERE St_ID IN (SELECT St_ID FROM StudentsInfo WHERE Branch_ID = @branch_id);

		-- Delete graduates' phone records associated with the branch
        DELETE FROM Graduate_Phone WHERE Graduate_ID IN (SELECT Graduate_ID FROM Graduates WHERE Track_ID IN (SELECT Track_ID FROM Tracks WHERE Branch_ID = @branch_id));

        -- Delete graduates' work company records associated with the branch
        DELETE FROM GraduatesWorkCompany WHERE Graduate_ID IN (SELECT Graduate_ID FROM Graduates WHERE Track_ID IN (SELECT Track_ID FROM Tracks WHERE Branch_ID = @branch_id));

        -- Delete graduates associated with the branch
        DELETE FROM Graduates WHERE Track_ID IN (SELECT Track_ID FROM Tracks WHERE Branch_ID = @branch_id);

		-- Delete students associated with the branch
        DELETE FROM StudentsInfo WHERE Branch_ID = @branch_id;

		-- Delete tracks associated with the branch
        DELETE FROM Tracks WHERE Branch_ID = @branch_id;

		-- Reassign instructors to Branch number 1
        UPDATE Instructors
        SET Branch_ID = 1
        WHERE Branch_ID = @branch_id;

        -- Delete the branch
        DELETE FROM Branches WHERE Branch_ID = @branch_id;

        PRINT 'Branch, associated tracks, graduates, students, and enrollment records deleted successfully.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


------test----
deletebranch @branch_id = 10;

--------------------------------------------------------------
--2)/*Question with choices*/
--when you delete Question you should delete choices

create or ALTER PROCEDURE deletequestionwithchoices @question_id INT
AS
BEGIN
    BEGIN TRY
        -- Check if Question_ID exists in the Questions table
        IF NOT EXISTS (SELECT 1 FROM questions WHERE question_id = @question_id)
        BEGIN
            THROW 60004, 'Invalid question ID. Please provide a valid question ID.', 1;
        END
        -- Delete records associated with the question ID from the Student_Answers_Exam table
        DELETE FROM Student_Answers_Exam WHERE Question_ID = @question_id;

		-- Delete records associated with the question ID from the Exam_Quest_Generation table
        DELETE FROM Exam_Quest_Generation WHERE Question_ID = @question_id;

        -- Delete choices associated with the question
        DELETE FROM question_choices WHERE question_id = @question_id;

        -- Delete the question
        DELETE FROM questions WHERE question_id = @question_id;
        PRINT 'Question, associated choices, and related records deleted successfully.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;


-----test------
-- Test case: Delete a question with a valid question ID
deletequestionwithchoices @question_id = 3;

--------------------------------------------------------------
--3)/*Faculty*/
create procedure deletefaculty @fcode varchar(200)
as
begin
    begin try
        -- Check if the faculty exists
        if not exists (select 1 from faculty where fcode = @fcode)
        begin
            throw 60005, 'Invalid faculty code. Please provide a valid faculty code.', 1;
        end
        -- Check if the faculty has associated students
        if exists (select 1 from studentsinfo where fcode = @fcode)
        begin
            throw 60006, 'Cannot delete faculty. Faculty has associated students.', 1;
        end
        -- Delete the faculty
        delete from faculty
        where fcode = @fcode;
        print 'Faculty deleted successfully.';
    end try
    begin catch
        print error_message();
    end catch
end;
-----test----
deletefaculty @fcode ='EGY-UNV002'
select * from Faculty
---------------------------------------------------------------
--4)/*Student_address*/

create proc deletestudentaddress @zipcode int
as
begin
    begin try
        -- Check if the student address exists
        if not exists (select 1 from student_address where zipcode = @zipcode)
        begin
            throw 60007, 'Invalid zipcode. Please provide a valid zipcode.', 1;
        end
        -- Check if the address has associated students
        if exists (select 1 from studentsinfo where zipcode = @zipcode)
        begin
            throw 60008, 'Cannot delete student address. Address has associated students.', 1;
        end
        -- Delete the address
        delete from student_address
        where zipcode = @zipcode;
        print 'Student address deleted successfully.';
    end try
    begin catch
        print error_message();
    end catch
end;
-------test----
deletestudentaddress @zipcode=10101
select * from Student_address
----------------------------------------------------
--5)/*Instructor_address*/
create proc deleteinstructoraddress  @zipcode int
as
begin
    begin try
        -- Check if the instructor address exists
        if not exists (select 1 from instructor_address where zipcode = @zipcode)
        begin
            throw 60009, 'Invalid zipcode. Please provide a valid zipcode.', 1;
        end
        -- Check if the address has associated instructors
        if exists (select 1 from instructors where zipcode = @zipcode)
        begin
            throw 60010, 'Cannot delete instructor address. Address has associated instructors.', 1;
        end
        -- Delete the address
        delete from instructor_address
        where zipcode = @zipcode;
        print 'Instructor address deleted successfully.';
    end try
    begin catch
        print error_message();
    end catch
end;
----test----
EXEC deleteinstructoraddress @zipcode = 11117;

--------------------------------------------------
--6)Gradute_company
create or alter proc deletegraduatedcompany  @company_code varchar(250)
as
begin
    begin try
        -- Check if the company exists
        if not exists (select 1 from graduate_company where company_code = @company_code)
        begin
            throw 60011, 'Invalid company code. Please provide a valid company code.', 1;
        end
        -- Check if the company has associated graduates
        if exists (select 1 from Graduatesworkcompany where Company_code = @company_code)
        begin
            throw 60012, 'Cannot delete graduated company. Company has associated graduates.', 1;
        end
        -- Delete the company
        delete from Graduate_company
        where company_code = @company_code;
        print 'Graduated company deleted successfully.';
    end try
    begin catch
        print error_message();
    end catch
end;
---------------test-----------------------------
deletegraduatedcompany @company_code = 'EGY-CMP001';
----------------------------------------------------
--7)Instructors
create or alter PROCEDURE deleteinstructor @inst_id INT, @new_inst_id INT -- The ID of the instructor to which courses will be reassigned
AS
BEGIN
    BEGIN TRY
        -- Check if the instructor exists
        IF NOT EXISTS (SELECT 1 FROM instructors WHERE inst_id = @inst_id)
        BEGIN
            THROW 60013, 'Invalid instructor ID. Please provide a valid instructor ID.', 1;
        END
        -- Reassign courses to the new instructor
        UPDATE Courses
        SET Inst_ID = @new_inst_id
        WHERE Inst_ID = @inst_id;
        -- Delete the instructor's phone records
        DELETE FROM instructor_phone
        WHERE inst_id = @inst_id;
        -- Delete the instructor
        DELETE FROM instructors
        WHERE inst_id = @inst_id;
        PRINT 'Instructor, associated phone records, and courses reassigned successfully.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;

-------test------
EXEC deleteinstructor @inst_id = 13,@new_inst_id=25;

-----------------------------------------------------
--8)/*Topics*/
create procedure delete_topic  @topic_id int
as
begin
    begin try
        -- Check if Topic_ID exists in the Topics table
        if not exists (select 1 from topics where topic_id = @topic_id)
        begin
            throw 50014, 'Invalid topic ID. Please provide a valid topic ID.', 1;
        end
        -- Check if the topic is the only topic associated with the course
        declare @course_id int;
        select @course_id = course_id from topics where topic_id = @topic_id;

        if (select count(*) from topics where course_id = @course_id) <= 2
        begin
            throw 50015, 'Cannot delete topic. Course must have at least two topic.', 1;
        end
        -- Delete the topic
        delete from topics where topic_id = @topic_id;
        print 'Topic deleted successfully.';
    end try
    begin catch
        print error_message();
    end catch
end;
----test----
EXEC delete_topic @topic_id = 1;

---------------------------------------------------------------
--9)/*Students*/
create or alter PROCEDURE deletestudent @St_ID int
AS
BEGIN
    BEGIN TRY
        -- Check if the student exists
        IF NOT EXISTS (SELECT 1 FROM StudentsInfo WHERE St_ID = @St_ID)
        BEGIN
            THROW 60016, 'Invalid student ID. Please provide a valid student ID.', 1;
        END
        -- Delete records from Student_Takes_Exam associated with the student
        DELETE FROM Student_Takes_Exam WHERE St_ID = @St_ID;

        -- Check if the student is enrolled in any intake
        IF EXISTS (SELECT 1 FROM Student_enroll_intake WHERE St_ID = @St_ID)
        BEGIN
            -- If the student is enrolled in any intake, delete the enrollment record
            DELETE FROM Student_enroll_intake WHERE St_ID = @St_ID;
            PRINT 'Student enrollment in intake deleted.';
        END

        -- Check if the student is enrolled in any round
        IF EXISTS (SELECT 1 FROM Student_enroll_Round WHERE St_ID = @St_ID)
        BEGIN
            -- If the student is enrolled in any round, delete the enrollment record
            DELETE FROM Student_enroll_Round WHERE St_ID = @St_ID;
            PRINT 'Student enrollment in round deleted.';
        END

        -- Delete the Student_Certificates records
        DELETE FROM Student_Certificates WHERE St_ID = @St_ID;

        -- Delete the student's phone records
        DELETE FROM Student_Phone WHERE St_ID = @St_ID;

        -- Delete the student
        DELETE FROM StudentsInfo WHERE St_ID = @St_ID;
        PRINT 'Student and associated records deleted successfully.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;

-----test---
EXEC deletestudent @St_ID = 123;
-------------------------------------------------------------------
--10)/*Graduate*/
create or alter PROCEDURE delete_graduate @graduate_id INT
AS
BEGIN
    BEGIN TRY
        -- Check if the graduate exists
        IF NOT EXISTS (SELECT 1 FROM graduates WHERE graduate_id = @graduate_id)
        BEGIN
            THROW 60017, 'Invalid graduate ID. Please provide a valid graduate ID.', 1;
        END

        -- Delete records from Graduate_Phone table associated with the graduate
        DELETE FROM Graduate_Phone WHERE Graduate_ID = @graduate_id;

        -- Delete records from Graduate_Fail_Reasons table associated with the graduate
        DELETE FROM Graduate_Fail_Reasons WHERE Graduate_ID = @graduate_id;

        -- Delete records from Graduates_work_at_company table associated with the graduate
        DELETE FROM Graduatesworkcompany WHERE Graduate_ID = @graduate_id;

        -- Delete the graduate
        DELETE FROM graduates WHERE graduate_id = @graduate_id;
        PRINT 'Graduate and associated records deleted successfully.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;

-----test-----
EXEC delete_graduate @graduate_id=122;
-----------------------------------------------------------------------------
--11)Tracks
create or ALTER PROCEDURE delete_track @track_id INT
AS
BEGIN
    BEGIN TRY
        -- Check if the track exists
        IF NOT EXISTS (SELECT 1 FROM tracks WHERE track_id = @track_id)
        BEGIN
            THROW 60018, 'Invalid track ID. Please provide a valid track ID.', 1;
        END

        -- Check if there are graduates associated with the track
        IF EXISTS (SELECT 1 FROM graduates WHERE track_id = @track_id)
        BEGIN
            -- Check if there are graduates with incomplete certification
            IF EXISTS (SELECT 1 FROM graduates WHERE Graduate_Certification = 'Not completed' AND track_id = @track_id)
            BEGIN
                -- Delete from Graduates_work_at_company
                DELETE FROM Graduatesworkcompany WHERE graduate_id IN (SELECT graduate_id FROM graduates WHERE track_id = @track_id);

                -- Remove graduates associated with the track from Graduates_fail_reasons
                DELETE FROM Graduate_Fail_Reasons WHERE graduate_id IN (SELECT graduate_id FROM graduates WHERE track_id = @track_id);

                -- Remove graduates associated with the track from Graduate_Phone
                DELETE FROM Graduate_Phone WHERE Graduate_ID IN (SELECT graduate_id FROM graduates WHERE track_id = @track_id);

                -- Remove graduates associated with the track
                DELETE FROM graduates WHERE track_id = @track_id;
            END
            ELSE
            BEGIN
                -- Remove graduates associated with the track from Graduates_work_at_company
                DELETE FROM Graduatesworkcompany WHERE graduate_id IN (SELECT graduate_id FROM graduates WHERE track_id = @track_id);

                -- Remove graduates associated with the track from Graduate_Phone
                DELETE FROM Graduate_Phone WHERE Graduate_ID IN (SELECT graduate_id FROM graduates WHERE track_id = @track_id);

                -- Remove graduates associated with the track
                DELETE FROM graduates WHERE track_id = @track_id;
            END
        END

        -- Delete records from Track_Contains_Courses
        DELETE FROM Track_Contains_Courses WHERE Track_ID = @track_id;

        -- Delete the track
        DELETE FROM tracks WHERE track_id = @track_id;

        PRINT 'Track deleted successfully.';
    END TRY
    BEGIN CATCH
        PRINT ERROR_MESSAGE();
    END CATCH
END;



-----test----
delete_track @track_id = 3;
---------------------------------------------
--Done :)

		