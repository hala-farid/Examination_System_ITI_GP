alter procedure Exam_Correction @Exam_ID int, @St_ID int
as

begin try
	if not exists (select * from Exams where Exam_ID=@Exam_ID)
		select 'exam doesnot exist' as 'error'
	else if not exists (select * from StudentsInfo where St_ID=@St_ID)
		select 'student doesnot exist' as 'error'
	else
		begin
		

			update Student_Answers_Exam 
			set Grade=case when Student_Answers_Exam.St_Answer=Questions.CorrectAnswer 
					       then 5
						   else 0
						   end
			from Student_Answers_Exam,Questions
			where Student_Answers_Exam.Question_ID=Questions.Question_ID
			and Student_Answers_Exam.Exam_ID=@Exam_ID
			and Student_Answers_Exam.St_ID=@St_ID

			declare @total_correct int
			select @total_correct=SUM(Grade)
			from Student_Answers_Exam
			where Student_Answers_Exam.Exam_ID=@Exam_ID
			and Student_Answers_Exam.St_ID=@St_ID

			declare @exam_percentage decimal(5,1)
			select @exam_percentage=(@total_correct*100.0)/Exam_FullMark
			from Student_Answers_Exam,Exams
			where student_answers_exam.Exam_ID=Exams.Exam_ID
			and Student_Answers_Exam.Exam_ID=@Exam_ID and St_ID=@St_ID

			declare @St_Status varchar(20)
				if @exam_percentage<50
				set @St_Status='Failed'
				if @exam_percentage>=50
				set @St_Status='Passed'

			insert into Student_Takes_Exam (St_ID,Exam_ID,Exam_Percentage,St_Status)
			values (@St_ID,@Exam_ID,@exam_percentage,@St_Status)
		end
end try
begin catch 
	select ERROR_MESSAGE() as errorMessage
end catch

Exam_Correction 201,1
select * from Student_Takes_Exam

delete from Student_Takes_Exam where Exam_ID=201

update exams set Exam_FullMark=50
where Exam_ID=201

select * from Student_Answers_Exam