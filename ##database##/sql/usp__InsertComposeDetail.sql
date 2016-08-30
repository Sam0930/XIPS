USE XIPS
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp__InsertComposeDetail]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[usp__InsertComposeDetail];
GO


CREATE PROCEDURE [dbo].[usp__InsertComposeDetail]
	@ComposeID INT,
	@ItemSequence INT,
	@ItemID INT,
	@PrintMethod INT,
	@PaperPerSet INT,
	@TrayID INT,
	@OffsetX DECIMAL(18, 2),
	@OffsetY DECIMAL(18, 2),
	@PaperStockID INT,
	@UserID NVARCHAR(20)
AS
BEGIN

	SET NOCOUNT ON;

	BEGIN TRY

		BEGIN TRAN;

		UPDATE [Compose_Detail] 
		SET 
			[ItemSequence] = [ItemSequence]  + 1
		WHERE ComposeID =  @ComposeID
			AND ItemSequence >=  @ItemSequence;

			
		INSERT INTO [dbo].[Compose_Detail] (
					[ComposeID],[ItemSequence], [ItemID], [PrintMethod], [PaperPerSet], [TrayID],
					[OffsetX], [OffsetY], [PaperStockID], [Creator], [Modifier], [DateCreated], [DateLastUpdated] )
			VALUES( @ComposeID, @ItemSequence, @ItemID, @PrintMethod, @PaperPerSet, @TrayID,
					@OffsetX, @OffsetY, @PaperStockID, @UserID, @UserID, GETDATE(), GETDATE() );

					
  		UPDATE [ins_Compose_Detail] 
		SET 
			[ins_Compose_Detail].[ItemSequence] = [ins_Compose_Detail].[NewSequence]
		FROM (
				SELECT 
				[ItemSequence], 
				ROW_NUMBER() OVER(PARTITION BY [ComposeID] ORDER BY [ItemSequence]) AS [NewSequence]
				FROM [Compose_Detail] WITH(NOLOCK)
				WHERE [ComposeID] = @ComposeID
			) [ins_Compose_Detail];	

		COMMIT TRAN;

		RETURN(1);

	END TRY
	BEGIN CATCH	

		PRINT N'Error Caught.';

		-- Test whether the transaction is uncommittable.
		IF (XACT_STATE()) = -1
		BEGIN
			PRINT N'The transaction is in an uncommittable state. Rolling back transaction.'
			ROLLBACK TRANSACTION;
		END;

		-- Test whether the transaction is committable.
		IF (XACT_STATE()) = 1
		BEGIN
			PRINT N'The transaction is committable. Committing transaction.'
			COMMIT TRANSACTION;   
		END;

		RETURN(0);

	END CATCH;

	SET NOCOUNT OFF;

END

GO