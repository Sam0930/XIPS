using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using XIPS.Data;

namespace XIPS. _Customer
{
    public partial class _custDefault : System.Web.UI.Page
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
                this.ddlGridPageCount.SelectedIndex = this.Session["CUSTOMER_LIST__GRID_PAGECOUNT__SINX"] == null ? 1 : int.Parse(this.Session["CUSTOMER_LIST__GRID_PAGECOUNT__SINX"].ToString());

                //this.GridView1.EmptyDataText = Resources.DefaultResource.DATAGRID_EMPTY__NO_DATA;
                this.GridView1.PagerSettings.Mode = PagerButtons.NumericFirstLast;

                this.Session["CUSTOMER_LIST__DATASOURCE"] = null;
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
                //__sbjs.Append("$get('" + this.UpdateProgress1.ClientID + "').style.display='block'; \n}\n");
                __sbjs.Append("$get('UpdateProgress1').style.display='block'; \n}\n");

                __sbjs.Append("}\n\n");
                __sbjs.Append("function BeginRequestHandler(sender, args) {\n");
                __sbjs.Append("if (__postbackElement && __postbackElement.id=='" + this.btnRefresh.ClientID + "') {\n");
                __sbjs.Append("var __btnPanel=$get('" + this.pnlButton.ClientID + "'); __btnPanel.disabled=true; __btnPanel.style.cursor='wait'; document.body.style.cursor='wait'; \n}\n");
                __sbjs.Append("}\n\n");
                __sbjs.Append("function EndRequestHandler(sender, args) {\n");
                __sbjs.Append("if (__postbackElement && __postbackElement.id=='" + this.btnRefresh.ClientID + "') {\n");
                __sbjs.Append("var __btnPanel=$get('" + this.pnlButton.ClientID + "'); __btnPanel.disabled=false; __btnPanel.style.cursor='default'; document.body.style.cursor='default';\n");
                __sbjs.Append("if( $get('" + this.pnlResult.ClientID + "') ) {$get('" + this.pnlResult.ClientID + "').style.visibility ='visible';\n}\n");

                //__sbjs.Append("$get('" + this.UpdateProgress1.ClientID + "').style.display='none'; \n}\n");
                __sbjs.Append("$get('UpdateProgress1').style.display='block'; \n}\n");

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
                    using (DataTable __dt = __xips.getDetailedList(XipsDAL.DataType.Customer))
                    {
                        this.Session["CUSTOMER_LIST__DATASOURCE"] = __dt.DefaultView;

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
                if (this.Session["CUSTOMER_LIST__DATASOURCE"].GetType() != typeof(DataView))
                {
                    this.___Get__GridView_DS();
                }

                DataView ___dv = this.Session["CUSTOMER_LIST__DATASOURCE"] as DataView;

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

            // Show record count
            this.lblRecCount.Text = Common.Instance.displayGridviewRecordCount(this.GridView1);
        }

        protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
        {
            this.ViewState["SORT_ORDER"] = this.ViewState["SORT_EXPRESSION"].ToString() == e.SortExpression ? (this.ViewState["SORT_ORDER"].ToString() == "asc" ? "desc" : "asc") : "asc";
            this.ViewState["SORT_EXPRESSION"] = e.SortExpression;

            // Operate DataView which stored in Session directly
            this.___Bind__GridView_DS();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                //for (int i = 0; i < e.Row.Cells.Count; i++)
                //{
                //    if (e.Row.Cells[i].Controls.Count > 0)
                //    {
                //        LinkButton Link = (LinkButton)e.Row.Cells[i].Controls[0] ;
                //        Link.Attributes.Add("style", "text-decoration:none;");
                //    }
                //};

                 // Create new cell container for operation button.
                int __index = e.Row.Cells.Add(new System.Web.UI.WebControls.TableCell());
                
                e.Row.Cells[0].Width = Unit.Pixel(60);
                e.Row.Cells[1].Width = Unit.Pixel(150);
                e.Row.Cells[2].Width = Unit.Pixel(400);
                e.Row.Cells[__index].Width = Unit.Pixel(200);    
            }

            // setting the gridview column width
            if (e.Row.RowType == DataControlRowType.Header  || e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[2].Attributes.Add("style", "text-align:left; ");
            }

            ////if (e.Row.RowType == DataControlRowType.DataRow)
            ////{

            ////    HyperLink Link = new HyperLink();
            ////    Link.Text = e.Row.Cells[1].Text;
            ////    Link.NavigateUrl = string.Format("custModify.aspx?cid={0}", Link.Text);
            ////    e.Row.Cells[1].Controls.Add(Link);
            ////    //e.Row.Cells[1].Text=string.Empty;                     
            ////}

