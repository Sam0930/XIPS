using System;
using System.Web.UI.WebControls;
using XIPS.Data;

namespace XIPS._StockLibrary
{
    public partial class _slDetail : System.Web.UI.Page
    {
        private UserCredential  __guc;
        private MyApplicationPermission __gmap;
 
        protected void Page_PreInit(object sender, EventArgs e)
        {
            __guc = this.Session["XIPS_ENV__USER_CREDENTIAL_CLASS"] as UserCredential;
            __gmap = new MyApplicationPermission(MyApplicationPermission.ApplicationName.StockLibrary, __guc);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            this.pnlErrorMsg.Visible = false;
            this.lblError.Text = string.Empty;

            if (!this.IsPostBack)
            {
                this.Page.Title = Resources.DefaultResource.PAGE_TITLE__STOCK_LIBRARY;

                if (this.Request["Mode"] != null)
                {
                    switch (this.Request["Mode"].ToString().ToUpper())
                    {
                        case "INSERT":
                            this.ViewState["PAGE_REDIRECT_COMMAND"] = "INSERT";
                            this.FormView1.DefaultMode = FormViewMode.Insert;
                            break;
                        case "UPDATE":
                            this.ViewState["PAGE_REDIRECT_COMMAND"] = "UPDATE";
                            this.FormView1.DefaultMode = FormViewMode.Edit;
                            break;
                        default:
                            this.ViewState["PAGE_REDIRECT_COMMAND"] = string.Empty;
                            this.FormView1.DefaultMode = FormViewMode.ReadOnly;
                            break;
                    }
                }
                else
                {
                    this.ViewState["PAGE_REDIRECT_COMMAND"] = string.Empty;
                    this.FormView1.DefaultMode = FormViewMode.ReadOnly;
                }

                this.FormView1.HeaderText = Common.Instance.getFormViewModeDepiction(this.FormView1.CurrentMode, Resources.DefaultResource.PAGE_TITLE__STOCK_LIBRARY);
             }

            //Set button's permission on <ItemTemplate> 
            if(this.FormView1.CurrentMode== FormViewMode.ReadOnly)
            {
                if (__gmap.RightToInsert != MyApplicationPermission.PermissionLevel.Yes && this.FormView1.FindControl("btnAdd")!=null)
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

        protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            if (e.Exception == null)
            {
                // Redirect back to list page after updating data
                if (this.ViewState["PAGE_REDIRECT_COMMAND"].ToString().Length > 0)
                    this.btnBackToMain_Click(sender, e);
            }
            else
            {
                e.ExceptionHandled = true;
                e.KeepInEditMode = true;
                this.pnlErrorMsg.Visible = true;
                this.lblError.Text = e.Exception.Message;
            }
        }

        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            if (e.Exception == null)
            {
                this.btnBackToMain_Click(sender, e);            
            }
            else
            {
                e.ExceptionHandled = true;
                e.KeepInInsertMode = true;
                this.pnlErrorMsg.Visible = true;
                this.lblError.Text = e.Exception.Message;
            }
        }

        protected void FormView1_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            if (e.Exception == null)
            {
                this.btnBackToMain_Click(sender, e);            
            }
            else
            {
                e.ExceptionHandled = true;
                this.pnlErrorMsg.Visible = true;
                this.lblError.Text = e.Exception.Message;
            }
        }

        protected void btnBackToMain_Click(object sender, EventArgs e)
        {
            this.ViewState["PAGE_REDIRECT_COMMAND"] = string.Empty;
            Response.Redirect("../_StockLibrary/slDefault.aspx");
            Response.End();
        }

        protected void FormView1_ItemDeleting(object sender, FormViewDeleteEventArgs e)
        {
            try
            {
                //Double check user permissiomn to delete data
                if (__gmap.RightToDelete != MyApplicationPermission.PermissionLevel.Yes)
                     throw new Exception( Resources.DefaultResource.PERMISSION_DENY__DELETE);

                // Validate to delete User.
                using (XipsDAL __xips = new XipsDAL())
                {
                    if (! __xips.ValidateToDeleteStockLibrary(e.Keys["StockID"].ToString()) )
                        throw new Exception(Resources.DefaultResource.MSG__ERROR_DELETE_DATA_INUSE);
                }
            }
            catch(Exception deleteExp)
            {
                e.Cancel = true;
                this.pnlErrorMsg.Visible = true;
                this.lblError.Text = deleteExp.Message;
            }
        }

