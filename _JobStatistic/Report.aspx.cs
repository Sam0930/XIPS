using System;
using System.Threading;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using System.Xml;
using System.Xml.Serialization;
using XIPS.Data;

namespace XIPS._JobStatistic
{
    public partial class _Report : System.Web.UI.Page
    {
        private UserCredential __guc;
        private MyApplicationPermission __gmap;

        protected void Page_PreInit(object sender, EventArgs e)
        {
            __guc = this.Session["XIPS_ENV__USER_CREDENTIAL_CLASS"] as UserCredential;
            __gmap = new MyApplicationPermission(MyApplicationPermission.ApplicationName.JobStatistic, __guc);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.Page.Title = Resources.DefaultResource.PAGE_TITLE__STATISTIC_REPORT;

                /// page size of gridview
                this.ddlGridPageCount.DataSource = Common.Instance.DropdownListCountOfGridviewPager();
                this.ddlGridPageCount.DataBind();
                this.ddlGridPageCount.SelectedIndex = this.Session["JOBSTATISTIC_REPORT__GRID_PAGECOUNT__SINX"] == null ? 1 : int.Parse(this.Session["JOBSTATISTIC_REPORT__GRID_PAGECOUNT__SINX"].ToString());

                //this.GridView1.EmptyDataText = Resources.DefaultResource.DATAGRID_EMPTY__NO_DATA;
                this.GridView1.PagerSettings.Mode = PagerButtons.NumericFirstLast;
                this.GridView1.PageSize = Convert.ToInt16(this.ddlGridPageCount.SelectedValue);

                this.Session["JOBSTATISTIC_REPORT__GRIDVIEW_DATASOURCE"] = null;
                this.ViewState["SORT_ORDER"] = "";
                this.ViewState["SORT_EXPRESSION"] = "";

                this.GridView1.Visible = false;
                this.pnlErrorMsg.Visible = false;
                this.pnlResultOP.Visible = false;
                this.lblRecCount.Text = string.Empty;
                this.lblError.Text = string.Empty;
                this.GridView1.DataSource = null;
                this.GridView1.DataBind();
         
                this.CalendarExtender1.Format = "yyyy/MM/dd";
                this.CalendarExtender2.Format = "yyyy/MM/dd";
                //this.CalendarExtender1.StartDate = DateTime.Now.AddMonths(-12);
                //this.CalendarExtender2.StartDate = this.CalendarExtender1.StartDate;
                this.CalendarExtender1.EndDate = DateTime.Now;
                this.CalendarExtender2.EndDate = this.CalendarExtender1.EndDate;
                this.CalendarExtender1.SelectedDate = DateTime.Now.AddDays(-1);
                this.CalendarExtender2.SelectedDate = DateTime.Now;

                // Initial Operator dropdown list
                using (XipsDAL __xips = new XipsDAL())
                {
                    using (DataTable __dt = __xips.getDetailedList(XipsDAL.DataType.UserBrief))
                    {
                        ddlUser.DataSource = __dt;
                        ddlUser.DataTextField = "UserName";
                        ddlUser.DataValueField = "UserID";
                        ddlUser.DataBind();
                    }
                }
                this.ddlUser.Items.Insert(0, "");

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
                __sbjs.Append("if (__postbackElement && __postbackElement.id=='" + this.btnQuery.ClientID + "') {\n");
                __sbjs.Append("if( $get('" + this.pnlResult.ClientID + "') ) {$get('" + this.pnlResult.ClientID + "').style.visibility ='hidden';} \n");
                __sbjs.Append("$get('" + this.UpdateProgress1.ClientID + "').style.display='block'; \n}\n");
                __sbjs.Append("}\n\n");
                __sbjs.Append("function BeginRequestHandler(sender, args) {\n");
                __sbjs.Append("if (__postbackElement && __postbackElement.id=='" + this.btnQuery.ClientID + "') {\n");
                __sbjs.Append("var __btnPanel=$get('" + this.pnlButton.ClientID + "'); __btnPanel.disabled=true; __btnPanel.style.cursor='wait'; document.body.style.cursor='wait'; \n}\n");
                __sbjs.Append("}\n\n");
                __sbjs.Append("function EndRequestHandler(sender, args) {\n");
                __sbjs.Append("if (__postbackElement && __postbackElement.id=='" + this.btnQuery.ClientID + "') {\n");
                __sbjs.Append("var __btnPanel=$get('" + this.pnlButton.ClientID + "'); __btnPanel.disabled=false; __btnPanel.style.cursor='default'; document.body.style.cursor='default';\n");
                __sbjs.Append("if( $get('" + this.pnlResult.ClientID + "') ) {$get('" + this.pnlResult.ClientID + "').style.visibility ='visible';\n}\n");
                __sbjs.Append("$get('" + this.UpdateProgress1.ClientID + "').style.display='none'; \n}\n");
                __sbjs.Append("}\n");
                __sbjs.Append("// -->\n");
                __sbjs.Append("</script> \n");
                this.ClientScript.RegisterStartupScript(this.GetType(), "ajaxProcress", __sbjs.ToString(), false);
            }

