/* redsoft training materials scripts
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


drop table [dbo].tDelegate
drop table [dbo].tCourseInstance
drop TABLE [dbo].tRoomFacility
drop TABLE [dbo].tCourseFacility
drop TABLE [dbo].tFacility
drop TABLE [dbo].tRoom
drop TABLE [dbo].tBuilding
drop table [dbo].tTrainerQualification
drop table [dbo].tCourse 
drop table [dbo].tTrainer
drop table [dbo].tClient

CREATE TABLE [dbo].tBuilding(
	buildingId   int primary key NOT NULL,
	building [nvarchar] (30) NOT NULL
) ON [PRIMARY]
GO
CREATE TABLE [dbo].tRoom(
	roomId   int primary key NOT NULL,
	room [nvarchar] (30) NOT NULL,
	buildingId int not null,
	FOREIGN KEY(buildingId) REFERENCES [dbo].tBuilding	 (buildingId)

) ON [PRIMARY]
GO
CREATE TABLE [dbo].tClient (
	[clientNumber] int primary key NOT NULL,
	surname nvarchar(100) NOT NULL,
	forename nvarchar(100) NOT NULL,
	title nvarchar(6) NOT NULL,
	[address] ntext NOT NULL 
)
GO
CREATE TABLE [dbo].tTrainer(
	trainerId  int primary key identity(1,1) NOT NULL,
	surname nvarchar(30) not null CHECK(surname<>N''),
	forename nvarchar(20) not null CHECK(forename<>N''),
	[address] nvarchar(max) not null CHECK ([address]<>N''),
	email varchar(254) not null CHECK(email LIKE '%___@___%.__%')
	--this was an idea, but problem of circular keys! FOREIGN KEY([trainerId]) REFERENCES tTrainerQualification (trainerQualificationId)

) ON [PRIMARY]
GO
CREATE TABLE [dbo].tCourse(
	[code] [nvarchar] (4) primary key NOT NULL ,
	[title] [nvarchar](30) NOT NULL,
	[duration] [tinyint] NOT NULL CHECK(duration BETWEEN 1 AND 10),
	[cost] [Money] NOT NULL CHECK(cost BETWEEN 100 AND 5000),
	[leadtrainerId] int not null,
	FOREIGN KEY([leadtrainerId]) REFERENCES [dbo].tTrainer ([trainerId])

) ON [PRIMARY]
GO
CREATE TABLE [dbo].tTrainerQualification(
	trainerId int foreign key references tTrainer(trainerId),
	[courseCode] [nvarchar] (4) foreign key references tCourse(code),
	primary key(trainerId,courseCode)
) ON [PRIMARY]
GO
CREATE TABLE [dbo].tCourseInstance(
	[courseCode] [nvarchar] (4) NOT NULL ,
	[courseDate] [datetime] NOT NULL,
	[trainerId] int not null,
	[roomId] int not null,
	PRIMARY KEY(courseCode, courseDate),
	FOREIGN KEY([courseCode]) REFERENCES [dbo].[tCourse] ([code]),
	FOREIGN KEY([trainerId]) REFERENCES [dbo].tTrainer ([trainerId]),
	FOREIGN KEY([roomId]) REFERENCES [dbo].tRoom ([roomId])
) ON [PRIMARY]
GO
CREATE TABLE [dbo].tDelegate(
	[courseCode] [nvarchar] (4) NOT NULL ,
	[courseDate] [datetime] NOT NULL,
	[clientNumber] int not null,
	primary key(courseCode, courseDate,clientNumber),
	foreign key(courseCode,courseDate) references tCourseInstance(courseCode,courseDate),
	foreign key(clientNumber) references tClient(clientNumber)
) ON [PRIMARY]
GO
CREATE TABLE [dbo].tFacility(
	facilityId   int primary key NOT NULL,
	facility [nvarchar] (30) NOT NULL
) ON [PRIMARY]
GO
CREATE TABLE [dbo].tRoomFacility(
	roomId   int  foreign key references tRoom(roomId),
	facilityId   int foreign key references tFacility(facilityid),
	primary key(roomId,facilityid)
) ON [PRIMARY]
GO
CREATE TABLE [dbo].tCourseFacility(
	courseCode [nvarchar](4)  foreign key references tCourse(code),
	facilityId   int foreign key references tFacility(facilityid),
	primary key(courseCode,facilityid)
) ON [PRIMARY]
GO
set dateformat dmy

INSERT INTO [dbo].[tClient]
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
insert into [dbo].[tTrainer]
           (surname
		   ,forename
		   ,[address]
		   ,email)
		VALUES
           ('Fawsett','Katie','12 bonchurch road, bn2 3ph','k80@fawsett.com'),
		   ('Symonds','Bob','13 frankline road, bn2 3ah','bobs@symonds.net'),
		   ('Parsnip','Jill','13 southover street, bn2 1as','jilly256@hotmail.com'),
		   ('French','Glynn','23 acacia road, cr0 3ph','spaceman@arrarrarr.com')
go
INSERT INTO [dbo].[tCourse]
           ([title]
           ,[code]
           ,[duration]
           ,[cost]
		   ,[leadtrainerId])
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
		(courseCode
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
		(1,'RS01'),
		(1,'B401'),
		(1,'MP01'),
		(2,'RS01'),
		(2,'B401'),
		(2,'MP01'),
		(3,'B401'),
		(4,'MP01'),
		(4,'RC22')
go
INSERT INTO [dbo].[tCourseInstance]
           ([courseCode]
           ,[courseDate]
           ,[trainerId]
		   ,[roomId])
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
           ,CAST('28/11/2018' AS DATETIME)
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
           ,CAST('16/12/2018' AS DATETIME)
           ,4
		   ,5)		
GO

INSERT INTO [dbo].[tDelegate]
           ([courseCode]
           ,[courseDate]
           ,[clientNumber])
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

drop view [dbo].[vwTrainerQualificationsTest]
drop view [dbo].vwExpensiveCourses
drop view [dbo].vwMediumdurationCourses
drop view [dbo].vwRedbaseCourses
drop view [dbo].vwSumCourses
drop view [dbo].vwCoursesLessThan
drop view [dbo].vwSum4GLCourses
drop view [dbo].[vwCoursesTaughtByKatie]


drop view [dbo].vwCoursesLongerThan1dAfterFeb2013
drop view [dbo].vwCourseInstanceDates
go
--test view to see what course a trainer can deliver
CREATE VIEW [dbo].[vwTrainerQualificationsTest]
AS
SELECT        dbo.tTrainer.trainerId, dbo.tTrainer.surname, dbo.tTrainer.forename, dbo.tTrainer.Address, dbo.tTrainer.email, dbo.tTrainerQualification.trainerId AS Expr1, dbo.tTrainerQualification.courseCode
FROM            dbo.tTrainer INNER JOIN
                         dbo.tTrainerQualification ON dbo.tTrainer.trainerId = dbo.tTrainerQualification.trainerId
GO

CREATE VIEW [dbo].vwExpensiveCourses
AS
SELECT        title, code, duration, cost
FROM            dbo.tCourse
WHERE        (cost > 800)
go
CREATE VIEW [dbo].vwMediumdurationCourses
AS
SELECT        title, code, duration, cost
FROM            dbo.tCourse
WHERE        (duration BETWEEN 2 AND 4)
go
CREATE VIEW [dbo].vwRedbaseCourses
AS
SELECT        title, code, duration, cost
FROM            dbo.tCourse
WHERE        (title LIKE '%redbase%')
GO
CREATE VIEW [dbo].vwSumCourses
AS
SELECT        SUM(cost) AS total
FROM            dbo.tCourse
go
CREATE VIEW [dbo].vwSum4GLCourses
AS
SELECT        SUM(cost) AS total
FROM            dbo.tCourse
WHERE        (title LIKE '%4GL%')
go
CREATE VIEW [dbo].vwCoursesLessThan
AS
SELECT        title, code, duration, cost
FROM            dbo.tCourse
WHERE        (duration < 3) OR
                         (cost < 500)
go
create view [dbo].vwCourseInstanceDates
as
select ci.courseDate from tCourse c join tCourseInstance ci
on c.code = ci.courseCode
go
create view [dbo].vwCoursesTaughtByKatie
as
select * from tCourse c join tCourseInstance ci
on c.code = ci.courseCode
where trainerId = 1
go
create view [dbo].vwCoursesLongerThan1dAfterFeb2013
as
select * from tCourse c join tCourseInstance ci
on c.code = ci.courseCode
where courseDate > '1/3/2013'

go


-- =============================================
-- Author:		Tristian O'Brien
-- Create date: 8th November 2018
-- Description:	Allows the addition of a trainer and their skillz (qualifications)
--				skillz, should be the course coded as csv e.g. 'RS01','B401' etc.
-- =============================================
--CREATE PROCEDURE spAddNewTrainer
Alter PROCEDURE spAddNewTrainer
	@surname nvarchar(30),
	@forename nvarchar(20),
	@address ntext,
	@email varchar(254),
	@qualifications nvarchar(1000)	
AS
BEGIN
SET NOCOUNT ON;

Declare @vmaxid int
select @vmaxid = max(trainerId) from [dbo].[tTrainer]
	begin try
		begin transaction
			INSERT INTO [dbo].[tTrainer]
				   ([surname]
				   ,[forename]
				   ,[address]
				   ,[email])
			 VALUES
				   (@surname
				   ,@forename
				   ,@Address
				   ,@email)
			insert into [dbo].[tTrainerQualification] (trainerId, courseCode)
			SELECT @@identity as tid,value FROM string_split(@qualifications,',')
		commit transaction

		--we'll return the courses for the next two months for that new trainer
		select courseCode, courseDate from [dbo].[tCourseInstance] 
		where courseCode in (select value from string_split(@qualifications,',')) 
			and courseDate between GETDATE() and DATEADD(m,2,GETDATE())

	end try
	begin catch
	  raiserror('Failed to add trainer.  check your input!  does name, address and email satisfy their constraints?', 16, 1)
	  rollback transaction
		print 'identity in catch block'
		print @@identity	  
		--reseed the identity value
		set @vmaxid = @vmaxid
		DBCC CHECKIDENT (tTrainer, reseed, @vmaxid)
	  return
	end catch	
SET NOCOUNT OFF;	
END
GO