        ///
        ///<InsertParameters>
        ///<asp:Parameter Name="StockName" Type="String" />
        ///<asp:Parameter Name="StockDepiction" Type="String" />
        ///<asp:Parameter Name="StockWidth" Type="Int16" />
        ///<asp:Parameter Name="StockHeight" Type="Int16" />
        ///<asp:Parameter Name="StockWeight" Type="Int16" />
        ///<asp:Parameter Name="StockCoated" Type="Int16" />
        ///<asp:Parameter Name="Creator" Type="String" />
        ///<asp:Parameter Name="Modifier" Type="String" />
        ///<asp:Parameter Name="DateCreated" Type="DateTime" />
        ///<asp:Parameter Name="DateLastUpdated" Type="DateTime" />
        ///</InsertParameters>
        ///
        protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
        {
            try
            {
                //Double check user permissiomn to Insert data 
                if( __gmap.RightToInsert != MyApplicationPermission.PermissionLevel.Yes ) 
                    throw new System.Exception(Resources.DefaultResource.PERMISSION_DENY__INSERT);
  
                short __value = 0;

                // Specify the default value
                e.Values["Creator"] =__guc.ID;            
                e.Values["Modifier"] =__guc.ID;   
                e.Values["DateCreated"] = DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss");
                e.Values["DateLastUpdated"] = DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss");

                //Check the mandatory fieldsd
                if( e.Values[0].ToString().Trim().Length == 0 )
                    throw new System.Exception("請輸入紙張名稱");

                //if (e.Values[1].ToString().Trim().Length == 0)
                //    throw new System.Exception("請輸入紙張描述");

                if (!Int16.TryParse(e.Values[2].ToString(), out __value))
                    throw new System.Exception("請輸入正確的紙張寬度");

                if (!Int16.TryParse(e.Values[3].ToString(), out __value))
                    throw new System.Exception("請輸入正確的紙張高度");

                if (!Int16.TryParse(e.Values[4].ToString(), out __value))
                    throw new System.Exception("請輸入正確的紙張重量");

                if (!Int16.TryParse(e.Values[5].ToString(), out __value))
                    throw new System.Exception("請點選紙張塗布");
            }
            catch (Exception __InsertEXP)
            {
                e.Cancel = true;
                this.pnlErrorMsg.Visible = true;
                this.lblError.Text = __InsertEXP.Message;
            }
        }

        ///
        ///<UpdateParameters>
        ///<asp:Parameter Name="StockName" Type="String" />
        ///<asp:Parameter Name="StockDepiction" Type="String" />
        ///<asp:Parameter Name="StockWidth" Type="Int16" />
        ///<asp:Parameter Name="StockHeight" Type="Int16" />
        ///<asp:Parameter Name="StockWeight" Type="Int16" />
        ///<asp:Parameter Name="StockCoated" Type="Int16" />
        ///<asp:Parameter Name="Modifier" Type="String" />
        ///<asp:Parameter Name="DateLastUpdated" Type="DateTime" />
        ///<asp:Parameter Name="StockID" Type="Int32" />
        ///</UpdateParameters>        
        ///
        protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {   
            try
            {
                if (__gmap.RightToUpdate != MyApplicationPermission.PermissionLevel.Yes)
                    throw new System.Exception(Resources.DefaultResource.PERMISSION_DENY__UPDATE);

                short __value = 0;

                // Specify the default value
                e.NewValues["Modifier"]  = __guc.ID;   
                e.NewValues["DateLastUpdated"] = DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss");

                // Check the mandatory fieldsd
                if (e.NewValues[0].ToString().Trim().Length == 0)
                    throw new System.Exception("請輸入紙張名稱");

                //if (e.NewValues[1].ToString().Trim().Length == 0)
                //    throw new System.Exception("請輸入紙張描述");

                if (!Int16.TryParse(e.NewValues[2].ToString(), out __value))
                    throw new System.Exception("請輸入正確的紙張寬度");

                if (!Int16.TryParse(e.NewValues[3].ToString(), out __value))
                    throw new System.Exception("請輸入正確的紙張高度");

                if (!Int16.TryParse(e.NewValues[4].ToString(), out __value))
                    throw new System.Exception("請輸入正確的紙張重量");

                if (!Int16.TryParse(e.NewValues[5].ToString(), out __value))
                    throw new System.Exception("請點選紙張塗布");
            }
            catch (Exception __UpdateEXP)
            {
                e.Cancel = true;
                this.pnlErrorMsg.Visible = true;
                this.lblError.Text = __UpdateEXP.Message;
            }
        }

        protected void FormView1_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            switch(e.CommandName)
            {
                case "New":
                    // Begin to add data
                    // Do nothing here
                    break;
                case "Edit":
                    // Begin to update data
                    // Do nothing
                    break;
                case "Delete":
                    // Confirm to delete data
                    // Do nothing here
                    break;
                case "Insert":
                    // Commit to insert data
                    // Do nothing here
                    break;
                case "Update":
                    // Commit to update data
                    // Do nothing here
                    break;
                case "Cancel":
                    // Cancel Insert/Update data
                    if (this.ViewState["PAGE_REDIRECT_COMMAND"].ToString().Length > 0)
                    {
                        this.btnBackToMain_Click(sender, e);
                    }
                    break;
                default:
                    break;
            };
        }

        protected void FormView1_ModeChanging(object sender, FormViewModeEventArgs e)
        {
            try
            {
                if (e.NewMode== FormViewMode.Edit && __gmap.RightToUpdate != MyApplicationPermission.PermissionLevel.Yes)
                    throw new System.Exception(Resources.DefaultResource.PERMISSION_DENY__UPDATE);

                if (e.NewMode == FormViewMode.Insert && __gmap.RightToInsert != MyApplicationPermission.PermissionLevel.Yes)
                    throw new System.Exception(Resources.DefaultResource.PERMISSION_DENY__INSERT);

                this.FormView1.HeaderText = Common.Instance.getFormViewModeDepiction(e.NewMode, Resources.DefaultResource.PAGE_TITLE__STOCK_LIBRARY);                        
            }
            catch (Exception __PermissionExp)
            {
                e.Cancel = true;
                this.pnlErrorMsg.Visible = true;
                this.lblError.Text = __PermissionExp.Message;
            }
        }

    }
}