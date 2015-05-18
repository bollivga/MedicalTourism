USE [MedicalTourism]
GO

/****** Object:  StoredProcedure [dbo].[NewOffers]    Script Date: 5/7/2015 1:54:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[NewOffers]

@Surgery varchar(20) = NULL,
@HospitalID int,
@Offer_Price money,
@PIN int

AS

--IF (@PIN != )

IF((SELECT COUNT(1) FROM Offers WHERE
	S_NAME = @Surgery AND
	@HospitalID = H_ID
	GROUP BY S_NAME) > 0)
BEGIN
	RAISERROR ('Hospital already offers procedure.',14,1)
	ROLLBACK TRANSACTION
END

IF (@HospitalID not in (SELECT H_ID FROM [Hospital]))
BEGIN
	RAISERROR ('Hospital ID not valid. No changes made to database. Please add new hospital before trying again.',14,1)
	ROLLBACK TRANSACTION
END

INSERT INTO [Offers](S_NAME,H_ID,Avg_Cost)
VALUES (@Surgery, @HospitalID, @Offer_Price)



GO

