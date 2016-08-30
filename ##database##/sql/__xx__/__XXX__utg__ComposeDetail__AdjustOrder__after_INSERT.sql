
USE XIPS;

IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[utg__ComposeDetail__AdjustOrder__after_INSERT]'))
	DROP TRIGGER [dbo].[utg__ComposeDetail__AdjustOrder__after_INSERT]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[utg__ComposeDetail__AdjustOrder__after_INSERT]
	ON  [dbo].[Compose_Detail]
	AFTER INSERT
	NOT FOR REPLICATION
AS 
BEGIN

	SET NOCOUNT ON;

	DECLARE @__ComposeID INT = (SELECT TOP 1 ComposeID FROM inserted);
	DECLARE @__Sequence INT = (SELECT TOP 1 ItemSequence FROM inserted WHERE ComposeID = @__ComposeID);

	BEGIN TRY
		
		-- bug: 
		-- Can insert after specified sequence, can not insert before specified sequence.
		UPDATE [Compose_Detail] SET [ItemSequence] = [ItemSequence]  + 1
			WHERE ComposeID =  @__ComposeID
					AND ItemSequence >=  @__Sequence;

  		UPDATE [ins_Compose_Detail] 
		SET [ins_Compose_Detail].[ItemSequence] = [ins_Compose_Detail].[NewSequence]
		FROM (
					SELECT 
					[ItemSequence], 
					ROW_NUMBER() OVER(PARTITION BY [ComposeID] ORDER BY [ItemSequence]) AS [NewSequence]
					FROM [Compose_Detail] WITH(NOLOCK)
					WHERE [ComposeID] = @__ComposeID
		) [ins_Compose_Detail];

	END TRY
	BEGIN CATCH
		--PRINT ERROR_MESSAGE();
	END CATCH;

	SET NOCOUNT OFF;

END

GO
