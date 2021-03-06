USE [MedicalTourism]
GO

/****** Object:  StoredProcedure [dbo].[NewHospital]    Script Date: 5/7/2015 2:28:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[NewHospital]
@H_Name varchar(40),
@CityID int,
@Rating int,
@PIN int

AS


IF((@H_NAME IS NULL) OR (@CityID IS NULL) OR (@Rating IS NULL))
BEGIN
RAISERROR ('Invalid null input',14,1)
	RETURN
END

IF(@Rating < 0)
BEGIN
RAISERROR ('Invalid input: rating below 0',14,1)
	RETURN
END

IF(@Rating > 5)
BEGIN
RAISERROR ('Invalid input: rating above 5',14,1)
	RETURN
END

IF (@CityID not in (SELECT CIT_ID FROM [City]))
BEGIN
	RAISERROR ('City ID not valid. No changes made to database. Please add new city before trying again.',14,1)
	RETURN
END

DECLARE @Hospital_ID int
SET @Hospital_ID = (SELECT max(H_ID) FROM [Hospital]) + 1

IF((SELECT COUNT(1) FROM Hospital WHERE
	Name = @H_Name AND
	CIT_ID = @CityID
	GROUP BY Name
	) > 0)
BEGIN
	RAISERROR ('Duplicate data: Hospital name+location already in use',14,1)
	RETURN
END

INSERT INTO [Hospital] (H_ID,Rating,Name,CIT_ID)
VALUES (@Hospital_ID, @Rating, @H_Name, @CityID)



GO

