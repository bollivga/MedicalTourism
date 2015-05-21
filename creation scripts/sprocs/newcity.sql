USE [MedicalTourism]
GO

/****** Object:  StoredProcedure [dbo].[NewCity]    Script Date: 5/7/2015 2:28:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[NewCity]
@CityName varchar(40),
@Rating int,
@Country varchar(40),
@PIN int

AS
IF((@CityName IS NULL) OR (@Rating IS NULL) OR (@Country IS NULL))
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

IF(@CityName = '')
BEGIN
RAISERROR ('Invalid input: no city name',14,1)
	RETURN
END

IF((SELECT COUNT(1) FROM City WHERE
	NAME = @CityName AND
	CO_NAME = @Country
	GROUP BY NAME) > 0)
BEGIN
	RAISERROR ('City+country combo already in use',14,1)
	ROLLBACK TRANSACTION
END

DECLARE @CityID int
SET @CityID = (SELECT max(CIT_ID) FROM [City]) + 1

INSERT INTO [City](CIT_ID,Name,Rating,CO_NAME)
VALUES (@CityID, @CityName, @Rating, @Country)


RETURN 0
GO

