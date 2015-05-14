USE [MedicalTourism]
GO

/****** Object:  StoredProcedure [dbo].[NewVisits]    Script Date: 5/7/2015 2:28:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[NewVisits]
@AirlineID int,
@CityID int,
@Cost money,
@PIN int

AS

IF((SELECT COUNT(1) FROM Visits WHERE
	A_ID = @AirlineID AND
	CIT_ID = @CityID
	GROUP BY CIT_ID) > 0)
BEGIN
	RAISERROR ('Airline route already in database',14,1)
END

IF (@AirlineID not in (SELECT A_ID FROM [Airline]))
BEGIN
RAISERROR ('Airline ID not valid. No changes made to database. Please add new airline before trying again.',14,1)

END

IF (@CityID not in (SELECT CIT_ID FROM [City]))
BEGIN
RAISERROR ('City ID not valid. No changes made to database. Please add new city before trying again.',14,1)
END

INSERT INTO [Visits](A_ID,CIT_ID,Avg_cost)
VALUES (@AirlineID, @CityID, @Cost)



GO

