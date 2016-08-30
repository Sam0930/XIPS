using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using XIPS.Data;

namespace XIPS._Compose
{
    public partial class _compDetail : System.Web.UI.Page
    {
        private UserCredential __guc;
        private MyApplicationPermission __gmap;

        protected void Page_PreInit(object sender, EventArgs e)
        {
            __guc = this.Session["XIPS_ENV__USER_CREDENTIAL_CLASS"] as UserCredential;
            __gmap = new MyApplicationPermission(MyApplicationPermission.ApplicationName.Compose, __guc);
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!this.IsPostBack)
            {
                this.Page.Title = Resources.DefaultResource.PAGE_TITLE__COMPOSE;

                if (this.Request["ComposeID"] != null)
                {
                    this.hid_Request_ComposeID.Value = this.Request["ComposeID"].ToString();
                }

                // Initiate page statement
                if (this.Request["Mode"] == null || this.Request["Mode"].ToString().Length == 0 )
                {
                    //this.ViewState["PAGE_REDIRECT_COMMAND"] = "INSERT";
                    //this.FormView1.DefaultMode = FormViewMode.Insert;                     
                    this.ViewState["PAGE_REDIRECT_COMMAND"] = string.Empty;
                    this.FormView1.DefaultMode = FormViewMode.ReadOnly;
                    this.pnlComposeMaster.Enabled = true;
                    this.pnlComposeDetail.Enabled = true;
                    this.pnlComposeDetail.Visible = true;
                    this.pnlNewComposeDetailWindow.Visible = false;
                    this.btnNewComposeDetail.Visible = true;
                    this.btnNewComposeDetail.Enabled = true;
                }
                else
                {
                    switch (this.Request["Mode"].ToString().ToUpper())
                    {
                        case "INSERT":
                            this.ViewState["PAGE_REDIRECT_COMMAND"] = "INSERT";
                            this.FormView1.DefaultMode = FormViewMode.Insert;
                            this.pnlComposeMaster.Enabled = true;
                            this.pnlComposeDetail.Enabled = false;
                            this.pnlComposeDetail.Visible = false;
                            this.pnlNewComposeDetailWindow.Visible = false;
                            this.btnNewComposeDetail.Visible = false;
                            this.btnNewComposeDetail.Enabled = false;
                            break;
                        case "UPDATE":
                            this.ViewState["PAGE_REDIRECT_COMMAND"] = "UPDATE";
                            this.FormView1.DefaultMode = FormViewMode.Edit;
                            this.pnlComposeMaster.Enabled = true;
                            this.pnlComposeDetail.Enabled = false;
                            this.pnlComposeDetail.Visible = true;
                            this.pnlNewComposeDetailWindow.Visible = false;
                            this.btnNewComposeDetail.Visible = true;
                            this.btnNewComposeDetail.Enabled = false;
                            break;
                        default:
                            this.ViewState["PAGE_REDIRECT_COMMAND"] = string.Empty;
                            this.FormView1.DefaultMode = FormViewMode.ReadOnly;
                            this.pnlComposeMaster.Enabled = true;
                            this.pnlComposeDetail.Enabled = true;
                            this.pnlComposeDetail.Visible = true;
                            this.pnlNewComposeDetailWindow.Visible = false;
                            this.btnNewComposeDetail.Visible = true;
                            this.btnNewComposeDetail.Enabled = true;
                            break;
                    };
                }
  
                this.pnlFormViewError.Visible = false;
                this.lblFormViewError.Text = string.Empty;
                this.pnlGridViewError.Visible = false;
                this.lblGridViewError.Text = string.Empty;
                this.FormView1.HeaderText = Common.Instance.getFormViewModeDepiction(this.FormView1.CurrentMode, Resources.DefaultResource.PAGE_TITLE__COMPOSE);
            }

