USE [MedicalTourism]
GO

/****** Object:  Table [dbo].[Surgery]    Script Date: 5/6/2015 7:05:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Surgery1](
	[S_NAME] [nchar](40) NOT NULL,
	[Type] [nchar](40) NOT NULL,
	[US_cost] [money] NOT NULL,
	[Recovery] [smallint] NOT NULL,
 CONSTRAINT [PK_Surgery1] PRIMARY KEY CLUSTERED 
(
	[S_NAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Surgery1] ADD  CONSTRAINT [DF_Surgery_Recovery1]  DEFAULT ((1)) FOR [Recovery]
GO

