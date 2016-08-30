using System;
using System.Text;
using System.Web.UI.WebControls;
using XIPS.Data;

namespace XIPS._StockLibrary
{
    public partial class _slDefault : System.Web.UI.Page
    {
        private MyApplicationPermission __gmap;

        protected void Page_PreInit(object sender, EventArgs e)
        {
            __gmap = new MyApplicationPermission(MyApplicationPermission.ApplicationName.StockLibrary, this.Session["XIPS_ENV__USER_CREDENTIAL_CLASS"] as UserCredential);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.Page.Title = Resources.DefaultResource.PAGE_TITLE__STOCK_LIBRARY;

                /// page size of gridview
                this.ddlGridPageCount.DataSource = Common.Instance.DropdownListCountOfGridviewPager();
                this.ddlGridPageCount.DataBind();
                this.ddlGridPageCount.SelectedIndex = this.Session["STOCKLIBRARY_LIST__GRID_PAGECOUNT__SINX"] == null ? 1 : int.Parse(this.Session["STOCKLIBRARY_LIST__GRID_PAGECOUNT__SINX"].ToString());

                //this.GridView1.EmptyDataText = Resources.DefaultResource.DATAGRID_EMPTY__NO_DATA;
                this.GridView1.PagerSettings.Mode = PagerButtons.NumericFirstLast;
                this.GridView1.PageSize = Convert.ToInt16(this.ddlGridPageCount.SelectedValue);

                ///
                /// Register AJAX async client javascript
                /// 
                StringBuilder __sbjs = new StringBuilder();
                __sbjs.Append("<script type=\"text/javascript\" language=\"javascript\"> \n");
                __sbjs.Append("<!--\n");
                __sbjs.Append("var ____prm=Sys.WebForms.PageRequestManager.getInstance();\n");
                __sbjs.Append("var __postbackElement;\n\n");
                __sbjs.Append("____prm.add_initializeRequest(InitializeRequestHandler);\n");
                __sbjs.Append("____prm.add_beginRequest(BeginRequestHandler);\n");
                __sbjs.Append("____prm.add_endRequest(EndRequestHandler);\n\n");

                //function CancelAsyncPostBack()
                __sbjs.Append("function CancelAsyncPostBack() {\n");
                __sbjs.Append("if( ____prm.get_isInAsyncPostBack() ) { ____prm.abortPostBack(); }\n");
                __sbjs.Append("}\n\n");

                //function InitializeRequestHandler(sender, args)
                __sbjs.Append("function InitializeRequestHandler(sender, args) {\n");
                __sbjs.Append("if( ____prm.get_isInAsyncPostBack() ) { args.set_cancel(true); }\n");
                __sbjs.Append("__postbackElement=args.get_postBackElement();\n");
                __sbjs.Append("if( __postbackElement && __postbackElement.id=='" + this.btnRefresh.ClientID + "' ) {\n");
                __sbjs.Append("if( $get('" + this.pnlResult.ClientID + "') ) {$get('" + this.pnlResult.ClientID + "').style.visibility ='hidden';} \n");
                __sbjs.Append("if( $get('" + this.UpdateProgress1.ClientID + "') ) {$get('" + this.UpdateProgress1.ClientID + "').style.display='block'; }\n");
                //__sbjs.Append("$(\"#divProcess\").css({\"position\": \"absolute\", \"display\": \"block\",\"z-index\": \"9999\"});\n");
                //__sbjs.Append("$(\"#divProcess\").css(\"top\", ( $(window).height() - $(\"#divProcess\").height() ) / 2 + \"px\");\n");
                //__sbjs.Append("$(\"#divProcess\").css(\"left\", ( $(window).width() - $(\"#divProcess\").width() ) / 2 + \"px\");\n");
                //__sbjs.Append("$('#divProcess').css({'top': ( $(window).height()-$('#divProcess').height() )/2+$(window).scrollTop()+'px','left': ( $(window).width()-$('#divProcess').width() )/2+$(window).scrollLeft()+'px','display': 'block','z-index': '9999'});\n");
                __sbjs.Append("$('#divMaskFrame').css({'top': '0','left': '0','display': 'block','z-index': '9998','height': $(window).height() +'px','width': $(window).width()+'px'});\n");
                __sbjs.Append("}\n}\n\n");

                //function BeginRequestHandler(sender, args)
                __sbjs.Append("function BeginRequestHandler(sender, args) {\n");
                __sbjs.Append("if (__postbackElement && __postbackElement.id=='" + this.btnRefresh.ClientID + "') {\n");
                __sbjs.Append("document.body.style.cursor='wait'; \n");
                __sbjs.Append("}\n}\n\n");

                //function EndRequestHandler(sender, args)
                __sbjs.Append("function EndRequestHandler(sender, args) {\n");
                __sbjs.Append("if (__postbackElement && __postbackElement.id=='" + this.btnRefresh.ClientID + "') {\n");
                __sbjs.Append("if( $get('" + this.pnlResult.ClientID + "') ) {$get('" + this.pnlResult.ClientID + "').style.visibility ='visible';}\n");
                __sbjs.Append("document.body.style.cursor='default';\n");
                __sbjs.Append("if( $get('" + this.UpdateProgress1.ClientID + "') ) {$get('" + this.UpdateProgress1.ClientID + "').style.display='none';}\n");
                __sbjs.Append("}\n}\n");
                __sbjs.Append("// -->\n");
                __sbjs.Append("</script> \n");
                this.ClientScript.RegisterStartupScript(this.GetType(), "ajaxProcress", __sbjs.ToString(), false);
            }

