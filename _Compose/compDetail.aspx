<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="compDetail.aspx.cs" Inherits="XIPS._Compose._compDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterContent" Runat="Server">
<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" >
    <ContentTemplate>
    <asp:HiddenField ID="hid_Request_ComposeID" runat="server" />
    <table style="width: 100%;" border="0">
        <tr>
            <td style="border:1px solid #cccccc;">
                 <table style="width: 100%; font-family:'Arial Unicode MS'; font-size: 11pt;border:1px solid silver; background-color:#cccccc">
                    <tr>   
                        <td style="white-space:nowrap; vertical-align:middle;  padding-left:5px; font-family: 'Arial Unicode MS'; font-size: 12pt; font-weight:700;">
                        </td>
                        <td style="white-space:nowrap; padding-right:15px; vertical-align:middle; text-align: right">
                            <asp:Panel ID="pnlButton" runat="server" >  
                                <asp:Button ID="btnBackToMain" runat="server" Text="回主畫面" 
                                    style="font-family: 'Arial Unicode MS'; font-size: 10pt;" UseSubmitBehavior="False" onclick="btnBackToMain_Click" />                                                            
                            </asp:Panel>                        
                        </td>
                    </tr>
                  </table>
            </td>
        </tr>
        <tr>
            <td style="padding: 5px;">
            <asp:Panel ID="pnlComposeMaster" runat="server">
                <asp:FormView ID="FormView1" runat="server" 
                    BackColor="#CCCCCC" 
                    BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" 
                    ForeColor="Black" GridLines="Both" Font-Size="10pt" Width="920px"                     
                    CellSpacing="2" 
                    AllowPaging="false" 
                    onitemcommand="FormView1_ItemCommand" 
                    onitemdeleting="FormView1_ItemDeleting" 
                    oniteminserting="FormView1_ItemInserting" 
                    onitemupdating="FormView1_ItemUpdating" 
                    onmodechanging="FormView1_ModeChanging" 
                    HeaderText="FormView - HeaderText" 
                    oniteminserted="FormView1_ItemInserted" 
                    onitemupdated="FormView1_ItemUpdated" 
                    onitemdeleted="FormView1_ItemDeleted" 
                    Font-Names="arial"
                    DataKeyNames="ComposeID" 
                    DataSourceID="sqlDS_ComposeMaster">
                    <EditItemTemplate>
                        <table style="width: 100%; border:0px solid #cccccc; padding:4px;" cellpadding="2">
                         <table cellpadding="2" style="width: 100%; font-size: 10pt;border:1px solid silver; padding: 5px;">
                            <tr>
                                <td style="white-space:nowrap; padding-left:5px; width:45%;">
                                    <asp:Label ID="Label1" runat="server" Text="配頁名稱 : "></asp:Label>
                                    <asp:TextBox ID="txtComposeNameEdit" runat="server" Font-Size="10pt" 
                                        MaxLength="50" Text='<%# Bind("ComposeName") %>' Width="280px" />
                                </td>
                                <td style="white-space:nowrap; vertical-align:middle; width:auto;">
                                    <asp:Label ID="lblComposeDipiction" runat="server" Text="配頁描述 : "></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="white-space:nowrap; vertical-align:top;  padding-left:5px;">
                                    <asp:Label ID="Label4" runat="server" Text="客戶名稱 : "></asp:Label>
                                    <asp:DropDownList ID="ddlCustomerEdit" runat="server" 
                                        DataSourceID="sqlDS_CustomerInformation" DataTextField="CustomerName" 
                                        DataValueField="CustomerID" SelectedValue='<%# Bind("CustomerID") %>' 
                                        style="width:280px; font-family:微軟正黑體, 細明體; font-size:10pt;">
                                    </asp:DropDownList>
                                </td>
                                <td style="vertical-align:top;  padding-left:3px; padding-right:10px" rowspan="2">
                                    <asp:TextBox ID="txtComposeDepictionEdit" runat="server"
                                        MaxLength="100" ReadOnly="False" Rows="2" 
                                        style="background: #ffffff; border: 1px solid #bcbcbc; width: 100%; height: 40px; font-size: 10pt; font-size: 10pt; font-family: '微軟正黑體, Times New Roman'" 
                                        Text='<%# Bind("ComposeDepiction") %>' TextMode="MultiLine"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="white-space:nowrap; padding-left:5px;">
                                    <asp:Label ID="Label12" runat="server" Text="子集偏移 : "></asp:Label>
                                    <asp:RadioButtonList ID="rbl_SubsetOffset_Edit" runat="server" RepeatLayout="Flow"
                                        RepeatDirection="Horizontal" SelectedValue='<%# Bind("SubsetOffset") %>'>
                                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                                    </asp:RadioButtonList>   
                                </td>
                            </tr>
                             <tr>
                                 <td colspan="2" style="border:1px solid #cccccc; padding:2px ">
                                     <table style="width:100%">
                                         <tr>
                                             <td style="padding-top:7px; padding-bottom: 2px; padding-right: 12px; text-align:right;  border:1px solid #dedede; background-color:#999999">
                                                 <asp:Button ID="btnSaveAs" runat="server" CommandArgument="SaveAs" 
                                                     CommandName="Cancel" 
                                                     style="font-family: 'Arial Unicode MS'; font-size: 10pt; width: 160px; margin-right:50px;" 
                                                     Text="另存配頁設定檔" />                                                    
                                                 <asp:Button ID="btnUpdate" runat="server" CommandArgument="Update" 
                                                     CommandName="Update" 
                                                     style="font-family: 'Arial Unicode MS'; font-size: 10pt; width: 90px" 
                                                     Text="確定" />
                                                 <asp:Button ID="btnCancelUpdate" runat="server" CommandArgument="CancelUpdate" 
                                                     CommandName="Cancel" 
                                                     style="font-family: 'Arial Unicode MS'; font-size: 10pt; width: 70px; margin-left:15px;" 
                                                     Text="取消" />
                                             </td>
                                         </tr>
                                     </table>
                                 </td>
                             </tr>
                        </table>
                        <asp:HiddenField ID="HiddenField1" runat="server" 
                            Value='<%# Bind("Modifier") %>' />
                        <asp:HiddenField ID="HiddenField2" runat="server" 
                            Value='<%# Bind("DateLastUpdated") %>' />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <table style="width: 100%; border:0px solid #cccccc; padding:5px;" cellpadding="2">
                         <table style="width: 100%; font-size: 10pt;border:1px solid silver; padding: 5px;" cellpadding="2">
                            <tr>   
                                <td style="white-space:nowrap; padding-left:5px; width:45%;">
                                    <asp:Label ID="Label1" runat="server" Text="配頁名稱 : "></asp:Label>
                                    <asp:TextBox ID="txtComposeNameInsert" runat="server" MaxLength="50" Width="280px" Font-Size="10pt" Text='<%# Bind("ComposeName") %>' />
                                </td>
                                <td style="white-space:nowrap; vertical-align:middle; width:auto;">
                                    <asp:Label ID="lblComposeDipiction" runat="server" Text="配頁描述 : "></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="white-space:nowrap; vertical-align:top;  padding-left:5px;">
                                    <asp:Label ID="Label4" runat="server" Text="客戶名稱 : "></asp:Label>
                                    <asp:DropDownList ID="ddlCustomerInsert" runat="server" 
                                        style="width:280px; font-family:微軟正黑體, 細明體; font-size:9pt;" 
                                        DataSourceID="sqlDS_CustomerInformation" DataTextField="CustomerName" 
                                        DataValueField="CustomerID" SelectedValue='<%# Bind("CustomerID") %>'>
                                    </asp:DropDownList>
                                </td>
                                <td style="vertical-align:middle;  padding-left:3px; padding-right:10px" rowspan="2">
                                    <asp:TextBox ID="txtComposeDepictionInsert" runat="server" ReadOnly="False" MaxLength="100"                             
                                        style="background:#ffffff; border: 1px solid #bcbcbc; width: 100%; height:40px; font-size:10pt; font-size:10pt;font-family:'微軟正黑體, Times New Roman'" 
                                        Rows="2" TextMode="MultiLine" Text='<%# Bind("ComposeDepiction") %>' ></asp:TextBox>                            
                                </td>
                            </tr>			
                            <tr>
                                <td style="white-space:nowrap; padding-left:5px;">
                                    <asp:Label ID="Label12" runat="server" Text="子集偏移 : "></asp:Label>
                                    <asp:RadioButtonList ID="rbl_SubsetOffset_Insert" runat="server" RepeatLayout="Flow"
                                        RepeatDirection="Horizontal" SelectedValue='<%# Bind("SubsetOffset") %>' >
                                        <asp:ListItem Text="是" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="否" Value="0"></asp:ListItem>
                                    </asp:RadioButtonList>   
                                </td>
                            </tr>                          			
                            <tr>
                                <td colspan="2" style="border:1px solid #cccccc; padding:2px ">
                                    <table style="width:100%">
                                        <tr>
                                            <td style="padding-top:7px; padding-bottom: 2px; padding-right: 12px; text-align:right;  border:1px solid #dedede; background-color:#dedede">                                            
                                                <asp:Button ID="btnInsert" runat="server"  CommandName="Insert" Text="確定" CommandArgument="Insert" style="font-family: 'Arial Unicode MS'; font-size: 10pt; width: 90px" />
                                                <asp:Button ID="btnCancelInsert" runat="server"  CommandName="Cancel" Text="取消" CommandArgument="CancelInsert" style="font-family: 'Arial Unicode MS'; font-size: 10pt; width: 70px; margin-left:15px;"  />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>                                 
                        </table>                              
						<asp:HiddenField  ID="hidCreator" runat="server" Value='<%# Bind("Creator") %>' />   
                        <asp:HiddenField  ID="hidModifier" runat="server" Value='<%# Bind("Modifier") %>' /> 
                        <asp:HiddenField  ID="hidDateCreated" runat="server" Value='<%# Bind("DateCreated") %>' />                                     
                        <asp:HiddenField  ID="hidDateLastUpdated" runat="server" Value='<%# Bind("DateLastUpdated") %>' />
                    </InsertItemTemplate>                                 
                    <ItemTemplate>
                        <table style="width:100%; background-color: #fefeff; " cellpadding="2">
                            <tr>
                                <td style="padding-top:7px; padding-bottom: 1px; padding-left:8px;">
                                    <asp:Button ID="btnAdd" runat="server"  CommandName="New" Text="新增配頁設定主檔" CommandArgument="New" style="font-family: 'Arial Unicode MS'; font-size: 10pt; width: 160px" /> &nbsp;
                                    <asp:Button ID="btnEdit" runat="server"  CommandName="Edit" Text="編輯配頁設定主檔" CommandArgument="Edit" style="font-family: 'Arial Unicode MS'; font-size: 10pt; width: 160px" />
                                </td>
                                <td style="padding-top:7px; padding-bottom: 1px; padding-right: 10px; text-align:right;">
                                    <asp:Button ID="btnDelete" runat="server" CommandName="Delete" Text="刪除配頁設定" CommandArgument="Delete" style="font-family: 'Arial Unicode MS'; font-size: 10pt; width: 110px" 
                                    OnClientClick="javascript: return confirm('請確定是否要刪除此筆配頁設定檔?\n刪除配頁設定檔, 也會刪除所有配頁明細資料.');" />                                                                                              
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="padding: 7px">
                                    <table style="width: 100%; font-size: 10pt;border:1px solid #efefef; padding: 5px;" cellpadding="4">         
                                        <tr>   
                                            <td style="white-space:nowrap; padding-left:5px; width:45%;">
                                                <asp:Label ID="Label1" runat="server" Text="配頁名稱 : "></asp:Label>
                                                <asp:Label ID="lblUserName" runat="server" Text='<%# Bind("ComposeName") %>' />
                                            </td>
                                            <td style="white-space:nowrap; vertical-align:middle; width:auto;">
                                                <asp:Label ID="lblComposeDipiction" runat="server" Text="配頁描述 : "></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="white-space:nowrap; vertical-align:top;  padding-left:5px;">
                                                <asp:Label ID="Label4" runat="server" Text="客戶名稱 : "></asp:Label>
                                                <asp:DropDownList ID="ddlCustomer" runat="server" 
                                                    style="width:280px; font-family:微軟正黑體, 細明體; font-size:9pt; background-color:transparent; border-style:none;" 
                                                    DataSourceID="sqlDS_CustomerInformation" DataTextField="CustomerName" 
                                                    DataValueField="CustomerID" SelectedValue='<%# Bind("CustomerID") %>' Enabled="False">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="vertical-align:top;  padding-left:3px; padding-right:10px" rowspan="2">
                                                <asp:TextBox ID="txtComposeDepiction" runat="server" Enabled="false" ReadOnly="true"                             
                                                    style="background:#ffffff; border: 1px solid #bcbcbc; width: 100%; height:40px; font-size:10pt;" 
                                                    Rows="2" TextMode="MultiLine" Text='<%# Bind("ComposeDepiction") %>' Font-Names="微軟正黑體,標楷體,Arial Unicode MS"></asp:TextBox>                            
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="white-space:nowrap; padding-left:5px;">
                                                <asp:Label ID="Label12" runat="server" Text="子集偏移 : "></asp:Label>
                                                <asp:RadioButtonList ID="rbl_SubsetOffset" runat="server" RepeatLayout="Flow"
                                                    RepeatDirection="Horizontal" SelectedValue='<%# System.Convert.ToInt16(Eval("SubsetOffset")) > 0 ? 1:0 %>' Enabled="False">
                                                    <asp:ListItem Text="是" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="否" Value="0"></asp:ListItem>
                                                </asp:RadioButtonList>   
                                            </td>
                                        </tr>
                                    </table>                                
                                </td>
                            </tr>
                        </table>                                                 
                    </ItemTemplate>
                    <InsertRowStyle BackColor="#C5C5C5" Font-Size="10" />                    
                    <EditRowStyle BackColor="#808080" Font-Bold="True" ForeColor="White" Font-Size="10" />
                    <FooterStyle BackColor="#CCCCCC" />
                    <HeaderStyle BackColor="#666666" Font-Bold="True" ForeColor="White" 
                        Font-Size="11pt" HorizontalAlign="Left" VerticalAlign="Middle" 
                        BorderColor="White" BorderWidth="1px" />
                    <PagerStyle BackColor="#888888" ForeColor="White" HorizontalAlign="Center" 
                        BorderColor="Gray" BorderStyle="Solid" BorderWidth="1px" Font-Size="11pt" 
                        VerticalAlign="Middle" />
                    <RowStyle BackColor="White" />
                </asp:FormView>
                <asp:Panel ID="pnlFormViewError" runat="server" style="padding: 5px">
                    <asp:Image ID="imgError" runat="server" ImageUrl="~/images/error.gif" style="vertical-align:bottom; padding-left:2px; padding-right:5px;"/>
                    <asp:Label ID="lblFormViewError" runat="server" Font-Bold="True" 
                        Font-Size="10pt" ForeColor="#FF3300" Width="900px" >[FormView Error Message]</asp:Label>
                </asp:Panel>  
             </asp:Panel>             
            </td>
        </tr>           
        <tr>
            <td style="padding: 7px;">
            <asp:Panel ID="pnlComposeDetail" runat="server">
                <asp:Panel ID="pnlGridViewError" runat="server" style="padding: 5px">
                    <asp:Image ID="Image1" runat="server" ImageUrl="~/images/error.gif" style="vertical-align:bottom; padding-left:2px; padding-right:5px;"/>
                    <asp:Label ID="lblGridViewError" runat="server" Font-Bold="True" 
                        Font-Size="10pt" ForeColor="#FF3300" Width="900px" >[GridView Error Message]</asp:Label>
                </asp:Panel>  
                <asp:GridView  
                    ID="GridView1" 
                    runat="server" 
                    CellPadding="4" 
                    Font-Size="10pt"
                    ForeColor="#333333" 
                    GridLines="Vertical" 
                    BorderColor="#666666" 
                    BorderStyle="Solid" 
                    BorderWidth="2px" 
                    AutoGenerateColumns="False" 
                    PageSize="1"     
                    CaptionAlign="Left" 
                    DataKeyNames="DetailID" 
                    DataSourceID="sqlDS_ComposeDetail" 
                    onprerender="GridView1_PreRender" 
                    onrowcommand="GridView1_RowCommand" 
                    onrowdeleting="GridView1_RowDeleting" 
                    onrowupdating="GridView1_RowUpdating" 
                    onrowdeleted="GridView1_RowDeleted" 
                    onrowupdated="GridView1_RowUpdated" EnablePersistedSelection="True" 
                    onrowdatabound="GridView1_RowDataBound" EmptyDataText="無配頁設定檔明細" >
                    <Columns>
                        <asp:TemplateField HeaderText="編輯項目" ShowHeader="true">
                            <ItemTemplate>
                            	<asp:Button ID="btnEdit" runat="server" CausesValidation="false" Text="編輯" CommandArgument='<%# Eval("DetailID") %>' CommandName="Edit"  Font-Size="9pt" UseSubmitBehavior="true" Height="20px" />&nbsp;
                            	<asp:Button ID="btnDelete" runat="server" CausesValidation="false" Text="刪除" CommandArgument='<%# Eval("DetailID") %>' CommandName="Delete"  Font-Size="9pt" UseSubmitBehavior="true" Height="20px" 
                                    OnClientClick="javascript: return confirm('請確定是否要刪除此筆配頁明細資料?');"/>
                            </ItemTemplate>
                            <EditItemTemplate>
                            	<asp:Button ID="btnUpdate" runat="server" CausesValidation="false" Text="更新" CommandArgument='<%# Eval("DetailID") %>' CommandName="Update"  Font-Size="9pt" UseSubmitBehavior="true" Height="20px" />&nbsp;
                            	<asp:Button ID="btnCancel" runat="server" CausesValidation="false" Text="取消" CommandArgument='<%# Eval("DetailID") %>' CommandName="Cancel"  Font-Size="9pt" UseSubmitBehavior="true" Height="20px" />
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="70"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>  
                        </asp:TemplateField>
                        <asp:BoundField DataField="DetailID" HeaderText="DetailID" SortExpression="DetailID" InsertVisible="False" ReadOnly="True" Visible="False" />
                        <asp:BoundField DataField="ComposeID" HeaderText="ComposeID" SortExpression="ComposeID" Visible="False" />
                        <asp:TemplateField HeaderText="順序" SortExpression="ItemSequence" HeaderStyle-Wrap="False" ItemStyle-Wrap="False" FooterStyle-Wrap="False">
                            <ItemTemplate>
