using System;
using System.Threading;

namespace XIPS.__default
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            this.MasterPageFile = "DefaultMaster.master";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.Page.Title = Resources.DefaultResource.PAGE_TITLE__DEFAULT_HOME;

                Response.Write("<div id='mydiv' style='font-size:12pt; font-weight: 900; font-family:\"微軟正黑體, Times New Roman\";' >\n");
                Response.Write("_");
                Response.Write("</div>\n");
                Response.Write("<script>mydiv.innerText = '';</script>\n");
                Response.Write("<script language=javascript>\n;");
                Response.Write("var timeID;\nvar dots = 0;\nvar dotmax = 500;\n");
                Response.Write("function ShowWait()\n");
                Response.Write("{var output; output = 'Loading'; dots++; \n");
                Response.Write("if(dots>=dotmax) dots=1;\n");
                Response.Write("for(var x = 0; x < dots; x++) {output += '.';}\n");
                Response.Write("mydiv.innerText =  output;}\n\n");
                Response.Write("function StartShowWait()\n");
                Response.Write("{mydiv.style.visibility = 'visible'; timeID=window.setInterval('ShowWait()',1000);}\n\n");
                Response.Write("function HideWait()\n");
                Response.Write("{mydiv.innerText=''; mydiv.style.visibility = 'hidden'; window.clearInterval(timeID);}\n");
                Response.Write("StartShowWait();\n");
                Response.Write("</script>\n");
                Response.Flush();
                Thread.Sleep(1500);
            }
        }

        //protected void tmrServer_Tick(object sender, EventArgs e)
        //{
        //    this.lblServerTime.Text = DateTime.Now.ToString("yyyy/MM/dd HH:mm:ss");
        //}
    }
}