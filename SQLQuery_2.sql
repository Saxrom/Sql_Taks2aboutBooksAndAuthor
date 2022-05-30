CREATE DATABASE TaskBooks

USE TaskBooks

CREATE TABLE Books(
    Id INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(100) CONSTRAINT CK_Name CHECK(Len(Name)>=2),
    [PageCount] INT CONSTRAINT CK_Count CHECK([PageCount]>=10),
    Author_Id INT FOREIGN KEY REFERENCES Authors(ID)
)

CREATE TABLE Authors(
    ID INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(30),
    Surname NVARCHAR(30)
)

CREATE VIEW vw_GetsBookInfo 
as
SELECT * FROM
(
    SELECT b.Id ,b.[Name],[PageCount],a.[Name]+' '+Surname as AuthorFullname FROM Authors as a
    JOIN Books as b 
    on a.Id=b.Author_Id
)as AllBooks


CREATE PROCEDURE usp_Insert
@Name NVARCHAR(20),
@Surname NVARCHAR(20),
@Id INT PRIMARY KEY IDENTITY
AS
Insert into Authors(Name,Surname,ID)
VALUES(@Name,@Surname,@ID)

EXEC usp_Insert 'Shahrom','Rajabov',1

CREATE PROCEDURE usp_Update
@Id int,
@Name NVARCHAR(20)
AS
UPDATE Books
Set Books.Name=@Name WHERE Id=@Id

EXEC usp_Update 1,'wd'


CREATE PROCEDURE usp_Delete
@Id int
AS
DELETE FROM Authors
WHERE ID=@Id

EXEC usp_Delete 2


CREATE VIEW vw_AllInformation
AS
SELECT * FROM
(
    SELECT a.ID,a.Name+' '+a.Surname as Fullname,b.Pagecount as BookCount,MAX(b.PageCount) as MaxPageCount FROM Authors as a 
    JOIN Books as b
    on b.Author_Id=b.Id
)GROUP BY a.ID,Fullname,BookCount,MaxPageCount

