<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="pjDefault.aspx.cs" Inherits="XIPS._PrintingJob._pjDefault" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderContent" Runat="Server">
    <asp:placeholder runat="server">
        <%--<script src="../scripts/commontools.js" type="text/javascript"></script>--%>
        <script src='<%: ResolveUrl("~/scripts/commontools.js") %>' type="text/javascript"></script>
    </asp:placeholder>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MasterContent" Runat="Server">
    <table style="width: 100%;" border="0">
        <tr>
            <td style="border:1px solid #cccccc;">
                 <table style="width: 100%; font-size: 10pt;border:1px solid silver; background-color:#cccccc; padding: 5px">
                    <tr>   
                        <td style="white-space:nowrap; padding-left:5px; width:400px;">
                            <asp:Label ID="Label2" runat="server" Text="客戶名稱 : "></asp:Label>
                            <asp:DropDownList ID="ddlCustomer" runat="server" AutoPostBack="True" 
                                DataSourceID="sqlDS_Customer" DataTextField="CustomerName" 
                                DataValueField="CustomerID" style="width:300px;" 
                                onselectedindexchanged="ddlCustomer_SelectedIndexChanged">
                                </asp:DropDownList>
                        </td>
                        <td style="white-space:nowrap; vertical-align:middle;">
                            <asp:Label ID="Label1" runat="server" Text="配頁描述 : "></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="white-space:nowrap;  padding-left:5px;">
                            <asp:Label ID="Label3" runat="server" Text="配頁名稱 : "></asp:Label>
                            <asp:DropDownList ID="ddlComposeMaster" runat="server" AutoPostBack="True" 
                                DataSourceID="sqlDS_ComposeMaster_List" DataTextField="ComposeName" 
                                DataValueField="ComposeID" style="width:300px;" 
                                ondatabound="ddlComposeMaster_DataBound" 
                                onselectedindexchanged="ddlComposeMaster_SelectedIndexChanged"></asp:DropDownList> 
                        </td>
                        <td style="vertical-align:top;  padding-left:3px; padding-right:10px; width:750px" rowspan="2">
                            <asp:TextBox ID="txtComposeDepiction" runat="server" Enabled="false" ReadOnly="true"                   
                                style="background:#ffffff; border: 1px solid #bcbcbc; width: 100%; height:40px; font-size:10pt; vertical-align:top" 
                                Rows="3" TextMode="MultiLine"></asp:TextBox>                            
                        </td>
                    </tr>
                    <tr>
                        <td style="white-space:nowrap; padding-left:5px;">
                            <asp:Label ID="Label12" runat="server" Text="子集偏移 : "></asp:Label>
                            <%--<asp:TextBox ID="txtSunsetOffset" runat="server" style="border:none; background-color:transparent; font-size:10pt;" ReadOnly="true"  ></asp:TextBox>--%>
                            <asp:RadioButtonList ID="rbl_SubsetOffset" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" Enabled="False">
                                <asp:ListItem Text="是" Value="1"></asp:ListItem>
                                <asp:ListItem Text="否" Value="0"></asp:ListItem>
                            </asp:RadioButtonList>   
                        </td>                    
                    </tr>
                    <tr>
                        <td style="white-space:nowrap; padding-left:5px;">
                            <asp:Label ID="Label13" runat="server" Text="輸出設備 : "></asp:Label>
                            <asp:DropDownList ID="ddlPrinterInfo" runat="server" 
                                DataSourceID="sqlDS_PrinterInfo" DataTextField="OutputDevice" 
                                DataValueField="PrinterQueue" style="width:300px;"></asp:DropDownList> 
                        </td>                    
                    </tr>
                  </table>
            </td>
        </tr> 
        <tr>
            <td style="border:0px solid #cccccc; padding-top:5px">
                <asp:Repeater ID="repeater_ComposeDetail" runat="server" 
                    DataSourceID="sqlDS_ComposeDetail" 
                    OnItemCreated ="repeater_ComposeDetail_ItemCreated"
                    onprerender="repeater_ComposeDetail_PreRender">
                    <HeaderTemplate>
                        <table style="width: 100%;border:1px solid silver;">
                    </HeaderTemplate>
                    <ItemTemplate>
                            <tr>
                                <td style="padding: 3px; background-color:#ffffff">
                                    <table style="width: 100%; font-size: 10pt;border:1px solid #cccccc;">                                
                                        <tr>
                                            <td rowspan="2" style="white-space:nowrap; background-color:#cccccc; width:50px; font-size:20pt; font-weight:800; text-align:center; vertical-align: middle;">
                                                <asp:Label ID="Label10" runat="server" Text='<%# Eval("SEQ") %>'></asp:Label>
                                            </td>
                                            <td style="white-space:nowrap; background-color:#cccccc; text-align:center; width:80px;">頁面項目</td>
                                            <td style="white-space:nowrap; background-color:#cccccc; text-align:center; width:70px;">列印面</td>
                                            <td style="white-space:nowrap; background-color:#cccccc; text-align:center; width:70px;">張數</td>
                                            <td style="white-space:nowrap; background-color:#cccccc; text-align:center; width:90px;">紙匣</td>
                                            <td style="white-space:nowrap; background-color:#cccccc; text-align:center; width:180px;">頁面位移調整</td>
                                            <td style="white-space:nowrap; background-color:#cccccc; width:230px;">列印紙張</td>
                                            <td style="white-space:nowrap; background-color:#cccccc; width:400px;">列印資料檔</td>
                                        </tr>
                                        <tr>
                                            <td style="white-space:nowrap; border: 1px solid #cccccc; text-align:center; "><asp:Label ID="Label4" runat="server" Text='<%# Eval("ItemName") %>'></asp:Label></td>
                                            <td style="white-space:nowrap; border: 1px solid #cccccc; text-align:center; "><asp:Label ID="Label5" runat="server" Text='<%# Eval("PrintMethodName") %>'></asp:Label></td>
                                            <td style="white-space:nowrap; border: 1px solid #cccccc; text-align:center; "><asp:Label ID="Label6" runat="server" Text='<%# Eval("PaperPerSet") %>'></asp:Label></td>
                                            <td style="white-space:nowrap; border: 1px solid #cccccc; text-align:center; "><asp:Label ID="Label7" runat="server" Text='<%# Eval("TrayName") %>'></asp:Label></td>
                                            <td style="white-space:nowrap; border: 1px solid #cccccc; text-align:center; ">
                                                <asp:Label ID="Label8" runat="server" Text='<%# "X: " + Eval("OffsetX") + " mm" %>'></asp:Label>&nbsp;&nbsp;
                                                <asp:Label ID="Label11" runat="server" Text='<%# "Y: " + Eval("OffsetY") + " mm" %>'></asp:Label>
                                            </td>
                                            <td style="white-space:nowrap; border: 1px solid #cccccc;"><asp:Label ID="Label9" runat="server" Text='<%# Eval("PaperSelected") %>'></asp:Label></td>
                                            <td style="white-space:nowrap; border: 1px solid #cccccc; padding-left:5px; padding-right:5px; vertical-align:middle">
