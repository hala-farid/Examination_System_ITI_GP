/*select Stored Procedures*/
-----------------------------
--1)Branches
create proc selectbranch @branch_id int
as
begin
    begin try
        -- Check if the branch exists
        if not exists (select 1 from branches where branch_id = @branch_id)
        begin
            throw 70001, 'Invalid branch ID. Please provide a valid branch ID.', 1;
        end
        -- Select branch data
        select *
        from branches
        where branch_id = @branch_id;
    end try
    begin catch
        print error_message();
    end catch
end;
----test-----
selectbranch 1
select *
        from branches
        where branch_id =1
----------------------------------------------------------------------
--2)Question and choices
create procedure selectquestionwithchoices @question_id int
as
begin
    begin try
        -- Check if the question exists
        if not exists (select 1 from questions where question_id = @question_id)
        begin
           throw 70002, 'Invalid question ID. Please provide a valid question ID.', 1;
        end
        -- Select question data
        select q.*, qc.choice
        from questions q
        left join question_choices qc on q.question_id = qc.question_id
        where q.question_id = @question_id;
    end try
    begin catch
        print error_message();
    end catch
end;
---test---
selectquestionwithchoices 1
select q.*,qc.Choice
        from Questions q , Question_Choices qc
        where q.Question_ID= qc.Question_ID and  q.Question_ID =1
---------------------------------------------------------
--3)Faculty
create procedure selectfaculty @fcode varchar(200)
as
begin
    begin try
        -- Check if the faculty exists
        if not exists (select 1 from faculty where fcode = @fcode)
        begin
            throw 70003, 'Invalid faculty code. Please provide a valid faculty code.', 1;
        end
        -- Select faculty data
        select *
        from faculty
        where fcode = @fcode;
    end try
    begin catch
        print error_message();
    end catch
end;
----test----
selectfaculty 'EGY-UNV001'
select *
        from faculty
        where fcode ='EGY-UNV001'
---------------------------------------------------------------
--4)Student_address
create procedure selectstudentaddress @zipcode int
as
begin
    begin try
        -- Check if the student address exists
        if not exists (select 1 from student_address where zipcode = @zipcode)
        begin
            throw 70004, 'Invalid zipcode. Please provide a valid zipcode.', 1;
        end
        -- Select student address data
        select *
        from student_address
        where zipcode = @zipcode;
    end try
    begin catch
        print error_message();
    end catch
end;
----test----
selectstudentaddress 11111
select *
        from student_address
        where zipcode = 11111
---------------------------------------
--5)Instructor_address
create procedure selectinstructoraddress @zipcode int
as
begin
    begin try
        -- Check if the instructor address exists
        if not exists (select 1 from instructor_address where zipcode = @zipcode)
        begin
            throw 70005, 'Invalid zipcode. Please provide a valid zipcode.', 1;
        end
        -- Select instructor address data
        select *
        from instructor_address
        where zipcode = @zipcode;
    end try
    begin catch
        print error_message();
    end catch
end;
----test----
selectinstructoraddress 11111
 select *
        from instructor_address
        where zipcode =11111
------------------------------------------------------
--6)Gradute_company
create procedure selectgradutecompany @company_code varchar(250)
as
begin
    begin try
        -- Check if the graduate company exists
        if not exists (select 1 from Graduate_company where company_code = @company_code)
        begin
            throw 70006, 'Invalid company code. Please provide a valid company code.', 1;
        end
        -- Select graduate company data
        select *
        from Graduate_company
        where company_code = @company_code;
    end try
    begin catch
        print error_message();
    end catch
end;
----test---
selectgradutecompany 'EGY-CMP001'
 select *
        from Graduate_company
        where company_code= 'EGY-CMP001'
-----------------------------------------------------------
--7)Instructors
create procedure selectinstructors @inst_id int
as
begin
    begin try
        -- Check if the instructor exists
        if not exists (select 1 from instructors where inst_id = @inst_id)
        begin
            throw 70007, 'Invalid instructor ID. Please provide a valid instructor ID.', 1;
        end
        -- Select instructor data
        select *
        from instructors
        where inst_id = @inst_id;
    end try
    begin catch
        print error_message();
    end catch
end;
----test------
selectinstructors 1
  select *
        from instructors
        where inst_id =1
----------------------------------------------------------------------
--8)Instructor Phone
create procedure selectinstructorphone @inst_id int   
as
begin
    begin try
        -- Check if the instructor phone record exists
        if not exists (select 1 from instructor_phone where inst_id = @inst_id )
        begin
            throw 70008, 'Invalid instructor ID or phone number. Please provide valid information.', 1;
        end
        -- Select instructor phone record
        select *
        from instructor_phone
        where inst_id = @inst_id;
    end try
    begin catch
        print error_message();
    end catch
end;
----test----
selectinstructorphone 1
  select *
        from instructor_phone
        where inst_id=1
