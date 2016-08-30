USE XIPS
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp__GetComposeDetail]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[usp__GetComposeDetail];
GO


CREATE PROCEDURE [dbo].[usp__GetComposeDetail]
	@ComposeID INT
AS
BEGIN

	SET NOCOUNT ON;

	SELECT	[DetailID], 
			[ComposeID], 
			[ItemSequence], 
			[ItemID], 
			[PrintMethod], 
			ISNULL([PaperPerSet], 0) [PaperPerSet], 
			[TrayID], 
			ISNULL([OffsetX], 0.00) [OffsetX], 
			ISNULL([OffsetY], 0.00) [OffsetY], 
			[PaperStockID], 
			[Creator], 
			[Modifier], 
			[DateCreated], 
			[DateLastUpdated] 
		FROM [Compose_Detail] WITH(NOLOCK) 
		WHERE ([ComposeID] = @ComposeID) 
		ORDER BY [ItemSequence];
	
	SET NOCOUNT OFF;

END

GO