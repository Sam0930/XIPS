using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Text;
using XIPS.Data;

namespace XIPS._User
{
    public partial class _userDefault : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                /// page size of gridview
                this.ddlGridPageCount.Items.Add("10");
                this.ddlGridPageCount.Items.Add("20");
                this.ddlGridPageCount.Items.Add("30");
                this.ddlGridPageCount.Items.Add("40");
                this.ddlGridPageCount.Items.Add("50");
                this.ddlGridPageCount.SelectedIndex = this.Session["USER_LIST__GRID_PAGECOUNT__SINX"] == null ? 1 : int.Parse(this.Session["USER_LIST__GRID_PAGECOUNT__SINX"].ToString());

                //this.GridView1.EmptyDataText = Resources.DefaultResource.DATAGRID_EMPTY__NO_DATA;
                this.GridView1.PagerSettings.Mode = PagerButtons.NumericFirstLast;

                this.Session["USER_LIST__DATASOURCE"] = null;
                this.ViewState["SORT_ORDER"] = "";
                this.ViewState["SORT_EXPRESSION"] = "";

                this.GridView1.Visible = false;
                this.pnlErrorMsg.Visible = false;
                this.pnlResultOP.Visible = false;
                this.lblRecCount.Text = string.Empty;
                this.lblError.Text = string.Empty;
                this.GridView1.DataSource = null;
                this.GridView1.DataBind();

                ///
                /// Register client javascript
                /// 
                StringBuilder __sbjs = new StringBuilder();
                __sbjs.Append("<script type=\"text/javascript\" language=\"javascript\"> \n");
                __sbjs.Append("<!--\n");
                __sbjs.Append("var ____prm=Sys.WebForms.PageRequestManager.getInstance();\n");
                __sbjs.Append("var __postbackElement;\n\n");
                __sbjs.Append("____prm.add_initializeRequest(InitializeRequestHandler);\n");
                __sbjs.Append("____prm.add_beginRequest(BeginRequestHandler);\n");
                __sbjs.Append("____prm.add_endRequest(EndRequestHandler);\n\n");
                __sbjs.Append("function CancelAsyncPostBack() {\n");
                __sbjs.Append("if (____prm.get_isInAsyncPostBack()) { ____prm.abortPostBack(); }\n");
                __sbjs.Append("}\n\n");
                __sbjs.Append("function InitializeRequestHandler(sender, args) {\n");
                __sbjs.Append("if (____prm.get_isInAsyncPostBack()) { args.set_cancel(true); }\n");
                __sbjs.Append("__postbackElement=args.get_postBackElement();\n");
                __sbjs.Append("if (__postbackElement && __postbackElement.id=='" + this.btnRefresh.ClientID + "') {\n");
                __sbjs.Append("if( $get('" + this.pnlResult.ClientID + "') ) {$get('" + this.pnlResult.ClientID + "').style.visibility ='hidden';} \n");
                __sbjs.Append("$get('" + this.UpdateProgress1.ClientID + "').style.display='block'; \n}\n");
                __sbjs.Append("}\n\n");
                __sbjs.Append("function BeginRequestHandler(sender, args) {\n");
                __sbjs.Append("if (__postbackElement && __postbackElement.id=='" + this.btnRefresh.ClientID + "') {\n");
                __sbjs.Append("var __btnPanel=$get('" + this.pnlButton.ClientID + "'); __btnPanel.disabled=true; __btnPanel.style.cursor='wait'; document.body.style.cursor='wait'; \n}\n");
                __sbjs.Append("}\n\n");
                __sbjs.Append("function EndRequestHandler(sender, args) {\n");
                __sbjs.Append("if (__postbackElement && __postbackElement.id=='" + this.btnRefresh.ClientID + "') {\n");
                __sbjs.Append("var __btnPanel=$get('" + this.pnlButton.ClientID + "'); __btnPanel.disabled=false; __btnPanel.style.cursor='default'; document.body.style.cursor='default';\n");
                __sbjs.Append("if( $get('" + this.pnlResult.ClientID + "') ) {$get('" + this.pnlResult.ClientID + "').style.visibility ='visible';\n}\n");
                __sbjs.Append("$get('" + this.UpdateProgress1.ClientID + "').style.display='none'; \n}\n");
                __sbjs.Append("}\n");
                __sbjs.Append("// -->\n");
                __sbjs.Append("</script> \n");
                this.ClientScript.RegisterStartupScript(this.GetType(), "ajaxProcress", __sbjs.ToString(), false);