            //Set button's permission on <ItemTemplate> 
            if (this.FormView1.CurrentMode == FormViewMode.ReadOnly)
            {
                if (__gmap.RightToInsert != MyApplicationPermission.PermissionLevel.Yes && this.FormView1.FindControl("btnAdd") != null)
                {
                    (this.FormView1.FindControl("btnAdd") as Button).Enabled = false;
                }

                if (__gmap.RightToUpdate != MyApplicationPermission.PermissionLevel.Yes && this.FormView1.FindControl("btnEdit") != null)
                {
                    (this.FormView1.FindControl("btnEdit") as Button).Enabled = false;
                }

                if (__gmap.RightToDelete != MyApplicationPermission.PermissionLevel.Yes && this.FormView1.FindControl("btnDelete") != null)
                {
                    (this.FormView1.FindControl("btnDelete") as Button).Enabled = false;
                }
            }           
       }

        protected void btnBackToMain_Click(object sender, EventArgs e)
        {
            this.ViewState["PAGE_REDIRECT_COMMAND"] = string.Empty;
            Response.Redirect("../_Compose/compDefault.aspx");
            Response.End();
        }

        /// <summary>
        /// manually change EditMode to "Readonly" if request from list page
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                e.KeepInEditMode = true;
                this.pnlFormViewError.Visible = true;
                this.lblFormViewError.Text = e.Exception.Message;
            }
            else
            {
                //manually change EditMode to "Readonly" if request from list page
                if (this.ViewState["PAGE_REDIRECT_COMMAND"].ToString().Length > 0)
                {
                    this.FormView1.DefaultMode = FormViewMode.ReadOnly;
                }

                this.pnlComposeDetail.Enabled = true;
                this.pnlComposeDetail.Visible = true;
                this.btnNewComposeDetail.Visible = true;
                this.btnNewComposeDetail.Enabled = true;
            }
        }

        /// <summary>
        /// manually change EditMode to "Readonly" if request from list page
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                e.KeepInInsertMode = true;
                this.pnlFormViewError.Visible = true;
                this.lblFormViewError.Text = e.Exception.Message;
            }
            else
            {
                try
                {
                    this.FormView1.DefaultMode = FormViewMode.ReadOnly;

                    using (XipsDAL __xips = new XipsDAL())
                    {
                        if ((this.hid_Request_ComposeID.Value = __xips.GetLastComposeID()) == string.Empty)
                        {
                            throw new Exception();
                        }
                    }
                    this.pnlComposeDetail.Enabled = true;
                    this.pnlComposeDetail.Visible = true;
                    this.btnNewComposeDetail.Visible = true;
                    this.btnNewComposeDetail.Enabled = true;
                }
                catch
                {
                    this.btnBackToMain_Click(sender, e);
                }
            }
        }

        protected void FormView1_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                this.pnlFormViewError.Visible = true;
                this.lblFormViewError.Text = e.Exception.Message;
            }
            else
            {
                this.btnBackToMain_Click(sender, e);
            }
        }

        protected void FormView1_ItemDeleting(object sender, FormViewDeleteEventArgs e)
        {
            //Double check user permissiomn to delete data
            if (__gmap.RightToDelete != MyApplicationPermission.PermissionLevel.Yes)
            {
                e.Cancel = true;

                this.pnlFormViewError.Visible = true;
                this.lblFormViewError.Text = Resources.DefaultResource.PERMISSION_DENY__DELETE;
            }
        }

        ///
        ///<InsertParameters>
        ///    <asp:Parameter Name="ComposeName" Type="String" />
        ///    <asp:Parameter Name="ComposeDepiction" Type="String" />
        ///    <asp:Parameter Name="CustomerID" Type="String" />
        ///    <asp:Parameter Name="Creator" Type="String" />
        ///    <asp:Parameter Name="Modifier" Type="String" />
        ///    <asp:Parameter Name="DateCreated" Type="DateTime" />
        ///    <asp:Parameter Name="DateLastUpdated" Type="DateTime" />
        ///</InsertParameters>
        ///
        protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            try
            {
                //Double check user permissiomn to Insert data 
                if (__gmap.RightToInsert != MyApplicationPermission.PermissionLevel.Yes)
                    throw new System.Exception(Resources.DefaultResource.PERMISSION_DENY__INSERT);

                // Specify the default value
                e.Values["Creator"] = __guc.ID;
                e.Values["Modifier"] = __guc.ID;
                e.Values["DateCreated"] = DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss");
                e.Values["DateLastUpdated"] = DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss");

                // Check the mandatory fieldsd
                if (e.Values["ComposeName"].ToString().Trim().Length ==0)
                    throw new System.Exception("請輸入配頁設定名稱");

                if (e.Values["CustomerID"].ToString().Trim().Length == 0)
                    throw new System.Exception("請選擇客戶.");

                //if (e.Values["ComposeDepiction"].ToString().Trim().Length == 0)
                //    throw new System.Exception("請輸入配頁設定描述.");

                if (e.Values["SubsetOffset"].ToString().Trim().Length == 0)
                    throw new System.Exception("請選擇子集是否偏移.");
            }
            catch (Exception __InsertEXP)
            {
                e.Cancel = true;
                this.pnlFormViewError.Visible = true;
                this.lblFormViewError.Text = __InsertEXP.Message;
            }
        }

        ///
        ///<UpdateParameters>
        ///    <asp:Parameter Name="ComposeName" Type="String" />
        ///    <asp:Parameter Name="ComposeDepiction" Type="String" />
        ///    <asp:Parameter Name="CustomerID" Type="String" />
        ///    <asp:Parameter Name="Modifier" Type="String" />
        ///    <asp:Parameter Name="DateLastUpdated" Type="DateTime" />
        ///    <asp:Parameter Name="ComposeID" Type="String" />
        ///</UpdateParameters>        
        ///
        protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            try
            {
                //Double check user permissiomn to Modify data 
                if (__gmap.RightToUpdate != MyApplicationPermission.PermissionLevel.Yes)
                    throw new System.Exception(Resources.DefaultResource.PERMISSION_DENY__UPDATE);

                // Specify the default value            
                e.NewValues["Modifier"] = __guc.ID;
                e.NewValues["DateLastUpdated"] = DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss");

                // Check the mandatory fieldsd
                if (e.NewValues["ComposeName"].ToString().Trim().Length == 0)
                    throw new System.Exception("請輸入配頁設定名稱");

                if (e.NewValues["CustomerID"].ToString().Trim().Length == 0)
                    throw new System.Exception("請選擇客戶.");

                //if (e.NewValues["ComposeDepiction"].ToString().Trim().Length == 0)
                //    throw new System.Exception("請輸入配頁設定描述.");

                if (e.NewValues["SubsetOffset"].ToString().Trim().Length == 0)
                    throw new System.Exception("請選擇子集是否偏移.");
            }
            catch (Exception __UpdateEXP)
            {
                e.Cancel = true;
                this.pnlFormViewError.Visible = true;
                this.lblFormViewError.Text = __UpdateEXP.Message;
            }
        }

        protected void FormView1_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            this.pnlFormViewError.Visible = false;
            this.lblFormViewError.Text = string.Empty;
            this.pnlGridViewError.Visible = false;
            this.lblGridViewError.Text = string.Empty;

            switch (e.CommandName)
            {
                case "New":
                    //<ItemTemplate>
                    // Begin to add data
                    this.pnlComposeDetail.Visible = false;
                    this.pnlComposeDetail.Enabled = false;
                    this.btnNewComposeDetail.Enabled = false;
                    this.btnNewComposeDetail.Visible = true;
                    break;
                case "Edit":
                    //<ItemTemplate>
                    // Begin to update data
                    this.pnlComposeDetail.Visible = true;
                    this.pnlComposeDetail.Enabled = false;
                    this.btnNewComposeDetail.Enabled = false;
                    this.btnNewComposeDetail.Visible = true;
                    break;
                case "Delete":
                    //<ItemTemplate>
                    // Confirm to delete data
                    // Do nothing here
                    break;
                case "Insert":
                    // <InsertItemTemplate>
                    // Commit to insert data
                    // Do nothing here
                    break;
                case "Update":
                    // <EditItemTemplate>
                    // Commit to update data
                    // Do nothing here
                    break;
                case "SaveAs":
                    //<EditItemTemplate>
                    break;
                case "Cancel":
                    //<InsertItemTemplate> && <EditItemTemplate>
                    // Cancel Insert/Update data
                    #region Region.CommandArgument == "Cancel"
                    if (e.CommandArgument.ToString() == "SaveAs")
                    {
                        this.__Duplicate_ComposeSet();
                    }
                    else
                    {
                        //Means page was redirected from default page 
                        if (this.ViewState["PAGE_REDIRECT_COMMAND"].ToString().Length > 0)
                        {
                            // Stay at detail page if canceling update, or return back to the previous page                            
                            if (e.CommandArgument.ToString() == "CancelUpdate")
                            {
                                this.FormView1.DefaultMode = FormViewMode.ReadOnly;
                            }
                            else
                            {
                                // cancel to inesrt new data, return back to list page
                                this.btnBackToMain_Click(sender, e);
                            }
                        }
                    }
                    #endregion

                    this.pnlComposeDetail.Visible = true;
                    this.pnlComposeDetail.Enabled = true;
                    this.btnNewComposeDetail.Enabled = true;
                    this.btnNewComposeDetail.Visible = true;                    
                    break;
                default:
                    break;
            };
        }

        private void __Duplicate_ComposeSet()
        {
            try
            {
                string __newComposeName = string.Empty;
                string __newComposeDepiction = string.Empty;
                string __newCustomerID = string.Empty;
                int __newSubsetOffset = 0;

                if (this.FormView1.FindControl("txtComposeNameEdit") != null) __newComposeName = (this.FormView1.FindControl("txtComposeNameEdit") as TextBox).Text.Trim();
                if (this.FormView1.FindControl("txtComposeDepictionEdit") != null) __newComposeDepiction = (this.FormView1.FindControl("txtComposeDepictionEdit") as TextBox).Text.Trim();
                if (this.FormView1.FindControl("ddlCustomerEdit") != null) __newCustomerID = (this.FormView1.FindControl("ddlCustomerEdit") as DropDownList).SelectedValue;
                if (this.FormView1.FindControl("rbl_SubsetOffset_Edit") != null) __newSubsetOffset = System.Convert.ToInt32((this.FormView1.FindControl("rbl_SubsetOffset_Edit") as RadioButtonList).SelectedValue);

                if (__newComposeName.Length == 0)
                    throw new System.Exception("請輸入配頁設定名稱.");

                using (XipsDAL __xips = new XipsDAL())
                {
                    int ____newCompID = __xips.DuplicateCompose(Convert.ToInt16(this.hid_Request_ComposeID.Value), __newComposeName, __newComposeDepiction, __newSubsetOffset, __newCustomerID, __guc.ID);

                    if (____newCompID > 0)
                    {
                        this.hid_Request_ComposeID.Value = ____newCompID.ToString();
                        this.FormView1.DataBind();
                        this.GridView1.DataBind();
                    }
                    else
                    {
                        throw new Exception(__xips.ErrorMessage);
                    }
                };
            }
            catch (Exception _duperror)
            {
                this.pnlFormViewError.Visible = true;
                this.lblFormViewError.Text = "另存配頁設定檔失敗. " + _duperror.Message;
            }
            finally
            {
                this.FormView1.DefaultMode = FormViewMode.ReadOnly;
                //this.pnlComposeDetail.Visible = true;
                //this.pnlComposeDetail.Enabled = true;
                //this.btnNewComposeDetail.Enabled = true;
                //this.btnNewComposeDetail.Visible = true;
            };
        }

        protected void FormView1_ModeChanging(object sender, FormViewModeEventArgs e)
        {
            try
            {
                if (e.NewMode == FormViewMode.Edit && __gmap.RightToUpdate != MyApplicationPermission.PermissionLevel.Yes)
                    throw new System.Exception(Resources.DefaultResource.PERMISSION_DENY__UPDATE);

                if (e.NewMode == FormViewMode.Insert && __gmap.RightToInsert != MyApplicationPermission.PermissionLevel.Yes)
                    throw new System.Exception(Resources.DefaultResource.PERMISSION_DENY__INSERT);

                this.FormView1.HeaderText = Common.Instance.getFormViewModeDepiction(e.NewMode, Resources.DefaultResource.PAGE_TITLE__COMPOSE);
                this.pnlComposeDetail.Enabled = e.NewMode == FormViewMode.ReadOnly ? true : false;
            }
            catch (Exception __PermissionExp)
            {
                e.Cancel = true;
                this.pnlFormViewError.Visible = true;
                this.lblFormViewError.Text = __PermissionExp.Message;
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            this.pnlFormViewError.Visible = false;
            this.lblFormViewError.Text = string.Empty;
            this.pnlGridViewError.Visible = false;
            this.lblGridViewError.Text = string.Empty;

            try
            {
              switch (e.CommandName)
                {
                    case "Edit":                    
                        //<ItemTemplate>                
                        if (__gmap.RightToUpdate == MyApplicationPermission.PermissionLevel.Yes)
                        {
                            this.pnlComposeMaster.Enabled = false;
                            this.btnNewComposeDetail.Visible = true;
                            this.btnNewComposeDetail.Enabled = false;
                        }
                        else
                        {
                            throw new Exception(Resources.DefaultResource.PERMISSION_DENY__UPDATE);
                        }                    
                        break;
                    case "Delete":
                        //<ItemTemplate>     
                        if (__gmap.RightToDelete != MyApplicationPermission.PermissionLevel.Yes)
                        {
                            throw new Exception(Resources.DefaultResource.PERMISSION_DENY__DELETE);
                        }
                        break;
                    case "Update":
                        //<EditItemTemplate>
                        if (__gmap.RightToUpdate != MyApplicationPermission.PermissionLevel.Yes)
                        {
                            throw new Exception(Resources.DefaultResource.PERMISSION_DENY__UPDATE);
                        }
                        break;
                    case "Cancel":
                        //<EditItemTemplate>
                        this.pnlComposeMaster.Enabled = true;
                        this.btnNewComposeDetail.Enabled = true;
                        this.btnNewComposeDetail.Visible = true;
                        break;
                    case "Decrease":
                        //<ItemTemplate>     
                        using (XipsDAL __xips = new XipsDAL())
                        {
                            if (__xips.SwapComposeItemSequence(e.CommandArgument.ToString(), __guc.ID, XipsDAL.ComposeSequenceMode.DecreaseOrder))
                            {
                                this.GridView1.DataBind();
                            }
                            else
                            {
                                throw new Exception( __xips.ErrorMessage);
                            }
                        }
                        break;
                    case "Increase":
                        //<ItemTemplate>     
                        using (XipsDAL __xips = new XipsDAL())
                        {
                            if (__xips.SwapComposeItemSequence(e.CommandArgument.ToString(), __guc.ID,  XipsDAL.ComposeSequenceMode.IncreaseOrder))
                            {
                                this.GridView1.DataBind();
                            }
                            else
                            {
                               throw new Exception( __xips.ErrorMessage);
                            }
                        }
                        break;
                    //case "Detail":
                    //    break;
                    //case "sort":
                    //    break;
                    //case "Page":
                    //    break;
                    default:
                        break;
                };            
            }
            catch (Exception CommandException)
            {
                this.pnlGridViewError.Visible = true;
                this.lblGridViewError.Text = CommandException.Message;           
            }
        }

        protected void GridView1_PreRender(object sender, EventArgs e)
        {
            //this.pnlResultOP.Visible = true;

            //// Show record count
            //this.lblRecCount.Text = Common.Instance.displayGridviewRecordCount(this.GridView1);
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            //Double check user permissiomn to delete data
            if (__gmap.RightToDelete != MyApplicationPermission.PermissionLevel.Yes)
            {
                e.Cancel = true;

                this.pnlGridViewError.Visible = true;
                this.lblGridViewError.Text = Resources.DefaultResource.PERMISSION_DENY__DELETE;
            }
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                //Double check user permissiomn to Modify data 
                if (__gmap.RightToUpdate != MyApplicationPermission.PermissionLevel.Yes)
                    throw new System.Exception(Resources.DefaultResource.PERMISSION_DENY__UPDATE);

                short __s_value;

                if (e.NewValues["PaperPerSet"] == null || !Int16.TryParse(e.NewValues["PaperPerSet"].ToString(), out __s_value))
                    throw new System.Exception("請輸入列印張數.");


                decimal __d_value;

                if (e.NewValues["OffsetX"] == null || !Decimal.TryParse(e.NewValues["OffsetX"].ToString(), out __d_value))
                    e.NewValues["OffsetX"] = 0;

                if (e.NewValues["OffsetY"] == null || !Decimal.TryParse(e.NewValues["OffsetY"].ToString(), out __d_value))
                    e.NewValues["OffsetY"] = 0;

                e.NewValues["UserID"] = this.__guc.ID;

                //e.NewValues["Modifier"] = __guc.ID;
                //e.NewValues["DateLastUpdated"] = DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss");                   
            }
            catch (Exception __UpdateEXP)
            {
                e.Cancel = true;
                this.pnlGridViewError.Visible = true;
                this.lblGridViewError.Text = __UpdateEXP.Message;
            }
        }

        protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if (e.Exception != null)
            {
                e.ExceptionHandled = true;
                this.lblGridViewError.Text = e.Exception.Message;                
                this.pnlGridViewError.Visible = true;

                this.GridView1_RowDataBound(sender, null);
            }
        }
   
        protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.Exception == null)
            {
                //Finish updaing the data
                this.pnlComposeMaster.Enabled = true;
                this.btnNewComposeDetail.Visible = true;                
                this.btnNewComposeDetail.Enabled = true;
            }
            else
            {
                e.ExceptionHandled = true;
                e.KeepInEditMode = true;
                this.lblGridViewError.Text = e.Exception.Message;                
                this.pnlGridViewError.Visible = true;
            }            
        }

        protected void DetailsView1_ItemInserting(object sender, DetailsViewInsertEventArgs e)
        {
            try
            {
                short __value;

                if(e.Values["PaperPerSet"] == null || !Int16.TryParse( e.Values["PaperPerSet"].ToString(), out __value ))
                    throw new System.Exception("請輸入列印張數.");


                decimal __d_value;

                if (e.Values["OffsetX"] == null || !Decimal.TryParse(e.Values["OffsetX"].ToString(), out __d_value))
                    e.Values["OffsetX"] = 0;

                if (e.Values["OffsetY"] == null || !Decimal.TryParse(e.Values["OffsetY"].ToString(), out __d_value))
                    e.Values["OffsetY"] = 0;

                e.Values["ComposeID"] = this.hid_Request_ComposeID.Value;
                e.Values["UserID"] = __guc.ID;

                //e.Values["Creator"] = __guc.ID;
                //e.Values["Modifier"] = __guc.ID;
                //e.Values["DateCreated"] = DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss");
                //e.Values["DateLastUpdated"] = DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss");        
            }
            catch (Exception __InsertEXP)
            {
                e.Cancel = true;
                this.pnlGridViewError.Visible = true;
                this.lblGridViewError.Text = __InsertEXP.Message;
            }      
        }

        protected void DetailsView1_ItemCommand(object sender, DetailsViewCommandEventArgs e)
        {
            this.pnlFormViewError.Visible = false;
            this.lblFormViewError.Text = string.Empty;
            this.pnlGridViewError.Visible = false;
            this.lblGridViewError.Text = string.Empty;

            try
            {
                switch (e.CommandName)
                {
                   case "Insert":
                        //<InsertItemTemplate>
                        if (__gmap.RightToInsert != MyApplicationPermission.PermissionLevel.Yes)
                        {
                            throw new Exception(Resources.DefaultResource.PERMISSION_DENY__INSERT);
                        }
                        break;
                    case "Cancel":
                        //<InsertItemTemplate>
                        this.pnlComposeMaster.Enabled = true;
                        this.pnlComposeDetail.Enabled = true;
                        this.pnlNewComposeDetailWindow.Visible = false;
                        this.btnNewComposeDetail.Visible = true;
                        break;
                    //case "New":
                    //case "Delete":
                    //    break;
                    //case "Update":
                    //    break;
                    //case "Edit":
                    //    break;
                    //case "Page":
                    //    break;
                    default:
                        break;
                };
            }
            catch (Exception CommandException)
            {
                this.pnlGridViewError.Visible = true;
                this.lblGridViewError.Text = CommandException.Message;
            }
        }

        protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            if (e.Exception == null)
            {
                //Manually update the gridview's datasource as using stored procedure
                this.GridView1.DataBind();

                //Finish updaing the data
                this.pnlComposeMaster.Enabled = true;
                this.pnlComposeDetail.Visible = true;
                this.pnlComposeDetail.Enabled = true;
                this.pnlNewComposeDetailWindow.Visible = false;
                this.btnNewComposeDetail.Visible = true;
                this.btnNewComposeDetail.Enabled = true;
            }
            else
            {
                e.ExceptionHandled = true;
                e.KeepInInsertMode = true;
                this.lblGridViewError.Text = e.Exception.Message;
                this.pnlGridViewError.Visible = true;
            }       
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.RowIndex == 0 && e.Row.Cells[1].FindControl("btnSeqDec") != null)
                {
                    ImageButton imgbtnUp = e.Row.Cells[1].FindControl("btnSeqDec") as ImageButton;
                    imgbtnUp.ImageUrl = "../images/up-disable.gif";
                    imgbtnUp.Enabled=false;
                    //(e.Row.Cells[1].FindControl("btnSeqDec") as Button).Enabled = false;
                }
 
                if (e.Row.RowIndex == (this.sqlDS_ComposeDetail.Select(new DataSourceSelectArguments()) as DataView).Count - 1 && e.Row.Cells[1].FindControl("btnSeqInc") != null)
                {
                    ImageButton imgbtnDown = e.Row.Cells[1].FindControl("btnSeqInc") as ImageButton;
                    imgbtnDown.ImageUrl = "../images/down-disable.gif";
                    imgbtnDown.Enabled = false;
                    //(e.Row.Cells[1].FindControl("btnSeqInc") as Button).Enabled = false;
                }
            }
        }        
        
        protected void btnNewComposeDetail_Click(object sender, EventArgs e)
        {
            if (__gmap.RightToInsert == MyApplicationPermission.PermissionLevel.Yes)
            {
                if (this.DetailsView1.FindControl("txtDVPaperPerSetInsert") != null)
                    (this.DetailsView1.FindControl("txtDVPaperPerSetInsert") as TextBox).Text = string.Empty;

                if (this.DetailsView1.FindControl("txtOffsetXInsert") != null)
                    (this.DetailsView1.FindControl("txtOffsetXInsert") as TextBox).Text = string.Empty;

                if (this.DetailsView1.FindControl("txtOffsetYInsert") != null)
                    (this.DetailsView1.FindControl("txtOffsetYInsert") as TextBox).Text = string.Empty;

                if (this.DetailsView1.FindControl("txtOffsetYInsert") != null)
                {
                    int __detail_Cnt = (this.sqlDS_ComposeDetail.Select(new DataSourceSelectArguments()) as DataView).Count;                   
                    DropDownList __ddl_Sequence = this.DetailsView1.FindControl("ddlItemSequenceInsert") as DropDownList;

                    __ddl_Sequence.Items.Clear();

                    for(int __seqInx=1; __seqInx <=__detail_Cnt+1; __seqInx++)
                        __ddl_Sequence.Items.Add(new ListItem(__seqInx.ToString(),__seqInx.ToString()));

                    __ddl_Sequence.SelectedIndex =__detail_Cnt;
                }

                this.pnlComposeMaster.Enabled = false;
                this.pnlComposeDetail.Enabled = false;
                this.pnlNewComposeDetailWindow.Visible = true;
                this.btnNewComposeDetail.Visible = false;
            }
            else
            {
                this.pnlGridViewError.Visible = true;
                this.lblGridViewError.Text = Resources.DefaultResource.PERMISSION_DENY__INSERT;
            }
        }

}
}