<%--                                <asp:DropDownList ID="ddlItemSequence" runat="server" 
                                    DataSourceID="xmlDS_Sequence" DataTextField="ID" DataValueField="ID" style="font-size:9pt; width: 95%;"
                                    SelectedValue='<%# Bind("ItemSequence") %>' Enabled="False">
                                </asp:DropDownList>--%>
                                <asp:ImageButton ID="btnSeqDec" runat="server" ImageUrl="~/images/up.gif" style="height: 15px; width:20px; padding-left:3px;" CommandName="Decrease" CommandArgument='<%# Bind("DetailID") %>' ToolTip="順序往上" />
                                <%--<asp:Button ID="btnSeqDec" runat="server" Text="-" CommandName="Decrease" CommandArgument='<%# Bind("DetailID") %>' style=" font-size:8pt; font-family:Verdana; font-weight:800;width:25px;"  />--%>
                                <asp:Label ID="lblItemSequence" runat="server" Text='<%# Bind("ItemSequence") %>' style=" font-weight:800; font-size:10pt; padding-right:4px; padding-left:4px;"></asp:Label>                               
                                <%--<asp:Button ID="btnSeqInc" runat="server" Text="+"  CommandName="Increase" CommandArgument='<%# Bind("DetailID") %>' style=" font-size:8pt; font-family:Verdana; font-weight:800; width:25px;"  />--%>                            
                                <asp:ImageButton ID="btnSeqInc" runat="server" ImageUrl="~/images/down.gif" style="height: 15px; width:20px; padding-right:3px;" CommandName="Increase" CommandArgument='<%# Bind("DetailID") %>' ToolTip="順序往下"  />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:ImageButton ID="btnSeqDecEdit" runat="server" ImageUrl="~/images/up-disable.gif" style="height: 15px; width:20px; padding-left:3px;" CommandName="Decrease" CommandArgument='<%# Bind("DetailID") %>' Enabled="false"/>
                                <%--  <asp:Button ID="btnSeqDecEdit" runat="server" Text="-"  style=" font-size:8pt; font-family:Verdana; font-weight:800;width:25px;"  Enabled="False" /> --%>                              
                               <asp:Label ID="lblItemSequence" runat="server" Text='<%# Bind("ItemSequence") %>' style=" font-weight:800; font-size:10pt; padding-right:8px;padding-left:8px;"></asp:Label>
                               <%--<asp:Button ID="btnSeqIncEdit" runat="server" Text="+"   style=" font-size:8pt; font-family:Verdana; font-weight:800; width:25px;"  Enabled="False" />--%>
                               <asp:ImageButton ID="btnSeqIncEdit" runat="server" ImageUrl="~/images/down-disable.gif" style="height: 15px; width:20px; padding-right:3px;" CommandName="Increase" CommandArgument='<%# Bind("DetailID") %>' Enabled="false" />
