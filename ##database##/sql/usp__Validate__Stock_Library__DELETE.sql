USE XIPS
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp__Validate__Stock_Library__DELETE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[usp__Validate__Stock_Library__DELETE];
GO


CREATE PROCEDURE [dbo].[usp__Validate__Stock_Library__DELETE]
	@StockID INT
AS
BEGIN

	IF EXISTS( SELECT * FROM [dbo].[Compose_Detail] WITH (NOLOCK) WHERE PageStockID = @StockID OR PaperStockID = @StockID)
		RETURN( 0 );
	ELSE
		RETURN( 1 );

END

GO