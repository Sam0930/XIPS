<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="custDetail.aspx.cs" Inherits="XIPS._Customer._custDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterContent" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" >
    <ContentTemplate>
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
                                    style="font-family: 'Arial Unicode MS'; font-size: 10pt;" 
                                    UseSubmitBehavior="False" onclick="btnBackToMain_Click" />                                                            
                            </asp:Panel>                        
                        </td>
                    </tr>
                  </table>
            </td>
        </tr>
        <tr>
            <td style="padding-top: 5px; padding-left: 5px; padding-right:20px">
                <asp:FormView ID="FormView1" runat="server" BackColor="#CCCCCC" 
                    BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" 
                    ForeColor="Black" GridLines="Both" Font-Size="10pt" Width="880px"                     
                    CellSpacing="2" 
                    DataKeyNames="CustomerID" 
                    DataSourceID="sqlDS_Customer" 
                    AllowPaging="True" 
                    onitemcommand="FormView1_ItemCommand" 
                    onitemdeleting="FormView1_ItemDeleting" 
                    oniteminserting="FormView1_ItemInserting" 
                    onitemupdating="FormView1_ItemUpdating" 
                    onmodechanging="FormView1_ModeChanging" HeaderText="FormView - HeaderText" 
                    oniteminserted="FormView1_ItemInserted" 
                    onitemupdated="FormView1_ItemUpdated" 
                    onitemdeleted="FormView1_ItemDeleted" Font-Names="arial">
                    <EditItemTemplate>
                        <table style="width: 100%; border:0px solid #cccccc; padding:5px;" cellpadding="4">
                            <tr>
                                <td style="width:70px; white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; padding-right:15px">統一編號 :</td>
                                <td style=" white-space:nowrap;">
                                    <asp:Label ID="CustomerIDLabelEdit" runat="server" Text='<%# Eval("CustomerID") %>' Font-Bold="false" Font-Size="10pt" />
								</td>
                            </tr>
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; ">客戶名稱 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:TextBox ID="CustomerNameTextBoxEdit" runat="server" Text='<%# Bind("CustomerName") %>' MaxLength="50" Width="550px" Font-Size="10pt" />                                                       
                                </td>
                            </tr>
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px;vertical-align:top; ">客戶描述 :</td>
                                <td>
                                    <asp:TextBox ID="CustomerDepictionTextBoxEdit" runat="server" 
                                        Text='<%# Bind("CustomerDepiction") %>' MaxLength="100" Width="750px" 
                                        Height="40px" Font-Size="10pt" style="vertical-align:top; white-space:normal" 
                                        TextMode="MultiLine" Font-Names="微軟正黑體,標楷體,Arial Unicode MS" />                                                        
                                </td>
                            </tr>
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; vertical-align:top; ">客戶地址 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:TextBox ID="CustomerAddressTextBoxEdit" runat="server" 
                                        Text='<%# Bind("CustomerAddress") %>' MaxLength="255" Width="750px" 
                                        Height="40px" Font-Size="10pt" style="vertical-align:top; white-space:normal" 
                                        TextMode="MultiLine" Font-Names="微軟正黑體,標楷體,Arial Unicode MS" />                                                                
                                </td>
                            </tr>                        
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; ">客戶電話 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:TextBox ID="CustomerTelephoneTextBoxEdit" runat="server" Text='<%# Bind("CustomerTelephone") %>' MaxLength="20" Width="300px" Font-Size="10pt" />
                                    <ajaxToolkit:FilteredTextBoxExtender 
                                        ID="FilteredTextBoxExtender3" 
                                        runat="server" 
                                        FilterMode="ValidChars" 
                                        FilterType="Numbers, Custom" 
                                        ValidChars="+-=_&#*()|,.;:"
                                        TargetControlID="CustomerTelephoneTextBoxEdit" />                                                                                                
                                </td>
                            </tr>                          
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; ">客戶傳真 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:TextBox ID="CustomerFacsimileTextBoxEdit" runat="server" Text='<%# Bind("CustomerFacsimile") %>' MaxLength="20" Width="300px" Font-Size="10pt" />
                                     <ajaxToolkit:FilteredTextBoxExtender 
                                        ID="FilteredTextBoxExtender4" 
                                        runat="server" 
                                        FilterMode="ValidChars" 
                                        FilterType="Numbers, Custom" 
                                        ValidChars="+-=_&#*()|,.;:"
                                        TargetControlID="CustomerFacsimileTextBoxEdit" />                                                                                       
                                </td>
                            </tr>             
                            <tr>
                                <td colspan="2" style="border:1px solid #cccccc; padding:2px ">
                                    <table style="width:100%">
                                        <tr>
                                            <td  style="padding-top:15px; padding-bottom: 10px; padding-right: 25px; text-align:right;  border:3px solid #ffffff; background-color:#cccccc">
                                                 <asp:Button ID="btnUpdate" runat="server"  CommandName="Update" Text="確定" CommandArgument="Update" style="font-family: 'Arial Unicode MS'; font-size: 10pt; width: 100px" /> &nbsp;&nbsp;&nbsp;
                                                <asp:Button ID="btnCancelUpdate" runat="server"  CommandName="Cancel" CommandArgument="CancelUpdate" Text="取消" style="font-family: 'Arial Unicode MS'; font-size: 10pt; width: 80px"  />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>                           
                        </table>
                       <%-- <asp:HiddenField  ID="hidCreator" runat="server" Value='<%# Bind("Creator") %>' />--%>   
                        <asp:HiddenField  ID="hidModifier" runat="server" Value='<%# Bind("Modifier") %>' /> 
                       <%-- <asp:HiddenField  ID="hidDateCreated" runat="server" Value='<%# Bind("DateCreated") %>' />  --%>                                   
                        <asp:HiddenField  ID="hidDateLastUpdated" runat="server" Value='<%# Bind("DateLastUpdated") %>' />                                   
                   </EditItemTemplate>
                    <InsertItemTemplate>
                        <table style="width: 100%; border:0px solid #cccccc; padding:5px;" cellpadding="4">
                            <tr>
                                <td style="width:70px; white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; padding-right:15px">統一編號 :</td>
                                <td style=" white-space:nowrap;">
                                    <asp:TextBox ID="CustomerIDTextBoxInsert" runat="server" Text='<%# Bind("CustomerID") %>' MaxLength="8" Width="100px" Font-Size="10pt" />
                                    <ajaxToolkit:FilteredTextBoxExtender 
                                        ID="FilteredTextBoxExtender1" 
                                        runat="server" 
                                        FilterMode="ValidChars" 
                                        FilterType="Numbers" 
                                        TargetControlID="CustomerIDTextBoxInsert" />                                                         
                                </td>
                            </tr>
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; ">客戶名稱 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:TextBox ID="CustomerNameTextBoxInsert" runat="server" Text='<%# Bind("CustomerName") %>' MaxLength="50" Width="500px" Font-Size="10pt" />                                                       
                                </td>
                            </tr>
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; vertical-align:top; ">客戶描述 :</td>
                                <td>
                                    <asp:TextBox ID="CustomerDepictionTextBoxInsert" runat="server" 
                                        Text='<%# Bind("CustomerDepiction") %>' MaxLength="100" Width="750px" 
                                        Height="40px" Font-Size="10pt" style="vertical-align:top; white-space:normal" 
                                        TextMode="MultiLine" Font-Names="微軟正黑體,標楷體,Arial Unicode MS" />                                                         
                                </td>
                            </tr>
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; vertical-align:top; ">客戶地址 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:TextBox ID="CustomerAddressTextBoxInsert" runat="server" 
                                        Text='<%# Bind("CustomerAddress") %>' MaxLength="255" Width="750px" 
                                        Height="40px" Font-Size="10pt" style="vertical-align:top; white-space:normal" 
                                        TextMode="MultiLine" Font-Names="微軟正黑體,標楷體,Arial Unicode MS" />                                                              
                                </td>
                            </tr>                        
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; ">客戶電話 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:TextBox ID="CustomerTelephoneTextBoxInsert" runat="server" Text='<%# Bind("CustomerTelephone") %>' MaxLength="20" Width="300px" Font-Size="10pt" />
                                    <ajaxToolkit:FilteredTextBoxExtender 
                                        ID="FilteredTextBoxExtender3" 
                                        runat="server" 
                                        FilterMode="ValidChars" 
                                        FilterType="Numbers, Custom" 
                                        ValidChars="+-=_&#*()|,.;:"
                                        TargetControlID="CustomerTelephoneTextBoxInsert" />                                                                                                       
                                </td>
                            </tr>                          
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; ">客戶傳真 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:TextBox ID="CustomerFacsimileTextBoxInsert" runat="server" Text='<%# Bind("CustomerFacsimile") %>' MaxLength="20" Width="300px" Font-Size="10pt" />
                                    <ajaxToolkit:FilteredTextBoxExtender 
                                        ID="FilteredTextBoxExtender2" 
                                        runat="server" 
                                        FilterMode="ValidChars" 
                                        FilterType="Numbers, Custom" 
                                        ValidChars="+-=_&#*()|,.;:"
                                        TargetControlID="CustomerFacsimileTextBoxInsert" />                                                                                     
                                </td>
                            </tr>  
                            <tr>
                                <td colspan="2" style="border:1px solid #cccccc; padding:2px ">
                                    <table style="width:100%">
                                        <tr>
                                            <td  style="padding-top:15px; padding-bottom: 10px; padding-right: 25px; text-align:right;  border:3px solid #ffffff; background-color:#cccccc">
                                                <asp:Button ID="btnInsert" runat="server"  CommandName="Insert" Text="確定" CommandArgument="Insert" style="font-family: 'Arial Unicode MS'; font-size: 10pt; width: 100px" /> &nbsp;&nbsp;&nbsp;
                                                <asp:Button ID="btnCancelInsert" runat="server"  CommandName="Cancel" Text="取消" CommandArgument="CancelInsert" style="font-family: 'Arial Unicode MS'; font-size: 10pt; width: 80px"  />
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
                        <table style="width: 100%; border:0px solid #cccccc; padding:5px;" cellpadding="4">
                            <tr>
                                <td style="width:70px; white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; padding-right:15px">統一編號 :</td>
                                <td style=" white-space:nowrap;">
                                    <asp:Label ID="CustomerIDLabel" runat="server" Text='<%# Eval("CustomerID") %>' />                                                               
                                </td>
                            </tr>
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; ">客戶名稱 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:Label ID="CustomerNameLabel" runat="server" Text='<%# Bind("CustomerName") %>' />                                                   
                                </td>
                            </tr>
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; vertical-align:top">客戶描述 :</td>
                                <td>
                                    <asp:TextBox ID="txtCustomerDepiction" runat="server" 
                                        Text='<%# Bind("CustomerDepiction") %>' Width="750px" Height="40px" 
                                        ReadOnly="true" 
                                        style="border-style:none; white-space:normal; vertical-align:top; font-size:10pt" 
                                        TextMode="MultiLine" Font-Names="微軟正黑體,標楷體,Arial Unicode MS" />
                                    <%--<asp:Label ID="CustomerDepictionLabel" runat="server" Text='<%# Bind("CustomerDepiction") %>' style="border-style:none; white-space:normal; vertical-align:top; width:750px; height:40px;" />                                    --%>            
                                </td>
                            </tr>
                             <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; vertical-align:top ">客戶地址 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:TextBox ID="txtCustomerAddress" runat="server" 
                                        Text='<%# Bind("CustomerAddress") %>' Width="750px" Height="40px" 
                                        ReadOnly="true" 
                                        style="border-style:none; white-space:normal; vertical-align:top; font-size:10pt" 
                                        TextMode="MultiLine" Font-Names="微軟正黑體,標楷體,Arial Unicode MS" />
