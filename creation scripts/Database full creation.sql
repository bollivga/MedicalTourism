USE [MedicalTourism]
GO
/****** Object:  User [333Spring2015Medical]    Script Date: 5/14/2015 2:22:06 PM ******/
CREATE USER [333Spring2015Medical] FOR LOGIN [333Spring2015Medical] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [loganga]    Script Date: 5/14/2015 2:22:06 PM ******/
CREATE USER [loganga] FOR LOGIN [loganga] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [wickersl]    Script Date: 5/14/2015 2:22:06 PM ******/
CREATE USER [wickersl] FOR LOGIN [wickersl] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  DatabaseRole [sproc_runner]    Script Date: 5/14/2015 2:22:06 PM ******/
CREATE ROLE [sproc_runner]
GO
/****** Object:  DatabaseRole [teammate]    Script Date: 5/14/2015 2:22:06 PM ******/
CREATE ROLE [teammate]
GO
ALTER ROLE [sproc_runner] ADD MEMBER [333Spring2015Medical]
GO
ALTER ROLE [teammate] ADD MEMBER [loganga]
GO
ALTER ROLE [teammate] ADD MEMBER [wickersl]
GO
/****** Object:  Schema [wickersl]    Script Date: 5/14/2015 2:22:06 PM ******/
CREATE SCHEMA [wickersl]
GO
/****** Object:  StoredProcedure [dbo].[AllDetails]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[AllDetails]

@SelectedCity varchar(20),
@Surgery varchar(20)

AS

DECLARE @City_id AS INTEGER
SET @City_id = (SELECT CIT_ID FROM City WHERE Name = @SelectedCity)

DECLARE @Hospital_id AS INTEGER
SET @Hospital_id = (SELECT H_ID FROM Hospital WHERE CIT_ID = @City_id)

DECLARE @Airline_id AS INTEGER
SET @Airline_id = (SELECT TOP 1 Visits.A_ID FROM Visits WHERE Visits.CIT_ID = @City_id)

--Returns all info about the trip
SELECT City.CO_NAME as Country, Surgery.S_NAME as Surgery, City.Name as [City], City.Rating, Hospital.Name as [Hospital], Airline.Name as [Airline]

FROM City, Surgery, Airline, Hospital

WHERE	City.Name = @SelectedCity and
		Hospital.CIT_ID = @City_id and
		Airline.A_ID = @Airline_id and
		Surgery.S_NAME = @Surgery


--Returns price information of the trip
SELECT Offers.Avg_cost as [Surgery cost], Visits.Avg_cost as [Flight cost], Hotel.CPN as [Hotel fees]
FROM Offers, Visits, Hotel
WHERE Offers.H_ID = @Hospital_id and Hotel.CIT_ID = @City_id and
		Visits.A_ID = @Airline_id



GO
/****** Object:  StoredProcedure [dbo].[DeleteAirline]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[DeleteAirline]
@AirlineID smallint

AS

Delete from Airline
WHERE A_ID = @AirlineID

if(@@ERROR != 0)
BEGIN
RAISERROR('Deletion failed, please check input',13,1)
ROLLBACK TRANSACTION
END


GO
/****** Object:  StoredProcedure [dbo].[DeleteCity]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[DeleteCity]
@CityID smallint
AS

Delete from City

WHERE CIT_ID = @CityID

if(@@ERROR != 0)
BEGIN
RAISERROR('Deletion failed, please check input',13,1)
ROLLBACK TRANSACTION
END


GO
/****** Object:  StoredProcedure [dbo].[DeleteHospital]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[DeleteHospital]
@HospitalID smallint
AS

Delete from Hospital
WHERE H_ID = @HospitalID

if(@@ERROR != 0)
BEGIN
RAISERROR('Deletion failed, please check input',13,1)
ROLLBACK TRANSACTION
END


GO
/****** Object:  StoredProcedure [dbo].[DeleteHotel]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[DeleteHotel]
@HotelID smallint,
@CityID smallint
AS

Delete from Hotel
WHERE HOT_ID = @HotelID and CIT_ID = @CityID

if(@@ERROR != 0)
BEGIN
RAISERROR('Deletion failed, please check input',13,1)
ROLLBACK TRANSACTION
END


GO
/****** Object:  StoredProcedure [dbo].[DeleteOffers]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[DeleteOffers]
@Surgery varchar(20),
@HospitalID smallint

AS

Delete from Offers
WHERE H_ID = @HospitalID and S_NAME = @Surgery

if(@@ERROR != 0)
BEGIN
RAISERROR('Deletion failed, please check input',13,1)
ROLLBACK TRANSACTION
END


GO
/****** Object:  StoredProcedure [dbo].[DeleteSurgery]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[DeleteSurgery]
@SurgeryName varchar(20)
AS

Delete from Surgery
WHERE S_NAME = @SurgeryName

if(@@ERROR != 0)
BEGIN
RAISERROR('Deletion failed, please check input',13,1)
ROLLBACK TRANSACTION
END


GO
/****** Object:  StoredProcedure [dbo].[DeleteVisits]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[DeleteVisits]
@AirlineID smallint,
@CityID smallint
AS

Delete from Visits
WHERE A_ID = @AirlineID and CIT_ID = @CityId

if(@@ERROR != 0)
BEGIN
RAISERROR('Deletion failed, please check input',13,1)
ROLLBACK TRANSACTION
END0
END


GO
/****** Object:  StoredProcedure [dbo].[DisplayCityResults]    Script Date: 5/14/2015 2:22:06 PM ******/
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
/****** Object:  StoredProcedure [dbo].[NewAirline]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[NewAirline]
@AirlineName varchar(10)

AS

DECLARE @AirlineID int
SET @AirlineID = (SELECT max(A_ID) FROM [Airline]) + 1

IF(@AirlineName in (SELECT Name FROM Airline))
BEGIN
	RAISERROR ('Airline name already in use',14,1)
END

INSERT INTO [Airline](A_ID,Name)
VALUES (@AirlineID, @AirlineName)



GO
/****** Object:  StoredProcedure [dbo].[NewCity]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[NewCity]
@CityName varchar(10),
@Rating int,
@Country varchar(20),
@PIN int

AS

IF((SELECT COUNT(1) FROM City WHERE
	NAME = @CityName AND
	CO_NAME = @Country
	GROUP BY NAME) > 0)
BEGIN
	RAISERROR ('City+country combo already in use',14,1)
END

DECLARE @CityID int
SET @CityID = (SELECT max(CIT_ID) FROM [City]) + 1

INSERT INTO [City](CIT_ID,Name,Rating,CO_NAME)
VALUES (@CityID, @CityName, @Rating, @Country)


RETURN 0

GO
/****** Object:  StoredProcedure [dbo].[NewHospital]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[NewHospital]
@H_Name varchar(10),
@CityID int,
@Rating int,
@PIN int

AS



IF (@CityID not in (SELECT CIT_ID FROM [City]))
BEGIN
	RAISERROR ('City ID not valid. No changes made to database. Please add new city before trying again.',14,1)
END

DECLARE @Hospital_ID int
SET @Hospital_ID = (SELECT max(H_ID) FROM [Hospital]) + 1

IF((SELECT COUNT(1) FROM Hospital WHERE
	Name = @H_Name AND
	CIT_ID = @CityID
	GROUP BY Name
	) > 0)
BEGIN
	RAISERROR ('Duplicate data: Hospital name+location already in use',14,1)
END

INSERT INTO [Hospital] (H_ID,Rating,Name,CIT_ID)
VALUES (@Hospital_ID, @Rating, @H_Name, @CityID)




GO
/****** Object:  StoredProcedure [dbo].[NewHotel]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[NewHotel]
@Name varchar(20),
@CityID smallint,
@CostPerNight money

AS

IF (@CityID not in (SELECT CIT_ID FROM [City]))
BEGIN
	RAISERROR ('City ID not valid. No changes made to database. Please add new city before trying again.',14,1)
END

IF((SELECT COUNT(1) FROM Hotel WHERE
	Name = @Name AND
	CIT_ID = @CityID AND
	CPN = @CostPerNight
	GROUP BY NAME) > 0)
BEGIN
	RAISERROR ('City+Hotel+Cost combo already in use',14,1)
END

DECLARE @Hotel_ID int
SET @Hotel_ID = (SELECT max(HOT_ID) FROM [Hotel]) + 1

INSERT INTO [Hotel] (HOT_ID,Name,CPN,CIT_ID)
VALUES (@Hotel_ID, @Name, @CostPerNight, @CityID)




GO
/****** Object:  StoredProcedure [dbo].[NewLogin]    Script Date: 5/14/2015 2:22:06 PM ******/
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
END
INSERT INTO [Login](Username, [Password],[Permission level]) 
VALUES (@Username, @HashedPassword, @permissionLevel)




