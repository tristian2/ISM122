--clear down database first
--run the code to add the sproc (when we're happy with the sproc, it will be merged into the db creation script)
--then run these lines
--this should fail
EXEC spAddNewTrainer
  '',
  'fred',
  '123 a road anytown',
  'fred@email.com',
  'RS01,RN01,MP01' --fails

--exec spAddNewTrainer 'bloggs','','123 a road anytown','fred@email.com','RSo1,RN01,MP01' --fails
--exec spAddNewTrainer 'bloggs','fred','','fred@email.com','RSo1,RN01,MP01' --fails
--exec spAddNewTrainer 'bloggs','fred','123 a road anytown','','RSo1,RN01,MP01' --fails
--exec spAddNewTrainer 'bloggs','fred','123 a road anytown','fred@email.com','' --fails
--exec spAddNewTrainer 'bloggs','fred','123 a road anytown','fred£email.com','RSo1,RN01,MP01' --fails

--this should pass with new trainer of id=5 for the first run, then incrementing
EXEC spAddNewTrainer
  'bloggs',
  'fred',
  '123 a road anytown',
  'fred@email.com',
  'RS01,RN01,MP01'

--which it does running the following we expect three records as so
/*courseCode  courseDate
MP01  2018-11-28 00:00:00.000
RN01  2018-12-16 00:00:00.000
RS01  2018-12-01 00:00:00.000 */
SELECT coursecode,
       coursedate
FROM   [dbo].[tcourseinstance]
WHERE  coursecode IN ( 'RS01', 'RN01', 'MP01' )
       AND coursedate BETWEEN Getdate() AND Dateadd(m, 2, Getdate())

SELECT *
FROM   ttrainer
ORDER  BY trainerid DESC  