<%--                                                <input id="<%# Eval("SEQ") %>" name="txtDataFile_<%# Eval("SEQ") %>" type="text" readonly="readonly" disabled="disabled" style="font-size:10pt; width:350px;
                                                    border-color:#efefef; background-color: #efefef; " ReadOnly="true"  />  --%>   
                                                 
                                                <asp:TextBox id='txtDataFile' runat="server" Enabled="false" 
                                                    style="font-size:10pt; width:350px; background-color: #efefef; border: 1px dotted #bbbbbb;"></asp:TextBox>&nbsp;        
                                                <input id='btnBrowser_<%# Eval("SEQ") %>' name='btnBrowser' class="browser"  value="瀏覽" 
                                                    TrayID="<%# Eval("TrayID") %>" 
                                                    SEQ="<%# Eval("SEQ") %>" type="button"                                                        
                                                    TrayPath="<%# Eval("TrayPath") %>" 
                                                    PrintMethod="<%# Eval("PrintMethod") %>" 
                                                    TargetControlID="<%# "MasterContent_repeater_ComposeDetail_txtDataFile_" + Eval("INK") %>" />
                                                                                                         
                                            </td>
                                        </tr>
                                    </table>                                  
                                </td>
                            </tr>      
                    </ItemTemplate>                 
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
               </asp:Repeater>
            </td>
        </tr>     
        <tr>
            <td  style="padding: 5px 5px 10px 0px;" >
               <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>                                
                        <asp:Panel ID="pnlPrint" runat="server" style="padding:10px; text-align:right">                           
                            <hr style="width:100%; " size="2" noshade="noshade" />
                            <asp:Button ID="btnPrint" runat="server" style="font-size:11pt; width: 100px; margin-top:8px;" Text="列印" onclick="btnPrint_Click" />   
                        </asp:Panel> 
                        <asp:Panel ID="pnlResult" runat="server">
                            <asp:Panel ID="pnlResultFail" runat="server" style="padding:5px;">
                                <asp:Image ID="imgError" runat="server" ImageUrl="~/images/error.gif" style="vertical-align:bottom; padding-left:2px; padding-right:5px;"/>
                                <asp:Label ID="lblError" runat="server" Font-Bold="True" Font-Size="12pt" ForeColor="#FF3300" style="padding: 4px; width:800px;white-space:normal" >[Error Message]</asp:Label>
                            </asp:Panel>
                            <asp:Panel ID="pnlResultOk" runat="server" style="padding:10px; text-align:left">
                                <asp:Image ID="imgOperation" runat="server" ImageUrl="~/images/HandleHand.png" style="vertical-align:bottom; padding-left:2px; padding-right:5px;"/>
                                <asp:Label ID="lblResult" runat="server" Font-Bold="True" Font-Size="12pt" ForeColor="#101010" style="padding: 4px; width:800px; white-space:normal">[Print Result]</asp:Label>
                                <br />                           
                                <asp:Button ID="btnPrintNext" runat="server" style="font-size:11pt; width: 150px; margin-top:10px" Text="列印下一筆" onclick="btnPrintNext_Click" /> 
                            </asp:Panel> 
                        </asp:Panel>        
                    </ContentTemplate>   
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnPrint" EventName="Click" />
                        <asp:PostBackTrigger ControlID="btnPrintNext" />
                    </Triggers>   
                </asp:UpdatePanel>                                                  
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="1">
                    <ProgressTemplate>
                        <div id="divMaskFrame" style="opacity:0.80; filter:alpha(opacity=80); background-color: #808080; left: 0px; top: 0px; position: fixed; width: 100%;height: 100%; z-index:9998"></Div>
                        <div id="divProcess"   style ="opacity:0.85; filter:alpha(opacity=85); border:2px double #cccccc; background-color:#ffffff; position:absolute; text-align:center; vertical-align:middle; top: 50%; left: 50%; width: 170px;height: 160px; margin-left: 0px; margin-top: 0px; padding:3px;z-index:9999">                       
                            <asp:Image ID="imgProgress" runat="server" ImageUrl="~/images/ajaxLoad-9.gif" 
                                style ="width: 80px;height: 80px; padding: 15px;" AlternateText="Loading ..." 
                                GenerateEmptyAlternateText="True"/>
                            <div style="opacity:1; filter:alpha(opacity=100);">
                                <input type="button" value="取消列印" style="font-family: Arial Unicode MS; font-size: 14px; font-weight: 500;" onclick="javascript: CancelAsyncPostBack();" />                                                      
                            </div>
                    </div>
                    </ProgressTemplate>                                             
                </asp:UpdateProgress> 
            </td>     
        </tr>
    </table>
 
    <asp:SqlDataSource ID="sqlDS_Customer" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DATACNNSTR__SQLEXP_XIPS %>" 
        SelectCommand="SELECT DISTINCT Compose_Master.CustomerID, Customer_Information.CustomerName FROM Compose_Master WITH(NOLOCK) INNER JOIN Customer_Information WITH(NOLOCK) ON Compose_Master.CustomerID = Customer_Information.CustomerID"></asp:SqlDataSource>
   
    <asp:SqlDataSource ID="sqlDS_ComposeMaster_List" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DATACNNSTR__SQLEXP_XIPS %>" 
        SelectCommand="SELECT DISTINCT [ComposeID], [ComposeName] FROM [Compose_Master] WITH(NOLOCK) WHERE ([CustomerID] = @CustomerID) ">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlCustomer" Name="CustomerID" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlDS_PrinterInfo" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DATACNNSTR__SQLEXP_XIPS %>" 
        SelectCommand="SELECT [PrinterID] + ' - ' + [QueueName] [OutputDevice], [PrinterID], [IPAddress], [QueueName], [IPAddress] + '::' + [QueueName]  [PrinterQueue] FROM Printer_Information WITH(NOLOCK)"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sqlDS_ComposeDetail" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DATACNNSTR__SQLEXP_XIPS %>" 
        SelectCommand="usp__PreparePrintJobs" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlComposeMaster" Name="ComposeID" 
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

