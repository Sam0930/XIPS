USE XIPS
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp__DeleteComposeSet]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[usp__DeleteComposeSet];
GO


CREATE PROCEDURE [dbo].[usp__DeleteComposeSet]
	@ComposeID INT
AS
BEGIN

	SET NOCOUNT ON;

	BEGIN TRY

		BEGIN TRAN;

		DELETE FROM [dbo].[Compose_Detail] WHERE [ComposeID] = @ComposeID;

		DELETE FROM [dbo].[Compose_Master] WHERE [ComposeID] = @ComposeID;

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