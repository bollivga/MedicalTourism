USE [MedicalTourism]
GO

/****** Object:  Table [dbo].[Login]    Script Date: 5/7/2015 1:46:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Login1](
	[Username] [nchar](40) NOT NULL,
	[Password] [nchar](40) NOT NULL,
	[Permission level] [tinyint] NOT NULL,
	[Owner_ID][nchar](40) NOT NULL,
 CONSTRAINT [PK_Login1] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

