USE XIPS
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp__PreparePrintJobs]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[usp__PreparePrintJobs];
GO


CREATE PROCEDURE [dbo].[usp__PreparePrintJobs]
	@ComposeID INT
AS
BEGIN

	SET NOCOUNT ON;

	SELECT Compose_Detail.ComposeID, 
			--( SELECT COUNT(*) FROM [Compose_Detail] T2 WHERE T2.ItemSequence <= Compose_Detail.ItemSequence AND T2.ComposeID=Compose_Detail.ComposeID)-1 AS [INX], 
			ROW_NUMBER() OVER(PARTITION BY Compose_Detail.ComposeID ORDER BY Compose_Detail.ItemSequence) - 1 AS [INK],
			Compose_Detail.ItemSequence AS [SEQ], 
			Compose_Detail.ItemID, 
			Item_List.ItemName, 
			Compose_Detail.PrintMethod, 
			CASE Compose_Detail.PrintMethod WHEN 0 THEN '不印' WHEN 1 THEN '正面' WHEN 2 THEN '反面' ELSE '雙面' END  AS [PrintMethodName], 
			Compose_Detail.PaperPerSet, 
			Compose_Detail.TrayID, 
			Tray_List.TrayName, 
			System_Parameter.ParameterValue AS [TrayPath], 
			--CAST(Stock_Library.StockWidth AS VARCHAR(5)) + 'x' + CAST(Stock_Library.StockHeight AS VARCHAR(5)) + 'mm' AS [PageSize], 
			--Stock_Library.StockWidth AS PageWidth, 
			--Stock_Library.StockHeight AS PageHeight,
			ISNULL(OffsetX, 0.00) [OffsetX],
			ISNULL(OffsetY, 0.00) [OffsetY],
			PaperStock_Library.StockWidth AS PaperWidth, 
			PaperStock_Library.StockHeight AS PaperHeight, 
			PaperStock_Library.StockWeight AS PaperWeight, 
			PaperStock_Library.StockCoated AS PaperCoated, 
			CAST(PaperStock_Library.StockWidth AS VARCHAR(5)) + 'x' + CAST(PaperStock_Library.StockHeight AS VARCHAR(5)) + 'mm,' + CAST(PaperStock_Library.StockWeight AS VARCHAR(5)) + 'gsm,' + CASE WHEN PaperStock_Library.StockCoated = 1 THEN '塗布' ELSE '非塗布' END AS [PaperSelected] 
			FROM [dbo].Compose_Detail WITH(NOLOCK) 
			LEFT OUTER JOIN [dbo].Item_List  WITH(NOLOCK) ON Compose_Detail.ItemID = Item_List.ItemID 
			LEFT OUTER JOIN [dbo].Tray_List  WITH(NOLOCK) ON Compose_Detail.TrayID = Tray_List.TrayID 
			--LEFT OUTER JOIN [dbo].Stock_Library WITH(NOLOCK) ON Compose_Detail.PageStockID = Stock_Library.StockID 
			LEFT OUTER JOIN [dbo].Stock_Library PaperStock_Library  WITH(NOLOCK) ON Compose_Detail.PaperStockID = PaperStock_Library.StockID
			LEFT OUTER JOIN [dbo].System_Parameter WITH(NOLOCK) ON Compose_Detail.TrayID = System_Parameter.ParameterKey
        WHERE System_Parameter.[Section] = 'RetrievePath' 
			AND Compose_Detail.ComposeID = @ComposeID
        ORDER BY Compose_Detail.ItemSequence; 

	SET NOCOUNT OFF;

END

GO


/*
EXEC [dbo].[usp__PreparePrintJobs] 1

*/