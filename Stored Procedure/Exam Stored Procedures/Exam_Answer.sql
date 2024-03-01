create procedure [dbo].[exam_answer]
    @st_ID  int,
	@exam_ID INT,
	@q_ID int, 
	@answer varchar(300)
as
begin
declare @std_name varchar(50)
set @std_name = 
			(select StudentsInfo.St_Fname+' '+StudentsInfo.St_Lname from StudentsInfo
			where StudentsInfo.St_ID = @st_ID)
    begin try
        IF (@exam_ID IS NULL OR @st_ID IS NULL OR @q_ID IS NULL )
            RAISERROR('exam_ID, this data are required', 16, 1)
        ELSE
            -- Insert the answers into the answers table
            INSERT INTO Student_Answers_Exam(St_ID,Exam_ID,Question_ID,St_Answer)
            VALUES (@st_ID,@exam_ID,@q_ID,@answer)

    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT @ErrorMessage = ERROR_MESSAGE(),
               @ErrorSeverity = ERROR_SEVERITY(),
               @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;
END;


exam_answer 1,201,8,'To ensure data integrity and consistency by grouping related operations together'

exam_answer 1,201,10,'To group rows that have the same values into summary rows'


exam_answer 1,201,11,'GETDATE()'

exam_answer 1,201,14,'To save the changes made in the current transaction to the database'


exam_answer 1,201,17,'To save the changes made in the current transaction to the database'

exam_answer 1,201,116,'To save the changes made in the current transaction to the database'

exam_answer 1,201,117,'False'

exam_answer 1,201,118,'True'

exam_answer 1,201,119,'True'

exam_answer 1,201,120,'False'

select * from Student_Answers_Exam