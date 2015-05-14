USE [MedicalTourism]
GO

/****** Object:  StoredProcedure [dbo].[NewAirlineRoute]    Script Date: 5/7/2015 2:28:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[NewAirlineRoute]
@AirlineID int,
@CityID int,
@Cost money,
@PIN int

AS

IF (@AirlineID not in (SELECT A_ID FROM [Airline]))
BEGIN
	print 'Airline ID not valid. No changes made to database. Please add new airline before trying again.'
	ROLLBACK TRANSACTION
END

IF (@CityID not in (SELECT CIT_ID FROM [City]))
BEGIN
	print 'City ID not valid. No changes made to database. Please add new city before trying again.'
	ROLLBACK TRANSACTION
END

INSERT INTO [Visits]
VALUES (@AirlineID, @CityID, @Cost)



GO

