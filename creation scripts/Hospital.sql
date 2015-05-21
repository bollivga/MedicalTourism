USE [MedicalTourism]
GO

/****** Object:  Table [dbo].[Hospital]    Script Date: 5/7/2015 1:50:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Hospital1](
	[H_ID] [smallint] NOT NULL,
	[Rating] [tinyint] NOT NULL,
	[Name] [nchar](40) NOT NULL,
	[CIT_ID] [smallint] NOT NULL,
	[owner_id] [nchar](40) NOT NULL,
 CONSTRAINT [PK_Hospital1] PRIMARY KEY CLUSTERED 
(
	[H_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Hospital1]  WITH CHECK ADD  CONSTRAINT [FK_Hospital_City1] FOREIGN KEY([CIT_ID])
REFERENCES [dbo].[City] ([CIT_ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Hospital1] CHECK CONSTRAINT [FK_Hospital_City1]
GO

ALTER TABLE [dbo].[Hospital1]  WITH CHECK ADD  CONSTRAINT [FK_Hospital_Login1] FOREIGN KEY([owner_id])
REFERENCES [dbo].[Login1] ([Username])
GO

ALTER TABLE [dbo].[Hospital1] CHECK CONSTRAINT [FK_Hospital_Login1]
GO

