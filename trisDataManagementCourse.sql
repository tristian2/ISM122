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
drop TABLE [dbo].tRoomFacility
drop TABLE [dbo].tCourseFacility
drop TABLE [dbo].tFacility
drop TABLE [dbo].tRoom
drop TABLE [dbo].tBuilding
drop table [dbo].tTrainerQualification
drop table [dbo].tcourse 
drop table [dbo].[ttrainer]
drop table [dbo].tclient

CREATE TABLE [dbo].tBuilding(
	buildingId   int primary key NOT NULL,
	building [nvarchar] (30) NOT NULL
) ON [PRIMARY]
GO
CREATE TABLE [dbo].tRoom(
	roomId   int primary key NOT NULL,
	room [nvarchar] (30) NOT NULL,
	buildingId int not null,
	FOREIGN KEY(buildingId) REFERENCES [dbo].tbuilding	 (buildingId)

) ON [PRIMARY]
GO
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
	Email varchar(254) not null CHECK(Email LIKE '%___@___%.__%')--,
	--FOREIGN KEY([trainerid]) REFERENCES ttrainerqualification (trainerQualificationId)

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
CREATE TABLE [dbo].tTrainerQualification(
	trainerId int foreign key references ttrainer(trainerid),
	[courseCode] [nvarchar] (4) foreign key references tcourse(code),
	primary key(trainerId,courseCode)
) ON [PRIMARY]
GO
CREATE TABLE [dbo].tcourseinstance(
	[CourseCode] [nvarchar] (4) NOT NULL ,
	[CourseDate] [datetime] NOT NULL,
	[TrainerId] int not null,
	[RoomId] int not null,
	PRIMARY KEY(CourseCode, CourseDate),
	FOREIGN KEY([CourseCode]) REFERENCES [dbo].[tcourse] ([Code]),
	FOREIGN KEY([Trainerid]) REFERENCES [dbo].ttrainer ([trainerid]),
	FOREIGN KEY([RoomId]) REFERENCES [dbo].troom ([Roomid])
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
CREATE TABLE [dbo].tFacility(
	facilityId   int primary key NOT NULL,
	facility [nvarchar] (30) NOT NULL
) ON [PRIMARY]
GO
CREATE TABLE [dbo].tRoomFacility(
	roomId   int  foreign key references troom(roomid),
	facilityId   int foreign key references tfacility(facilityid),
	primary key(roomid,facilityid)
) ON [PRIMARY]
GO
CREATE TABLE [dbo].tCourseFacility(
	CourseCode [nvarchar](4)  foreign key references tcourse(code),
	facilityId   int foreign key references tfacility(facilityid),
	primary key(CourseCode,facilityid)
) ON [PRIMARY]
GO
set dateformat dmy

INSERT INTO [dbo].[tclient]
           ([clientNumber]
           ,[surname]
           ,[forename]
           ,[title]
           ,[address])
     VALUES
           (1
           ,'holness'
           ,'bob'
           ,'mr.'
           ,'123 acacia st. lewes lw12 3ss'),
           (2
           ,'araiah'
           ,'zac'
           ,'mr.'
           ,'13 wall st. lewes lw2 3ds'),
           (3
           ,'smith'
           ,'lacy'
           ,'mrs.'
           ,'23 rock st. lewes lw2 5as'),
           (4
           ,'patel'
           ,'nic'
           ,'mr.'
           ,'3 road wk. soes sw12 3ss'),
           (5
           ,'fenk'
           ,'nacy'
           ,'mrs.'
           ,'44 acacia st. lewes lw12 3ss'),
           (6
           ,'fair'
           ,'noot'
           ,'mr.'
           ,'13 felt st. brighton bn2 3ss'),
           (7
           ,'polar'
           ,'bear'
           ,'mr.'
           ,'993 high st. lewes lw1 1aa'),
           (8
           ,'pope'
           ,'sara'
           ,'ms.'
           ,'77 acacia st. lewes lw12 3ss'),
           (14
           ,'pope'
           ,'bernie'
           ,'mr.'
           ,'99 hot st. lewes lw12 3ss'),
           (10
           ,'fairwirk'
           ,'bing'
           ,'mr.'
           ,'77 display ln. lewes lw88 4as'),
           (11
           ,'minks'
           ,'jasmine'
           ,'mrs.'
           ,'99 rock st. lewes lw12 3ss'),
           (12
           ,'bass-rocks'
           ,'david'
           ,'mr.'
           ,'88 server st. lewes lw12 3ss'),
           (13
           ,'phipps'
           ,'airle'
           ,'mrs.'
           ,'22 ever st. lewes lw12 3ss')
GO

insert into tBuilding 
	(buildingId
	,building)
	VALUES
	(1,'Watts'),
	(2,'Cockroft'),
	(3,'Mithras')
go
insert into tRoom
	(roomId
	,room
	,buildingid)
	VALUES 
	(1,'2A', 1),
	(2,'2B', 1),
	(3,'101',2),
	(4,'lecture XYZ', 3),
	(5,'seminar ABC', 3)
go
insert into tFacility 
	(facilityId
	 ,facility)
	 VALUES 
		(1,'MacOSX'),
		(2,'SQL Server'),
		(3,'Citrix'),
		(4,'Windows 10')
go
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
go
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
go
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


go
insert into [dbo].[tCourseFacility]
		(CourseCode
			,facilityId)
		VALUES
			('RS01', 1),
			('RC22', 3),
			('B401', 1),
			('MP01', 3),
			('MP01', 1),
			('RC22', 4),
			('CB01', 4)
go
insert into tTrainerQualification 
	(trainerId
	 ,courseCode)
	 VALUES 
		(1,'RC22'),
		(2,'RS01'),
		(3,'B401'),
		(4,'MP01')
go
INSERT INTO [dbo].[tcourseinstance]
           ([CourseCode]
           ,[CourseDate]
           ,[TrainerId]
		   ,[RoomId])
     VALUES
           ('RS01'
           ,CAST('1/12/2018' AS DATETIME)
           ,1
		   ,1),
           ('RC22'
           ,CAST('10/12/2018' AS DATETIME)
           ,2
		   ,1),
           ('B401'
           ,CAST('17/12/2018' AS DATETIME)
           ,4
		   ,2),
           ('MP01'
           ,CAST('28/2/2019' AS DATETIME)
           ,1
		   ,1),
           ('RC22'
           ,CAST('19/6/2019' AS DATETIME)
           ,2
		   ,2),
           ('CB01'
           ,CAST('27/3/2019' AS DATETIME)
           ,3
		   ,2),
           ('RS01'
           ,CAST('13/2/2019' AS DATETIME)
           ,4
		   ,2),
           ('DB01'
           ,CAST('23/4/2019' AS DATETIME)
           ,1
		   ,2),
           ('DP21'
           ,CAST('19/5/2019' AS DATETIME)
           ,2
		   ,3),
           ('RC22'
           ,CAST('24/3/2019' AS DATETIME)
           ,3
		   ,3),		   
           ('B401'
           ,CAST('1/9/2019' AS DATETIME)
           ,4
		   ,2),		   
           ('DT01'
           ,CAST('2/4/2019' AS DATETIME)
           ,2
		   ,3),
           ('B401'
           ,CAST('11/4/2019' AS DATETIME)
           ,3
		   ,4),		   
           ('RN01'
           ,CAST('16/6/2019' AS DATETIME)
           ,4
		   ,5)		
GO

INSERT INTO [dbo].[tdelegate]
           ([CourseCode]
           ,[CourseDate]
           ,[ClientNumber])
     VALUES
           ('RS01'
           ,CAST('1/12/2018' AS DATETIME)
           ,1),
           ('RS01'
           ,CAST('1/12/2018' AS DATETIME)
           ,2),
           ('RS01'
           ,CAST('1/12/2018' AS DATETIME)
           ,3),
           ('RS01'
           ,CAST('1/12/2018' AS DATETIME)
           ,4),
           ('RS01'
           ,CAST('1/12/2018' AS DATETIME)
           ,5),		   		
           ('RC22'
           ,CAST('10/12/2018' AS DATETIME)
           ,6),
           ('RC22'
           ,CAST('10/12/2018' AS DATETIME)
           ,7),
           ('RC22'
           ,CAST('10/12/2018' AS DATETIME)
           ,8),
           ('RC22'
           ,CAST('10/12/2018' AS DATETIME)
           ,10),
           ('B401'
           ,CAST('11/4/2019' AS DATETIME)
           ,10),
           ('B401'
           ,CAST('11/4/2019' AS DATETIME)
           ,11),
           ('B401'
           ,CAST('11/4/2019' AS DATETIME)
           ,7),
           ('B401'
           ,CAST('11/4/2019' AS DATETIME)
           ,12),
           ('B401'
           ,CAST('11/4/2019' AS DATETIME)
           ,13)


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