------------------------------------------------------------------
--9)Courses
create procedure selectcourses  @course_id int
as
begin
    begin try
        -- Check if the course exists
        if not exists (select 1 from courses where course_id = @course_id)
        begin
            throw 70009, 'Invalid course ID. Please provide a valid course ID.', 1;
        end
        -- Select course data
        select *
        from courses
        where course_id = @course_id;
    end try
    begin catch
        print error_message();
    end catch
end;
-----test-----
selectcourses 2
---------------------------------------------------------------
--10)Exams
create procedure selectexams  @exam_id int
as
begin
    begin try
        -- Check if the exam exists
        if not exists (select 1 from exams where exam_id = @exam_id)
        begin
            throw 70010, 'Invalid exam ID. Please provide a valid exam ID.', 1;
        end
        -- Select exam data
        select *
        from exams
        where exam_id = @exam_id;
    end try
    begin catch
        print error_message();
    end catch
end;
-----test------
selectexams 1
------------------------------------------------
--11)Topics
create procedure selecttopics  @topic_id int
as
begin
    begin try
        -- Check if the topic exists
        if not exists (select 1 from topics where topic_id = @topic_id)
        begin
            throw 70011, 'Invalid topic ID. Please provide a valid topic ID.', 1;
        end
        -- Select topic data
        select *
        from topics
        where topic_id = @topic_id;
    end try
    begin catch
        print error_message();
    end catch
end;
---test---
selecttopics 2 
---------------------------------------------------------
--12)Tracks
create procedure selecttracks @track_id int
as
begin
    begin try
        -- Check if the track exists
        if not exists (select 1 from tracks where track_id = @track_id)
        begin
            throw 70012, 'Invalid track ID. Please provide a valid track ID.', 1;
        end
        -- Select track data
        select *
        from tracks
        where track_id = @track_id;
    end try
    begin catch
        print error_message();
    end catch
end;
---test---
selecttracks 1
------------------------------------------------------
--13)Intake
create procedure selectintake @intake_id int
as
begin
    begin try
        -- Check if the intake exists
        if not exists (select 1 from intake where intake_id = @intake_id)
        begin
            throw 70013, 'Invalid intake ID. Please provide a valid intake ID.', 1;
        end
        -- Select intake data
        select *
        from intake
        where intake_id = @intake_id;
    end try
    begin catch
        print error_message();
    end catch
end;
----test----
selectintake 3
---------------------------------------------------------------
--14)Round
create procedure selectrounds @round_id int
as
begin
    begin try
        -- Check if the round exists
        if not exists (select 1 from rounds where round_id = @round_id)
        begin
            throw 70014, 'Invalid round ID. Please provide a valid round ID.', 1;
        end
        -- Select round data
        select *
        from rounds
        where round_id = @round_id;
    end try
    begin catch
        print error_message();
    end catch
end;
----test----
selectrounds 3
------------------------------------------------------------------------
--15)Students
create procedure selectstudentsinfo  @st_id int
as
begin
    begin try
        -- Check if the student exists
        if not exists (select 1 from studentsinfo where st_id = @st_id)
        begin
            throw 70015, 'Invalid student ID. Please provide a valid student ID.', 1;
        end
        -- Select student data
        select *
        from studentsinfo
        where st_id = @st_id;
    end try
    begin catch
        print error_message();
    end catch
end;
----test----
selectstudentsinfo 3
-------------------------------------------------------------
--16)Student Phone
create procedure selectstudentphone @st_id int
as
begin
    begin try
        -- Check if the student phone record exists
        if not exists (select 1 from student_phone where st_id = @st_id)
        begin
            throw 70016, 'Invalid student ID. No phone number found for the provided student ID.', 1;
        end
        -- Select student phone data
        select *
        from student_phone
        where st_id = @st_id;
    end try
    begin catch
        print error_message();
    end catch
end;
----test----
selectstudentphone 1
----------------------------------------
--17)Track_Contains_Courses
create procedure selecttrackcontainscourses  @track_id int
as
begin
    begin try
        -- Check if the track contains the specified course
        if not exists (
            select 1 
            from track_contains_courses 
            where track_id = @track_id 
        )
        begin
            throw 70017, 'The specified track does not contain the specified course.', 1;
        end
        -- Select track-course relationship data
        select t.Track_ID,c.Course_ID,c.Course_Name
        from track_contains_courses t
		left join Courses c on t.Course_ID=c.Course_ID
		where track_id = @track_id ;
		
    end try
    begin catch
        print error_message();
    end catch
