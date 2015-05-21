USE [MedicalTourism]
GO

/****** Object:  Table [dbo].[Visits]    Script Date: 5/6/2015 7:06:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Visits1](
	[A_ID] [smallint] NOT NULL,
	[CIT_ID] [smallint] NOT NULL,
	[Avg_cost] [money] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Visits1]  WITH CHECK ADD  CONSTRAINT [FK_Visits_Airline1] FOREIGN KEY([A_ID])
REFERENCES [dbo].[Airline1] ([A_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Visits1] CHECK CONSTRAINT [FK_Visits_Airline1]
GO

ALTER TABLE [dbo].[Visits1]  WITH CHECK ADD  CONSTRAINT [FK_Visits_City1] FOREIGN KEY([CIT_ID])
REFERENCES [dbo].[City1] ([CIT_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Visits1] CHECK CONSTRAINT [FK_Visits_City1]
GO

