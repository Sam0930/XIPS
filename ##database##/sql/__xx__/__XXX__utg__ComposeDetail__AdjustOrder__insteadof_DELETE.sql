USE XIPS;

IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[utg__ComposeDetail__AdjustOrder__insteadof_DELETE]'))
	DROP TRIGGER [dbo].[utg__ComposeDetail__AdjustOrder__insteadof_DELETE]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[utg__ComposeDetail__AdjustOrder__insteadof_DELETE]
	ON  [dbo].[Compose_Detail]
	INSTEAD OF DELETE
	NOT FOR REPLICATION
AS 
BEGIN

	SET NOCOUNT ON;

	BEGIN TRY
		--DECLARE @__ComposeID INT = (SELECT TOP 1 ComposeID FROM inserted);
		--DECLARE @__Sequence INT = (SELECT TOP 1 ItemSequence FROM inserted WHERE ComposeID = @__ComposeID);

		DELETE FROM [dbo].[Compose_Detail] WHERE [DetailID] IN (SELECT [DetailID] FROM deleted);

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