            ////if (e.Row.RowType == DataControlRowType.DataRow)
            ////{      
            ////    // Create new cell
            ////    int __index = e.Row.Cells.Add(new System.Web.UI.WebControls.TableCell());

            ////    // Add 'Modify' button
            ////    Button __btnModify = new Button();
            ////    __btnModify.CausesValidation = false;
            ////    __btnModify.CommandName = string.Format("cust_btnModify__{0}", __index);
            ////    __btnModify.Text = "Modify";
            ////    __btnModify.CommandArgument = e.Row.Cells[1].Text;           
            ////   // __btnModify.Click += new EventHandler(GridView1_RowCommand());
            ////    //__btnModify.CommandArgument = DataBinder.Eval(e.Row.DataItem, (string) "統一編號");
            ////    e.Row.Cells[__index].Controls.Add(__btnModify);

            ////    // Add space between buttons
            ////    e.Row.Cells[__index].Controls.Add(new LiteralControl("&nbsp;&nbsp;&nbsp;"));

            ////    // Add 'Delete' button
            ////    Button __btnDelete = new Button();
            ////    __btnDelete.CommandName = string.Format("cust_btnDelete__{0}", __index);
            ////    __btnDelete.Text = "Delete";
            ////    //__btnDelete.Attributes.Add("style", "margin-left:10px");
            ////    __btnDelete.CommandArgument = e.Row.Cells[1].Text;
            ////    __btnDelete.OnClientClick = "OnClientClick=\"javascript:return confirm('確定刪除 ?')\"";
            ////    // __btnDelete.CommandArgument = ( (System.Data.Common .DbDataRecord)(e.Row.DataItem)).GetString(2) ;
            ////    e.Row.Cells[__index].Controls.Add(__btnDelete);
            ////} 

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

                this.Session["CUSTOMER_LIST__GRID_PAGECOUNT__SINX"] = this.ddlGridPageCount.SelectedIndex;
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

        protected void  GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            ////OnClientClick="javascript:return confirm('確定刪除?')";

            Response.Write("CommandArgument " + e.CommandArgument);
            Response.Write("<br>");
            Response.Write("CommandSource " + e.CommandSource);
            Response.Write("<br>");
            Response.Write("CommandName " + e.CommandName);
            Response.Write("<br>");
        }

        protected void GridView1_RowCreated(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HyperLink Link = new HyperLink();
                //LinkButton Link = new LinkButton();
                Link.Text = e.Row.Cells[1].Text;
                Link.NavigateUrl = string.Format("custModify.aspx?cid={0}", Link.Text);
                e.Row.Cells[1].Controls.Add(Link);
                Button __btnMM = new Button();
                __btnMM.CausesValidation = false;
                __btnMM.CommandName = string.Format("cust_btnModify__{0}", "__btnMM");
                __btnMM.Text = "Modify";
                __btnMM.CommandArgument = e.Row.Cells[1].Text;
                //__btnModify.CommandArgument = DataBinder.Eval(e.Row.DataItem, (string) "統一編號");
                e.Row.Cells[1].Controls.Add(__btnMM);

                // Create new cell
                int __index = e.Row.Cells.Add(new System.Web.UI.WebControls.TableCell());

                // Add 'Modify' button
                Button __btnModify = new Button();
                __btnModify.CausesValidation = false;
                __btnModify.CommandName = string.Format("cust_btnModify__{0}", __index);
                __btnModify.Text = "Modify";
                __btnModify.CommandArgument = e.Row.Cells[1].Text;
                //__btnModify.CommandArgument = DataBinder.Eval(e.Row.DataItem, (string) "統一編號");
                e.Row.Cells[__index].Controls.Add(__btnModify);

                // Add space between buttons
                e.Row.Cells[__index].Controls.Add(new LiteralControl("&nbsp;&nbsp;&nbsp;"));

                // Add 'Delete' button
                Button __btnDelete = new Button();
                __btnDelete.CommandName = string.Format("cust_btnDelete__{0}", __index);
                __btnDelete.Text = "Delete";
                //__btnDelete.Attributes.Add("style", "margin-left:10px");
                __btnDelete.CommandArgument = e.Row.Cells[1].Text;
                __btnDelete.OnClientClick = "OnClientClick=\"javascript:return confirm('確定刪除 ?')\"";
                // __btnDelete.CommandArgument = ( (System.Data.Common .DbDataRecord)(e.Row.DataItem)).GetString(2) ;
                e.Row.Cells[__index].Controls.Add(__btnDelete);
            } 
        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }
    }

}