using System;
using System.Web.UI;
using XIPS.Data;

namespace XIPS
{
    public partial class _Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = Resources.DefaultResource.PAGE_TITLE__DEFAULT_HOME;
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            if (this.Session["XIPS_ENV__USER_CREDENTIAL_CLASS"].GetType() != typeof(UserCredential))
            {
                this.Session["XIPS_ENV__USER_CREDENTIAL_CLASS"] = new UserCredential();
            }

            UserCredential __guc = this.Session["XIPS_ENV__USER_CREDENTIAL_CLASS"] as UserCredential;

            if (__guc.Login(this.txtUserID.Text, this.txtPassword.Text))
            {
                //Server.Transfer("Default.aspx", true);
                Response.Redirect("Default.aspx",true);
            }
            else
            {
                this.txtUserID.Focus();
                this.lblFailureText.Text = __guc.ErrorMessage.Length > 0 ? __guc.ErrorMessage : "登入失敗.";
                ScriptManager.RegisterClientScriptBlock(this, typeof(string), "", "<script>$(window).resize();</script>", false);
            }
        }
        protected void ResetButton_Click(object sender, EventArgs e)
        {
            this.txtUserID.Text = string.Empty;
            this.txtPassword.Text = string.Empty;
            this.txtUserID.Focus();
            ScriptManager.RegisterClientScriptBlock(this, typeof(string), "", "<script>$(window).resize();</script>", false);
        }
}
}