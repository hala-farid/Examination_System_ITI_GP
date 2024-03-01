--Report that takes course id and returns its topics

create proc topicsbycourseid @courseid int
as
begin
	begin try
		if exists (select * from Courses where Course_ID=@courseid)
		begin
			select t.*
			from Topics t,Courses 
			where t.Course_ID=Courses.Course_ID
			and t.Course_ID=@courseid
		end
		else
		begin
			select 'course doesnot exist' as 'Course_ID'
		end
end try
begin catch 
	select ERROR_MESSAGE() as error
end catch
end

topicsbycourseid 6