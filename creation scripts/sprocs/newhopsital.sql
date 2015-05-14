USE [MedicalTourism]
GO

/****** Object:  StoredProcedure [dbo].[NewHospital]    Script Date: 5/7/2015 2:28:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[NewHospital]
@H_Name varchar(10),
@CityID int,
@Rating int,
@PIN int

AS

IF (@CityID not in (SELECT CIT_ID FROM [City]))
BEGIN
	print 'City ID not valid. No changes made to database. Please add new city before trying again.'
	ROLLBACK TRANSACTION
END

DECLARE @Hospital_ID int
SET @Hospital_ID = (SELECT max(H_ID) FROM [Hospital]) + 1

INSERT INTO [Hospital] (H_ID,Rating,Name,CIT_ID)
VALUES (@Hospital_ID, @Rating, @H_Name, @CityID)



GO

