using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using XIPS.Data;

namespace XIPS._Group
{
    public partial class _GroupPermission : System.Web.UI.Page
    {
     private UserCredential __guc;
        private MyApplicationPermission __gmap;

        protected void Page_PreInit(object sender, EventArgs e)
        {
            __guc = this.Session["XIPS_ENV__USER_CREDENTIAL_CLASS"] as UserCredential;
            __gmap = new MyApplicationPermission(MyApplicationPermission.ApplicationName.GroupPermission, __guc);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.Page.Title = Resources.DefaultResource.PAGE_TITLE__GROUP_PERMISSION;

               // ///
               // /// Register AJAX async client javascript
               // /// REQUIRE FOR DropDownList event AutoPostPack=true does not fire <UpdatePanel> 
               // /// 
               // StringBuilder __sbjs = new StringBuilder();
               // __sbjs.Append("<script type=\"text/javascript\" language=\"javascript\"> \n");
               // __sbjs.Append("<!--\n");
               // __sbjs.Append("var ____prm=Sys.WebForms.PageRequestManager.getInstance();\n");
               // __sbjs.Append("var __postbackElement;\n\n");
               // __sbjs.Append("____prm.add_initializeRequest(InitializeRequestHandler);\n");
               // __sbjs.Append("____prm.add_beginRequest(BeginRequestHandler);\n");
               // __sbjs.Append("____prm.add_endRequest(EndRequestHandler);\n\n");

               // //function CancelAsyncPostBack()
               // __sbjs.Append("function CancelAsyncPostBack() {\n");
               // __sbjs.Append("if( ____prm.get_isInAsyncPostBack() ) { ____prm.abortPostBack(); }\n");
               // __sbjs.Append("}\n\n");

               // //function InitializeRequestHandler(sender, args)
               // __sbjs.Append("function InitializeRequestHandler(sender, args) {\n");
               // __sbjs.Append("if( ____prm.get_isInAsyncPostBack() ) { args.set_cancel(true); }\n");
               // __sbjs.Append("__postbackElement=args.get_postBackElement();\n");
               // __sbjs.Append("if( __postbackElement && __postbackElement.id=='" + this.ddlGroupInformation.ClientID + "' ) {\n");
               // //__sbjs.Append("if( $get('" + this.pnlResult.ClientID + "') ) {$get('" + this.pnlResult.ClientID + "').style.visibility ='hidden';} \n");
               // __sbjs.Append("if( $get('" + this.UpdateProgress1.ClientID + "') ) {$get('" + this.UpdateProgress1.ClientID + "').style.display='block'; }\n");
               //__sbjs.Append("$('#divMaskFrame').css({'top': '0','left': '0','display': 'block','z-index': '9998','height': $(window).height() +'px','width': $(window).width()+'px'});\n");
               // __sbjs.Append("}\n}\n\n");

               // //function BeginRequestHandler(sender, args)
               // __sbjs.Append("function BeginRequestHandler(sender, args) {\n");
               // __sbjs.Append("if (__postbackElement && __postbackElement.id=='" + this.ddlGroupInformation.ClientID + "') {\n");
               // __sbjs.Append("document.body.style.cursor='wait'; \n");
               // __sbjs.Append("}\n}\n\n");

               // //function EndRequestHandler(sender, args)
               // __sbjs.Append("function EndRequestHandler(sender, args) {\n");
               // __sbjs.Append("if (__postbackElement && __postbackElement.id=='" + this.ddlGroupInformation.ClientID + "') {\n");
               // //__sbjs.Append("if( $get('" + this.pnlResult.ClientID + "') ) {$get('" + this.pnlResult.ClientID + "').style.visibility ='visible';}\n");
               // __sbjs.Append("document.body.style.cursor='default';\n");
               // __sbjs.Append("if( $get('" + this.UpdateProgress1.ClientID + "') ) {$get('" + this.UpdateProgress1.ClientID + "').style.display='none';}\n");
               // __sbjs.Append("}\n}\n");
               // __sbjs.Append("// -->\n");
               // __sbjs.Append("</script> \n");
               // this.ClientScript.RegisterStartupScript(this.GetType(), "ajaxProcress", __sbjs.ToString(), false);

            }

