USE [MedicalTourism]
GO

/****** Object:  Table [dbo].[Offers]    Script Date: 5/6/2015 7:05:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Offers1](
	[S_NAME] [nchar](40) NOT NULL,
	[H_ID] [smallint] NOT NULL,
	[Avg_cost] [money] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Offers1]  WITH CHECK ADD  CONSTRAINT [FK_Offers_Hospital1] FOREIGN KEY([H_ID])
REFERENCES [dbo].[Hospital1] ([H_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Offers1] CHECK CONSTRAINT [FK_Offers_Hospital1]
GO

ALTER TABLE [dbo].[Offers1]  WITH CHECK ADD  CONSTRAINT [FK_Offers_Surgery1] FOREIGN KEY([S_NAME])
REFERENCES [dbo].[Surgery1] ([S_NAME])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Offers1] CHECK CONSTRAINT [FK_Offers_Surgery1]
GO

