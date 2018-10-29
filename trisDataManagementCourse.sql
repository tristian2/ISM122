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
drop table [dbo].tdelegate
drop table [dbo].tcourseinstance
drop table [dbo].tclient
drop table [dbo].tcourse --be mindful of the order
drop table [dbo].[ttrainer]
--drop table [dbo].[ttrainerlead]
drop table [dbo].tTrainerQualification
drop TABLE [dbo].tBuilding
drop TABLE [dbo].tRoom
drop TABLE [dbo].tRoomFacility
drop TABLE [dbo].tFacility














CREATE TABLE [dbo].tclient (
	[clientNumber] int primary key NOT NULL,
	surname nvarchar(100) NOT NULL,
	forename nvarchar(100) NOT NULL,
	title nvarchar(6) NOT NULL,
	[address] ntext NOT NULL 
)
GO
CREATE TABLE [dbo].tTrainer(
	trainerId  int primary key NOT NULL,
	Surname nvarchar(30) not null,
	Forename nvarchar(20) not null,
	[Address] ntext not null,
	Email varchar(254) not null CHECK(Email LIKE '%___@___%.__%')
) ON [PRIMARY]
GO
CREATE TABLE [dbo].tcourse(
	[Code] [nvarchar] (4) primary key NOT NULL ,
	[Title] [nvarchar](30) NOT NULL,
	[Duration] [tinyint] NOT NULL CHECK(Duration BETWEEN 1 AND 10),
	[Cost] [Money] NOT NULL CHECK(Cost BETWEEN 100 AND 5000),
	[leadTrainerId] int not null,
	FOREIGN KEY([leadTrainerid]) REFERENCES [dbo].ttrainer ([trainerid])

) ON [PRIMARY]
GO
CREATE TABLE [dbo].tcourseinstance(
	[CourseCode] [nvarchar] (4) NOT NULL ,
	[CourseDate] [datetime] NOT NULL,
	[TrainerId] int not null,
	PRIMARY KEY(CourseCode, CourseDate),
	FOREIGN KEY([CourseCode]) REFERENCES [dbo].[tcourse] ([Code]),
	FOREIGN KEY([Trainerid]) REFERENCES [dbo].ttrainer ([trainerid])
) ON [PRIMARY]
GO

CREATE TABLE [dbo].tdelegate(
	[CourseCode] [nvarchar] (4) NOT NULL ,
	[CourseDate] [datetime] NOT NULL,
	[ClientNumber] int not null,
	primary key(CourseCode, Coursedate,ClientNumber),
	foreign key(CourseCode,CourseDate) references tcourseinstance(CourseCode,CourseDate),
	foreign key(clientnumber) references tclient(clientnumber)
) ON [PRIMARY]
GO

/* an alternative
CREATE TABLE [dbo].tTrainerLead(
	trainerId  int primary key NOT NULL,
	[CourseCode] [nvarchar] (4) NOT NULL
) ON [PRIMARY]
GO*/


CREATE TABLE [dbo].tTrainerQualification(
	trainerId  int NOT NULL,
	Qualification [nvarchar] (30) NOT NULL
) ON [PRIMARY]
GO
CREATE TABLE [dbo].tBuilding(
	buildingId   int primary key NOT NULL,
	building [nvarchar] (30) NOT NULL
) ON [PRIMARY]
GO
CREATE TABLE [dbo].tRoom(
	roomId   int primary key NOT NULL,
	room [nvarchar] (30) NOT NULL
) ON [PRIMARY]
GO
CREATE TABLE [dbo].tRoomFacility(
	roomId   int  NOT NULL,
	facilityId   int NOT NULL,
) ON [PRIMARY]
GO
CREATE TABLE [dbo].tFacility(
	facilityId   int primary key NOT NULL,
	facility [nvarchar] (30) NOT NULL
) ON [PRIMARY]
GO


--todo 

insert into tTrainerQualification 
	(trainerId
	 ,Qualification)
	 VALUES 
		(1,'DBA'),
		(2,'ISEB level x'),
		(3,'CITP'),
		(4,'MCP')
insert into tFacility 
	(facilityId
	 ,facility)
	 VALUES 
		(1,'projector'),
		(2,'smart board'),
		(3,'video confernecing')
