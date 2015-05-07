USE [MedicalTourism]
GO

/****** Object:  Table [dbo].[Hospital]    Script Date: 5/7/2015 1:50:18 PM ******/
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

