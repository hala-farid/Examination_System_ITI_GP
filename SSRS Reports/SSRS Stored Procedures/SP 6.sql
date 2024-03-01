Create PROCEDURE GetStudentAns @examId int , @studentId int
AS
BEGIN
BEGIN TRY

  IF EXISTS (SELECT * FROM Student_Answers_Exam WHERE St_ID = @studentId)
  BEGIN

  SELECT 
  Q.Question_Text, St_Answer
  FROM Exams E inner join Student_Answers_Exam SE on E.Exam_ID = SE.Exam_ID 
  inner join Questions Q on SE.Question_ID = Q.Question_ID
  inner join StudentsInfo St on St.St_ID = SE.St_ID
 
  WHERE E.Exam_ID = @examId AND St.St_ID = @studentId
  GROUP BY Q.Question_Text, St_Answer
    
END;
else
	begin
		select 'Student did not take exam' as 'St_ID'
	end
end try
begin catch 
	select ERROR_MESSAGE() as error
end catch
end

GetStudentAns 202,100

select  distinct St_ID,Exam_ID from Student_Answers_Exam