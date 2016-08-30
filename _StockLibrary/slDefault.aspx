﻿<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="slDefault.aspx.cs" Inherits="XIPS._StockLibrary._slDefault" %>

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
                            <asp:DropDownList ID="ddlGridPageCount" runat="server" AutoPostBack="True" 
                                onselectedindexchanged="ddlGridPageCount_SelectedIndexChanged"></asp:DropDownList>
                        </td>
                        <td style="white-space:nowrap; padding-right:15px; vertical-align:middle; text-align: right">
                            <asp:Panel ID="pnlButton" runat="server" >  
                                <asp:Button ID="btnAdd" runat="server" Text=" 新增資料"  style="font-family: 'Arial Unicode MS'; font-size: 10pt;" onclick="btnAdd_Click" />
                                &nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnRefresh" runat="server" Text=" 重新整理" style="font-family: 'Arial Unicode MS'; font-size: 10pt;" onclick="btnRefresh_Click" 
                                   />
                            </asp:Panel>                        
                        </td>
                    </tr>
                  </table>
            </td>
        </tr>
        <tr>
            <td style="padding-top: 5px; padding-left: 5px; padding-right:20px">

             <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                    <ContentTemplate>                                
                    <asp:Panel ID="pnlResult" runat="server" >     

                        <asp:Panel ID="pnlErrorMsg" runat="server" style="padding: 5px">
                            <asp:Image ID="imgError" runat="server" ImageUrl="~/images/error.gif" style="vertical-align:bottom; padding-left:2px; padding-right:5px;"/>
                            <asp:Label ID="lblError" runat="server" Font-Bold="True" Font-Size="10pt" ForeColor="#FF3300"  style="width:800px; white-space:normal">[Error Message]</asp:Label>
                        </asp:Panel> 
                        <asp:Panel ID="pnlResultOP" runat="server" style="padding:5px">
                            <asp:Label ID="lblRecCount" runat="server" Font-Size="9pt" Font-Bold="true" Font-Italic="true" ForeColor="silver">lblRecCount</asp:Label>
                        </asp:Panel>

                      <asp:GridView 
                            ID="GridView1" 
                            runat="server" 
                            CellPadding="4" 
                            Font-Size="10pt" 
                            AllowPaging="True" 
                            AllowSorting="True"
                            ForeColor="#333333" 
                            GridLines="None" 
                            BorderColor="#D1D1D1" 
                            BorderStyle="Solid" 
                            BorderWidth="2px" 
                            AutoGenerateColumns="False" 
                            DataSourceID="sqlDS_StockLibraryList" 
                            onrowcommand="GridView1_RowCommand" 
                            PageSize="1" 
                            onprerender="GridView1_PreRender" 
                            EnableSortingAndPagingCallbacks="True" 
                            DataKeyNames="StockID" 
                            onrowdatabound="GridView1_RowDataBound" >
                            <Columns>
                                <asp:BoundField DataField="StockID" HeaderText="StockID" SortExpression="StockID"  
                                    Visible="False" ItemStyle-Wrap="False" >
                                <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="項次" HeaderText="項次" InsertVisible="False" 
                                    ReadOnly="True" SortExpression="項次"  HeaderStyle-Width="80px" ItemStyle-Wrap="False" 
                                    HeaderStyle-Wrap="False" >
                                    <HeaderStyle Wrap="False" Width="80px"></HeaderStyle>
                                    <ItemStyle Wrap="False"></ItemStyle>
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="紙張名稱" ShowHeader="False" SortExpression="紙張名稱">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                            CommandArgument='<%# Eval("StockID") %>' CommandName="Detail" 
                                            Text='<%# Eval("紙張名稱") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Width="230px" 
                                        Wrap="False" />
                                    <ItemStyle ForeColor="#0066FF" HorizontalAlign="Left" VerticalAlign="Middle" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="紙張寬度(mm)" HeaderText="紙張寬度(mm)" SortExpression="紙張寬度(mm)"  
                                    HeaderStyle-Width="150px" HeaderStyle-VerticalAlign="Middle" 
                                    HeaderStyle-HorizontalAlign="center" FooterStyle-HorizontalAlign="NotSet" 
                                    ItemStyle-HorizontalAlign="center" ItemStyle-VerticalAlign="middle" 
                                    HeaderStyle-Wrap="False" >
                                    <HeaderStyle HorizontalAlign="center" VerticalAlign="Middle" Wrap="False" Width="150px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="center" VerticalAlign="Top"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="紙張高度(mm)" HeaderText="紙張高度(mm)" SortExpression="紙張高度(mm)"   
                                    HeaderStyle-Width="150px" HeaderStyle-VerticalAlign="Middle" 
                                    HeaderStyle-HorizontalAlign="center" FooterStyle-HorizontalAlign="NotSet" 
                                    ItemStyle-HorizontalAlign="center" ItemStyle-VerticalAlign="middle" 
                                    HeaderStyle-Wrap="False" >
                                    <HeaderStyle HorizontalAlign="center" VerticalAlign="Middle" Wrap="False" Width="150px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="center" VerticalAlign="Top"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="紙張重量(gsm)" HeaderText="紙張重量(gsm)" SortExpression="紙張重量(gsm)"  
                                    HeaderStyle-Width="150px" HeaderStyle-VerticalAlign="Middle" 
                                    HeaderStyle-HorizontalAlign="center" FooterStyle-HorizontalAlign="NotSet" 
                                    ItemStyle-HorizontalAlign="center" ItemStyle-VerticalAlign="middle" 
                                    HeaderStyle-Wrap="False" >
                                    <HeaderStyle HorizontalAlign="center" VerticalAlign="Middle" Wrap="False" Width="150px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="center" VerticalAlign="Top"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="紙張塗布" HeaderText="紙張塗布" ReadOnly="True" SortExpression="紙張塗布"   
                                    HeaderStyle-Width="120px" HeaderStyle-VerticalAlign="Middle" 
                                    HeaderStyle-HorizontalAlign="center" FooterStyle-HorizontalAlign="NotSet" 
                                    ItemStyle-HorizontalAlign="center" ItemStyle-VerticalAlign="middle" 
                                    HeaderStyle-Wrap="False" >
                                    <HeaderStyle HorizontalAlign="center" VerticalAlign="Middle" Wrap="False" Width="120px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="center" VerticalAlign="Top"></ItemStyle>
                                </asp:BoundField>
                               <asp:TemplateField ShowHeader="False" HeaderStyle-Wrap="False" ItemStyle-Wrap="False" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">
                                    <ItemTemplate>
                                        <asp:Button ID="btnEdit" runat="server" CausesValidation="false" Text="編輯" CommandArgument='<%# Eval("StockID") %>' CommandName="EditData"  Font-Size="10pt" UseSubmitBehavior="true" Height="20px" />
                                        &nbsp;
                                        <asp:Button ID="btnDelete" runat="server" CausesValidation="false" CommandArgument='<%# Eval("StockID") %>' CommandName="DeleteData" Font-Size="10pt" Text="刪除" UseSubmitBehavior="true" Height="20px"  OnClientClick="javascript: return confirm('請確定是否要刪除該筆資料?');"  />
                                    </ItemTemplate>
                                    <HeaderStyle Wrap="False"></HeaderStyle>
                                    <ItemStyle Wrap="False"></ItemStyle>
                                </asp:TemplateField> 
                            </Columns>
                            <AlternatingRowStyle BackColor="White" />
                            <EditRowStyle BackColor="#2461BF" BorderStyle="None" />
                            <EmptyDataRowStyle Font-Size="10pt" ForeColor="#0033CC" BorderColor="#AFBBCD" 
                                BorderStyle="Double" BorderWidth="3px" />
                            <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" 
                                Font-Italic="True" Font-Size="10pt" Font-Strikeout="True" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="False" ForeColor="#E8E8E8" 
                                Font-Size="10pt" BorderColor="#D1D1D1" BorderStyle="Solid" 
                                BorderWidth="2px" />
                            <PagerSettings Mode="NumericFirstLast" />
                            <PagerStyle ForeColor="White" HorizontalAlign="left" Font-Size="11pt" 
                                BackColor="#A1A1A1" BorderColor="#CCCFD9" BorderStyle="Solid" 
                                BorderWidth="2" Font-Bold="True" />
                            <RowStyle BackColor="#E1E1E1" Font-Size="9pt" ForeColor="#404040" 
                                BorderColor="#D1D1D1" BorderStyle="None" BorderWidth=" " HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#CC3300" Font-Size="10pt"
                                Font-Italic="False" />
                            <SortedAscendingCellStyle BackColor="#F5F7FB" />
                            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                            <SortedDescendingCellStyle BackColor="#E9EBEF" />
                            <SortedDescendingHeaderStyle BackColor="#4870BE" />
                        </asp:GridView>      
                    </asp:Panel>                     
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnRefresh" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="ddlGridPageCount" EventName="SelectedIndexChanged" />
                </Triggers>             
            </asp:UpdatePanel>                    
            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="1">
                <ProgressTemplate>
                        <div id="divMaskFrame" style="opacity:0.40; filter:alpha(opacity=40); background-color: #888888; left: 0px; top: 0px; position: fixed; width: 100%;height: 100%; z-index:9998"></Div>