<%--                                <asp:DropDownList ID="ddlItemSequenceEdit" runat="server" 
                                    DataSourceID="xmlDS_Sequence" DataTextField="ID" DataValueField="ID" style="font-size:9pt; width: 95%;"
                                    SelectedValue='<%# Bind("ItemSequence") %>'>
                                </asp:DropDownList>--%>
                            </EditItemTemplate>
                            <FooterStyle Wrap="False" />
                            <HeaderStyle Wrap="False" Width="90"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>  
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="頁面項目" SortExpression="ItemID">
                            <ItemTemplate>
                                <asp:DropDownList ID="ddlItemID" runat="server" DataSourceID="sqlDS_ItemList" 
                                    DataTextField="ItemName" DataValueField="ItemID"  style="font-size:9pt; width: 95%; background-color: #ffffff;"
                                    SelectedValue='<%# Bind("ItemID") %>' Enabled="False">
                                </asp:DropDownList>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlItemIDEdit" runat="server" DataSourceID="sqlDS_ItemList" 
                                    DataTextField="ItemName" DataValueField="ItemID"  style="font-size:9pt; width: 95%;"
                                    SelectedValue='<%# Bind("ItemID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="90"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>  
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="列印面" SortExpression="PrintMethod">
                            <ItemTemplate>
                                <asp:DropDownList ID="ddlPrintMethod" runat="server"  style="font-size:9pt; width: 95%; background-color: #ffffff;"
                                    DataSourceID="xmlDS_PrintMethod" DataTextField="Method" DataValueField="ID" 
                                    SelectedValue='<%# Bind("PrintMethod") %>' Enabled="False">
                                </asp:DropDownList>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlPrintMethodEdit" runat="server"  style="font-size:9pt; width: 95%;"
                                    DataSourceID="xmlDS_PrintMethod" DataTextField="Method" DataValueField="ID" 
                                    SelectedValue='<%# Bind("PrintMethod") %>' >
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="70"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>  
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="張數" SortExpression="PaperPerSet">
                            <ItemTemplate>                                
                                <asp:Label ID="lblPaperPerSet" runat="server" Text='<%# Bind("PaperPerSet") %>'  style="font-size:9pt;"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPaperPerSetEdit" runat="server" Text='<%# Bind("PaperPerSet") %>'  style="font-size:9pt; width: 90%; text-align:center; " MaxLength="4" ></asp:TextBox>
                                <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender_txtPaperPerSetEdit" runat="server" FilterType="Numbers" TargetControlID="txtPaperPerSetEdit">
                                </ajaxToolkit:FilteredTextBoxExtender>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="50"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>  
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="紙匣" SortExpression="TrayID">
                            <ItemTemplate>
                                <asp:DropDownList ID="ddlTrayID" runat="server" DataSourceID="sqlDS_TrayList" 
                                    DataTextField="TrayName" DataValueField="TrayID" style="font-size:9pt; width: 95%; background-color: #ffffff;"
                                    SelectedValue='<%# Bind("TrayID") %>' Enabled="False">
                                </asp:DropDownList>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlTrayIDEdit" runat="server" DataSourceID="sqlDS_TrayList" 
                                    DataTextField="TrayName" DataValueField="TrayID" style="font-size:9pt; width: 95%;"
                                    SelectedValue='<%# Bind("TrayID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="80"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>  
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="頁面位移調整 (mm)" SortExpression="OffsetX">
                            <ItemTemplate>
