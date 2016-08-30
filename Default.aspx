<%@ Page Title="" Language="C#" MasterPageFile="DefaultMaster.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="XIPS.__default._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeaderContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MasterContent" Runat="Server">
    <script type="text/javascript" language="javascript">
        if ($.isFunction(window.HideWait)) {
            HideWait();
        }
    </script>       
    <img alt="CMP" src="images/CMP.png" />
<%--    <asp:Panel ID="Panel1" runat="server" style="padding-top:10px;">
    <asp:UpdatePanel ID="UpdatePanel_MasterPage" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Label ID="lblServerTime" runat="server" style=" font-size:12pt; font-family: Times New Roman"></asp:Label>
            <asp:Timer ID="tmrServer" runat="server" Interval="1000" ontick="tmrServer_Tick">
            </asp:Timer>                                                          
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="tmrServer" EventName="Tick" />
        </Triggers>
    </asp:UpdatePanel>
    </asp:Panel>--%>
</asp:Content>