insert into [dbo].[tRoomFacility]
		(roomId
			,facilityId)
		VALUES
			(1, 1),
			(1, 2),
			(2, 3),
			(3, 3),
			(4, 1),
			(5, 1)

insert into ttrainer
           (trainerid
		   ,surname
		   ,forename
		   ,[address]
		   ,email)
		VALUES
           (1,'Fawsett','Katie','12 bonchurch road, bn2 3ph','k80@fawsett.com'),
		   (2,'Symonds','Bob','13 frankline road, bn2 3ah','bobs@symonds.net'),
		   (3,'Parsnip','Jill','13 southover street, bn2 1as','jilly256@hotmail.com'),
		   (4,'French','Glynn','23 acacia road, cr0 3ph','spaceman@arrarrarr.com')




INSERT INTO [dbo].[tcourse]
           ([Title]
           ,[Code]
           ,[Duration]
           ,[Cost]
		   ,[leadTrainerId])
     VALUES
           ('RedSoft overview'
           ,'RS01'
           ,2
           ,475
		   ,2),
           ('RedCalc'
           ,'RC22'
           ,'1'
           ,'250'
		   ,2),
           ('RedBuild 4GL'
           ,'B401'
           ,5
           ,1150,
		   1),
           ('RedMan - projects'
           ,'MP01'
           ,3
           ,865,
		   1),
           ('Converting to RedBase'
           ,'CB01'
           ,2
           ,390,
		   1),
           ('RedBase DBA'
           ,'DB01'
           ,3
           ,900
		   ,2),
           ('RedBase Programming'
           ,'DP21'
           ,5
           ,1200
		   ,1),
           ('RedBase tuning'
           ,'DT01'
           ,1
           ,300
		   ,2),
           ('RedNet'
           ,'RN01'
           ,2
           ,525
		   ,3)

set dateformat dmy

INSERT INTO [dbo].[tcourseinstance]
           ([CourseCode]
           ,[CourseDate]
           ,[TrainerId])
     VALUES
           ('RS01'
           ,CAST('29/1/2015' AS DATETIME)
           ,1),
           ('RC22'
           ,CAST('17/2/2015' AS DATETIME)
           ,2),
           ('B401'
           ,CAST('17/2/2015' AS DATETIME)
           ,4),
           ('MP01'
           ,CAST('28/2/2015' AS DATETIME)
           ,1),
           ('RC22'
           ,CAST('19/6/2015' AS DATETIME)
           ,2),
           ('CB01'
           ,CAST('27/3/2015' AS DATETIME)
           ,3),
           ('RS01'
           ,CAST('13/2/2015' AS DATETIME)
           ,4),
           ('DB01'
           ,CAST('23/4/2015' AS DATETIME)
           ,1),
           ('DP21'
           ,CAST('19/5/2015' AS DATETIME)
           ,2),
           ('RC22'
           ,CAST('24/3/2015' AS DATETIME)
           ,3),		   
           ('B401'
           ,CAST('1/9/2015' AS DATETIME)
           ,4),		   
           ('DT01'
           ,CAST('2/4/2015' AS DATETIME)
           ,2),
           ('B401'
           ,CAST('11/4/2015' AS DATETIME)
           ,3),		   
           ('RN01'
           ,CAST('16/6/2015' AS DATETIME)
           ,4)		
GO
drop view [dbo].vwExpensiveCourses
drop view [dbo].vwMediumDurationCourses
drop view [dbo].vwRedbaseCourses
drop view [dbo].vwSumCourses
drop view [dbo].vwCoursesLessThan
drop view [dbo].vwSum4GLCourses
drop view [dbo].[vwCoursesTaughtByKatie]


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
select ci.coursedate from tcourse c join tcourseinstance ci
on c.code = ci.coursecode
go
create view [dbo].vwCoursesTaughtByKatie
as
select * from tcourse c join tcourseinstance ci
on c.code = ci.coursecode
where trainerid = 1
go
create view [dbo].vwCoursesLongerThan1dAfterFeb2013
as
select * from tcourse c join tcourseinstance ci
on c.code = ci.coursecode
where coursedate > '1/3/2013'