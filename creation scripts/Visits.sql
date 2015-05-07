USE [MedicalTourism]
GO

/****** Object:  Table [dbo].[Visits]    Script Date: 5/6/2015 7:06:05 PM ******/
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

