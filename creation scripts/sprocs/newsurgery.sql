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

INSERT INTO [Surgery]
VALUES (@SurgeryName, @SurgeryType, @HugeCost, @RecoveryTime)



GO

