USE [MedicalTourism]
GO

/****** Object:  StoredProcedure [dbo].[NewHotel]    Script Date: 5/7/2015 2:28:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[NewHotel]
@Name varchar(20),
@CityID smallint,
@CostPerNight money

AS

IF (@CityID not in (SELECT CIT_ID FROM [City]))
BEGIN
	RAISERROR ('City ID not valid. No changes made to database. Please add new city before trying again.',14,1)
	ROLLBACK TRANSACTION
END

IF((SELECT COUNT(1) FROM Hotel WHERE
	Name = @Name AND
	CIT_ID = @CityID AND
	CPN = @CostPerNight
	GROUP BY NAME) > 0)
BEGIN
	RAISERROR ('City+Hotel+Cost combo already in use',14,1)
	ROLLBACK TRANSACTION
END

DECLARE @Hotel_ID int
SET @Hotel_ID = (SELECT max(HOT_ID) FROM [Hotel]) + 1

INSERT INTO [Hotel] (HOT_ID,Name,CPN,CIT_ID)
VALUES (@Hotel_ID, @Name, @CostPerNight, @CityID)



GO