                btnRefresh_Click(sender, e);
            }
        }

        private void ___Get__GridView_DS()
        {
            try
            {
                using (XipsDAL __xips = new XipsDAL())
                {
                    using (DataTable __dt = __xips.getDetailedList(XipsDAL.DataType.User))
                    {
                        this.Session["USER_LIST__DATASOURCE"] = __dt.DefaultView;

                        if (__xips.ErrorMessage.Length > 0)
                        {
                            throw new Exception(__xips.ErrorMessage);
                        }
                    }
                }
            }
            catch (Exception __exp)
            {
                throw new Exception("[___Get__GridView_DS]:" + __exp.Message);
            }
        }

        private bool ___Bind__GridView_DS()
        {
            bool _____my_Return = false;

            try
            {
                // Check Session Type before operating the data
                if (this.Session["USER_LIST__DATASOURCE"].GetType() != typeof(DataView))
                {
                    this.___Get__GridView_DS();
                }

                DataView ___dv = this.Session["USER_LIST__DATASOURCE"] as DataView;

                if (this.ViewState["SORT_ORDER"].ToString() != string.Empty && this.ViewState["SORT_EXPRESSION"].ToString() != string.Empty)
                {
                    ___dv.Sort = string.Format("{0} {1}", this.ViewState["SORT_EXPRESSION"].ToString(), this.ViewState["SORT_ORDER"].ToString());
                }
                else
                {
                    ___dv.ApplyDefaultSort = true;
                }

                this.GridView1.DataSource = ___dv;
                this.GridView1.DataBind();

                _____my_Return = ___dv.Count > 0 ? true : false;
            }
            catch (Exception __exp)
            {
                this.lblError.Text = __exp.Message;
                this.pnlErrorMsg.Visible = true;
            }

            return (_____my_Return);
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.GridView1.PageIndex = e.NewPageIndex;

            // Operate DataView which stored in Session directly
            this.___Bind__GridView_DS();

            // Due to set the property "ChildrenAsTrigger" to false, it's need to manually to update UpdatePanel.
            this.UpdatePanel1.Update();

            // Show record count
            this.lblRecCount.Text = Common.Instance.displayGridviewRecordCount(this.GridView1);
        }

        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {
            this.ViewState["SORT_ORDER"] = this.ViewState["SORT_EXPRESSION"].ToString() == e.SortExpression ? (this.ViewState["SORT_ORDER"].ToString() == "asc" ? "desc" : "asc") : "asc";
            this.ViewState["SORT_EXPRESSION"] = e.SortExpression;

            // Operate DataView which stored in Session directly
            this.___Bind__GridView_DS();

            // Due to set the property "ChildrenAsTrigger" to false, it's need to manually to update UpdatePanel.
            this.UpdatePanel1.Update();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                //for (int i = 0; i < e.Row.Cells.Count; i++)
                //{
                //    if (e.Row.Cells[i].Controls.Count > 0)
                //    {
                //        LinkButton Link = (LinkButton)e.Row.Cells[i].Controls[0];
                //        Link.Attributes.Add("style", "text-decoration:none;");
                //    }
                //};
                e.Row.Cells[0].Width = Unit.Pixel(60);
                e.Row.Cells[1].Width = Unit.Pixel(150);
                e.Row.Cells[2].Width = Unit.Pixel(250);
                e.Row.Cells[3].Width = Unit.Pixel(180);
           }

            // setting the gridview column width
            if (e.Row.RowType == DataControlRowType.Header || e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[2].Attributes.Add("style", "text-align:left; ");
                e.Row.Cells[3].Attributes.Add("style", "text-align:left; ");
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            try
            {
                // Reset UpdatePanel content
                // Disable/hidden result and message
                this.GridView1.Visible = false;
                this.pnlErrorMsg.Visible = false;
                this.pnlResultOP.Visible = false;
                this.lblError.Text = string.Empty;
                this.lblRecCount.Text = string.Empty;

                // Reset the sort order when retrieving cdr 
                this.ViewState["SORT_ORDER"] = "";
                this.ViewState["SORT_EXPRESSION"] = "";

                this.Session["USER_LIST__GRID_PAGECOUNT__SINX"] = this.ddlGridPageCount.SelectedIndex;
                this.GridView1.PageSize = int.Parse(ddlGridPageCount.SelectedValue);

                // Reset pageindex to 0
                this.GridView1.PageIndex = 0;

                // Retrieve CDR DataView and store it in Session
                this.___Get__GridView_DS();

                // Operating DataView which stored in Session directly
                // Show "Result to EXCEL" button            
                if (this.___Bind__GridView_DS())
                {
                    this.pnlResultOP.Visible = true;
                }

                // Show gridview after binding data
                this.lblRecCount.Text = Common.Instance.displayGridviewRecordCount(this.GridView1);
                this.GridView1.Visible = true;
            }
            catch (Exception __exp)
            {
                // Retrieve the error of database server level
                this.lblError.Text = __exp.Message;
                this.pnlErrorMsg.Visible = true;
            }
        }

    }
}