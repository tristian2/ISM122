--clear down database first
--run the code to add the sproc (when we're happy with the sproc, it will be merged into the db creation script)
--then run these lines

--this should fail
--exec spAddNewTrainer '','fred','123 a road anytown','fred@email.com','RS01,RN01,MP01' --fails
--exec spAddNewTrainer 'bloggs','','123 a road anytown','fred@email.com','RSo1,RN01,MP01' --fails
--exec spAddNewTrainer 'bloggs','fred','','fred@email.com','RSo1,RN01,MP01' --fails
--exec spAddNewTrainer 'bloggs','fred','123 a road anytown','','RSo1,RN01,MP01' --fails
--exec spAddNewTrainer 'bloggs','fred','123 a road anytown','fred@email.com','' --fails
--exec spAddNewTrainer 'bloggs','fred','123 a road anytown','fred£email.com','RSo1,RN01,MP01' --fails
--return
--this should pass with new trainer of id=5
exec spAddNewTrainer 'bloggs','fred','123 a road anytown','fred@email.com','RS01,RN01,MP01'
--which it does running the following
select coursecode, coursedate from [dbo].[tcourseinstance] 
	where coursecode in ('RS01','RN01','MP01') 
		and coursedate between GETDATE() and DATEADD(m,2,GETDATE())

