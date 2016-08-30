USE [XIPS]
GO

/****** Object:  Table [dbo].[Printer_Information]    Script Date: 2014/11/5 ¤U¤È 05:13:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Printer_Information](
	[PrinterID] [nvarchar](50) NOT NULL,
	[IPAddress] [nvarchar](15) NOT NULL,
	[QueueName] [nvarchar](255) NOT NULL,
	[Creator] [nvarchar](20) NULL,
	[Modifier] [nvarchar](20) NULL,
	[DateCreated] [datetime] NULL CONSTRAINT [DF_Printer_Information_DateCreated]  DEFAULT (getdate()),
	[DateLastUpdated] [datetime] NULL CONSTRAINT [DF_Printer_Information_DateLastUpdated]  DEFAULT (getdate()),
 CONSTRAINT [PK_Printer_Information] PRIMARY KEY CLUSTERED 
(
	[PrinterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING ON

GO

/****** Object:  Index [IX_Printer_Information]    Script Date: 2014/11/5 ¤U¤È 05:13:37 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Printer_Information] ON [dbo].[Printer_Information]
(
	[IPAddress] ASC,
	[QueueName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

