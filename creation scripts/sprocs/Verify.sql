
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
CREATE PROCEDURE [Verify] 
	-- Add the parameters for the stored procedure here
	@Username nchar(40)
	
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [Password], [Permission Level] FROM [Login] WHERE @username = username
END
GO
