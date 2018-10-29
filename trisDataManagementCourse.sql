/* redsoft training amterials scripts
if using my machine, use the command blow to open an instance of sql server management studio
runas /netonly /user:UNIVERSITY\tso14 ssms.exe
tristian o'brien october 2018*/


USE [tso14]
GO

/****** Object:  Table [dbo].[Table_1]    Script Date: 08/10/2018 11:27:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


drop table [dbo]. tclient
drop table [dbo]. tcourse_instance
drop table [dbo]. tdelegate
drop table [dbo]. tcourse --be mindful of the order

CREATE TABLE [dbo]. tcourse(
	[Title] [nvarchar](30) NOT NULL,
	[Code] [char] (4) NOT NULL ,
	[Duration] [int] NOT NULL CHECK(Duration BETWEEN 1 AND 10),
	[Cost] [Money] NOT NULL CHECK(Cost BETWEEN 100 AND 5000)
) ON [PRIMARY]
GO

ALTER TABLE dbo. tcourse 
ADD CONSTRAINT PK_code PRIMARY KEY NONCLUSTERED (code);


CREATE TABLE [dbo]. tclient (
	[clientNumber] int NOT NULL,
	surname nvarchar(100) NOT NULL,
	forename nvarchar(100) NOT NULL,
	title varchar(5) NOT NULL,
	[address] ntext NOT NULL 
)

ALTER TABLE dbo. tclient 
ADD CONSTRAINT PK_client PRIMARY KEY NONCLUSTERED (clientNumber);

CREATE TABLE [dbo]. tcourse_instance(
	[CourseCode] [char] (4) NOT NULL ,
	[Date] [datetime] NOT NULL,
	[Trainer] [nvarchar](100)
) ON [PRIMARY]
ALTER TABLE [dbo].[tcourse_instance]  WITH CHECK ADD  CONSTRAINT [FK_tcourse_instance_tcourse] FOREIGN KEY([CourseCode])
REFERENCES [dbo].[tcourse] ([Code])
GO

ALTER TABLE [dbo].[tcourse_instance] CHECK CONSTRAINT [FK_tcourse_instance_tcourse]
GO

CREATE TABLE [dbo]. tdelegate(
	[CourseCode] [char] (4) NOT NULL ,
	[Date] [datetime] NOT NULL,
	[ClientNumber] [nvarchar](100)
) ON [PRIMARY]


GO

INSERT INTO [dbo].[tcourse]
           ([Title]
           ,[Code]
           ,[Duration]
           ,[Cost])
     VALUES
           ('RedSoft overview'
           ,'RS01'
           ,2
           ,475),
           ('RedCalc'
           ,'RC22'
           ,'1'
           ,'250'),
           ('RedBuild 4GL'
           ,'B401'
           ,5
           ,1150),
           ('RedMan - projects'
           ,'MP01'
           ,3
           ,865),
           ('Converting to RedBase'
           ,'CB01'
           ,2
           ,390),
           ('RedBase DBA'
           ,'DB01'
           ,3
           ,900),
           ('RedBase Programming'
           ,'DP21'
           ,5
           ,1200),
           ('RedBase tuning'
           ,'DT01'
           ,1
           ,300),
           ('RedNet'
           ,'RN01'
           ,2
           ,525)

set dateformat dmy

INSERT INTO [dbo].[tcourse_instance]
           ([CourseCode]
           ,[Date]
           ,[Trainer])
     VALUES
           ('RS01'
           ,CAST('29/1/2015' AS DATETIME)
           ,'Katie Fawset'),
           ('RC22'
           ,CAST('17/2/2015' AS DATETIME)
           ,'Bob Symonds'),
           ('B401'
           ,CAST('17/2/2015' AS DATETIME)
           ,'Glynn French'),
           ('MP01'
           ,CAST('28/2/2015' AS DATETIME)
           ,'Katie Fawset'),
           ('RC22'
           ,CAST('19/6/2015' AS DATETIME)
           ,'Bob Symonds'),
           ('CB01'
           ,CAST('27/3/2015' AS DATETIME)
           ,'Jill Parsnip'),
           ('RS01'
           ,CAST('13/2/2015' AS DATETIME)
           ,'Glynn French'),
           ('DB01'
           ,CAST('23/4/2015' AS DATETIME)
           ,'Katie Fawset'),
           ('DP21'
           ,CAST('19/5/2015' AS DATETIME)
           ,'Bob Symonds'),
           ('RC22'
           ,CAST('24/3/2015' AS DATETIME)
           ,'Jill Parsnip'),		   
           ('B401'
           ,CAST('1/9/2015' AS DATETIME)
           ,'Glynn French'),		   
           ('DT01'
           ,CAST('2/4/2015' AS DATETIME)
           ,'Bob Symonds'),
           ('B401'
           ,CAST('11/4/2015' AS DATETIME)
           ,'Jill Parsnip'),		   
           ('RN01'
           ,CAST('16/6/2015' AS DATETIME)
           ,'Glynn French')		
GO
drop view [dbo].vwExpensiveCourses
drop view [dbo].vwMediumDurationCourses
drop view [dbo].vwRedbaseCourses
drop view [dbo].vwSumCourses
drop view [dbo].vwCoursesLessThan
drop view [dbo].vwSum4GLCourses
drop view [dbo].vwCoursesTaughtByKatie
drop view [dbo].vwCoursesLongerThan1dAfterFeb2013
drop view [dbo].vwCourseInstanceDates
go
CREATE VIEW [dbo].vwExpensiveCourses
AS
SELECT        Title, Code, Duration, Cost
FROM            dbo.tcourse
WHERE        (Cost > 800)
go
CREATE VIEW [dbo].vwMediumDurationCourses
AS
SELECT        Title, Code, Duration, Cost
FROM            dbo.tcourse
WHERE        (Duration BETWEEN 2 AND 4)
go
CREATE VIEW [dbo].vwRedbaseCourses
AS
SELECT        Title, Code, Duration, Cost
FROM            dbo.tcourse
WHERE        (Title LIKE '%redbase%')
GO
CREATE VIEW [dbo].vwSumCourses
AS
SELECT        SUM(Cost) AS total
FROM            dbo.tcourse
go
CREATE VIEW [dbo].vwSum4GLCourses
AS
SELECT        SUM(Cost) AS total
FROM            dbo.tcourse
WHERE        (Title LIKE '%4GL%')
go
CREATE VIEW [dbo].vwCoursesLessThan
AS
SELECT        Title, Code, Duration, Cost
FROM            dbo.tcourse
WHERE        (Duration < 3) OR
                         (Cost < 500)
go
create view [dbo].vwCourseInstanceDates
as
select ci.date from tcourse c join tcourse_instance ci
on c.code = ci.coursecode
go
create view [dbo].vwCoursesTaughtByKatie
as
select * from tcourse c join tcourse_instance ci
on c.code = ci.coursecode
where trainer = 'Katie Fawset'
go
create view [dbo].vwCoursesLongerThan1dAfterFeb2013
as
select * from tcourse c join tcourse_instance ci
on c.code = ci.coursecode
where date > '1/3/2013'