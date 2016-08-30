USE XIPS;

IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[utg__ComposeDetail__AdjustOrder__after_DELETE]'))
	DROP TRIGGER [dbo].[utg__ComposeDetail__AdjustOrder__after_DELETE]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[utg__ComposeDetail__AdjustOrder__after_DELETE]
	ON  [dbo].[Compose_Detail]
	AFTER DELETE
	NOT FOR REPLICATION
AS 
BEGIN

	SET NOCOUNT ON;

	BEGIN TRY

  		UPDATE [sub_Compose_Detail] 
		SET [sub_Compose_Detail].[ItemSequence] = [sub_Compose_Detail].[NewSequence]
		FROM (
					SELECT 
					[ItemSequence], 
					ROW_NUMBER() OVER(PARTITION BY [ComposeID] ORDER BY [ItemSequence]) AS [NewSequence]
					FROM [Compose_Detail] WITH(NOLOCK)
					WHERE [ComposeID] = ( SELECT ComposeID FROM deleted )
		) [sub_Compose_Detail];

	END TRY
	BEGIN CATCH
   		--PRINT ERROR_MESSAGE();
	END CATCH
 

	SET NOCOUNT OFF;

END
GO