<%--                                <div id="divProcess"   style ="opacity:0.85; filter:alpha(opacity=85); border:2px double #cccccc; background-color:#ffffff; position:absolute; text-align:center; vertical-align:middle; top: 50%; left: 50%; width: 150px;height: 150px; margin-left: 0px; margin-top: 0px; padding:3px;z-index:9999">                       
                            <asp:Image ID="imgProgress" runat="server" ImageUrl="~/images/ajax-loader.gif" 
                                style ="width: 85px;height: 85px; padding: 15px;" AlternateText="Loading ..." 
                                GenerateEmptyAlternateText="True"/>
                            <div style="opacity:1; filter:alpha(opacity=100);">
                                <input type="button" value="取消更新" style="font-family: Arial Unicode MS; font-size: 14px; font-weight: 500;" onclick="CancelAsyncPostBack();" />                                                      
                            </div>
                            </div>--%>
                    </ProgressTemplate>
                </asp:UpdateProgress> 
             </td>
        </tr>          
    </table>

<asp:SqlDataSource ID="sqlDS_StockLibraryList" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DATACNNSTR__SQLEXP_XIPS %>" 
        SelectCommand="SELECT StockID,  ROW_NUMBER() OVER(ORDER BY StockID)  AS [項次], StockName AS [紙張名稱], StockWidth AS [紙張寬度(mm)], StockHeight AS [紙張高度(mm)], StockWeight AS [紙張重量(gsm)], CASE WHEN StockCoated <> 0 THEN '是' ELSE '否' END AS [紙張塗布] FROM [Stock_Library] WITH(NOLOCK)"></asp:SqlDataSource>
</asp:Content>