<%--    <asp:SqlDataSource ID="sqlDS_ComposeMaster_Detail" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DATACNNSTR__SQLEXP_XIPS %>" 
        DataSourceMode="DataReader"
        SelectCommand="SELECT [ComposeName], ISNULL([ComposeDepiction], '') [ComposeDepiction], ISNULL([Subsetoffset], 0) [Subsetoffset] FROM [Compose_Master] WITH(NOLOCK)  WHERE ([ComposeID] = @ComposeID) ">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlComposeMaster" Name="ComposeID" 
                PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>--%>

    <div id="divFileSelectorMask" style="display:none; opacity:0.40; filter:alpha(opacity=40); left: 0px; top: 0px; position: fixed;"></div>   
    <div id="divFileSelector" style="display:none; position: fixed; background-color:silver; border: 2px solid #808080; vertical-align:middle; text-align:center;  width: 250px; padding:5px">
        <table style="width: 100%; height:100%; font-family:微軟正黑體;">
            <tr>
                <td style="background-color:#cccccc; font-size:11pt; padding:3px;">選取列印資料檔</td>
            </tr>
            <tr>
                <td>
                    <select size="10" name="lbxDataFileSelector" id="lbxDataFileSelector" style="width: 100%; border: 1px solid #cccccc; font-size:10pt;">
	                    <option value="vAAAA1">AAAA1</option>
	                    <option value="vAAAA2">AAAA2</option>
	                    <option value="vAAAA3">AAAA3</option>
	                    <option value="vAAAA4">AAAA4</option>
                    </select> 
