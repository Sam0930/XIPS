USE XIPS
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp__UpdateComposeDetail]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[usp__UpdateComposeDetail];
GO


CREATE PROCEDURE [dbo].[usp__UpdateComposeDetail]
	@DetailID INT,
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

    UPDATE [Compose_Detail] 
	SET 
		[ItemSequence] = @ItemSequence, 
		[ItemID] = @ItemID, 
		[PrintMethod] = @PrintMethod, 
		[PaperPerSet] = @PaperPerSet, 
		[TrayID] = @TrayID, 
		[OffsetX] = @OffsetX, 
		[OffsetY] = @OffsetY, 
		[PaperStockID] = @PaperStockID, 
		[Modifier] = @UserID, 
		[DateLastUpdated] = GETDATE() 
	WHERE [DetailID] = @DetailID;

	SET NOCOUNT OFF;

END

GO