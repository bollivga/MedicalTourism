USE [MedicalTourism]
GO

/****** Object:  StoredProcedure [dbo].[NewOffers]    Script Date: 5/7/2015 1:54:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[NewOffers]

@Surgery varchar(40),
@HospitalID int,
@Offer_Price money,
@PIN int

AS

--IF (@PIN != )

IF((@Surgery IS NULL) OR (@HospitalID IS NULL) OR (@Offer_price IS NULL))
BEGIN
RAISERROR ('Invalid null input',14,1)
	RETURN
END

IF(@Offer_Price < 0)
BEGIN
RAISERROR ('Invalid input: price below 0',14,1)
	RETURN
END

IF((SELECT COUNT(1) FROM Offers WHERE
	S_NAME = @Surgery AND
	@HospitalID = H_ID
	GROUP BY S_NAME) > 0)
BEGIN
	RAISERROR ('Hospital already offers procedure.',14,1)
	RETURN
END

IF (@HospitalID not in (SELECT H_ID FROM [Hospital]))
BEGIN
	RAISERROR ('Hospital ID not valid. No changes made to database. Please add new hospital before trying again.',14,1)
	RETURN
END

INSERT INTO [Offers](S_NAME,H_ID,Avg_Cost)
VALUES (@Surgery, @HospitalID, @Offer_Price)



GO