            this.btnAdd.Visible = __gmap.RightToInsert == MyApplicationPermission.PermissionLevel.Yes ? true : false;
            this.pnlErrorMsg.Visible = false;
            this.pnlResultOP.Visible = false;
            this.lblRecCount.Text = string.Empty;
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            this.pnlErrorMsg.Visible = false;
            this.lblError.Text = string.Empty;

            try
            {
                switch (e.CommandName)
                {
                    case "EditData":
                        if (__gmap.RightToUpdate == MyApplicationPermission.PermissionLevel.Yes)
                        {
                            Response.Redirect(string.Format("../_StockLibrary/slDetail.aspx?Mode=Update&StockLibraryID={0}", e.CommandArgument));
                        }
                        else
                        {
                            throw new Exception( Resources.DefaultResource.PERMISSION_DENY__UPDATE);
                        }
                        break;
                    case "DeleteData":
                        if (__gmap.RightToDelete == MyApplicationPermission.PermissionLevel.Yes)
                        {
                            using (XipsDAL __xips = new XipsDAL())
                            {
                                // Validate to delete StockLibrary.
                                if (!__xips.ValidateToDeleteStockLibrary(e.CommandArgument.ToString()))
                                    throw new Exception(Resources.DefaultResource.MSG__ERROR_DELETE_DATA_INUSE);

                                if (__xips.DeleteData(XipsDAL.DataType.StockLibrary, e.CommandArgument.ToString()))
                                {
                                    this.btnRefresh_Click(sender, e);
                                }
                                else
                                {
                                    throw new Exception( __xips.ErrorMessage);
                                }
                            }
                        }
                        else
                        {
                            throw new Exception( Resources.DefaultResource.PERMISSION_DENY__DELETE);
                        }
                        break;
                    case "Detail":
                        Response.Redirect(string.Format("../_StockLibrary/slDetail.aspx?Mode=Detail&StockLibraryID={0}", e.CommandArgument));
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

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            try
            {
                this.GridView1.DataBind();
            }
            catch (Exception _exp)
            {
                this.pnlErrorMsg.Visible = true;
                this.lblError.Text = _exp.Message;
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {

            if (__gmap.RightToInsert == MyApplicationPermission.PermissionLevel.Yes)
            {
                Response.Redirect("../_StockLibrary/slDetail.aspx?Mode=Insert");
            }
            else
            {
                this.pnlErrorMsg.Visible = true;
                this.lblError.Text = Resources.DefaultResource.PERMISSION_DENY__INSERT;
            }
        }

        protected void ddlGridPageCount_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.Session["STOCKLIBRARY_LIST__GRID_PAGECOUNT__SINX"] = this.ddlGridPageCount.SelectedIndex;
            this.GridView1.PageSize = Convert.ToInt16(this.ddlGridPageCount.Text);
        }

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            this.pnlResultOP.Visible = true;

            // Show record count
            this.lblRecCount.Text = Common.Instance.displayGridviewRecordCount(this.GridView1);
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.FindControl("btnEdit") != null)
                    (e.Row.FindControl("btnEdit") as Button).Enabled = __gmap.RightToUpdate == MyApplicationPermission.PermissionLevel.Yes ? true : false;

                if (e.Row.FindControl("btnDelete") != null)
                    (e.Row.FindControl("btnDelete") as Button).Enabled = __gmap.RightToDelete == MyApplicationPermission.PermissionLevel.Yes ? true : false;
            }
        }
    }
}