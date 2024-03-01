--Report that takes the student ID and returns the grades of the student in all courses. %
Create PROCEDURE GetStudentGrade @StudentID int
AS
BEGIN
BEGIN TRY
  IF EXISTS (SELECT * FROM StudentsInfo WHERE St_ID = @StudentID)
  BEGIN
    SELECT 
      STE.St_ID,
      s.St_Fname + ' ' + s.St_Lname AS 'Full Name',
      C.Course_Name,
      CAST(ROUND(SUM(STE.Exam_Percentage) / COUNT(E.Exam_ID), 2) AS DECIMAL(10, 2)) AS Course_Grade 
    FROM 
      Student_Takes_Exam STE 
      INNER JOIN StudentsInfo s ON s.St_ID = STE.St_ID
      INNER JOIN Exams E ON E.Exam_ID = STE.Exam_ID
      INNER JOIN Courses C ON C.Course_ID = E.Course_ID
    WHERE  
      STE.St_ID = @StudentID
    GROUP BY 
      STE.St_ID, -- Include St_ID in the GROUP BY clause
      s.St_Fname, -- Include St_Fname in the GROUP BY clause
      s.St_Lname, -- Include St_Lname in the GROUP BY clause
      C.Course_Name;
  END
  ELSE
  BEGIN
    SELECT 'Student does not exist' AS St_ID;
  END
END TRY
BEGIN CATCH 
  SELECT ERROR_MESSAGE() AS error;
END CATCH
END

getstudentgrade 1