<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="userDetail.aspx.cs" Inherits="XIPS._User._userDetail" %>

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
                <asp:FormView ID="FormView1" runat="server" 
                    BackColor="#CCCCCC" 
                    BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" 
                    ForeColor="Black" GridLines="Both" Font-Size="10pt" Width="880px"                     
                    CellSpacing="2" 
                    DataKeyNames="UserID" 
                    DataSourceID="sqlDS_UserInformation" 
                    AllowPaging="True" 
                    onitemcommand="FormView1_ItemCommand" 
                    onitemdeleting="FormView1_ItemDeleting" 
                    oniteminserting="FormView1_ItemInserting" 
                    onitemupdating="FormView1_ItemUpdating" 
                    onmodechanging="FormView1_ModeChanging" 
                    HeaderText="FormView - HeaderText" 
                    oniteminserted="FormView1_ItemInserted" 
                    onitemupdated="FormView1_ItemUpdated" 
                    onitemdeleted="FormView1_ItemDeleted" 
                    Font-Names="arial">
                    <EditItemTemplate>
                        <table style="width: 100%; border:0px solid #cccccc; padding:5px;" cellpadding="4">
                            <tr>
                                <td style="width:70px; white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; padding-right:15px">使用者代碼 :</td>
                                <td style=" white-space:nowrap">
									<asp:Label ID="lblUserNameEdit" runat="server" Text='<%# Bind("UserName") %>' />							
                                </td>
                            </tr>
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; vertical-align:top">使用者名稱 :</td>
                                <td>
									<asp:TextBox ID="txtUserNameEdit" runat="server"  Text='<%# Bind("UserName") %>'  MaxLength="50" Width="400px" Font-Size="10pt" />
                                    </td>
                            </tr>
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; vertical-align:top ">使用者描述 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:TextBox ID="txtUserDepictionEdit" runat="server" 
                                        Text='<%# Bind("UserDepiction") %>' Width="750px" Height="35px"
                                        style=" font-size:10pt"  TextMode="MultiLine" Font-Names="微軟正黑體,標楷體,Arial Unicode MS" MaxLength="100"></asp:TextBox>						
                                    </td>
                            </tr>                        
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; ">使用者密碼 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:TextBox ID="txtUserPasswordEdit" runat="server" Text='<%# Bind("UserPassword") %>'
                                        Width="180px" style="font-size:10pt; font-family:'微軟正黑體, Times New Roman';" MaxLength="20" TextMode="SingleLine"></asp:TextBox>
                                   </td>
                            </tr>         
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; ">確認密碼 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:TextBox ID="txtConfirmPasswordEdit" runat="server" Text='<%# Eval("UserPassword") %>'
                                    Width="180px"  style=" font-size:10pt; font-family:'微軟正黑體, Times New Roman';" MaxLength="20" TextMode="SingleLine"></asp:TextBox>
                                    </td>
                            </tr> 							
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px;" >使用者群組 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:DropDownList ID="dplGroupIDEdit" runat="server" 
                                        DataSourceID="sqlDS_GroupInformation" DataTextField="GroupName" style="font-size:10pt;font-family:'微軟正黑體, Times New Roman';"
                                        DataValueField="GroupID"  SelectedValue='<%# Bind("GroupID") %>'>
                                    </asp:DropDownList>
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
                        <asp:HiddenField  ID="HiddenField1" runat="server" Value='<%# Bind("Modifier") %>' />                                  
                        <asp:HiddenField  ID="HiddenField2" runat="server" Value='<%# Bind("DateLastUpdated") %>' />  
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <table style="width: 100%; border:0px solid #cccccc; padding:5px;" cellpadding="4">
                            <tr>
                                <td style="width:70px; white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; padding-right:15px">使用者代碼 :</td>
                                <td style=" white-space:nowrap">
									<asp:TextBox ID="txtUserIDInsert" runat="server" Text='<%# Bind("UserID") %>' MaxLength="20" Width="180px" Font-Size="10pt" />
                                    &nbsp;<ajaxToolkit:FilteredTextBoxExtender 
                                        ID="FilteredTextBoxExtender1" 
                                        runat="server" 
                                        FilterMode="ValidChars" 
                                        FilterType="UppercaseLetters, LowercaseLetters, Numbers, Custom" 
                                        ValidChars="+-=_#*()."
                                        TargetControlID="txtUserIDInsert" />									
                                </td>
                            </tr>
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; vertical-align:top">使用者名稱 :</td>
                                <td>
									<asp:TextBox ID="txtUserNameInsert" runat="server"  Text='<%# Bind("UserName") %>'  MaxLength="50" Width="400px" Font-Size="10pt" />
                                </td>
                            </tr>
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; vertical-align:top ">使用者描述 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:TextBox ID="txtUserDepictionInsert" runat="server" 
                                        Text='<%# Bind("UserDepiction") %>' Width="750px" Height="35px"
                                        style=" font-size:10pt"  TextMode="MultiLine" Font-Names="微軟正黑體,標楷體,Arial Unicode MS" MaxLength="100"></asp:TextBox>						
                                    </td>
                            </tr>                        
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; ">使用者密碼 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:TextBox ID="txtUserPasswordInsert" runat="server" Text='<%# Bind("UserPassword") %>' Width="180px"
                                    style="font-size:10pt; font-family:'微軟正黑體, Times New Roman';" TextMode="SingleLine" MaxLength="20" ></asp:TextBox>
                                </td>
                            </tr>         
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; ">確認密碼 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:TextBox ID="txtConfirmPasswordInsert" runat="server" Text='' Width="180px"
                                    style=" font-size:10pt; font-family:'微軟正黑體, Times New Roman';" TextMode="SingleLine" MaxLength="20"></asp:TextBox>
                                   </td>
                            </tr> 							
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px;" >使用者群組 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:DropDownList ID="dplGroupIDInsert" runat="server" 
                                        DataSourceID="sqlDS_GroupInformation" DataTextField="GroupName" style="font-size:10pt;font-family:'微軟正黑體, Times New Roman';"
                                        DataValueField="GroupID"  SelectedValue='<%# Bind("GroupID") %>'>
                                    </asp:DropDownList>
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
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; ">使用者代碼 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:Label ID="UserIDLabel" runat="server" Text='<%# Eval("UserID") %>' />                                                   
                                </td>
                            </tr>
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; vertical-align:top">使用者名稱 :</td>
                                <td>
									<asp:Label ID="UserNameLabel" runat="server" Text='<%# Bind("UserName") %>' />	
                                </td>
                            </tr>
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; vertical-align:top ">使用者描述 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:TextBox ID="txtUserDepiction" runat="server" 
                                        Text='<%# Bind("UserDepiction") %>' Width="750px" Height="35px" ReadOnly="true" 
                                        style="border-style:none; white-space:normal; vertical-align:top; font-size:10pt" 
                                        TextMode="MultiLine" Font-Names="微軟正黑體,標楷體,Arial Unicode MS" ></asp:TextBox>						
                                    </td>
                            </tr>                        
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px; ">使用者密碼 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:TextBox ID="txtUserPassword" runat="server" Text='***************' Width="120px" ReadOnly="True" 
                                    style="border-style:none; white-space:normal; vertical-align:top; font-size:12pt; font-weight:800; font-family:'微軟正黑體, Times New Roman';"></asp:TextBox>                                                           
                                </td>
                            </tr>                          
                            <tr>
                                <td style="white-space:nowrap; border:1px solid #cccccc;  text-align:left; padding-left:15px;" >使用者群組 :</td>
                                <td style=" white-space:nowrap">
                                    <asp:DropDownList ID="dplGroupID" runat="server" 
                                        DataSourceID="sqlDS_GroupInformation" DataTextField="GroupName" style="font-size:10pt;font-family:'微軟正黑體, Times New Roman'; background-color:transparent; border-style:none;"
                                        DataValueField="GroupID" Enabled="False" SelectedValue='<%# Bind("GroupID") %>'>
                                    </asp:DropDownList>
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
    </ProgressTemplate>