GO
/****** Object:  StoredProcedure [dbo].[NewOffers]    Script Date: 5/14/2015 2:22:06 PM ******/
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
END

IF (@HospitalID not in (SELECT H_ID FROM [Hospital]))
BEGIN
	RAISERROR ('Hospital ID not valid. No changes made to database. Please add new hospital before trying again.',14,1)
END

INSERT INTO [Offers](S_NAME,H_ID,Avg_Cost)
VALUES (@Surgery, @HospitalID, @Offer_Price)




GO
/****** Object:  StoredProcedure [dbo].[NewSurgery]    Script Date: 5/14/2015 2:22:06 PM ******/
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
END

INSERT INTO [Surgery](S_NAME,Type,US_cost,Recovery)
VALUES (@SurgeryName, @SurgeryType, @HugeCost, @RecoveryTime)




GO
/****** Object:  StoredProcedure [dbo].[NewVisits]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[NewVisits]
@AirlineID int,
@CityID int,
@Cost money,
@PIN int

AS

IF((SELECT COUNT(1) FROM Visits WHERE
	A_ID = @AirlineID AND
	CIT_ID = @CityID
	GROUP BY CIT_ID) > 0)
BEGIN
	RAISERROR ('Airline route already in database',14,1)
END

IF (@AirlineID not in (SELECT A_ID FROM [Airline]))
BEGIN
RAISERROR ('Airline ID not valid. No changes made to database. Please add new airline before trying again.',14,1)

END

IF (@CityID not in (SELECT CIT_ID FROM [City]))
BEGIN
RAISERROR ('City ID not valid. No changes made to database. Please add new city before trying again.',14,1)
END

INSERT INTO [Visits](A_ID,CIT_ID,Avg_cost)
VALUES (@AirlineID, @CityID, @Cost)




GO
/****** Object:  StoredProcedure [dbo].[UpdateAirline]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[UpdateAirline]
@AirlineID smallint,
@AirlineName varchar(10)
AS

Update Airline
SET Name = @AirlineName
WHERE A_ID = @AirlineID

if(@@ERROR != 0)
BEGIN
RAISERROR('Update failed, please check input',13,1)
ROLLBACK TRANSACTION
END



GO
/****** Object:  StoredProcedure [dbo].[UpdateCity]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[UpdateCity]
@CityID smallint,
@CityName varchar(10),
@CityRating tinyint,
@CountryName varchar(20)
AS

Update City
SET Name = @CityName, Rating = @CityRating, CO_NAME = @CountryName
WHERE CIT_ID = @CityID

if(@@ERROR != 0)
BEGIN
RAISERROR('Update failed, please check input',13,1)
ROLLBACK TRANSACTION
END



GO
/****** Object:  StoredProcedure [dbo].[UpdateHospital]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[UpdateHospital]
@HospitalID smallint,
@HospitalRating tinyint,
@HospitalName varchar(10),
@CityID smallint,
@OwnerID varchar(30)
AS

Update Hospital
SET Rating = @HospitalRating, Name = @HospitalName, CIT_ID = @CityID, owner_id = @OwnerID
WHERE H_ID = @HospitalID

if(@@ERROR != 0)
BEGIN
RAISERROR('Update failed, please check input',13,1)
ROLLBACK TRANSACTION
END



GO
/****** Object:  StoredProcedure [dbo].[UpdateHotel]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[UpdateHotel]
@HotelID smallint,
@HotelName varchar(20),
@CostPerNight money,
@CityID smallint
AS

Update Hotel
Set Name = @HotelName, CPN = @CostPerNight
WHERE HOT_ID = @HotelID and CIT_ID = @CityID

if(@@ERROR != 0)
BEGIN
RAISERROR('Update failed, please check input',13,1)
ROLLBACK TRANSACTION
END


GO
/****** Object:  StoredProcedure [dbo].[UpdateOffers]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[UpdateOffers]
@Surgery varchar(20),
@HospitalID smallint,
@Cost money
AS

Update Offers
SET Avg_cost = @Cost
WHERE H_ID = @HospitalID and S_NAME = @Surgery

if(@@ERROR != 0)
BEGIN
RAISERROR('Update failed, please check input',13,1)
ROLLBACK TRANSACTION
END


GO
/****** Object:  StoredProcedure [dbo].[UpdatePassword]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[UpdatePassword]
@NewPassword varchar(10),
@User varchar(30)
AS

Update Login
SET Password = @NewPassword
WHERE Username = @User

if(@@ERROR != 0)
BEGIN
RAISERROR('Update failed, please check input',13,1)
ROLLBACK TRANSACTION
END


GO
/****** Object:  StoredProcedure [dbo].[UpdateSurgery]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[UpdateSurgery]
@SurgeryName varchar(20),
@SurgeryType varchar(10),
@USCost money,
@RecoveryTime smallint
AS

UPDATE Surgery
SET Type = @SurgeryType, US_cost = @USCost, Recovery = @RecoveryTime
WHERE S_NAME = @SurgeryName

if(@@ERROR != 0)
BEGIN
RAISERROR('Update failed, please check input',13,1)
ROLLBACK TRANSACTION
END


GO
/****** Object:  StoredProcedure [dbo].[UpdateVisits]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[UpdateVisits]
@AirlineID smallint,
@CityID smallint,
@Cost money
AS

UPDATE Visits
SET Avg_cost = @Cost
WHERE A_ID = @AirlineID and CIT_ID = @CityId

if(@@ERROR != 0)
BEGIN
RAISERROR('Update failed, please check input',13,1)
ROLLBACK TRANSACTION
END


GO
/****** Object:  Table [dbo].[Airline]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Airline](
	[A_ID] [smallint] NOT NULL,
	[Name] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Airline] PRIMARY KEY CLUSTERED 
(
	[A_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[City]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[City](
	[CIT_ID] [smallint] NOT NULL,
	[Name] [nchar](10) NULL,
	[Rating] [tinyint] NULL,
	[CO_NAME] [nchar](20) NOT NULL,
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[CIT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Country]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Country](
	[CO_NAME] [nchar](20) NOT NULL,
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[CO_NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Hospital]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hospital](
	[H_ID] [smallint] NOT NULL,
	[Rating] [tinyint] NULL,
	[Name] [nchar](10) NULL,
	[CIT_ID] [smallint] NULL,
	[owner_id] [nchar](30) NULL,
 CONSTRAINT [PK_Hospital] PRIMARY KEY CLUSTERED 
(
	[H_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Hotel]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Hotel](
	[HOT_ID] [smallint] NOT NULL,
	[Name] [nchar](20) NULL,
	[CPN] [money] NULL,
	[CIT_ID] [smallint] NOT NULL,
 CONSTRAINT [PK_Hotel] PRIMARY KEY CLUSTERED 
(
	[HOT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Login]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Login](
	[Username] [nchar](30) NOT NULL,
	[Password] [nchar](10) NOT NULL,
	[Permission level] [tinyint] NOT NULL,
 CONSTRAINT [PK_Login] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Offers]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Offers](
	[S_NAME] [nchar](20) NOT NULL,
	[H_ID] [smallint] NOT NULL,
	[Avg_cost] [money] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Surgery]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Surgery](
	[S_NAME] [nchar](20) NOT NULL,
	[Type] [nchar](10) NOT NULL,
	[US_cost] [money] NULL,
	[Recovery] [smallint] NOT NULL,
 CONSTRAINT [PK_Surgery] PRIMARY KEY CLUSTERED 
(
	[S_NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Visits]    Script Date: 5/14/2015 2:22:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Visits](
	[A_ID] [smallint] NOT NULL,
	[CIT_ID] [smallint] NOT NULL,
	[Avg_cost] [money] NOT NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Surgery] ADD  CONSTRAINT [DF_Surgery_Recovery]  DEFAULT ((1)) FOR [Recovery]
GO
ALTER TABLE [dbo].[City]  WITH CHECK ADD  CONSTRAINT [FK_City_Country] FOREIGN KEY([CO_NAME])
REFERENCES [dbo].[Country] ([CO_NAME])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[City] CHECK CONSTRAINT [FK_City_Country]
GO
ALTER TABLE [dbo].[Hospital]  WITH CHECK ADD  CONSTRAINT [FK_Hospital_City] FOREIGN KEY([CIT_ID])
REFERENCES [dbo].[City] ([CIT_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Hospital] CHECK CONSTRAINT [FK_Hospital_City]
GO
ALTER TABLE [dbo].[Hospital]  WITH CHECK ADD  CONSTRAINT [FK_Hospital_Login] FOREIGN KEY([owner_id])
REFERENCES [dbo].[Login] ([Username])
GO
ALTER TABLE [dbo].[Hospital] CHECK CONSTRAINT [FK_Hospital_Login]
GO
ALTER TABLE [dbo].[Hotel]  WITH CHECK ADD  CONSTRAINT [FK_Hotel_City] FOREIGN KEY([CIT_ID])
REFERENCES [dbo].[City] ([CIT_ID])
GO
ALTER TABLE [dbo].[Hotel] CHECK CONSTRAINT [FK_Hotel_City]
GO
ALTER TABLE [dbo].[Offers]  WITH CHECK ADD  CONSTRAINT [FK_Offers_Hospital] FOREIGN KEY([H_ID])
REFERENCES [dbo].[Hospital] ([H_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Offers] CHECK CONSTRAINT [FK_Offers_Hospital]
GO
ALTER TABLE [dbo].[Offers]  WITH CHECK ADD  CONSTRAINT [FK_Offers_Surgery] FOREIGN KEY([S_NAME])
REFERENCES [dbo].[Surgery] ([S_NAME])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Offers] CHECK CONSTRAINT [FK_Offers_Surgery]
GO
ALTER TABLE [dbo].[Visits]  WITH CHECK ADD  CONSTRAINT [FK_Visits_Airline] FOREIGN KEY([A_ID])
REFERENCES [dbo].[Airline] ([A_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Visits] CHECK CONSTRAINT [FK_Visits_Airline]
GO
ALTER TABLE [dbo].[Visits]  WITH CHECK ADD  CONSTRAINT [FK_Visits_City] FOREIGN KEY([CIT_ID])
REFERENCES [dbo].[City] ([CIT_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Visits] CHECK CONSTRAINT [FK_Visits_City]
GO