<%--
                                X:&nbsp;<asp:Label ID="lblListOffsetX" runat="server" Text='<%# Bind("OffsetX") %>' style="font-size:9pt;"></asp:Label>&nbsp;&nbsp;                               
                                Y:&nbsp;<asp:Label ID="lblListOffsetY" runat="server" Text='<%# Bind("OffsetY") %>' style="font-size:9pt;"></asp:Label>
--%>                            
                                <asp:Label ID="Label16" runat="server" Text='X:' style="font-size:10pt;"></asp:Label>&nbsp;
                                <asp:TextBox ID="txtListOffsetX" runat="server" Text='<%# Bind("OffsetX") %>' style="width:45px; font-size:9pt; border: 1px solid #cccccc; text-align:right; background-color: #ffffff;" Enabled="False"></asp:TextBox>&nbsp;&nbsp;
                                <asp:Label ID="Label17" runat="server" Text='Y:' style="font-size:10pt;"></asp:Label>&nbsp;
                                <asp:TextBox ID="txtListOffsetY" runat="server" Text='<%# Bind("OffsetY") %>' style="width:45px; font-size:9pt; border: 1px solid #cccccc; text-align:right; background-color: #ffffff;" Enabled="False"></asp:TextBox>&nbsp;
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="Label13" runat="server" Text='X:' style="font-size:10pt;"></asp:Label>&nbsp;
                                <asp:TextBox ID="txtListOffsetXEdit" runat="server" Text='<%# Bind("OffsetX") %>' MaxLength="7" style="width:45px; font-size:9pt; text-align:right;"></asp:TextBox>&nbsp;&nbsp;
                                <asp:Label ID="Label15" runat="server" Text='Y:' style="font-size:10pt;"></asp:Label>&nbsp;
                                <asp:TextBox ID="txtListOffsetYEdit" runat="server" Text='<%# Bind("OffsetY") %>' MaxLength="7" style="width:45px; font-size:9pt; text-align:right;"></asp:TextBox>&nbsp;
                                <ajaxToolkit:FilteredTextBoxExtender 
                                    ID="FilteredTextBoxExtender7" 
                                    runat="server" 
                                    FilterMode="ValidChars" 
                                    FilterType="Numbers, Custom" 
                                    ValidChars="-."
                                    TargetControlID="txtListOffsetXEdit" />                                                                                             
                                <ajaxToolkit:FilteredTextBoxExtender 
                                    ID="FilteredTextBoxExtender8" 
                                    runat="server" 
                                    FilterMode="ValidChars" 
                                    FilterType="Numbers, Custom" 
                                    ValidChars="-."
                                    TargetControlID="txtListOffsetYEdit" />        
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="150"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle> 
                        </asp:TemplateField>
 <%--                       
                        <asp:TemplateField HeaderText="頁面尺寸" SortExpression="PageStockID">
                            <ItemTemplate>
                                <asp:DropDownList ID="ddlPageStockID" runat="server"  style="font-size:9pt; width: 95%;"
                                    DataSourceID="sqlDS_StockLibrary" DataTextField="PaperSize" 
                                    DataValueField="StockID" SelectedValue='<%# Bind("PageStockID") %>' Enabled="False">
                                </asp:DropDownList>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlPageStockIDEdit" runat="server"  style="font-size:9pt; width: 95%;"
                                    DataSourceID="sqlDS_StockLibrary" DataTextField="PaperSize" 
                                    DataValueField="StockID" SelectedValue='<%# Bind("PageStockID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="150"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>  
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="列印紙張" SortExpression="PaperStockID">
                            <ItemTemplate>
                                <asp:DropDownList ID="ddlPaperStockID" runat="server"  style="font-size:9pt; width: 95%; background-color: #ffffff;"
                                    DataSourceID="sqlDS_StockLibrary" DataTextField="PaperSelected" 
                                    DataValueField="StockID" SelectedValue='<%# Bind("PaperStockID") %>' Enabled="False">
                                </asp:DropDownList>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlPaperStockIDEdit" runat="server"  style="font-size:9pt; width: 95%;"
                                    DataSourceID="sqlDS_StockLibrary" DataTextField="PaperSelected" 
                                    DataValueField="StockID" SelectedValue='<%# Bind("PaperStockID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <HeaderStyle Wrap="False" Width="210"></HeaderStyle>
                            <ItemStyle Wrap="False"></ItemStyle>  
                        </asp:TemplateField>
                        <asp:BoundField DataField="Creator" HeaderText="Creator" SortExpression="Creator" Visible="False" />
                        <asp:BoundField DataField="Modifier" HeaderText="Modifier" SortExpression="Modifier" Visible="False" />
                        <asp:BoundField DataField="DateCreated" HeaderText="DateCreated" SortExpression="DateCreated" Visible="False" />
                        <asp:BoundField DataField="DateLastUpdated" HeaderText="DateLastUpdated" SortExpression="DateLastUpdated" Visible="False" />
                    </Columns>
                    <AlternatingRowStyle BackColor="#E1E1E1" BorderColor="White" 
                        BorderStyle="Solid" BorderWidth="1px" />
                    <EditRowStyle BackColor="#F09100" BorderStyle="Dotted" BorderColor="#333333" 
                        BorderWidth="3px" Font-Size="9pt" />
                    <EmptyDataRowStyle Font-Size="10pt" ForeColor="#0033CC" BorderColor="#AFBBCD" 
                        BorderStyle="Double" BorderWidth="3px" />
                    <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" 
                        Font-Italic="True" Font-Size="10pt" Font-Strikeout="True" />
                    <HeaderStyle BackColor="Silver" Font-Bold="False" ForeColor="#6C2300" 
                        Font-Size="10pt" />
                    <PagerSettings Mode="NumericFirstLast" />
                    <PagerStyle ForeColor="White" HorizontalAlign="left" Font-Size="11pt" 
                        BackColor="#A1A1A1" BorderColor="#CCCFD9" BorderStyle="Solid" 
                        BorderWidth="2" Font-Bold="True" />
                    <RowStyle BackColor="White" Font-Size="9pt" ForeColor="#404040" 
                        BorderColor="#D1D1D1" BorderStyle="Solid" BorderWidth="1px" 
                        HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#CC3300" Font-Size="10pt"
                        Font-Italic="False" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>  
            </asp:Panel>                                          
            </td>       
        </tr>  
        <tr>
            <td style="padding: 15px 50px 10px 20px; text-align:right;">
                <asp:Button ID="btnNewComposeDetail" runat="server" Text="新增配頁設定項目" 
                    style="padding-left:10pf; padding-right:10pt; font-size:10pt; font-family:微軟正黑體;"  onclick="btnNewComposeDetail_Click" />
                <%--<input id="create-ComposeDetail" type="button" value="新增配頁設定項目" style="padding-left:10pt; padding-right:10pt; font-size:10pt; font-family:微軟正黑體;"/>--%>
            </td>
        </tr>      
        <tr><td style="padding-left:8px;">
            <asp:Panel ID="pnlNewComposeDetailWindow"  runat="server" style=" background-color:#ffffff; border: 4px dotted #808080; vertical-align:middle; text-align:center;  width: 300px; padding:3px; margin-top:-20px; ">                                  
                    <table style="width: 100%; height:100%; font-family:微軟正黑體; border: 0px solid #ffffff; ">
                        <tr>
                            <td>
                                <asp:DetailsView ID="DetailsView1" 
                                    runat="server"  
                                    DataSourceID="sqlDS_ComposeDetail" 
                                    AutoGenerateRows="False" 
                                    DataKeyNames="DetailID" 
                                    Width="100%" 
                                    Font-Size="10pt" 
                                    oniteminserting="DetailsView1_ItemInserting" CellPadding="3" 
                                    DefaultMode="Insert" 
                                    onitemcommand="DetailsView1_ItemCommand" 
                                    oniteminserted="DetailsView1_ItemInserted">
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" Font-Size="9pt"   HorizontalAlign="Left" />
                                    <CommandRowStyle BackColor="#E2DED6" Font-Bold="True" Font-Size="10pt"  HorizontalAlign="Center" Wrap="False"  Font-Names="微軟正黑體,標楷體,Arial Unicode MS" />
                                    <EditRowStyle BackColor="#999999" Font-Size="9pt" />
                                    <FieldHeaderStyle BackColor="#D1D8E2" Font-Bold="True" Font-Size="9pt"  HorizontalAlign="Right" Width="70px" Wrap="False" />
                                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"   Font-Size="9pt" />
                                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White"  Font-Size="10pt" HorizontalAlign="Center" Wrap="False" />
                                    <HeaderTemplate>新增配頁設定檔項目</HeaderTemplate>
                                    <InsertRowStyle Font-Size="9pt" HorizontalAlign="Left" Wrap="False" />
                                    <PagerStyle BackColor="#284775" Font-Names="Verdana" Font-Size="10pt"   ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" Font-Size="9pt"  HorizontalAlign="Left" />
                                    <Fields>
                                        <asp:BoundField DataField="DetailID" HeaderText="DetailID" InsertVisible="False" ReadOnly="True" SortExpression="DetailID" Visible="False" />
                                        <asp:BoundField DataField="ComposeID" HeaderText="ComposeID" SortExpression="ComposeID" Visible="False" />
                                        <asp:TemplateField HeaderText="順序 :" SortExpression="ItemSequence">
                                            <ItemTemplate>
                                                <asp:Label ID="lblItemSequence" runat="server" Text='<%# Bind("ItemSequence") %>' ></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
