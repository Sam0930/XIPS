USE XIPS
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp__UpdateUserPassword]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[usp__UpdateUserPassword];
GO


CREATE PROCEDURE [dbo].[usp__UpdateUserPassword]
	@UserID NVARCHAR(20),
	@NewPassword NVARCHAR(20) 
AS
BEGIN

	SET NOCOUNT ON;

	UPDATE User_Information SET UserPassword = @NewPassword WHERE UserID = @UserID;

	SET NOCOUNT OFF;

END

GO