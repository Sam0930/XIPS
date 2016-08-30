USE XIPS
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp__DeleteComposeDetail]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[usp__DeleteComposeDetail];
GO


CREATE PROCEDURE [dbo].[usp__DeleteComposeDetail]
	@DetailID INT
AS
BEGIN

	SET NOCOUNT ON;

	BEGIN TRY

		BEGIN TRAN;

		DECLARE @__ComposeID INT = ( SELECT ComposeID FROM [dbo].[Compose_Detail] WITH(NOLOCK) WHERE [DetailID] = @DetailID );

		DELETE FROM [dbo].[Compose_Detail] WHERE [DetailID] = @DetailID;

  		UPDATE [sub_Compose_Detail] 
		SET [sub_Compose_Detail].[ItemSequence] = [sub_Compose_Detail].[NewSequence]
		FROM (
				SELECT 
				[ItemSequence], 
				ROW_NUMBER() OVER(PARTITION BY [ComposeID] ORDER BY [ItemSequence]) AS [NewSequence]
				FROM [dbo].[Compose_Detail] WITH(NOLOCK)
				WHERE [ComposeID] = @__ComposeID
			) [sub_Compose_Detail];


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
	SET XACT_ABORT ON;

END

GO


/*
[usp__DeleteComposeSet] 28
*/