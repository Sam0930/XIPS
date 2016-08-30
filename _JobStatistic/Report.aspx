<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="XIPS._JobStatistic._Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterContent" Runat="Server">

    <table style="width: 100%;" border="0">
        <tr>
            <td style="border:1px solid #cccccc;">
                 <table style="width: 100%; font-family:'Arial Unicode MS'; font-size: 10pt;border:1px solid silver; background-color:#cccccc">
                    <tr>
                       <td style="width: 330px; white-space:nowrap; padding: 5px 10px 5px 10px;">               
                            <asp:Label ID="Label1" runat="server" Text="查詢日期 : "></asp:Label>
                            &nbsp;&nbsp;
                            <asp:TextBox ID="txtCallStart" cssClass="conditionTextbox" contentEditable="false" Enabled="false" runat="server" AutoComplete="Off" 
                                Height="16px" Width="80px" />
                            <asp:ImageButton runat="Server" ID="imgStart" 
                                ImageUrl="~/images/Calendar_scheduleHS.png" 
                                AlternateText="Click to select start date." ImageAlign="Bottom" />&nbsp;&nbsp;-&nbsp;
                            <asp:TextBox ID="txtCallEnd" cssClass="conditionTextbox" contentEditable="false" Enabled="false" runat="server" AutoComplete="Off" 
                                Height="16px" Width="80px" />  
                            <asp:ImageButton runat="Server" ID="imgEnd" 
                                ImageUrl="~/images/Calendar_scheduleHS.png" 
                                AlternateText="Click to select end date." ImageAlign="Bottom" />             
                         </td>          
                         <td style="white-space:nowrap; width: 250px;">
                             <asp:Label ID="Label6" runat="server" Text="列印人員 : "></asp:Label>
                             <asp:DropDownList ID="ddlUser" runat="server"  style="width:150px"></asp:DropDownList>
                        </td>
                        <td style="white-space:nowrap; width: 200px; vertical-align:middle; text-align:center;">
                            <asp:Label ID="Label2" runat="server" Text="每頁資料筆數 : "></asp:Label>
                            <asp:DropDownList ID="ddlGridPageCount" runat="server"></asp:DropDownList>
                        </td>
                        <td style="white-space:nowrap; padding-left:10px; padding-right:15px; vertical-align:middle">
                            <asp:Panel ID="pnlButton" runat="server" >  
                                <asp:Button ID="btnQuery" runat="server" Text="查詢" style="font-family: 'Arial Unicode MS'; font-size: 10pt;" 
                                    onclick="btnQuery_Click"/>
    <%--                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnPrint" runat="server" Text="列印" style="font-family: 'Arial Unicode MS'; font-size:12pt;" /> --%>   
                            </asp:Panel>                        
                        </td>
                    </tr>
                  </table>

                 <ajaxToolkit:CalendarExtender 
                        ID="CalendarExtender1"      
                        TargetControlID="txtCallStart" 
                        PopupButtonID="imgStart" 
                        runat="server" 
                        Format="yyyy/MM/dd" 
                        Animated="true"/>
                 <ajaxToolkit:CalendarExtender 
                        ID="CalendarExtender2"      
                        TargetControlID="txtCallEnd" 
                        PopupButtonID="imgEnd" 
                        runat="server" 
                        Format="yyyy/MM/dd" 
                        Animated="true"/>
            </td>
        </tr>
        <tr>
            <td style="padding-top: 5px; padding-left: 5px; padding-right:20px">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>                                
                  
                    <asp:Panel ID="pnlResult" runat="server" >                  
                        <asp:Panel ID="pnlErrorMsg" runat="server">
                            <asp:Image ID="imgError" runat="server" ImageUrl="~/images/error.gif" style="vertical-align:bottom; padding-left:2px; padding-right:5px;"/>
                            <asp:Label ID="lblError" runat="server" Font-Bold="True" Font-Size="10pt" ForeColor="#FF3300" style="padding: 4px; width:800px; white-space:normal">[Error Message]</asp:Label>
                        </asp:Panel> 
                        <asp:Panel ID="pnlResultOP" runat="server" style="padding:5px">
                            <table style="width:100%">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblRecCount" runat="server" Text="Label" Font-Size="9pt" Font-Bold="true" Font-Italic="true" ForeColor="silver"></asp:Label>                                  
                                    </td>
                                    <td style="text-align:right; padding-right:15px';">
                                        <asp:Button ID="btnExport" runat="server" Text="匯出" 
                                            style="font-family:微軟正黑體; font-size:10pt; width:100px;" 
                                            onclick="btnExport_Click" /> 
                                    </td>
                                </tr>
                            </table>                         
                        </asp:Panel>
                        <asp:GridView 
                            ID="GridView1" 
                            runat="server" 
                            CellPadding="4" 
                            Font-Size="10pt" 
                            AllowPaging="true" 
                            AllowSorting="true"
                            OnPageIndexChanging="GridView1_PageIndexChanging" 
                            OnSorting="GridView1_Sorting" 
                            OnRowDataBound="GridView1_RowDataBound"
                            ForeColor="#333333" 
                            GridLines="Vertical" 
                            PageSize="1" 
                            BorderColor="#D1D1D1" 
                            BorderStyle="Solid" 
                            BorderWidth="2px"                        
                            EnableSortingAndPagingCallbacks="true">
                            <AlternatingRowStyle BackColor="White" />
                            <EditRowStyle BackColor="#2461BF" BorderStyle="None" />