end;
-----test-----
selecttrackcontainscourses 2
--------------------------------------------------------------------
--18)Student_enroll_in_intake
create procedure selectstudentenrollintake @st_id int
as
begin
    begin try
        -- Check if the student enrollment in intake exists
        if not exists (select 1 from student_enroll_intake where st_id = @st_id)
        begin
            throw 70018, 'Invalid student ID. No enrollment record found for the provided student ID.', 1;
        end
        -- Select student enrollment data for intake
        select s.*, i.Intake_NO
        from student_enroll_intake s
		left join Intake i on s.Intake_ID=i.Intake_ID
        where st_id = @st_id;
    end try
    begin catch
        print error_message();
    end catch
end;
----test----
selectstudentenrollintake 1
-----------------------------------------------------------------
--19)Student_enroll_in_Round
create procedure selectstudentenrollround @st_id int
as
begin
    begin try
        -- Check if the student enrollment in round exists
        if not exists (select 1 from student_enroll_round where st_id = @st_id)
        begin
            throw 70019, 'Invalid student ID. No enrollment record found for the provided student ID.', 1;
        end
        -- Select student enrollment data for round
        select r.*,ro.Round_NO
        from Student_enroll_Round r
		left join Rounds ro on r.Round_ID=ro.Round_ID
        where st_id = @st_id;
    end try
    begin catch
        print error_message();
    end catch
end;
------test------
selectstudentenrollround 1001
----------------------------------------------------------------------
--20)Student_Answers_Exam
create procedure selectstudentanswersexam @st_id int
as
begin
    begin try
        -- Check if the student's answers for the exam exist
        if not exists (
            select 1 
            from student_answers_exam 
            where st_id = @st_id 
        )
        begin
            throw 70020, 'Invalid student ID or exam ID. No answers found for the provided student and exam.', 1;
        end
        -- Select student's answers for the exam
        select *
        from student_answers_exam
        where st_id = @st_id ;
    end try
    begin catch
        print error_message();
    end catch
end;
------test----
selectstudentanswersexam 100
------------------------------------------------
--21)Graduates
create procedure selectgraduates @graduate_id int
as
begin
    begin try
        -- Check if the graduate exists
        if not exists (select 1 from graduates where graduate_id = @graduate_id)
        begin
            throw 70021, 'Invalid graduate ID. No record found for the provided graduate ID.', 1;
        end
        -- Select graduate data
        select *
        from graduates
        where graduate_id = @graduate_id;
    end try
    begin catch
        print error_message();
    end catch
end;
----test---
selectgraduates 2
--------------------------------------------------------------------------
--22)Graduate_Fail_Reasons
create procedure selectGraduatesfailreasons @graduate_id int
as
begin
    begin try
        -- Check if the graduate's fail reasons exist
        if not exists (
            select 1 
            from Graduate_Fail_Reasons
            where graduate_id = @graduate_id
        )
        begin
            throw 70022, 'Invalid graduate ID. No fail reasons found for the provided graduate ID.', 1;
        end
        -- Select fail reasons for the graduate
        select *
        from Graduate_Fail_Reasons
        where graduate_id = @graduate_id;
    end try
    begin catch
        print error_message();
    end catch
end;
-----test----
selectGraduatesfailreasons 54
-----------------------------------------------------
--23)Student_Certificates
create procedure selectstudentcertificates @certificate_id int
as
begin
    begin try
        -- Check if the certificate exists
        if not exists (select 1 from student_certificates where certificate_id = @certificate_id)
        begin
            throw 70023, 'Invalid certificate ID. No record found for the provided certificate ID.', 1;
        end
        -- Select certificate data
        select *
        from student_certificates
        where certificate_id = @certificate_id;
    end try
    begin catch
        print error_message();
    end catch
end;
------test--------
selectstudentcertificates 1
-----------------------------------------------------------
--24)Graduates_work_at_company
create procedure selectgraduatesworkatcompany @graduate_id int
as
begin
    begin try
        -- Check if the graduate works at a company
        if not exists (
            select 1 
            from graduatesworkcompany 
            where graduate_id = @graduate_id
        )
        begin
            throw 70024, 'Invalid graduate ID. No record found for the provided graduate ID.', 1;
        end
        -- Select company information where the graduate works
        select *
        from graduatesworkcompany
        where graduate_id = @graduate_id;
    end try
    begin catch
        print error_message();
    end catch
end;
----test---
selectgraduatesworkatcompany 1
----------------------------------------------------------------
--25)Student_Takes_Exam
create procedure selectStudent_Takes_Exam @st_id int
as
begin
    begin try
        -- Check if the student's answers for the exam exist
        if not exists (
            select 1 
            from Student_Takes_Exam
            where st_id = @st_id 
        )
        begin
            throw 70020, 'Invalid student ID . No Grade found for the provided student and exam.', 1;
        end
        -- Select student's Grade for the exam
        select *
        from Student_Takes_Exam
        where st_id = @st_id ;
    end try
    begin catch
        print error_message();
    end catch
end;
------test----
selectStudent_Takes_Exam 1
--------------------------------------------------
//Good Luck! :)