<%--                                                <asp:DropDownList ID="ddlItemSequenceEdit" runat="server" style="font-size:9pt; width: 50px;"
                                                    DataSourceID="xmlDS_Sequence" DataTextField="ID" DataValueField="ID" 
                                                    SelectedValue='<%# Bind("ItemSequence") %>'>
                                                </asp:DropDownList>--%>
                                                <asp:DropDownList ID="ddlItemSequenceEdit" runat="server" style="font-size:9pt; width: 50px;" SelectedValue='<%# Bind("ItemSequence") %>' >  </asp:DropDownList>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
<%--                                                <asp:DropDownList ID="ddlItemSequenceInsert" runat="server" style="font-size:9pt; width: 50px;"
                                                    DataSourceID="xmlDS_Sequence" DataTextField="ID" DataValueField="ID" 
                                                    SelectedValue='<%# Bind("ItemSequence") %>'>
                                                </asp:DropDownList>--%>
                                                <asp:DropDownList ID="ddlItemSequenceInsert" runat="server" style="font-size:9pt; width: 50px;" SelectedValue='<%# Bind("ItemSequence") %>' > </asp:DropDownList>
                                            </InsertItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="頁面項目 :" SortExpression="ItemID">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlItemID" runat="server" style="font-size:9pt; width: 100px;"
                                                    DataSourceID="sqlDS_ItemList" DataTextField="ItemName" DataValueField="ItemID" Enabled="false"
                                                    SelectedValue='<%# Bind("ItemID") %>'>
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlItemIDEdit" runat="server" style="font-size:9pt; width: 100px;"
                                                    DataSourceID="sqlDS_ItemList" DataTextField="ItemName" DataValueField="ItemID" 
                                                    SelectedValue='<%# Bind("ItemID") %>'>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:DropDownList ID="ddlItemIDInsert" runat="server" style="font-size:9pt; width: 100px;"
                                                    DataSourceID="sqlDS_ItemList" DataTextField="ItemName" DataValueField="ItemID" 
                                                    SelectedValue='<%# Bind("ItemID") %>'>
                                                </asp:DropDownList>
                                            </InsertItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="列印面 :" SortExpression="PrintMethod">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlPrintMethod" runat="server" style="font-size:9pt; width: 100px;"
                                                    DataSourceID="xmlDS_PrintMethod" DataTextField="Method" DataValueField="ID" Enabled="false"
                                                    SelectedValue='<%# Bind("PrintMethod") %>'>
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlPrintMethodEdit" runat="server" style="font-size:9pt; width: 100px;"
                                                    DataSourceID="xmlDS_PrintMethod" DataTextField="Method" DataValueField="ID" 
                                                    SelectedValue='<%# Bind("PrintMethod") %>'>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:DropDownList ID="ddlPrintMethodInsert" runat="server" style="font-size:9pt; width: 100px;"
                                                    DataSourceID="xmlDS_PrintMethod" DataTextField="Method" DataValueField="ID" 
                                                    SelectedValue='<%# Bind("PrintMethod") %>'>
                                                </asp:DropDownList>
                                            </InsertItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="張數 :" SortExpression="PaperPerSet">
                                            <ItemTemplate>
                                                <asp:Label ID="txtDVPaperPerSet" runat="server" Text='<%# Bind("PaperPerSet") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>                                  
                                                <asp:TextBox ID="txtDVPaperPerSetEdit" runat="server" Text='<%# Bind("PaperPerSet") %>' MaxLength="4" style="width:50px; font-size:9pt;"></asp:TextBox>
                                                <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers" TargetControlID="txtDVPaperPerSetEdit">
                                                </ajaxToolkit:FilteredTextBoxExtender>                                                                 
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:TextBox ID="txtDVPaperPerSetInsert" runat="server" Text='<%# Bind("PaperPerSet") %>' MaxLength="4" style="width:50px; font-size:9pt;"></asp:TextBox>
                                                <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="Numbers" TargetControlID="txtDVPaperPerSetInsert">
                                                </ajaxToolkit:FilteredTextBoxExtender>         
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="請輸入列印張數." SetFocusOnError="True" ControlToValidate="txtDVPaperPerSetInsert"></asp:RequiredFieldValidator>                       
                                            </InsertItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="紙匣 :" SortExpression="TrayID">
                                            <ItemTemplate>
                                                 <asp:DropDownList ID="ddlITrayID" runat="server" style="font-size:9pt; width: 100px;"
                                                    DataSourceID="sqlDS_TrayList" DataTextField="TrayName" DataValueField="TrayID" Enabled="false"
                                                    SelectedValue='<%# Bind("TrayID") %>'>
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlITrayIDEdit" runat="server" style="font-size:9pt; width: 100px;"
                                                    DataSourceID="sqlDS_TrayList" DataTextField="TrayName" DataValueField="TrayID" 
                                                    SelectedValue='<%# Bind("TrayID") %>'>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                 <asp:DropDownList ID="ddlITrayIDInsert" runat="server" style="font-size:9pt; width: 100px;"
                                                    DataSourceID="sqlDS_TrayList" DataTextField="TrayName" DataValueField="TrayID" 
                                                    SelectedValue='<%# Bind("TrayID") %>'>
                                                </asp:DropDownList>
                                            </InsertItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="頁面位移 :" SortExpression="OffsetX">
                                            <ItemTemplate>
                                                X:&nbsp;<asp:Label ID="txtOffsetX" runat="server" Text='<%# Bind("OffsetX") %>' style="font-size:9pt;"></asp:Label>&nbsp;mm&nbsp;&nbsp;
                                                Y:&nbsp;<asp:Label ID="txtOffsetY" runat="server" Text='<%# Bind("OffsetY") %>' style="font-size:9pt;"></asp:Label>&nbsp;mm
                                            </ItemTemplate>
                                           <EditItemTemplate>                                  
                                                <asp:Label ID="Label5" runat="server" Text='X:' style="font-size:10pt;"></asp:Label>&nbsp;
                                                <asp:TextBox ID="txtOffsetXEdit" runat="server" Text='<%# Bind("OffsetX") %>' MaxLength="7" style="width:45px; font-size:9pt;"></asp:TextBox>&nbsp;
                                                <asp:Label ID="Label6" runat="server" Text='mm' style="font-size:10pt;"></asp:Label>&nbsp;&nbsp;
                                                <asp:Label ID="Label7" runat="server" Text=' Y:' style="font-size:10pt;"></asp:Label>&nbsp;
                                                <asp:TextBox ID="txtOffsetYEdit" runat="server" Text='<%# Bind("OffsetY") %>' MaxLength="7" style="width:45px; font-size:9pt;"></asp:TextBox>&nbsp;
                                                <asp:Label ID="Label8" runat="server" Text='mm'  style="font-size:10pt;"></asp:Label> 
                                                 <ajaxToolkit:FilteredTextBoxExtender 
                                                    ID="FilteredTextBoxExtender3" 
                                                    runat="server" 
                                                    FilterMode="ValidChars" 
                                                    FilterType="Numbers, Custom" 
                                                    ValidChars="-."
                                                    TargetControlID="txtOffsetXEdit" />                                                                                             
                                                 <ajaxToolkit:FilteredTextBoxExtender 
                                                    ID="FilteredTextBoxExtender4" 
                                                    runat="server" 
                                                    FilterMode="ValidChars" 
                                                    FilterType="Numbers, Custom" 
                                                    ValidChars="-."
                                                    TargetControlID="txtOffsetYEdit" />                                                                                                                                                                                   
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:Label ID="Label9" runat="server" Text='X: ' style="font-size:10pt;"></asp:Label>
                                                <asp:TextBox ID="txtOffsetXInsert" runat="server" Text='<%# Bind("OffsetX") %>' MaxLength="7" style="width:45px; font-size:9pt;"></asp:TextBox>
                                                <asp:Label ID="Label10" runat="server" Text=' mm' style="font-size:10pt;"></asp:Label>&nbsp;&nbsp;
                                                <asp:Label ID="Label11" runat="server" Text=' Y: ' style="font-size:10pt;"></asp:Label>
                                                <asp:TextBox ID="txtOffsetYInsert" runat="server" Text='<%# Bind("OffsetY") %>' MaxLength="7" style="width:45px; font-size:9pt;"></asp:TextBox>
                                                <asp:Label ID="Label12" runat="server" Text=' mm'  style="font-size:10pt;"></asp:Label> 
                                                 <ajaxToolkit:FilteredTextBoxExtender 
                                                    ID="FilteredTextBoxExtender5" 
                                                    runat="server" 
                                                    FilterMode="ValidChars" 
                                                    FilterType="Numbers, Custom" 
                                                    ValidChars="-."
                                                    TargetControlID="txtOffsetXInsert" />                                                                                             
                                                 <ajaxToolkit:FilteredTextBoxExtender 
                                                    ID="FilteredTextBoxExtender6" 
                                                    runat="server" 
                                                    FilterMode="ValidChars" 
                                                    FilterType="Numbers, Custom" 
                                                    ValidChars="-."
                                                    TargetControlID="txtOffsetYInsert" />
                                            </InsertItemTemplate>
                                        </asp:TemplateField>

 <%--                                       
                                        <asp:TemplateField HeaderText="頁面尺寸 :" SortExpression="PageStockID">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlPageStockID" runat="server" style="font-size:9pt; width: 90%;"
                                                    DataSourceID="sqlDS_StockLibrary" DataTextField="PaperSize" Enabled="false"
                                                    DataValueField="StockID" SelectedValue='<%# Bind("PageStockID") %>'>
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlPageStockIDEdit" runat="server" style="font-size:9pt; width: 90%;"
                                                    DataSourceID="sqlDS_StockLibrary" DataTextField="PaperSize" 
                                                    DataValueField="StockID" SelectedValue='<%# Bind("PageStockID") %>'>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:DropDownList ID="ddlPageStockIDInsert" runat="server" style="font-size:9pt; width: 90%;"
                                                    DataSourceID="sqlDS_StockLibrary" DataTextField="PaperSize" 
                                                    DataValueField="StockID" SelectedValue='<%# Bind("PageStockID") %>'>
                                                </asp:DropDownList>
                                            </InsertItemTemplate>
                                        </asp:TemplateField>
