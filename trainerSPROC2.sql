SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
-- SET NOCOUNT ON added to prevent extra result sets from
-- interfering with SELECT statements.
SET NOCOUNT ON;

Declare @vmaxid int
select @vmaxid = max(trainerId) from [dbo].[tTrainer]
print 'ttrainer max id at start of sproc'
print @vmaxid

	begin try
		begin transaction
			INSERT INTO [dbo].[tTrainer]
				   ([Surname]
				   ,[Forename]
				   ,[Address]
				   ,[Email])
			 VALUES
				   (@Surname
				   ,@Forename
				   ,@Address
				   ,@Email)
			print 'ok added new identity'
			print @@identity
			insert into [dbo].[tTrainerQualification] (trainerid, coursecode)
			SELECT @@identity as tid,value FROM string_split(@qualifications,',')
		commit transaction

		--we'll return the courses for the next two months for that new trainer
		select coursecode, coursedate from [dbo].[tcourseinstance] 
		where coursecode in (select value from string_split(@qualifications,',')) 
			and coursedate between GETDATE() and DATEADD(m,2,GETDATE())

	end try
	begin catch
	  raiserror('Failed to add trainer.  check your input!  does name, address and email satisfy their constraints?', 16, 1)
	  rollback transaction
		print 'identity in catch block'
		print @@identity	  
		--reseed the identity value
		set @vmaxid = @vmaxid
		DBCC CHECKIDENT (tTrainer, reseed, @vmaxid)
		print 'ttrainer max id'
		print @vmaxid


	  return
	  print 'shouldnt be here'
	end catch	
SET NOCOUNT OFF;	
print 'end of sproc'
END
GO
