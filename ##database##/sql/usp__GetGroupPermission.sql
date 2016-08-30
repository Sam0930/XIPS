USE XIPS
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp__GetGroupPermission]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[usp__GetGroupPermission];
GO


CREATE PROCEDURE [dbo].[usp__GetGroupPermission]
	@GroupID NVARCHAR(20)
AS
BEGIN

	SELECT 
			ROW_NUMBER() OVER(PARTITION BY Group_Permission.GroupID ORDER BY Program_List.MPID, Program_List.SPID) [SEQ],
			Program_List.ProgramName, 
			Program_List.ProgramDepiction, 
			Group_Permission.Granted, 
			Group_Permission.MPID, 
			Group_Permission.SPID 
		FROM Program_List WITH (NOLOCK) 
			LEFT OUTER JOIN Group_Permission WITH (NOLOCK) 
				ON Program_List.MPID = Group_Permission.MPID AND Program_List.SPID = Group_Permission.SPID 
		WHERE (Group_Permission.GroupID = @GroupID);

END

GO


/*
usp__GetGroupPermission 'Administrators'
*/