alter procedure Exam_Generation
	@Exam_ID int,
	@Course_ID int,
	@Exam_Level varchar(50),
	@Exam_Type varchar(50),
	@Exam_Duration varchar(100),
	@Exam_FullMark int,
	@Exam_Name varchar(100),
	@Num_TF_Questions int,
	@Num_MCQ_Questions int
as
begin
	declare @Quest_Difficulty varchar(20)
	if @Exam_Level='Basic'
		set @Quest_Difficulty='Basic'
	if @Exam_Level='Intermediate'
		set @Quest_Difficulty='Intermediate'
	if @Exam_Level='Advanced'
		set @Quest_Difficulty='Advanced'

	begin try
		if not exists (select * from Courses where Course_ID=@Course_ID)
			select 'Course doesnot exist' as 'error'
		else
			----insert the generated exam in exam table---
			insert into Exams(Exam_ID,Exam_Level,Exam_Type,Exam_Date,Exam_Duration,Exam_FullMark,Exam_Name,Course_ID)
			values(@Exam_ID,@Exam_Level,@Exam_Type,GETDATE(),@Exam_Duration,@Exam_FullMark,@Exam_Name,@Course_ID)
			
			--insert T or F questions according to exam_level---
			insert into Exam_Quest_Generation(Exam_ID,Question_ID)
			select top (@Num_TF_Questions) @Exam_ID,Question_ID
			from Questions 
			where Questions.Course_ID=@Course_ID and Questions.Question_Type='T or F'
			and Questions.Question_Level=@Quest_Difficulty 
			order by NEWID()

			--insert MCQ questions according to exam_level---
			insert into Exam_Quest_Generation(Exam_ID,Question_ID)
			select top (@Num_MCQ_Questions) @Exam_ID,Question_ID
			from Questions 
			where Questions.Course_ID=@Course_ID and Questions.Question_Type='MCQ'
			and Questions.Question_Level=@Quest_Difficulty
			order by NEWID()

			-- Select exam model
            SELECT Q.* 
            FROM Exam_Quest_Generation eq, Questions Q, Exams E
			WHERE eq.Exam_ID = E.Exam_ID AND eq.Question_ID = Q.Question_ID AND eq.Exam_ID = @Exam_ID
			
		end try
		begin catch
			select ERROR_MESSAGE() as ErrorMessage
		end catch
end


delete from Exam_Quest_Generation where Exam_ID between 202 and 208
delete from Exams where Exam_ID between 202 and 208

Exam_Generation 202,200,'Intermediate','Online','30 minutes',50,'Data Mining and Warehouse',5,5

Exam_Generation 203,200,'Basic','Offline','30 minutes',50,'Data Mining and Warehouse',5,5

Exam_Generation 204,12,'Basic','Offline','30 minutes',50,'Web Development Basics',5,5

Exam_Generation 205,200,'Basic','Offline','30 minutes',50,'Data Mining and Warehouse',5,5

Exam_Generation 206,6,'Basic','Offline','30 minutes',50,'Data Mining and Warehouse',5,5

Exam_Generation 207,12,'Basic','Offline','30 minutes',50,'Data Mining and Warehouse',5,5

Exam_Generation 208,6,'Basic','Offline','30 minutes',50,'Data Mining and Warehouse',5,5

select * from Exams

