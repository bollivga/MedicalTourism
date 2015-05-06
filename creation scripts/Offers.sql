USE [MedicalTourism]
GO

/****** Object:  Table [dbo].[Offers]    Script Date: 5/6/2015 7:05:48 PM ******/
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

