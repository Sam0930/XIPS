using System;
using System.Web.UI;
using System.Threading;
using System.IO;
using XIPS.Data;

namespace XIPS
{
    public partial class _DefaultMaster : System.Web.UI.MasterPage
    {
        private UserCredential __gucMaster;

        protected void Page_Init(object sender, EventArgs e)
        {
            // Check user's permission 
            try
            {
                // logout user if session timeout
                if (this.Session["XIPS_ENV__USER_CREDENTIAL_CLASS"].GetType() != typeof(UserCredential))
                    throw new Exception();

                //Logout user if illegal or session timeout
                __gucMaster = this.Session["XIPS_ENV__USER_CREDENTIAL_CLASS"] as UserCredential;

                if (!__gucMaster.IsCheckValidity)
                    throw new Exception();

                this.menuLoginInfo.Items[0].Text = "Welcome !   " + __gucMaster.Name + "  ";
                //  this.lblUserName.Text = __guc.Name;                             
            }
            catch
            {
                this.__Logout();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.txtOrgPassword.Text = string.Empty;
                this.txtNewPassword.Text = string.Empty;
                this.txtNewPasswordConfirm.Text = string.Empty;
                this.pnlChangePasswordMask.Visible = false;
                this.pnlChangePasswordWindow.Visible = false;

                if (this.Page.Title.Length == 0)
                    this.Page.Title = Resources.DefaultResource.PAGE_TITLE__DEFAULT_HOME;
            }
        }

        protected void menuLoginInfo_MenuItemClick(object sender, System.Web.UI.WebControls.MenuEventArgs e)
        {
            switch (e.Item.Value)
            {
                case "ChangePassword":
                    this.txtOrgPassword.Text = string.Empty;
                    this.txtNewPassword.Text = string.Empty;
                    this.txtNewPasswordConfirm.Text = string.Empty;
                    this.pnlChangePasswordMask.Visible = true;
                    this.pnlChangePasswordWindow.Visible = true;
                    break;
                case "Logout":
                    this.__Logout();
                    break;
                default:
                    //this.__Logout();
                    break;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            this.pnlChangePasswordMask.Visible = false;
            this.pnlChangePasswordWindow.Visible = false;
        }

        protected void btnChangePwd_Click(object sender, EventArgs e)
        {
            try
            {
                if (__gucMaster.ChangePassword(this.txtOrgPassword.Text, this.txtNewPassword.Text))
                {
                    ScriptManager.RegisterClientScriptBlock(this, typeof(string), "", "<script>alert('變更密碼已完成.');</script>", false);
                    this.pnlChangePasswordMask.Visible = false;
                    this.pnlChangePasswordWindow.Visible = false;
                    Thread.Sleep(500);
                }
                else
                {
                    throw new Exception("變更密碼失敗. " + __gucMaster.ErrorMessage);
                }
            }
            catch (Exception _exp)
            {
                this.txtOrgPassword.Text = string.Empty;
                this.txtNewPassword.Text = string.Empty;
                this.txtNewPasswordConfirm.Text = string.Empty;
                this.txtOrgPassword.Focus();
                this.lblChangeFailed.Text = _exp.Message;
            }
        }

        private void __Logout()
        {
            //string ___currentPage = Server.MapPath(this.Request.Url.AbsolutePath);
            // new FileInfo( ___currentPage).Directory.Name)

            string __LogoutDestPage;

            if (Path.GetFileName(Request.PhysicalPath).Equals("default.aspx", StringComparison.OrdinalIgnoreCase))
            {
                __LogoutDestPage = "Login.aspx";
            }
            else
            {
                __LogoutDestPage = "../Login.aspx";
            }

            try
            {
                __gucMaster.Dispose(true);
                __gucMaster = null;
                this.Session.Abandon();
                this.Session.Clear();
                //Response.Redirect(__LogoutDestPage, true);
                Server.Transfer(__LogoutDestPage, false);
            }
            catch(Exception __exp)
            {
                ScriptManager.RegisterClientScriptBlock(this, typeof(string), "", "<script>alert(\"" + __exp.Message + "\"); this.close();</script>", false);
            }
        }

    }
}
