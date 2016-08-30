USE XIPS;

IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[utg__ComposeDetail__AdjustOrder__insetedof_INSERT]'))
	DROP TRIGGER [dbo].[utg__ComposeDetail__AdjustOrder__insetedof_INSERT]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[utg__ComposeDetail__AdjustOrder__insetedof_INSERT]
	ON  [dbo].[Compose_Detail]
	INSTEAD OF INSERT
	NOT FOR REPLICATION
AS 
BEGIN

	SET NOCOUNT ON;

	DECLARE @__ComposeID INT;
	DECLARE @__Sequence INT;

	DECLARE csrTMP CURSOR READ_ONLY FAST_FORWARD 
		FOR
			SELECT ComposeID, ItemSequence FROM  inserted;

 	OPEN csrTMP;

	FETCH NEXT FROM csrTMP INTO @__ComposeID, @__Sequence;

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		BEGIN TRY

			UPDATE [Compose_Detail] SET [ItemSequence] = [ItemSequence]  + 1
				WHERE ComposeID =  @__ComposeID
						AND ItemSequence >=  @__Sequence ;

			INSERT INTO [dbo].[Compose_Detail]
					   ([ComposeID]
					   ,[ItemSequence]
					   ,[ItemID]
					   ,[PrintMethod]
					   ,[PaperPerSet]
					   ,[TrayID]
					   ,[PageStockID]
					   ,[PaperStockID]
					   ,[Creator]
					   ,[Modifier]
					   ,[DateCreated]
					   ,[DateLastUpdated])
				SELECT @__ComposeID
					   ,[ItemSequence]
					   ,[ItemID]
					   ,[PrintMethod]
					   ,[PaperPerSet]
					   ,[TrayID]
					   ,[PageStockID]
					   ,[PaperStockID]
					   ,[Creator]
					   ,[Modifier]
					   ,[DateCreated]
					   ,[DateLastUpdated] FROM inserted 
					WHERE ComposeID = @__ComposeID AND  ItemSequence =  @__Sequence;

		END TRY
		BEGIN CATCH
			--PRINT ERROR_MESSAGE();
		END CATCH;

		FETCH NEXT FROM csrTMP INTO @__ComposeID, @__Sequence;

	END;

	CLOSE csrTMP;
	DEALLOCATE csrTMP;


  	UPDATE [ins_Compose_Detail] 
	SET [ins_Compose_Detail].[ItemSequence] = [ins_Compose_Detail].[NewSequence]
	FROM (
				SELECT 
				[ItemSequence], 
				ROW_NUMBER() OVER(PARTITION BY [ComposeID] ORDER BY [ItemSequence]) AS [NewSequence]
				FROM [Compose_Detail] WITH(NOLOCK)
				WHERE [ComposeID] = @__ComposeID
	) [ins_Compose_Detail];	
	

	SET NOCOUNT OFF;

END

GO