<%--                    <asp:ListBox runat="server"  id="lbxDataFileSelector" SelectionMode="Single" Rows="10" style="width: 100%; border: 1px solid #cccccc; font-size:10pt;">
                    </asp:ListBox>      
--%>          
                </td>
            </tr>
            <tr>
                <td style="font-size:10pt; padding: 5px">
                    <input id="__btnSelector_OK" type="button" value="選取" />&nbsp; &nbsp; &nbsp;  
                    <input id="__btnSelector_Cancel" type="button" value="取消" />              
                </td>
            </tr>
        </table>
        <input id="__hidTargetControlID" type="hidden" />
    </div>

    <script language="javascript" type="text/javascript">
        $(function () {
            $('input[name="btnBrowser"]').each(function () {
                if (!$.isNumeric($(this).attr("PrintMethod")) || $(this).attr("PrintMethod") == '0')
                    $(this).attr('disabled', 'disabled');
            });

            //$(document.getElementsByName("btnBrowser")).click(function (event) {
            $('input[name="btnBrowser"]').click(function (event) {
                try {
                    var __me = this;
                    //alert($(__me).attr("TargetControlID"));
                    //alert($(__me).attr("PrintMethod"));

                    if (!$.isNumeric($(this).attr("PrintMethod")) || $(this).attr("PrintMethod") == '0')
                        return false;

                    /// Store Job's Sequence number in "TargetControlID" attribute in order to specify which "browser" buttom is pressed.
                    $("#__hidTargetControlID").val($(this).attr("TargetControlID"));

                    /// Remove all the options of the select box
                    $('select#lbxDataFileSelector').find('option').remove().end();

                    /// ajax: get the list of data file
                    $.ajax({
                        url: "../____handler__/HandlerOfDatafileListByTrayid.ashx",
                        data: "traypath=" + $(this).attr("TrayPath") + "&trayfilter=*.pdf&delimiter=;",
                        type: "POST",
                        success: function (ajaxResponse) {
                            //alert(ajaxResponse);
                            var __eachitem = ajaxResponse.toString().split(";");
                            $.each(__eachitem, function (index, value) {
                                $('select#lbxDataFileSelector').append(new Option(value, value));
                            });
                            $("#divFileSelector").css({ "display": "block", "z-index": "100", "top": $(__me).position().top + "px", "left": ($(__me).position().left - $("#divFileSelector").width() - $(__me).width()) + "px" });
                            $("#divFileSelectorMask").css({ "display": "block", "z-index": "1", "width": "100%", "height": "100%", "background-color": "#888888" });
                        }

                        //                /// Enable error callback function implementation only for debug issue
                        //                ,
                        //                error: function (xhr, ajaxOptions, thrownError) {
                        //                    alert("Retrieve Data file failed. Status-" + xhr.status + thrownError);
                        //                }

                    });

                    /// locate winodw by mouse's position
                    //            $("#divFileSelector").css({ "display": "block", "z-index": "100", "top": event.pageY + $("#divFileSelector").height() + "px", "left": event.pageX - $("#divFileSelector").width() - $(this).width() -3 + "px" });
                    /// locate window near by the triggered buttom
                    //            $("#divFileSelector").css({ "display": "block", "z-index": "100", "top": $(this).position().top + "px", "left": ($(this).position().left - $("#divFileSelector").width() - $(this).width()) + "px" });
                    //            $("#divFileSelectorMask").css({ "display": "block", "z-index": "1", "width": "100%", "height": "100%", "background-color": "#888888" });
                }
                catch (err) {
                    alert(err);
                }
                //return false;
            });

            $("#__btnSelector_OK").click(function () {

                //            /// Get selected text
                //            alert($('select#lbxDataFileSelector option:selected').text());

                //            /// Get selected value
                //            alert($('select#lbxDataFileSelector option:selected').val());
                //            jQuery('option:selected', $("select#lbxDataFileSelector")).each(function () {
                //                alert(this.value);
                //            });
                //            alert("#"+ $("#__hidTargetControlID").val());

                /// fill to selected value to textbox
                if ($('select#lbxDataFileSelector option:selected').text().toString().length > 0) {
                    //                $("#txtDataFile_" + $("#__hidSEQ").val()).val($("select#lbxDataFileSelector option:selected").val());
                    $("#" + $("#__hidTargetControlID").val()).val($("select#lbxDataFileSelector option:selected").val());
                }

                $("#__btnSelector_Cancel").click();
            });

            $('select#lbxDataFileSelector').dblclick(function () {
                $("#__btnSelector_OK").click();
            });

            $("#__btnSelector_Cancel").click(function () {
                $("#divFileSelectorMask").css("display", "none");
                $("#divFileSelector").css("display", "none");
            });

            //        $("select#lbxDataFileSelector").change(function () {
            //            //alert("select#lbxDataFileSelector.change - " + this.value);
            //        });
        });
    </script>
</asp:Content>