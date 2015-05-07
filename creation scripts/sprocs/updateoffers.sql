USE [MedicalTourism]
GO

/****** Object:  StoredProcedure [dbo].[UpdateOffers]    Script Date: 5/7/2015 2:29:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[UpdateOffers]

@Surgery varchar(20) = NULL,
@HospitalID int,
@Offer_Price money,
@PIN int

AS

--IF (@PIN != )

IF (@HospitalID not in (SELECT H_ID FROM [Hospital]))
BEGIN
	print 'Hospital ID not valid. No changes made to database. Please add new hospital before trying again.'
	ROLLBACK TRANSACTION
END

UPDATE [Offers]
SET Avg_cost = @Offer_Price
WHERE H_ID = @HospitalID and S_NAME = @Surgery



GO