<%--                                    <asp:Label ID="CustomerAddressLabel" runat="server" Text='<%# Bind("CustomerAddress") %>' style="border-style:none; white-space:normal; vertical-align:top; width:750px; height:40px;" />                                                                
--%>                                </td>
                            </tr>                        
                           <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; ">客戶電話 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:Label ID="CustomerTelephoneLabel" runat="server" Text='<%# Bind("CustomerTelephone") %>' />                                                             
                                </td>
                            </tr>                          
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; ">客戶傳真 :</td>
                                <td style=" white-space:nowrap">
                                     <asp:Label ID="CustomerFacsimileLabel" runat="server" Text='<%# Bind("CustomerFacsimile") %>' />                                                 
                                </td>
                            </tr>  
                            <tr>
                                <td colspan="2" style="border:1px solid #cccccc; padding:2px ">
                                    <table style="width:100%">
                                        <tr>
                                            <td  style="padding-top:15px; padding-bottom: 10px; padding-right: 25px; text-align:right;  border:3px solid #ffffff; background-color:#cccccc">
                                                <asp:Button ID="btnAdd" runat="server"  CommandName="New" Text="新增" CommandArgument="New" style="font-family: 'Arial Unicode MS'; font-size: 10pt; width: 100px" /> &nbsp;
                                                <asp:Button ID="btnEdit" runat="server"  CommandName="Edit" Text="編輯" CommandArgument="Edit" style="font-family: 'Arial Unicode MS'; font-size: 10pt; width: 100px"  />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <asp:Button ID="btnDelete" runat="server" CommandName="Delete" Text="刪除" CommandArgument="Delete" style="font-family: 'Arial Unicode MS'; font-size: 10pt; width: 80px" OnClientClick="javascript: return confirm('請確定是否要刪除此筆資料?');" />                                                                                              
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
             </td>
            </tr>      
        </table>
        <asp:Panel ID="pnlErrorMsg" runat="server" style="padding: 5px">
            <asp:Image ID="imgError" runat="server" ImageUrl="~/images/error.gif" style="vertical-align:bottom; padding-left:2px; padding-right:5px;"/>
            <asp:Label ID="lblError" runat="server" Font-Bold="True" Font-Size="11pt" ForeColor="#FF3300" style="width:800px; white-space:normal">[Error Message]</asp:Label>
        </asp:Panel> 
    </ContentTemplate>
