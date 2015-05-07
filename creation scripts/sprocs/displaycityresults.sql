USE [MedicalTourism]
GO

/****** Object:  StoredProcedure [dbo].[DisplayCityResults]    Script Date: 5/7/2015 2:27:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[DisplayCityResults]

@Country varchar(20),
@SurgeryType varchar(20),
@Rating int
AS

--If a preferred country is specified
IF (@Country != '--')
BEGIN

SELECT c.Name, Offers.S_NAME as Surgery, c.Rating, c.CO_NAME as [Country Name]
FROM City as c, Offers, Hospital, Surgery
WHERE c.Rating > @Rating and @SurgeryType = Surgery.Type and Surgery.S_NAME = Offers.S_Name and
		Offers.H_ID = Hospital.H_ID and Hospital.CIT_ID = c.CIT_ID and c.CO_NAME = @Country
END

--If no country is chosen
ELSE
BEGIN

SELECT c.Name, Offers.S_NAME as Surgery, c.Rating, c.CO_NAME as [Country Name]
FROM City as c, Offers, Hospital, Surgery
WHERE	c.Rating > @Rating and @SurgeryType = Surgery.Type and Surgery.S_NAME = Offers.S_Name and
		Offers.H_ID = Hospital.H_ID and Hospital.CIT_ID = c.CIT_ID
END


GO

