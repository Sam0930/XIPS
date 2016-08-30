USE XIPS
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp__Validate__Customer_Information__DELETE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[usp__Validate__Customer_Information__DELETE];
GO


CREATE PROCEDURE [dbo].[usp__Validate__Customer_Information__DELETE]
	@CustomerID NVARCHAR(20)
AS
BEGIN

	IF EXISTS( SELECT * FROM [dbo].[Compose_Master] WITH (NOLOCK) WHERE CustomerID = @CustomerID )
		RETURN( 0 );
	ELSE
		RETURN( 1 );

END

GO