--%>
                                        <asp:TemplateField HeaderText="列印紙張 :" SortExpression="PaperStockID">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="ddlPaperStockIDInsert" runat="server" style="font-size:9pt; width: 90%;"
                                                    DataSourceID="sqlDS_StockLibrary" DataTextField="PaperSelected" Enabled="false" 
                                                    DataValueField="StockID" SelectedValue='<%# Bind("PaperStockID") %>'>
                                                </asp:DropDownList>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:DropDownList ID="ddlPaperStockIDEdit" runat="server" style="font-size:9pt; width: 90%;"
                                                    DataSourceID="sqlDS_StockLibrary" DataTextField="PaperSelected" 
                                                    DataValueField="StockID" SelectedValue='<%# Bind("PaperStockID") %>'>
                                                </asp:DropDownList>
                                            </EditItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:DropDownList ID="ddlPaperStockIDInsert" runat="server" style="font-size:9pt; width: 90%;"
                                                    DataSourceID="sqlDS_StockLibrary" DataTextField="PaperSelected" 
                                                    DataValueField="StockID" SelectedValue='<%# Bind("PaperStockID") %>'>
                                                </asp:DropDownList>
                                            </InsertItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Creator" HeaderText="Creator"  SortExpression="Creator" Visible="False" />
                                        <asp:BoundField DataField="Modifier" HeaderText="Modifier" SortExpression="Modifier" Visible="False" />
                                        <asp:BoundField DataField="DateCreated" HeaderText="DateCreated" SortExpression="DateCreated" Visible="False" />
                                        <asp:BoundField DataField="DateLastUpdated" HeaderText="DateLastUpdated" SortExpression="DateLastUpdated" Visible="False" />
                                        <asp:TemplateField ShowHeader="False" ItemStyle-Wrap="False" ItemStyle-HorizontalAlign="Right" ItemStyle-Height="45px" ItemStyle-VerticalAlign="Middle">
                                            <ItemTemplate>
                                                <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="New" Text="新增" style="Height: 22px; width:50px; font-size:10pt; font-family: 微軟正黑體;"/>
                                            </ItemTemplate>
                                            <InsertItemTemplate>
                                                <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Insert" CommandArgument="Insert" Text="插入" style="width:70px; font-size:10pt; font-family: 微軟正黑體;"/>&nbsp;&nbsp;
                                                <asp:Button ID="Button2" runat="server" CausesValidation="False"  CommandName="Cancel" CommandArgument="Cancel" Text="取消" style="width:50px; font-size:10pt; font-family: 微軟正黑體;"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                            </InsertItemTemplate>
                                        </asp:TemplateField>
                                    </Fields>
                                </asp:DetailsView>
                           </td>
                        </tr>
                    </table>
            </asp:Panel>
        </td>
    </tr>
    </table>
    </ContentTemplate>
