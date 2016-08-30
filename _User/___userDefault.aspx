<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="___userDefault.aspx.cs" Inherits="XIPS._User._userDefault" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterContent" Runat="Server">
    <table style="width: 100%;" border="0">
        <tr>
            <td style="border:1px solid #cccccc;">
                 <table style="width: 100%; font-family:'Arial Unicode MS'; font-size: 11pt;border:1px solid silver; background-color:#cccccc">
                    <tr>   
                        <td style="white-space:nowrap;; vertical-align:middle;  padding-left:5px;">
                            <asp:Label ID="Label2" runat="server" Text="每頁資料筆數 : "></asp:Label>
                            <asp:DropDownList ID="ddlGridPageCount" runat="server"></asp:DropDownList>
                        </td>

                        <td style="white-space:nowrap; padding-right:15px; vertical-align:middle; text-align: right">
                            <asp:Panel ID="pnlButton" runat="server" >  
                                <asp:Button ID="btnAdd" runat="server" Text=" 新增資料" style="font-family: 'Arial Unicode MS'; font-size: 12pt;" />
                                &nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnRefresh" runat="server" Text=" 重新整理" 
                                    style="font-family: 'Arial Unicode MS'; font-size: 12pt;" 
                                    onclick="btnRefresh_Click" />
                            </asp:Panel>                        
                        </td>
                    </tr>
                  </table>
            </td>
        </tr>
        <tr>
            <td style="padding-top: 5px; padding-left: 5px; padding-right:20px">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="False">
                    <ContentTemplate>                                
                  
                    <asp:Panel ID="pnlResult" runat="server" >                  
                        <asp:Panel ID="pnlErrorMsg" runat="server">
                            <asp:Label ID="lblError" runat="server" Font-Bold="True" Font-Size="10pt" ForeColor="#FF3300" style="padding: 4px; width:800px; white-space:normal">[Error Message]</asp:Label>
                        </asp:Panel> 
                        <asp:Panel ID="pnlResultOP" runat="server" style="padding:5px">
                            <asp:Label ID="lblRecCount" runat="server" Text="Label" Font-Size="9pt" Font-Bold="true" Font-Italic="true" ForeColor="silver"></asp:Label>
                        </asp:Panel>
                        <asp:GridView 
                            ID="GridView1" 
                            runat="server" 
                            CellPadding="4" 
                            Font-Size="10pt" 
                            AllowPaging="True" 
                            AllowSorting="True"
                            OnPageIndexChanging="GridView1_PageIndexChanging" 
                            OnSorting="GridView1_Sorting" 
                            OnRowDataBound="GridView1_RowDataBound"
                            ForeColor="#333333" 
                            GridLines="Vertical" 
                            PageSize="50" 
                            BorderColor="#D1D1D1" 
                            BorderStyle="Solid" 
                            BorderWidth="2px"                        
                            EnableSortingAndPagingCallbacks="True">
                            <AlternatingRowStyle BackColor="White" /> 
                            <EditRowStyle BackColor="#2461BF" BorderStyle="None" />
                            <EmptyDataRowStyle Font-Size="11pt" ForeColor="#0033CC" BorderColor="#AFBBCD" 
                                BorderStyle="Double" BorderWidth="3px" />
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
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="1">
                        <ProgressTemplate>
                        <div style ="border:medium double #ffffff 0px; background-color:#ffffff; position:  absolute; text-align:center; vertical-align:middle; top: 150px; left: 500px; width: 220px;height: 105px; padding:5px; z-index:999">
                            <asp:Image ID="imgProgress" runat="server" ImageUrl="~/images/ajaxLoad-10.gif" 
                                style ="width: 90px;height: 100px;" AlternateText="Loading ..." 
                                GenerateEmptyAlternateText="True"/>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="button" value="取消更新" style="font-family: Arial Unicode MS; font-size: 14px; font-weight: 500" onclick="javascript: CancelAsyncPostBack();">
                        </div>
                        </ProgressTemplate>
                      </asp:UpdateProgress> 
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnRefresh" EventName="Click" />
                    </Triggers>             
                </asp:UpdatePanel>
            </td>
        </tr>          
    </table>
</asp:Content>