            this.pnlErrorMsg.Visible = false;
            this.lblError.Text = string.Empty;
            this.pnlOperation.Visible = false;
            this.lblOperation.Text = string.Empty;  
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            this.pnlErrorMsg.Visible = false;
            this.lblError.Text = string.Empty;
            this.pnlOperation.Visible = false;
            this.lblOperation.Text = string.Empty;  

            try
            {
                this.GridView1.DataBind();
                Thread.Sleep(100);
            }
            catch (Exception _exp)
            {
                this.pnlErrorMsg.Visible = true;
                this.lblError.Text = _exp.Message;
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            this.pnlErrorMsg.Visible = false;
            this.lblError.Text = string.Empty;
            this.pnlOperation.Visible = false;
            this.lblOperation.Text = string.Empty;  
            
            try
            {
                switch (e.CommandName)
                {
                    case "Cancel":
                        break;
                    case "Detail":                     
                        break;
                    case "sort":
                        break;
                    case "Page":
                        break;
                    default:
                        break;
                };
            }
            catch (Exception __exp)
            {
                this.pnlErrorMsg.Visible = true;
                this.lblError.Text = __exp.Message;
            }
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            //if (e.Row.RowType == DataControlRowType.DataRow && e.Row.Cells[1].FindControl("chkGranted") != null )
            //{   
            //        (e.Row.Cells[1].FindControl("chkGranted") as CheckBox).Enabled = __gmap.RightToExecute == MyApplicationPermission.PermissionLevel.Yes? true:false;        
            //}

            // Finding control by Naming Container, not the relation of control's parent
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.FindControl("chkGranted") != null)
            {
                (e.Row.FindControl("chkGranted") as CheckBox).Enabled = __gmap.RightToExecute == MyApplicationPermission.PermissionLevel.Yes ? true : false;
            }
        }

        protected void chkGranted_CheckedChanged(object sender, EventArgs e)
        {
            this.pnlErrorMsg.Visible = false;
            this.lblError.Text = string.Empty;
            this.pnlOperation.Visible = false;
            this.lblOperation.Text = string.Empty;  
       
            try
            {
                if (sender.GetType() == typeof(CheckBox))
                {
                    CheckBox __chkGrant = sender as CheckBox;
                    //string __MPID = __chkGrant.ToolTip.Split('.')[0]; 
                    //string __SPID = __chkGrant.ToolTip.Split('.')[1];
                    //string __ProgName = __chkGrant.ToolTip.Split('.')[2];

                    string __MPID = (__chkGrant.FindControl("hid_MPID") as HiddenField).Value;
                    string __SPID = (__chkGrant.Parent.FindControl("hid_SPID") as HiddenField).Value;
                    string __ProgName = (__chkGrant.Parent.Parent.FindControl("hid_ProgName") as HiddenField).Value; 

                    this.sqlDS_GroupPermission.UpdateParameters["GroupID"].DefaultValue = this.ddlGroupInformation.SelectedValue; //SelectedItem.Text;
                    this.sqlDS_GroupPermission.UpdateParameters["MainPID"].DefaultValue = __MPID;
                    this.sqlDS_GroupPermission.UpdateParameters["SubPID"].DefaultValue = __SPID;
                    this.sqlDS_GroupPermission.UpdateParameters["IsGranted"].DefaultValue = __chkGrant.Checked? "1":"0";
                    this.sqlDS_GroupPermission.UpdateParameters["UserID"].DefaultValue = __guc.ID;
                    this.sqlDS_GroupPermission.Update();
                    this.pnlOperation.Visible = true;
                    this.lblOperation.Text = string.Format("已{0}{1}權限 - {2} ({3}.{4}).", __chkGrant.Checked ? "開啟" : "關閉", __guc.GroupName, __ProgName, __MPID, __SPID);
                    Thread.Sleep(150);
                }
            }
           catch (Exception __exp)
            {
                this.pnlErrorMsg.Visible = true;
                this.lblError.Text = __exp.Message;
            }
        }
}
}