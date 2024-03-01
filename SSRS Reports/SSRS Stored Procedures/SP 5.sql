alter PROCEDURE GetExamQS @examId int
AS
BEGIN
BEGIN TRY
  IF EXISTS (SELECT * FROM Exams WHERE Exam_ID = @examId)
  BEGIN

  select Questions.Question_ID,Question_Text,Question_Choices.Choice
from Questions,Exam_Quest_Generation,Exams,Question_Choices
where Questions.Question_ID=Exam_Quest_Generation.Question_ID
and Exams.Exam_ID=Exam_Quest_Generation.Exam_ID
and Questions.Question_ID=Question_Choices.Question_ID
and Exam_Quest_Generation.Exam_ID=@examid
order by Question_ID
 
    
END;
else
	begin
		select 'Exam does not exist' as 'Exam_ID'
	end
end try
begin catch 
	select ERROR_MESSAGE() as error
end catch
end

GetExamQS 202

select * from Exam_Quest_Generation