            if (__gmap.RightToExecute != MyApplicationPermission.PermissionLevel.Yes && this.FindControl("btnQuery") != null)
            {
                (this.FindControl("btnQuery") as Button).Enabled = false;
            }
        }

        private void ___Get__GridView_DS()
        {
            try
            {
                using (XipsDAL __xips = new XipsDAL())
                {
                    using (DataTable __dt = __xips.JobStatisticReport(
                        System.Convert.ToDateTime(this.txtCallStart.Text), System.Convert.ToDateTime(this.txtCallEnd.Text), ddlUser.SelectedItem.Value))
                    {
                        this.Session["JOBSTATISTIC_REPORT__DATASOURCE"] = __dt.DefaultView;

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
                if (this.Session["JOBSTATISTIC_REPORT__DATASOURCE"].GetType() != typeof(DataView))
                {
                    this.___Get__GridView_DS();
                }

                DataView ___dv = this.Session["JOBSTATISTIC_REPORT__DATASOURCE"] as DataView;

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

        ///
        /// remove header text underline when sorting is apply in gridview
        /// defined css in the gridview link button from code behind
        /// 
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
                e.Row.Cells[0].Width = Unit.Pixel(150);
                e.Row.Cells[1].Width = Unit.Pixel(400);
                e.Row.Cells[2].Width = Unit.Pixel(120);
                e.Row.Cells[3].Width = Unit.Pixel(80);
                e.Row.Cells[4].Width = Unit.Pixel(80);       
            }
        }

        protected void btnQuery_Click(object sender, EventArgs e)
        {

            try
            {
                if (__gmap.RightToExecute != MyApplicationPermission.PermissionLevel.Yes )
                {
                    throw new System.Exception(Resources.DefaultResource.PERMISSION_DENY__EXECUTE);
                }

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

                this.Session["JOBSTATISTIC_REPORT__GRID_PAGECOUNT__SINX"] = this.ddlGridPageCount.SelectedIndex;
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
                this.lblError.Text = __exp.Message;
                this.pnlErrorMsg.Visible = true;
            }
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            this.lblError.Text = string.Empty;
            this.lblRecCount.Text = string.Empty;           
            try
            {
                if (__gmap.RightToExecute != MyApplicationPermission.PermissionLevel.Yes )
                {
                    throw new System.Exception(Resources.DefaultResource.PERMISSION_DENY__EXECUTE);
                }

                using (DataView __dv_Report = (this.Session["JOBSTATISTIC_REPORT__DATASOURCE"] as DataView) )
                {
                    if (__dv_Report.Count > 0)
                    {
                        using (StructOfStatisticReport __struct_Report = new StructOfStatisticReport())
                        {
                            __struct_Report.Sender = __guc.Name;

                            foreach (DataRowView __dr_report_Row in __dv_Report)
                            {
                                using (StatisticRecord __struct_Record = new StatisticRecord())
                                {
                                    __struct_Record.JobID = __dr_report_Row["列印檔案名稱"].ToString();
                                    __struct_Record.UserName = __dr_report_Row["列印人員"].ToString();
                                    __struct_Record.DatePrinted = __dr_report_Row["列印日期/時間"].ToString();
                                    __struct_Record.TotalPages = __dr_report_Row["列印總頁數"].ToString();
                                    __struct_Record.DeductPages = __dr_report_Row["空白頁數"].ToString();
                                    __struct_Report.Statistics.Add(__struct_Record);
                                }
                            };

                            Common.Instance.SerializeObjectToXmlFile(
                                    __struct_Report,
                                    Path.Combine(new XipsDAL().GetXmlOutputPath(XipsDAL.XmlReportType.StatisticReport), Common.Instance.GetUniqueXmlFileNameByTime()),
                                    System.Text.Encoding.GetEncoding(950)
                            );

                            // Disable [EXOPORT] button
                            this.pnlResultOP.Visible = false;
                            Thread.Sleep(200);

                            //ScriptManager ___my_SM = ScriptManager.GetCurrent(this.Page);
                            ScriptManager.RegisterClientScriptBlock(this, typeof(string), "", "<script>alert('報表匯出完成.');</script>", false);
                        }
                    }
                }            
            }
            catch (Exception __exp)
            {
                this.lblError.Text = __exp.Message;
                this.pnlErrorMsg.Visible = true;
            }
        }

    }
}