</asp:UpdateProgress> 

    <asp:SqlDataSource ID="sqlDS_UserInformation" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DATACNNSTR__SQLEXP_XIPS %>" 
        DeleteCommand="DELETE FROM [User_Information] WHERE [UserID] = @UserID" 
        InsertCommand="INSERT INTO [User_Information] ([UserID], [UserName], [UserPassword], [UserDepiction], [GroupID], [Creator], [Modifier], [DateCreated], [DateLastUpdated]) VALUES (@UserID, @UserName, @UserPassword, @UserDepiction, @GroupID, @Creator, @Modifier, @DateCreated, @DateLastUpdated)" 
        SelectCommand="SELECT [UserName], [UserID], [UserPassword], [UserDepiction], [GroupID], [Creator], [Modifier], [DateCreated], [DateLastUpdated] FROM [User_Information]  WITH(NOLOCK) WHERE ([UserID] = @UserID) ORDER BY [UserID]" 
        UpdateCommand="UPDATE [User_Information] SET [UserName] = @UserName, [UserPassword] = @UserPassword, [UserDepiction] = @UserDepiction, [GroupID] = @GroupID, [Modifier] = @Modifier, [DateLastUpdated] = @DateLastUpdated WHERE [UserID] = @UserID">
        <DeleteParameters>
            <asp:Parameter Name="UserID" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="UserID" Type="String" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="UserDepiction" Type="String" />
            <asp:Parameter Name="UserPassword" Type="String" />
            <asp:Parameter Name="GroupID" Type="String" />
            <asp:Parameter Name="Creator" Type="String" />
            <asp:Parameter Name="Modifier" Type="String" />
            <asp:Parameter Name="DateCreated" Type="DateTime" />
            <asp:Parameter Name="DateLastUpdated" Type="DateTime" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="UserID" QueryStringField="UserID" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="UserDepiction" Type="String" />
            <asp:Parameter Name="UserPassword" Type="String" />
            <asp:Parameter Name="GroupID" Type="String" />
            <asp:Parameter Name="Modifier" Type="String" />
            <asp:Parameter Name="DateLastUpdated" Type="DateTime" />
            <asp:Parameter Name="UserID" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDS_GroupInformation" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DATACNNSTR__SQLEXP_XIPS %>" 
        SelectCommand="SELECT DISTINCT [GroupID], [GroupName] FROM [Group_Information]  WITH(NOLOCK)"></asp:SqlDataSource>
</asp:Content>

