USE [MedicalTourism]
GO

/****** Object:  StoredProcedure [dbo].[NewLogin]    Script Date: 5/7/2015 2:28:38 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[NewLogin]
@Username varchar(30),
@HashedPassword varchar(10)

AS
DECLARE @permissionLevel tinyint
SET @permissionLevel = 0

IF((SELECT COUNT(1) FROM [Login] WHERE
	Username = @Username
	GROUP BY Username) > 0)
BEGIN
	RAISERROR ('Username already in use',14,1)
	ROLLBACK TRANSACTION
END
INSERT INTO [Login](Username, [Password],[Permission level]) 
VALUES (@Username, @HashedPassword, @permissionLevel)



GO