</asp:UpdatePanel>

<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="1">
    <ProgressTemplate>
            <div id="divMaskFrame" style="opacity:0.40; filter:alpha(opacity=40); background-color: #888888; left: 0px; top: 0px; position: fixed; width: 100%;height: 100%; z-index:9998"></Div>
<%--                                
                <div id="divProcess"   style ="opacity:0.85; filter:alpha(opacity=85); border:2px double #cccccc; background-color:#ffffff; position:absolute; text-align:center; vertical-align:middle; top: 50%; left: 50%; width: 150px;height: 150px; margin-left: 0px; margin-top: 0px; padding:3px;z-index:9999">                       
                <asp:Image ID="imgProgress" runat="server" ImageUrl="~/images/ajax-loader.gif" 
                    style ="width: 85px;height: 85px; padding: 15px;" AlternateText="Loading ..." 
                    GenerateEmptyAlternateText="True"/>
                <div style="opacity:1; filter:alpha(opacity=100);">
                    <input type="button" value="取消更新" style="font-family: Arial Unicode MS; font-size: 14px; font-weight: 500;" onclick="CancelAsyncPostBack();" />                                                      
                </div>
                </div>
--%>
    </ProgressTemplate>
</asp:UpdateProgress> 


    <asp:SqlDataSource ID="sqlDS_Customer" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DATACNNSTR__SQLEXP_XIPS %>" 
        DeleteCommand="DELETE FROM [Customer_Information] WHERE [CustomerID] = @CustomerID" 
        InsertCommand="INSERT INTO [Customer_Information] ([CustomerID], [CustomerName], [CustomerDepiction], [CustomerAddress], [CustomerTelephone], [CustomerFacsimile], [Creator], [Modifier], [DateCreated], [DateLastUpdated]) VALUES (@CustomerID, @CustomerName, @CustomerDepiction, @CustomerAddress, @CustomerTelephone, @CustomerFacsimile, @Creator, @Modifier, @DateCreated, @DateLastUpdated)" 
        SelectCommand="SELECT [CustomerID], [CustomerName], [CustomerDepiction], [CustomerAddress], [CustomerTelephone], [CustomerFacsimile], [Creator], [Modifier], [DateCreated], [DateLastUpdated] FROM [Customer_Information] WITH(NOLOCK) WHERE ([CustomerID] = @CustomerID)"        
        UpdateCommand="UPDATE [Customer_Information] SET [CustomerName] = @CustomerName, [CustomerDepiction] = @CustomerDepiction, [CustomerAddress] = @CustomerAddress, [CustomerTelephone] = @CustomerTelephone, [CustomerFacsimile] = @CustomerFacsimile, [Modifier] = @Modifier, [DateLastUpdated] = @DateLastUpdated WHERE [CustomerID] = @CustomerID">
          <DeleteParameters>
              <asp:Parameter Name="CustomerID" Type="String" />
          </DeleteParameters>
          <InsertParameters>
              <asp:Parameter Name="CustomerID" Type="String" />
              <asp:Parameter Name="CustomerName" Type="String" />
              <asp:Parameter Name="CustomerDepiction" Type="String" />
              <asp:Parameter Name="CustomerAddress" Type="String" />
              <asp:Parameter Name="CustomerTelephone" Type="String" />
              <asp:Parameter Name="CustomerFacsimile" Type="String" />
              <asp:Parameter Name="Creator" Type="String" />
              <asp:Parameter Name="Modifier" Type="String" />
              <asp:Parameter Name="DateCreated" Type="DateTime" />
              <asp:Parameter Name="DateLastUpdated" Type="DateTime" />
          </InsertParameters>
          <SelectParameters>
            <asp:QueryStringParameter Name="CustomerID" QueryStringField="CustomerID"   Type="String" />
          </SelectParameters>      
          <UpdateParameters>
              <asp:Parameter Name="CustomerName" Type="String" />
              <asp:Parameter Name="CustomerDepiction" Type="String" />
              <asp:Parameter Name="CustomerAddress" Type="String" />
              <asp:Parameter Name="CustomerTelephone" Type="String" />
              <asp:Parameter Name="CustomerFacsimile" Type="String" />
              <asp:Parameter Name="Modifier" Type="String" />
              <asp:Parameter Name="DateLastUpdated" Type="DateTime" />
              <asp:Parameter Name="CustomerID" Type="String" />
          </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>

