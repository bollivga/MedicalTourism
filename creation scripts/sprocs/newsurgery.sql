USE [MedicalTourism]
GO

/****** Object:  StoredProcedure [dbo].[NewSurgery]    Script Date: 5/7/2015 2:28:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[NewSurgery]
@SurgeryName varchar(40),
@SurgeryType varchar(40),
@HugeCost money,
@RecoveryTime smallint

AS

IF((@SurgeryName IS NULL) OR (@SurgeryType IS NULL) OR (@HugeCost IS NULL) OR (@RecoveryTime IS NULL))
BEGIN
RAISERROR ('Invalid null input',14,1)
	RETURN
END

IF(@HugeCost < 0)
BEGIN
RAISERROR ('Invalid input: cost below 0',14,1)
	RETURN
END

IF(@RecoveryTime < 0)
BEGIN
RAISERROR ('Invalid input: recovery time below 0',14,1)
	RETURN
END

IF(@SurgeryName = '')
BEGIN
RAISERROR ('Invalid input: no surgery name',14,1)
	RETURN
END

IF((SELECT COUNT(1) FROM Surgery WHERE
	S_NAME = @SurgeryName AND
	Type = @SUrgeryType
	GROUP BY S_NAME) > 0)
BEGIN
	RAISERROR ('Surgery already exists',14,1)
	RETURN
END

INSERT INTO [Surgery](S_NAME,[Type],US_cost,[Recovery])
VALUES (@SurgeryName, @SurgeryType, @HugeCost, @RecoveryTime)



GO

