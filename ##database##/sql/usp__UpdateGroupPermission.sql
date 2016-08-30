USE XIPS
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp__UpdateGroupPermission]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[usp__UpdateGroupPermission];
GO


CREATE PROCEDURE [dbo].[usp__UpdateGroupPermission]
	@GroupID NVARCHAR(20),
	@MainPID VARCHAR(5),
	@SubPID INT,
	@IsGranted SMALLINT,
	@UserID NVARCHAR(20)
AS
BEGIN

	SET NOCOUNT ON;

	IF EXISTS( SELECT * FROM [dbo].[Group_Permission] WHERE GroupID = @GroupID AND MPID = @MainPID AND SPID = @SubPID )
	BEGIN

		UPDATE [dbo].[Group_Permission] SET
			Granted = @IsGranted, 
			Modifier = @UserID, 
			DateLastUpdated = GETDATE()
		WHERE GroupID = @GroupID AND MPID = @MainPID AND SPID = @SubPID;

	END
	ELSE
	BEGIN

		INSERT INTO [dbo].[Group_Permission]
				   ([GroupID]
				   ,[MPID]
				   ,[SPID]
				   ,[Granted]
				   ,[Creator]
				   ,[Modifier]
				   ,[DateCreated]
				   ,[DateLastUpdated])
			 VALUES (
				   @GroupID,
				   @MainPID,
				   @SubPID,
				   @IsGranted,
				   @UserID,
				   @UserID,
				   GETDATE(),
				   GETDATE())
	END;

END

GO