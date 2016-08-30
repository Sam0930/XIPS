USE XIPS;

IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[utg__ComposeMaster__after_DELETE]'))
	DROP TRIGGER [dbo].[utg__ComposeMaster__after_DELETE]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[utg__ComposeMaster__after_DELETE]
	ON  [dbo].[Compose_Master]
	AFTER DELETE
	NOT FOR REPLICATION
AS 
BEGIN

	SET NOCOUNT ON;

	DELETE FROM [dbo].[Compose_Detail] WHERE [ComposeID] = (SELECT ComposeID FROM deleted);

	SET NOCOUNT OFF;

END

GO