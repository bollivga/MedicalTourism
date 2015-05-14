USE [MedicalTourism]
GO

/****** Object:  StoredProcedure [dbo].[AddOffers]    Script Date: 5/7/2015 1:54:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[AddOffers]

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

INSERT INTO [Offers]
VALUES (@Surgery, @HospitalID, @Offer_Price)



GO

