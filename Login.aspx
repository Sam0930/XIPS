<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="XIPS._Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>票券配頁系統管理程式</title>
    <link href="styles/StyleSheet.css" rel="stylesheet" type="text/css" /> 
    <script language="javascript" type="text/javascript" src="scripts/jquery-1.10.2.min.js" ></script>
    <script language="javascript" type="text/javascript">
        // Fallback to loading jQuery from a local path if the CDN is unavailable
        // if (typeof jQuery == 'undefined') 
        !window.jQuery && document.write(unescape("%3Cscript src='http://code.jquery.com/jquery-latest.js' type='text/javascript'%3E%3C/script%3E"));
    </script>    
</head>
<body style="text-align:center; vertical-align:middle" >
    <form id="form1" runat="server">
        <ajaxToolkit:ToolkitScriptManager 
        runat="Server" 
        AsyncPostBackTimeout="6000"
        EnableScriptGlobalization="true"
        EnableScriptLocalization="true" 
        ID="ToolkitScriptManager_Login" 
        ScriptMode="Debug" 
        CombineScripts="false" /> 

    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
    <ContentTemplate>     
 <%--   <div id="divLoginForm" style ="background-color:white; position: absolute; left: 50%; top: 50%; margin-left: 0px; margin-top: 0px; padding:10px; z-index:1; width:360px;"> --%>             
      <table style="width: 360px; border: 2px solid #808080; font-family:微軟正黑體, 標楷體, 細明體; position: absolute;  left: 50%; top: 50%; margin-left: -180px; margin-top: -180px;">
            <tr>
                <td style="vertical-align:top; padding: 5px;border: 2px solid #ffffff;">
                    <table cellpadding="0" style="width:100%">
                        <tr>
                            <td align="center" colspan="2" 
                                style="white-space:nowrap; height:30px;white-space:nowrap; text-align:center; vertical-align:middle;letter-spacing:2px;padding:10px;">
                                <asp:Image runat="server" ID="HeaderImage" ImageUrl="~/images/xips-logo.jpg" AlternateText="華磁票券印刷股份有限公司"  style="width:38px; height:30px; vertical-align:bottom; padding-right:5px"/>
                                <asp:Label ID="Label1" runat="server" Text="華磁票券印刷股份有限公司" style="font-size:22px;"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" style="background-color:#5D7B9D; white-space:nowrap; letter-spacing:2px; padding:10px;">
                                <asp:Label ID="Label2" runat="server" Text="票券配頁系統管理程式" style="font-size:18px;color:White;"></asp:Label></td>
                        </tr>
                        <tr>
                            <td colspan="2" style="height:20px"></td>
                        </tr>
                        <tr style="height:25px;">
                            <td style="font-family:Arial;font-size:14px; text-align:right;  white-space:nowrap; ">
                                <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="txtUserID">使用者帳號 : &nbsp;</asp:Label>
                            </td>
                            <td style="height:25px; text-align:left;  white-space:nowrap">
                                <asp:TextBox Width="120px" ID="txtUserID" runat="server" Font-Names="Arial" Font-Size="12px" MaxLength="25"></asp:TextBox>
                                &nbsp;&nbsp;
                                <asp:RequiredFieldValidator ID="UserIDRequired" runat="server" SetFocusOnError="true"
                                    ControlToValidate="txtUserID" ErrorMessage="請輸入使用者帳號." 
                                    Font-Names="Arial" Font-Size="22px" ForeColor="Red" Font-Bold="true"
                                    ToolTip="請輸入使用者帳號." ValidationGroup="LoginMain">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                           <tr style="height:25px;">
                            <td style="font-family:Arial;font-size:14px; text-align:right;  white-space:nowrap; ">
                                <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="txtPassword">密&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;碼 : &nbsp;</asp:Label>
                            </td>
                            <td style="height:25px; text-align:left;  white-space:nowrap">
                                <asp:TextBox Width="120px" ID="txtPassword" runat="server" Font-Names="Arial" Font-Size="12px" TextMode="Password" MaxLength="25"></asp:TextBox>
                                &nbsp;&nbsp;
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                    ControlToValidate="txtPassword" ErrorMessage="請輸入密碼." SetFocusOnError="true"
                                    Font-Names="Arial" Font-Size="22px" ForeColor="Red" Font-Bold="true"
                                    ToolTip="請輸入密碼." ValidationGroup="LoginMain" >*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2" 
                                style="color:#ff3300; font-size:10pt;font-weight:500; padding:10px 2px 8px 2px; font-family:微軟正黑體">
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                                    ValidationGroup="LoginMain" DisplayMode="SingleParagraph" />
                                <asp:Literal ID="lblFailureText" runat="server" EnableViewState="False"></asp:Literal>
                            </td>
                        </tr>
                        <tr><td  colspan="2" style="background-color:#cccccc; height:4px;" ></td></tr>
                        <tr>
                            <td align="right" colspan="2" 
                                style="background-color: #999999; padding:10px 10px 10px 10px; font-family:Times New Roman; font-size:12pt; color:#284775">
                                <asp:Button ID="LoginButton" runat="server" Font-Size="10pt"  CommandName="Login" 
                                    Text="登  入" ValidationGroup="LoginMain" onclick="LoginButton_Click" />
                                &nbsp;&nbsp;&nbsp;
                                <asp:Button ID="ResetButton" runat="server" Font-Size="10pt"  
                                    CommandName="Reset" CausesValidation="False" 
                                    Text="清   除" ValidationGroup="LoginMain" onclick="ResetButton_Click" />
                            </td>
                        </tr>
                        <tr><td  colspan="2" style="background-color:#cccccc; height:4px;" ></td></tr>
                    </table>
                </td>
            </tr>
        </table>   
<%--    </div>   --%>   
    </ContentTemplate>   
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="LoginButton" EventName="Click" />
    </Triggers>   
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1" DisplayAfter="1">
        <ProgressTemplate>
            <div id="divMaskFrame" style="opacity:0.25; filter:alpha(opacity=25); background-color: #888888; left: 0px; top: 0px; position: fixed; width: 100%;height: 100%; z-index:9998"></Div>
        </ProgressTemplate>
    </asp:UpdateProgress> 
  
<%--    <script language="javascript" type="text/javascript">
        $(window).resize(function () {
            $('#divLoginForm').css({
                position: 'absolute',
                left: ($(window).width() - $('#divLoginForm').outerWidth()) / 2,
                top: ($(window).height() - $('#divLoginForm').outerHeight()) / 2
            });
        });

//        // To initially run the function:
//        $("divLoginForm").load(function () {
//                $(window).resize();
//        });

        // To initially run the function:
        $(window).resize();
    </script>     
                    --%>
   </form>
</body>
</html>