</asp:UpdatePanel>
<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="1">
    <ProgressTemplate>
        <div id="divMaskFrame" style="opacity:0.40; filter:alpha(opacity=40); background-color: #888888; left: 0px; top: 0px; position: fixed; width: 100%;height: 100%; z-index:9998"></Div>                               
        <div id="divProcess"   style ="opacity:0.85; filter:alpha(opacity=85); border:2px double #cccccc; background-color:#ffffff; position:absolute; text-align:center; vertical-align:middle; top: 50%; left: 50%; width: 150px;height: 150px; margin-left: -75px; margin-top: -75px; padding:3px;z-index:9999">                       
        <asp:Image ID="imgProgress" runat="server" ImageUrl="~/images/ajax-loader.gif" 
            style ="width: 85px;height: 85px; padding: 15px;" AlternateText="Loading ..." 
            GenerateEmptyAlternateText="True"/><br />
            <asp:Label ID="Label2" runat="server" Text="資料處理中, 請稍候." style=" font-size:11pt; font-family:微軟正黑體"></asp:Label>
<%--                    <div style="opacity:1; filter:alpha(opacity=100);">
            <input type="button" value="取消更新" style="font-family: Arial Unicode MS; font-size: 14px; font-weight: 500;" onclick="CancelAsyncPostBack();" />                                                      
        </div>--%>
        </div>
    </ProgressTemplate>
