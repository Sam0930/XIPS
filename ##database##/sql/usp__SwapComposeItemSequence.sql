USE XIPS
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp__SwapComposeItemSequence]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[usp__SwapComposeItemSequence];
GO


CREATE PROCEDURE [dbo].[usp__SwapComposeItemSequence]
	@DetailID INT,
	@Direction SMALLINT,
	@UserID NVARCHAR(20)
AS
BEGIN

	SET NOCOUNT ON;

	BEGIN TRY

		DECLARE @__this_ComposeID INT = (SELECT ComposeID FROM [dbo].Compose_Detail WITH(NOLOCK) WHERE DetailID = @DetailID);
		DECLARE @__this_Sequence INT = (SELECT ItemSequence FROM [dbo].Compose_Detail WITH(NOLOCK) WHERE DetailID = @DetailID);
	

		BEGIN TRAN;

		IF(@Direction > 0)
		BEGIN

			IF( @__this_Sequence < (SELECT MAX([ItemSequence]) FROM [dbo].Compose_Detail WITH(NOLOCK) WHERE ComposeID =  @__this_ComposeID) )
			BEGIN
				PRINT('Increase Item Sequence Order Number.');

				UPDATE [Compose_Detail] SET 
						[ItemSequence] =   [ItemSequence]  - 1,
						[Modifier] = @UserID,
						[DateLastUpdated] = GETDATE()
					WHERE [DetailID] =  (
							SELECT TOP 1 DetailID FROM Compose_Detail WITH(NOLOCK) 
							WHERE ComposeID = @__this_ComposeID 
								AND ItemSequence > @__this_Sequence 
							ORDER BY ItemSequence ASC )
		
				UPDATE [Compose_Detail] SET 
						[ItemSequence] =   [ItemSequence]  + 1,
						[Modifier] = @UserID,
						[DateLastUpdated] = GETDATE() 
					WHERE [DetailID] =  @DetailID;
			END
		END
		ELSE
		BEGIN

			IF( @__this_Sequence > 1 )
			BEGIN
				PRINT('Decrease Item Sequence ORder Number');

				UPDATE [Compose_Detail] SET 
						[ItemSequence] = [ItemSequence]  + 1,
						[Modifier] = @UserID,
						[DateLastUpdated] = GETDATE()
					WHERE [DetailID] =  ( 
							SELECT TOP 1 DetailID FROM Compose_Detail WITH(NOLOCK) 
							WHERE ComposeID = @__this_ComposeID 
								AND ItemSequence < @__this_Sequence 
							ORDER BY ItemSequence DESC);

				UPDATE [Compose_Detail] SET 
					[ItemSequence] = [ItemSequence]  - 1,
						[Modifier] = @UserID,
						[DateLastUpdated] = GETDATE() 
					WHERE [DetailID] =  @DetailID;
			END
		END;


		/* Re-order the sequence number by row_number() */

		WITH cte__Compose_Detail AS
		(
			SELECT  
			[ItemSequence], 
			ROW_NUMBER() OVER(PARTITION BY [ComposeID] ORDER BY [ItemSequence]) AS [NewSequence]
			FROM [Compose_Detail] 
			WHERE [ComposeID] = @__this_ComposeID
		)
		UPDATE cte__Compose_Detail SET [ItemSequence] = [NewSequence];


		COMMIT TRAN;
		
		SET NOCOUNT OFF;

		RETURN(1);

	END TRY
	BEGIN CATCH		

		PRINT N'Error Caught.';

		/*
		Test XACT_STATE:
			If 1, the transaction is committable.
			If -1, the transaction is uncommittable and should be rolled back.
			XACT_STATE = 0 means that there is no transaction and a commit or rollback operation would generate an error.
		*/

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

		SET NOCOUNT OFF;
		SET XACT_ABORT ON;		
	
		RETURN(0);

	END CATCH;

	
END

/*
[usp__SwapComposeItemSequence] 3, 0, 'Administrator'
*/