<%--                            <EmptyDataRowStyle Font-Size="11pt" ForeColor="#0033CC" BorderColor="#AFBBCD" 
                                BorderStyle="Double" BorderWidth="3px" />--%>
                            <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" 
                                Font-Italic="True" Font-Size="10pt" Font-Strikeout="True" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="False" ForeColor="#E8E8E8" 
                                Font-Size="10pt" BorderColor="#D1D1D1" BorderStyle="Solid" 
                                BorderWidth="2px" />
                            <PagerSettings Mode="NumericFirstLast" />
                            <PagerStyle ForeColor="White" HorizontalAlign="left" Font-Size="11pt" 
                                BackColor="#A1A1A1" BorderColor="#CCCFD9" BorderStyle="Solid" 
                                BorderWidth="2px" Font-Bold="True" />
                            <RowStyle BackColor="#E1E1E1" Font-Size="10pt" ForeColor="#404040" 
                                BorderColor="#D1D1D1" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#CC3300" 
                                Font-Italic="False" />
                            <SortedAscendingCellStyle BackColor="#F5F7FB" />
                            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                            <SortedDescendingCellStyle BackColor="#E9EBEF" />
                            <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        </asp:GridView>                                          
                    </asp:Panel>                       
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnQuery" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnExport" EventName="Click" />
                </Triggers>             
            </asp:UpdatePanel >                   
            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="1">
                    <ProgressTemplate>
                        <div id="divMaskFrame" style="opacity:0.40; filter:alpha(opacity=40); background-color: #888888; left: 0px; top: 0px; position: fixed; width: 100%;height: 100%; z-index:999"></Div>
                        <div style ="opacity:0.85; filter:alpha(opacity=85); border:medium double #ffffff 0px; background-color:#ffffff; position:  absolute; text-align:center; vertical-align:middle; top: 150px; left: 500px; width: 220px;height: 105px; padding:5px; z-index:9999">
                            <asp:Image ID="imgProgress" runat="server" ImageUrl="~/images/ajaxLoad-10.gif" 
                                style ="width: 90px;height: 100px;" AlternateText="Loading ..." 
                                GenerateEmptyAlternateText="True"/>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="button" value="取消查詢" style="font-family: Arial Unicode MS; font-size: 14px; font-weight: 500" onclick="javascript: CancelAsyncPostBack();">
                        </div>

<%--                                   
                <div id="divProcess"   style ="opacity:0.85; filter:alpha(opacity=85); border:2px double #cccccc; background-color:#ffffff; position:absolute; text-align:center; vertical-align:middle; top: 50%; left: 50%; width: 150px;height: 150px; margin-left: -75px; margin-top: -75px; padding:3px;z-index:9999">                       
                <asp:Image ID="Image1" runat="server" ImageUrl="~/images/ajax-loader.gif" 
                    style ="width: 85px;height: 85px; padding: 15px;" AlternateText="Loading ..." 
                    GenerateEmptyAlternateText="True"/><br />
                    <asp:Label ID="Label2" runat="server" Text="資料處理中, 請稍候." style=" font-size:11pt; font-family:微軟正黑體"></asp:Label>
                <div style="opacity:1; filter:alpha(opacity=100);">
                    <input type="button" value="取消更新" style="font-family: Arial Unicode MS; font-size: 14px; font-weight: 500;" onclick="CancelAsyncPostBack();" />                                                      
                </div>
            </div>--%>
                    </ProgressTemplate>
                </asp:UpdateProgress> 
            </td>
        </tr>          
    </table>

</asp:Content>


