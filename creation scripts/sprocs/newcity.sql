USE [MedicalTourism]
GO

/****** Object:  StoredProcedure [dbo].[NewCity]    Script Date: 5/7/2015 2:28:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[NewCity]
@CityName varchar(10),
@Rating int,
@Country varchar(20),
@PIN int

AS

DECLARE @CityID int
SET @CityID = (SELECT max(CIT_ID) FROM [City]) + 1

INSERT INTO [City]
VALUES (@CityID, @CityName, @Rating, @Country)



GO

