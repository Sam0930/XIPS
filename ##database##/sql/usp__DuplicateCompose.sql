USE XIPS
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp__DuplicateCompose]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[usp__DuplicateCompose];
GO


CREATE PROCEDURE [dbo].[usp__DuplicateCompose]
	@SourceComposeID INT,
	@Name NVARCHAR(50),
	@Depiction NVARCHAR(100),
	@SubsetOffset INT,
	@CustomerID	NVARCHAR(8),
	@UserID NVARCHAR(20),
	@Error NVARCHAR(200) OUTPUT
AS
BEGIN

	SET NOCOUNT ON;

	SET @Error = '';
	SET @Name = LTRIM(RTRIM(@Name));
	SET @Depiction = LTRIM(RTRIM(@Depiction));
	SET @CustomerID = LTRIM(RTRIM(@CustomerID));
	SET @UserID = LTRIM(RTRIM(@UserID));

	IF NOT EXISTS(	SELECT * FROM [dbo].Compose_Master WITH(NOLOCK) WHERE [ComposeID] = @SourceComposeID ) 
		OR NOT EXISTS(	SELECT * FROM [dbo].Customer_Information WITH(NOLOCK) WHERE CustomerID = @CustomerID ) 
	BEGIN
		SET @Error = 'Source compose or customer does not exist.';
		RETURN(-1);
	END

	IF NOT EXISTS(	SELECT * FROM [dbo].User_Information WITH(NOLOCK) WHERE UserID = @UserID ) 
	BEGIN
		SET @Error = 'Illegal user ID.';
		RETURN(-2);
	END

	BEGIN TRY

		BEGIN TRAN;

		INSERT INTO [dbo].[Compose_Master]
					([ComposeName]
					,[ComposeDepiction]
					,[SubsetOffset]
					,[CustomerID]
					,[Creator]
					,[Modifier]
					,[DateCreated]
					,[DateLastUpdated])
				VALUES (@Name, @Depiction, @SubsetOffset, @CustomerID, @UserID, @UserID, GETDATE(), GETDATE());

		DECLARE @NewComposeID INT = @@IDENTITY;

		INSERT INTO [dbo].[Compose_Detail]
					([ComposeID]
					,[ItemSequence]
					,[ItemID]
					,[PrintMethod]
					,[PaperPerSet]
					,[TrayID]
					,[OffsetX]
					,[OffsetY]
					,[PaperStockID]
					,[Creator]
					,[Modifier]
					,[DateCreated]
					,[DateLastUpdated])
			SELECT @NewComposeID,ItemSequence,ItemID,PrintMethod,PaperPerSet,TrayID,OffsetX,OffsetY,PaperStockID,@UserID,@UserID,GETDATE(),GETDATE()
				FROM [dbo].[Compose_Detail] WITH(NOLOCK)WHERE [ComposeID] = @SourceComposeID;
	
		COMMIT TRANSACTION;

		RETURN(@NewComposeID);

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

		RETURN(0);

	END CATCH;

	SET NOCOUNT OFF;
	SET XACT_ABORT ON;
	
END

GO

/*
DECLARE @RC int
DECLARE @SourceComposeID int
DECLARE @Name nvarchar(50)
DECLARE @Depiction nvarchar(100)
DECLARE @SubsetOffset INT
DECLARE @CustomerID nvarchar(8)
DECLARE @UserID nvarchar(20)
DECLARE @Error nvarchar(200)

SET @RC=0;
SET @SourceComposeID = 1;
SET @Name = 'TEST Duplicate Compose 2';
SET @Depiction = 'TEST Duplicate Compose Depiction 2';
SET @SubsetOffset=1;
SET @CustomerID = '22853565';
SET @UserID = 'Administrator';

EXECUTE @RC = [dbo].[usp__DuplicateCompose] 
   @SourceComposeID
  ,@Name
  ,@Depiction
  ,@SubsetOffset
  ,@CustomerID
  ,@UserID
  ,@Error OUTPUT;

SELECT @RC, @Error;

*/