</asp:UpdateProgress> 

    <%--DeleteCommand="DELETE FROM [Compose_Master] WHERE [ComposeID] = @ComposeID" --%>
    <asp:SqlDataSource ID="sqlDS_ComposeMaster" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DATACNNSTR__SQLEXP_XIPS %>"       
        InsertCommand="INSERT INTO [Compose_Master] ([ComposeName], [ComposeDepiction], [Subsetoffset], [CustomerID], [Creator], [Modifier], [DateCreated], [DateLastUpdated]) VALUES (@ComposeName, @ComposeDepiction, @Subsetoffset, @CustomerID, @Creator, @Modifier, @DateCreated, @DateLastUpdated)" 
        SelectCommand="SELECT [ComposeID], [ComposeName], [ComposeDepiction], ISNULL([Subsetoffset], 0) [Subsetoffset], [CustomerID], [Creator], [Modifier], [DateCreated], [DateLastUpdated] FROM [Compose_Master] WITH(NOLOCK) WHERE [ComposeID] = @ComposeID" 
        UpdateCommand="UPDATE [Compose_Master] SET [ComposeName] = @ComposeName, [ComposeDepiction] = @ComposeDepiction, [Subsetoffset] = @Subsetoffset, [CustomerID] = @CustomerID, [Modifier] = @Modifier, [DateLastUpdated] = @DateLastUpdated WHERE [ComposeID] = @ComposeID"
        DeleteCommand="usp__DeleteComposeSet" 
        DeleteCommandType="StoredProcedure" >
        <DeleteParameters>
            <asp:Parameter Name="ComposeID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ComposeName" Type="String" />
            <asp:Parameter Name="ComposeDepiction" Type="String" />
            <asp:Parameter Name="Subsetoffset" Type="Int32" />
            <asp:Parameter Name="CustomerID" Type="String" />
            <asp:Parameter Name="Creator" Type="String" />
            <asp:Parameter Name="Modifier" Type="String" />
            <asp:Parameter Name="DateCreated" Type="DateTime" />
            <asp:Parameter Name="DateLastUpdated" Type="DateTime" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="hid_Request_ComposeID" Name="ComposeID" PropertyName="Value" Type="Int16" />
            <%--<asp:QueryStringParameter Name="ComposeID" QueryStringField="ComposeID" Type="Int32" />--%>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ComposeName" Type="String" />
            <asp:Parameter Name="ComposeDepiction" Type="String" />
            <asp:Parameter Name="Subsetoffset" Type="Int32" />
            <asp:Parameter Name="CustomerID" Type="String" />
            <asp:Parameter Name="Modifier" Type="String" />
            <asp:Parameter Name="DateLastUpdated" Type="DateTime" />
            <asp:Parameter Name="ComposeID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <%-- DeleteCommand="DELETE FROM [Compose_Detail] WHERE [DetailID] = @DetailID" --%>
    <%--InsertCommand="INSERT INTO [Compose_Detail] ([ComposeID], [ItemSequence], [ItemID], [PrintMethod], [PaperPerSet], [TrayID], [PageStockID], [PaperStockID], [Creator], [Modifier], [DateCreated], [DateLastUpdated]) VALUES (@ComposeID, @ItemSequence, @ItemID, @PrintMethod, @PaperPerSet, @TrayID, @PageStockID, @PaperStockID, @Creator, @Modifier, @DateCreated, @DateLastUpdated)" --%>
    <%--         
        <InsertParameters>
            <asp:Parameter Name="ComposeID" Type="Int16" />
            <asp:Parameter Name="ItemSequence" Type="Int16" />
            <asp:Parameter Name="ItemID" Type="Int16" />
            <asp:Parameter Name="PrintMethod" Type="Int16" />
            <asp:Parameter Name="PaperPerSet" Type="Int16" />
            <asp:Parameter Name="TrayID" Type="Int16" />
            <asp:Parameter Name="PageStockID" Type="Int16" />
            <asp:Parameter Name="PaperStockID" Type="Int16" />
            <asp:Parameter Name="Creator" Type="String" />
            <asp:Parameter Name="Modifier" Type="String" />
            <asp:Parameter Name="DateCreated" Type="DateTime" />
            <asp:Parameter Name="DateLastUpdated" Type="DateTime" />
        </InsertParameters>  --%>
    <%--SelectCommand="SELECT [DetailID], [ComposeID], [ItemSequence], [ItemID], [PrintMethod], ISNULL([PaperPerSet], 0), [TrayID], ISNULL([OffsetX], 0.00) [OffsetX], ISNULL([OffsetY], 0.00) [OffsetY], [PaperStockID], [Creator], [Modifier], [DateCreated], [DateLastUpdated] FROM [Compose_Detail] WITH(NOLOCK) WHERE ([ComposeID] = @ComposeID) ORDER BY [ItemSequence]" --%>        
    <%-- UpdateCommand="UPDATE [Compose_Detail] SET [ItemSequence] = @ItemSequence, [ItemID] = @ItemID, [PrintMethod] = @PrintMethod, [PaperPerSet] = @PaperPerSet, [TrayID] = @TrayID, [OffsetX] = @OffsetX, [OffsetY] = @OffsetY, [PaperStockID] = @PaperStockID, [Modifier] = @Modifier, [DateLastUpdated] = @DateLastUpdated WHERE [DetailID] = @DetailID"
         <UpdateParameters>
            <asp:Parameter Name="ItemSequence" Type="Int16" />
            <asp:Parameter Name="ItemID" Type="Int16" />
            <asp:Parameter Name="PrintMethod" Type="Int16" />
            <asp:Parameter Name="PaperPerSet" Type="Int16" />
            <asp:Parameter Name="TrayID" Type="Int16" />
            <asp:Parameter Name="OffsetX" Type="Decimal" />
            <asp:Parameter Name="OffsetY" Type="Decimal" />
            <asp:Parameter Name="PaperStockID" Type="Int16" />
            <asp:Parameter Name="Modifier" Type="String" />
            <asp:Parameter Name="DateLastUpdated" Type="DateTime" />
            <asp:Parameter Name="DetailID" Type="Int32" />
        </UpdateParameters>   
    --%> 
       
    <asp:SqlDataSource ID="sqlDS_ComposeDetail" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DATACNNSTR__SQLEXP_XIPS %>"       
        UpdateCommand="usp__UpdateComposeDetail"
        SelectCommand="usp__GetComposeDetail"
        InsertCommand="usp__InsertComposeDetail"
        DeleteCommand="usp__DeleteComposeDetail"
        SelectCommandType="StoredProcedure"
        DeleteCommandType="StoredProcedure"
        UpdateCommandType="StoredProcedure"
        InsertCommandType="StoredProcedure" >
        <DeleteParameters>
            <asp:Parameter Name="DetailID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ComposeID" Type="Int16" />
            <asp:Parameter Name="ItemSequence" Type="Int16" />
            <asp:Parameter Name="ItemID" Type="Int16" />
            <asp:Parameter Name="PrintMethod" Type="Int16" />
            <asp:Parameter Name="PaperPerSet" Type="Int16" />
            <asp:Parameter Name="TrayID" Type="Int16" />
            <asp:Parameter Name="OffsetX" Type="Decimal" />
            <asp:Parameter Name="OffsetY" Type="Decimal" />
            <asp:Parameter Name="PaperStockID" Type="Int16" />
            <asp:Parameter Name="UserID" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="hid_Request_ComposeID" Name="ComposeID" PropertyName="Value" Type="Int16" />
            <%--<asp:QueryStringParameter Name="ComposeID" QueryStringField="ComposeID" Type="Int16" />--%>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="DetailID" Type="Int32" />            
            <asp:Parameter Name="ItemSequence" Type="Int16" />
            <asp:Parameter Name="ItemID" Type="Int16" />
            <asp:Parameter Name="PrintMethod" Type="Int16" />
            <asp:Parameter Name="PaperPerSet" Type="Int16" />
            <asp:Parameter Name="TrayID" Type="Int16" />
            <asp:Parameter Name="OffsetX" Type="Decimal" />
            <asp:Parameter Name="OffsetY" Type="Decimal" />
            <asp:Parameter Name="PaperStockID" Type="Int16" />
            <asp:Parameter Name="UserID" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDS_CustomerInformation" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DATACNNSTR__SQLEXP_XIPS %>"       
        SelectCommand="SELECT DISTINCT [CustomerID], [CustomerName] FROM [Customer_Information] WITH(NOLOCK) ORDER BY [CustomerName]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDS_ItemList" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DATACNNSTR__SQLEXP_XIPS %>"       
        SelectCommand="SELECT DISTINCT [ItemID], [ItemName] FROM [Item_List] WITH(NOLOCK) ORDER BY [ItemID]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDS_TrayList" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DATACNNSTR__SQLEXP_XIPS %>"       
        SelectCommand="SELECT DISTINCT [TrayID], [TrayName] FROM [Tray_List] WITH(NOLOCK) ORDER BY [TrayID]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDS_StockLibrary" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DATACNNSTR__SQLEXP_XIPS %>"       
        SelectCommand="SELECT [StockID], [StockName], CAST(StockWidth AS VARCHAR(5)) + 'x' + CAST(StockHeight AS VARCHAR(5)) + 'mm' AS [PaperSize],  CAST(StockWidth AS VARCHAR(5)) + 'x' + CAST(StockHeight AS VARCHAR(5)) + 'mm,' + CAST(StockWeight AS VARCHAR(5)) + 'gsm,' + CASE WHEN StockCoated = 1 THEN '塗布' ELSE '非塗布' END AS [PaperSelected] FROM [Stock_Library] WITH(NOLOCK) ORDER BY [PaperSize]"></asp:SqlDataSource>
    <asp:XmlDataSource ID="xmlDS_PrintMethod" runat="server" 
        DataFile="~/App_Data/PrintMethod.xml" 
        TransformFile="~/App_Data/PrintMethod.xsl"></asp:XmlDataSource>
    <asp:XmlDataSource ID="xmlDS_Sequence" runat="server" 
        DataFile="~/App_Data/EnumItemSequence.xml" 
        TransformFile="~/App_Data/EnumItemSequence.xsl"></asp:XmlDataSource>
 
 <%-- <script  language="javascript" type="text/javascript">
     $(function () {
         $("#divNewDetail").dialog({
             resizable: false,
             modal: true,
             buttons: {
                 Close: function () {
                     $(this).dialog("close");
                 }
             }
         });

         $("#create-ComposeDetail")
            .click(function () {
                $("#divNewDetail").dialog("open");
                }
            );
     });
</script>--%>

</asp:Content>

