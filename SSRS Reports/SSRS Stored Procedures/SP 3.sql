CREATE PROCEDURE GetInstructorCourses @instructorId int
AS
BEGIN
BEGIN TRY
  IF EXISTS (SELECT * FROM Instructors WHERE Inst_ID = @instructorId)
  BEGIN
    SELECT 
      I.Inst_Fname + ' ' + I.Inst_Lname AS 'Full Name',
      C.Course_Name,
      COUNT(S.St_ID) AS StudentCount,
      I.Inst_ID 
    FROM  
      Courses C 
      INNER JOIN Instructors I ON I.Inst_ID = C.Inst_ID
      INNER JOIN Track_Contains_Courses CT ON CT.Course_ID = C.Course_ID
      INNER JOIN StudentsInfo S ON S.Track_ID = CT.Track_ID
    WHERE 
      I.Inst_ID = @instructorId
    GROUP BY 
      I.Inst_Fname, 
      I.Inst_Lname,
      C.Course_Name, 
      I.Inst_ID,
      I.Inst_Fname + ' ' + I.Inst_Lname;
  END
  ELSE
  BEGIN
    SELECT 'Instructor does not exist' AS 'Inst_ID';
  END
END TRY
BEGIN CATCH 
  SELECT ERROR_MESSAGE() AS error;
END CATCH
END

GetInstructorCourses 24

drop procedure GetInstructorCourses