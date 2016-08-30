<%@ Page Title="" Language="C#" MasterPageFile="~/DefaultMaster.master" AutoEventWireup="true" CodeFile="GroupPermission.aspx.cs" Inherits="XIPS._Group._GroupPermission" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterContent" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
    <ContentTemplate>            
    <table style="width: 100%;" border="0">
        <tr>
            <td style="border:1px solid #808080;  font-size: 11pt; background-color:#cccccc">
               <table style="width: 100%; font-family:'Arial Unicode MS'; font-size: 11pt;border:1px solid silver; background-color:#cccccc">             
                    <tr>                  
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="使用者群組名稱 : "></asp:Label>
                            <asp:DropDownList ID="ddlGroupInformation" runat="server" AutoPostBack="True" 
                                 DataSourceID="sqlDS_GroupInformation" DataTextField="GroupName" style="width: 350px" 
                                 DataValueField="GroupID">
                            </asp:DropDownList>                       
                        </td>
                        <td style="white-space:nowrap; padding-right:15px; vertical-align:middle; text-align: right">
                            <asp:Panel ID="pnlButton" runat="server" >  
                                <asp:Button ID="btnRefresh" runat="server" Text=" 重新整理"  style="font-family: 'Arial Unicode MS'; font-size: 10pt;" onclick="btnRefresh_Click"  />
                            </asp:Panel>                        
                        </td>
                    </tr>
                  </table>
            </td>
        </tr>
        <tr>
            <td style="padding-top: 5px; padding-left: 5px; padding-right:20px">                  
                    <asp:Panel ID="pnlResult" runat="server" >    
                        <asp:Panel ID="pnlOperation" runat="server" style="padding: 5px">
                            <asp:Image ID="imgOperation" runat="server" ImageUrl="~/images/HandleHand.png" style="vertical-align:bottom; padding-left:2px; padding-right:5px;"/>
                            <asp:Label ID="lblOperation" runat="server" Font-Bold="True" Font-Size="10pt" ForeColor="#000000" >[Message]</asp:Label>
                        </asp:Panel>                      
                        <asp:Panel ID="pnlErrorMsg" runat="server" style="padding: 5px">
                            <asp:Image ID="imgError" runat="server" ImageUrl="~/images/error.gif" style="vertical-align:bottom; padding-left:2px; padding-right:5px;"/>
                            <asp:Label ID="lblError" runat="server" Font-Bold="True" Font-Size="10pt" ForeColor="#FF3300"  style="width:800px; white-space:normal">[Error Message]</asp:Label>
                        </asp:Panel> 
                      <asp:GridView 
                            ID="GridView1" 
                            runat="server" 
                            CellPadding="4" 
                            Font-Size="10pt" 
                            AllowSorting="True"
                            ForeColor="#333333" 
                            GridLines="None" 
                            BorderColor="#D1D1D1" 
                            BorderStyle="Solid" 
                            BorderWidth="2px" 
                            AutoGenerateColumns="False" 
                            DataSourceID="sqlDS_GroupPermission" 
                            onrowcommand="GridView1_RowCommand" 
                            PageSize="1" 
                            EnableSortingAndPagingCallbacks="True" 
                            onrowdatabound="GridView1_RowDataBound" style="margin-top: 0px" >
                            <Columns>
                                <asp:BoundField DataField="SEQ" HeaderText="項次"  SortExpression="SEQ" ReadOnly="True" >
                                    <HeaderStyle HorizontalAlign="center" VerticalAlign="Middle" Wrap="False" Width="50px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="center" VerticalAlign="Middle" Wrap="False"></ItemStyle>
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="權限" SortExpression="Granted">
                                    <EditItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Granted") %>'></asp:Label>
                                        <%--<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Granted") %>'></asp:TextBox>--%>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkGranted" runat="server" Text="授權" 
                                            Checked='<%# Convert.ToBoolean(Eval("Granted")) %>' AutoPostBack="True"  
                                            oncheckedchanged="chkGranted_CheckedChanged" 
                                            ToolTip='<%# Eval("MPID")+"."+Eval("SPID")+"."+Eval("ProgramName") %>'/>
                                        
                                        <asp:HiddenField ID="hid_MPID" runat="server" value='<%# Eval("MPID")%>'/>
                                        <asp:HiddenField ID="hid_SPID" runat="server" value='<%# Eval("SPID")%>'/>
                                        <asp:HiddenField ID="hid_ProgName" runat="server" value='<%# Eval("ProgramName")%>'/>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="center" VerticalAlign="Middle" Wrap="False" Width="100px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="center" VerticalAlign="Middle" Wrap="False"></ItemStyle>
                                </asp:TemplateField>
                                <asp:BoundField DataField="ProgramName" HeaderText="權限名稱" SortExpression="ProgramName">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" Width="280px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="ProgramDepiction" HeaderText="權限功能說明"  SortExpression="ProgramDepiction">
                                    <HeaderStyle HorizontalAlign="Left" VerticalAlign="Middle" Wrap="False" Width="570px"></HeaderStyle>
                                    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="MPID" HeaderText="MPID" SortExpression="MPID"  
                                    Visible="False" ItemStyle-Wrap="True" >
                                <ItemStyle Wrap="True" />
                                </asp:BoundField>
                                <asp:BoundField DataField="SPID" HeaderText="SPID" SortExpression="SPID"  Visible="False" />
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
             </td>
        </tr>          
    </table>
    </ContentTemplate>    
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="btnRefresh" EventName="Click" />
        <asp:AsyncPostBackTrigger ControlID="ddlGroupInformation" EventName="SelectedIndexChanged" />
    </Triggers>   
</asp:UpdatePanel>
        
<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="1">
    <ProgressTemplate>
        <div id="divMaskFrame" style="opacity:0.40; filter:alpha(opacity=40); background-color: #888888; left: 0px; top: 0px; position: fixed; width: 100%;height: 100%; z-index:9998"></Div>
        <div id="divProcess"   style ="opacity:0.85; filter:alpha(opacity=85); border:0px double #cccccc; background-color:transparent; position:absolute; text-align:center; vertical-align:middle; left: 50%; margin-left: -10px; margin-top: 0px; padding:3px;z-index:9999">                       
            <asp:Image ID="imgProgress" runat="server" ImageUrl="~/images/progcircle_32.gif"  style ="width: 50px;height: 50px; padding: 10px;" AlternateText="Updating ..." GenerateEmptyAlternateText="True"/>
        </div>
    </ProgressTemplate>        
 </asp:UpdateProgress> 

    <asp:SqlDataSource ID="sqlDS_GroupInformation" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DATACNNSTR__SQLEXP_XIPS %>" 
        SelectCommand="SELECT DISTINCT [GroupID], [GroupName] FROM [Group_Information] WITH(NOLOCK)"></asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlDS_GroupPermission" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DATACNNSTR__SQLEXP_XIPS %>"        
        SelectCommand="usp__GetGroupPermission" 
        UpdateCommand="usp__UpdateGroupPermission" 
        SelectCommandType="StoredProcedure" 
        UpdateCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlGroupInformation" Name="GroupID" PropertyName="SelectedValue" Type="String" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="GroupID"  Type="String" />
            <asp:Parameter Name="MainPID" Type="String" />
            <asp:Parameter Name="SubPID" Type="Int32" />
            <asp:Parameter Name="IsGranted" Type="Int16" />
            <asp:Parameter Name="UserID" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

