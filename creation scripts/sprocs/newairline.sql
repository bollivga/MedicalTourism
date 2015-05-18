USE [MedicalTourism]
GO

/****** Object:  StoredProcedure [dbo].[NewAirline]    Script Date: 5/7/2015 2:28:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[NewAirline]
@AirlineName varchar(10)

AS

DECLARE @AirlineID int
SET @AirlineID = (SELECT max(A_ID) FROM [Airline]) + 1

IF(@AirlineName in (SELECT Name FROM Airline))
BEGIN
	RAISERROR ('Airline name already in use',14,1)
	ROLLBACK TRANSACTION
END

INSERT INTO [Airline](A_ID,Name)
VALUES (@AirlineID, @AirlineName)


GO

