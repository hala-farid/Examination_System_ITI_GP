--Report that returns student info accoring to Branch_ID parameter
create proc studsinfobybranchid @branchid int
as
begin
	begin try
		if exists (select * from Branches where Branch_ID=@branchid)
		begin
			select s.*
			from StudentsInfo s,Branches
			where s.Branch_ID=Branches.Branch_ID
			and s.Branch_ID=@branchid
		end
		else
		begin
			select 'Branch doesnot exist' as 'Branch_ID'
		end
end try
begin catch 
	select ERROR_MESSAGE() as error
end catch
end

studsinfobybranchid 2