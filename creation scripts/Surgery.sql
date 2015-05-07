USE [MedicalTourism]
GO

/****** Object:  Table [dbo].[Surgery]    Script Date: 5/6/2015 7:05:56 PM ******/
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

ALTER TABLE [dbo].[Surgery] ADD  CONSTRAINT [DF_Surgery_Recovery]  DEFAULT ((1)) FOR [Recovery]
GO

