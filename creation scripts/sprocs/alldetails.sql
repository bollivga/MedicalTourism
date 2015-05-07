USE [MedicalTourism]
GO

/****** Object:  StoredProcedure [dbo].[AllDetails]    Script Date: 5/7/2015 1:55:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[AllDetails]

@SelectedCity varchar(20),
@Surgery varchar(20)

AS

DECLARE @City_id AS INTEGER
SET @City_id = (SELECT CIT_ID FROM City WHERE Name = @SelectedCity)

DECLARE @Hospital_id AS INTEGER
SET @Hospital_id = (SELECT H_ID FROM Hospital WHERE CIT_ID = @City_id)

DECLARE @Airline_id AS INTEGER
SET @Airline_id = (SELECT TOP 1 Visits.A_ID FROM Visits WHERE Visits.CIT_ID = @City_id)

--Returns all info about the trip
SELECT City.CO_NAME as Country, Surgery.S_NAME as Surgery, City.Name as [City], City.Rating, Hospital.Name as [Hospital], Airline.Name as [Airline]

FROM City, Surgery, Airline, Hospital

WHERE	City.Name = @SelectedCity and
		Hospital.CIT_ID = @City_id and
		Airline.A_ID = @Airline_id and
		Surgery.S_NAME = @Surgery


--Returns price information of the trip
SELECT Offers.Avg_cost as [Surgery cost], Visits.Avg_cost as [Flight cost], Hotel.CPN as [Hotel fees]
FROM Offers, Visits, Hotel
WHERE Offers.H_ID = @Hospital_id and Hotel.CIT_ID = @City_id and
		Visits.A_ID = @Airline_id



GO

