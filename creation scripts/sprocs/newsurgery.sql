USE [MedicalTourism]
GO

/****** Object:  StoredProcedure [dbo].[NewSurgery]    Script Date: 5/7/2015 2:28:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[NewSurgery]
@SurgeryName varchar(20),
@SurgeryType varchar(10),
@HugeCost money,
@RecoveryTime smallint

AS

IF((SELECT COUNT(1) FROM Surgery WHERE
	S_NAME = @SurgeryName AND
	Type = @SUrgeryType
	GROUP BY S_NAME) > 0)
BEGIN
	RAISERROR ('Surgery already exists',14,1)
	ROLLBACK TRANSACTION
END

INSERT INTO [Surgery](S_NAME,Type,US_cost,Recovery)
VALUES (@SurgeryName, @SurgeryType, @HugeCost, @RecoveryTime)



GO

