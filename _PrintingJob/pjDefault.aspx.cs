using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using System.Linq;
using System.Xml;
using System.Xml.Serialization;
using System.Threading;

using XIPS.Data;
//using CMP.ComposePrint;

namespace XIPS._PrintingJob
{
    public partial class _pjDefault : System.Web.UI.Page
    {

        private UserCredential __guc;
        private MyApplicationPermission __gmap;

        protected void Page_PreInit(object sender, EventArgs e)
        {
            __guc = this.Session["XIPS_ENV__USER_CREDENTIAL_CLASS"] as UserCredential;
            __gmap = new MyApplicationPermission(MyApplicationPermission.ApplicationName.Print, __guc);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.Page.Title = Resources.DefaultResource.PAGE_TITLE__PRINT_JOB;

                this.pnlResult.Visible = false;
                this.pnlResultFail.Visible = false;
                this.pnlResultOk.Visible = false;
                this.ViewState["XIPS__PRINT_JOB_STATE"] = "";

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

                // function CancelAsyncPostBack()
                __sbjs.Append("function CancelAsyncPostBack() {\n");
                __sbjs.Append("if( ____prm.get_isInAsyncPostBack() ) { ____prm.abortPostBack(); }\n");
                __sbjs.Append("}\n\n");

                //function InitializeRequestHandler(sender, args)
                __sbjs.Append("function InitializeRequestHandler(sender, args) {\n");
                __sbjs.Append("if( ____prm.get_isInAsyncPostBack() ) { args.set_cancel(true); }\n");
                __sbjs.Append("__postbackElement=args.get_postBackElement();\n");
                __sbjs.Append("if( __postbackElement && __postbackElement.id=='" + this.btnPrint.ClientID + "' ) {\n");
                __sbjs.Append("if( $get('" + this.pnlResult.ClientID + "') ) {$get('" + this.pnlResult.ClientID + "').style.visibility ='hidden';} \n");
                __sbjs.Append("if( $get('" + this.UpdateProgress1.ClientID + "') ) {$get('" + this.UpdateProgress1.ClientID + "').style.display='block'; }\n");
                __sbjs.Append("$(\"#divProcess\").css({\"position\": \"absolute\", \"display\": \"block\",\"z-index\": \"9999\"});\n");
                __sbjs.Append("$(\"#divProcess\").css(\"top\", ( $(window).height() - $(\"#divProcess\").height() ) / 2 + \"px\");\n");
                __sbjs.Append("$(\"#divProcess\").css(\"left\", ( $(window).width() - $(\"#divProcess\").width() ) / 2 + \"px\");\n");
                __sbjs.Append("$('#divProcess').css({'top': ( $(window).height()-$('#divProcess').height() )/2+$(window).scrollTop()+'px','left': ( $(window).width()-$('#divProcess').width() )/2+$(window).scrollLeft()+'px','display': 'block','z-index': '9999'});\n");

                ////__sbjs.Append("if( $get('divProcess') ) {\n");
                ////__sbjs.Append("var __divProgress=$get('divProcess'); \n");
                ////__sbjs.Append("__divProgress.style.display='block'; \n");
                ////__sbjs.Append("__divProgress.style.zIndex=9999; \n");
                ////__sbjs.Append("__divProgress.style.top= (viewportHeight() - __divProgress.offsetHeight)/2 +\"px\"; \n");
                ////__sbjs.Append("__divProgress.style.left= (viewportWidth() - __divProgress.offsetWidth )/2 +\"px\"; \n");
                ////__sbjs.Append("}\n");
                __sbjs.Append("$('#divMaskFrame').css({'top': '0','left': '0','display': 'block','z-index': '9998','height': $(window).height() +'px','width': $(window).width()+'px'});\n");

                ////__sbjs.Append("if( $get('divMaskFrame') ) {\n");
                ////__sbjs.Append("var __divMaskFrame=$get('divMaskFrame'); \n");
                ////__sbjs.Append("__divMaskFrame.style.display='block'; \n");
                ////__sbjs.Append("__divMaskFrame.style.zIndex=9998; \n");
                ////__sbjs.Append("__divMaskFrame.style.top=0; \n");
                ////__sbjs.Append("__divMaskFrame.style.left=0; \n");
                ////__sbjs.Append("__divMaskFrame.style.height=  document.documentElement.clientHeight+\"px\"; \n");
                ////__sbjs.Append("__divMaskFrame.style.width= document.documentElement.clientWidth+\"px\"; \n");
                ////__sbjs.Append("}\n");

                __sbjs.Append("}\n}\n\n");

                // function BeginRequestHandler(sender, args)
                __sbjs.Append("function BeginRequestHandler(sender, args) {\n");
                __sbjs.Append("if (__postbackElement && __postbackElement.id=='" + this.btnPrint.ClientID + "') {\n");
                __sbjs.Append("if( $get('" + this.pnlPrint.ClientID + "') ) {var __pnlPrint=$get('" + this.pnlPrint.ClientID + "'); __pnlPrint.disabled=true; __pnlPrint.style.cursor='wait'; }\n");
                __sbjs.Append("document.body.style.cursor='wait'; \n");
                __sbjs.Append("}\n}\n\n");

                //function EndRequestHandler(sender, args) 
                __sbjs.Append("function EndRequestHandler(sender, args) {\n");
                __sbjs.Append("if (__postbackElement && __postbackElement.id=='" + this.btnPrint.ClientID + "') {\n");
                __sbjs.Append("if( $get('" + this.pnlPrint.ClientID + "') ) {var __pnlPrint=$get('" + this.pnlPrint.ClientID + "'); __pnlPrint.disabled=false; __pnlPrint.style.cursor='default'; }\n");
                __sbjs.Append("if( $get('" + this.pnlResult.ClientID + "') ) {$get('" + this.pnlResult.ClientID + "').style.visibility ='visible';}\n");
                __sbjs.Append("document.body.style.cursor='default';\n");
                __sbjs.Append("if( $get('" + this.UpdateProgress1.ClientID + "') ) {$get('" + this.UpdateProgress1.ClientID + "').style.display='none';}\n");
                __sbjs.Append("}\n}\n");
                __sbjs.Append("// -->\n");
                __sbjs.Append("</script> \n");
                this.ClientScript.RegisterStartupScript(this.GetType(), "ajaxProcress", __sbjs.ToString(), false);
            }

            if (__gmap.RightToExecute != MyApplicationPermission.PermissionLevel.Yes && this.FindControl("btnQuery") != null)
            {
                (this.FindControl("btnQuery") as Button).Enabled = false;
            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            this.pnlResult.Visible = true;
            this.pnlResultFail.Visible = false;
            this.pnlResultOk.Visible = false;

            try
            {
                if (__gmap.RightToExecute != MyApplicationPermission.PermissionLevel.Yes)
                {
                    throw new System.Exception(Resources.DefaultResource.PERMISSION_DENY__EXECUTE);
                }

                using (DataView __dv_CD = this.sqlDS_ComposeDetail.Select(new DataSourceSelectArguments()) as DataView)
                {
                    //
                    // Prevent from user pressing F5 to refresh page or page cache
                    //
                    if (this.ViewState["XIPS__PRINT_JOB_STATE"].ToString() == "OK")
                    {
                        //ScriptManager ___my_SM = ScriptManager.GetCurrent(this.Page); 
                        string ___js = "<script>window.location='pjDefault.aspx';</script>";
                        ScriptManager.RegisterClientScriptBlock(this, typeof(string), "", ___js, false);
                        throw new Exception(Resources.DefaultResource.MSG__RESULT_PRINT_INVALID);
                    }


                    if (__dv_CD.Count == 0)
                        throw new System.Exception("無配頁設定檔資料.");

                    if (this.ddlPrinterInfo.SelectedIndex < 0)
                    {
                        this.ddlPrinterInfo.Focus();
                        throw new Exception("請指定輸出設備.");
                    }


                    //
                    // Printer_Information: new requirement V2.3
                    //
                    string[] __printInfo = ddlPrinterInfo.SelectedItem.Value.Split(new string[] { "::" }, StringSplitOptions.RemoveEmptyEntries);

                    if (__printInfo.Length != 2)
                    {
                        this.ddlPrinterInfo.Focus();
                        throw new System.Exception("輸出設備錯誤. 無法正確解析印表機 IP Address 與 Quene 名稱. Quene 名稱不可包含字元 :: .");
                    }

                    // Create PrintJob
                    using (StructOfPrintJob __printjob = new StructOfPrintJob())
                    {
                        __printjob.Sender = __guc.Name;
                        __printjob.ComposeID = this.ddlComposeMaster.SelectedItem.Value;
                        __printjob.SubsetOffset = this.rbl_SubsetOffset.SelectedValue.ToString();
                        __printjob.TotalSet = string.Empty;
                        __printjob.PrinterIpAddress = __printInfo[0].Trim();
                        __printjob.PrintQueue = __printInfo[1].Trim();


                        int ___itemIndex = 0;

                        foreach (DataRowView __dr_row in __dv_CD)
                        {
                            using (PrintItem __printitem = new PrintItem())
                            {
                                //HtmlInputText __txtbox = (HtmlInputText)this.repeater_ComposeDetail.Items[___itemIndex].FindControl(string.Format("txtDataFile_{0}", ___itemIndex + 1));
                                __printitem.PDF = ((TextBox)this.repeater_ComposeDetail.Items[___itemIndex++].FindControl("txtDataFile")).Text.Trim();

                                ///
                                /// Verify by CMP.ComposePrint.Verification.VerifyXML() function
                                ///
                                //if (__printitem.PDF.Length == 0)
                                //{
                                //    throw new System.Exception(string.Format(Resources.DefaultResource.MSG__ERROR_NO_DATAFILE, ___itemIndex));
                                //}

                                __printitem.ID = __dr_row["ItemID"].ToString();
                                __printitem.PrintMethod = __dr_row["PrintMethod"].ToString();
                                __printitem.PaperPerSet = __dr_row["PaperPerSet"].ToString();
                                __printitem.Tray = __dr_row["TrayID"].ToString();

                                using (PrintOffset __printoffset = new PrintOffset())
                                {
                                    __printoffset.X = __dr_row["OffsetX"].ToString();
                                    __printoffset.Y = __dr_row["OffsetY"].ToString();
                                    __printitem.Offset = __printoffset;
                                }

                                using (PrintPaper __printpaper = new PrintPaper())
                                {
                                    __printpaper.Width = __dr_row["PaperWidth"].ToString();
                                    __printpaper.Height = __dr_row["PaperHeight"].ToString();
                                    __printpaper.Weight = __dr_row["PaperWeight"].ToString();
                                    __printpaper.Coated = __dr_row["PaperCoated"].ToString();
                                    __printitem.Paper = __printpaper;
                                }

                                __printjob.ListItems.Add(__printitem);
                            }
                        };

                        #region MyRegion.ObjectSerialization
                        string __serialObjectXml = Common.Instance.SerializeObjectAsXml(__printjob, Encoding.GetEncoding("big5"));

                        // Verify document of output
                        using (CMP.ComposePrint.Verification __cmp = new CMP.ComposePrint.Verification(
                            System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DATACNNSTR__SQLEXP_XIPS"].ConnectionString))
                        {
                            if (__cmp.VerifyXML(ref __serialObjectXml))
                            {
                                Common.Instance.WriteStringToFile(
                                    __serialObjectXml,
                                    Path.Combine(new XipsDAL().GetXmlOutputPath(XipsDAL.XmlReportType.PrintJob), Common.Instance.GetUniqueXmlFileNameByTime()),
                                    Encoding.GetEncoding("big5")
                                );
                            }
                            else
                            {
                                throw new Exception(__cmp.ErrorMessage);
                            }
                        #endregion
                        }

                        #region MyRegion.ObjectSerialization.Sample
                        //string __xmlOutputPath=new XipsDAL().GetXmlOutputPath(XipsDAL.XmlReportType.PrintJob);

                        //// Serialize PrintJob to XML
                        ////XmlSerializer jobSerialier = new XmlSerializer(typeof(PrintJob));
                        ////jobSerialier.UnknownNode += new XmlNodeEventHandler(serializer_UnknownNode);
                        ////jobSerialier.UnknownNode += new XmlNodeEventHandler(serializer_UnknownAttribute);

                        //XmlSerializer jobSerialier = new XmlSerializer(__printjob.GetType());

                        //////
                        ////// (1). Serialize to file (default UTF-8 encoding)
                        //////

                        ////string __XmlOutputFilename = Path.Combine(__xmlOutputPath, Common.Instance.UniqueXMLFileNameForPrintJob());
                        ////FileStream fs = new FileStream(__XmlOutputFilename, FileMode.Create);
                        ////jobSerialier.Serialize(fs, __printjob);
                        ////fs.Close();

                        ////
                        //// (2). Serialize to Big5 string
                        ////

                        //using (StringWriter __stringW = new Big5StringWriter())
                        //{
                        //    jobSerialier.Serialize(__stringW, __printjob);

                        //    using (StreamWriter __streamW = new StreamWriter(Path.Combine(__xmlOutputPath, Common.Instance.UniqueXMLFileNameForPrintJob()), false, Encoding.GetEncoding("big5")))
                        //    {
                        //        __streamW.Write(__stringW.ToString());
                        //        __streamW.Flush();
                        //        __streamW.Close();
                        //    }
                        //}


                        //////
                        ////// (3). Serialize to memory stream, and write to file from memory stream (default UTF-8 encoding)
                        //////

                        ////using (MemoryStream __ms = new MemoryStream())
                        ////{
                        ////    jobSerialier.Serialize(__ms, __printjob);

                        ////    // Verify printjob XML schema                            
                        ////    if (true)
                        ////    {
                        ////        using (FileStream __fs = new FileStream(Path.Combine(__xmlOutputPath, Common.Instance.UniqueXMLFileNameForPrintJob()), FileMode.Create, FileAccess.Write))
                        ////        {
                        ////            byte[] __data = __ms.ToArray();
                        ////            __fs.Write(__data, 0, __data.Length);
                        ////            __fs.Flush();
                        ////            __fs.Close();
                        ////        }
                        ////    }
                        ////    else
                        ////    {
                        ////        throw new Exception("Error from Andy's DLL ");
                        ////    }
                        ////}


                        //// 
                        ////(4). Serialize to XmlWriter with XmlWriterSettings (encoding handle)
                        ////
                        ////Thread.Sleep(1000);
                        ////
                        //XmlWriterSettings xmlWriterSettings = new XmlWriterSettings
                        //{
                        //    Indent = true,
                        //    OmitXmlDeclaration = false,
                        //    Encoding = Encoding.GetEncoding("big5"),
                        //    NewLineOnAttributes=true
                        //};

                        //using (MemoryStream __ms = new MemoryStream())
                        //{
                        //    using (XmlWriter __xmlWriter = XmlWriter.Create(__ms, xmlWriterSettings))
                        //    {
                        //        jobSerialier.Serialize(__xmlWriter, __printjob);

                        //        // rewind the stream before reading back.
                        //        __ms.Position = 0;


                        //        using (StreamWriter __streamW = new StreamWriter(Path.Combine(__xmlOutputPath, Common.Instance.GetUniqueXmlFileNameByTime()), false, Encoding.GetEncoding("big5")))
                        //        {
                        //            //using (StreamReader sr = new StreamReader(__ms, Encoding.GetEncoding("big5")))
                        //            //{
                        //            //    __streamW.Write(sr.ReadToEnd());
                        //            //    // note memory stream disposed by StreamReaders Dispose()
                        //            //}  
                        //            //
                        //            // either way to save XML file.
                        //            __streamW.Write(Encoding.GetEncoding("big5").GetString(__ms.ToArray()));
                        //            __streamW.Flush();
                        //            __streamW.Close();
                        //        }
                        //    }
                        //}
                        #endregion
                    }

                    // Mark the flag when Job is finish. 
                    this.ViewState["XIPS__PRINT_JOB_STATE"] = "OK";
                    this.lblResult.Text = Resources.DefaultResource.MSG__RESULT_PRINT_SUCCESS;
                    this.pnlPrint.Visible = false;
                    this.pnlResultOk.Visible = true;
                }; // End of  using( DataView __dv_CD = this.sqlDS_ComposeDetail.Select(new DataSourceSelectArguments()) as DataView)

                Thread.Sleep(2500);
            }
            catch (Exception __exp)
            {
                this.lblError.Text = Resources.DefaultResource.MSG__RESULT_PRINT_FAILURE + ". " + __exp.Message;
                this.pnlResultFail.Visible = true;
                Thread.Sleep(1000);
            }
        }

        protected void btnPrintNext_Click(object sender, EventArgs e)
        {
            Response.Redirect("pjDefault.aspx");
        }

        protected void repeater_ComposeDetail_PreRender(object sender, EventArgs e)
        {
            //DataSourceSelectArguments __dataArg = new DataSourceSelectArguments();
            //this.sqlDS_ComposeDetail.Select(__dataArg);
            //this.pnlPrint.Visible = __dataArg.TotalRowCount > 0 ? true : false;

            this.pnlPrint.Visible = ((this.sqlDS_ComposeDetail.Select(new DataSourceSelectArguments())) as DataView).Count > 0 ? true : false;
            this.__retrieveComposeMasterDetail();
        }

        protected void repeater_ComposeDetail_ItemCreated(object sender, RepeaterItemEventArgs e)
        {

        }

        protected void ddlCustomer_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.pnlResult.Visible = false;
            this.pnlResultFail.Visible = false;
            this.pnlResultOk.Visible = false;
        }

        protected void ddlComposeMaster_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.pnlResult.Visible = false;
            this.pnlResultFail.Visible = false;
            this.pnlResultOk.Visible = false;
        }

        protected void ddlComposeMaster_DataBound(object sender, EventArgs e)
        {
            try
            {
                this.repeater_ComposeDetail.DataBind();
            }
            catch (Exception _exp)
            {
                this.lblError.Text = _exp.Message;
                this.pnlResultFail.Visible = true;
            }
        }

        /// <summary>
        /// get the details of master compose
        /// </summary>
        protected void __retrieveComposeMasterDetail()
        {
            try
            {
                using (SqlDataSource __sqlDS = new SqlDataSource())
                {
                    __sqlDS.ConnectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DATACNNSTR__SQLEXP_XIPS"].ConnectionString;
                    __sqlDS.SelectCommand = string.Format("SELECT [ComposeName], ISNULL([ComposeDepiction], '') [ComposeDepiction], ISNULL([Subsetoffset], 0) [Subsetoffset] FROM [Compose_Master] WITH(NOLOCK)  WHERE ([ComposeID] = {0})", this.ddlComposeMaster.SelectedValue);
                    __sqlDS.DataSourceMode = SqlDataSourceMode.DataReader;

                    using (SqlDataReader __sqlReader = __sqlDS.Select(DataSourceSelectArguments.Empty) as SqlDataReader)
                    {
                        if (__sqlReader != null && __sqlReader.Read())
                        {
                            this.rbl_SubsetOffset.SelectedValue = __sqlReader["Subsetoffset"].ToString();
                            this.txtComposeDepiction.Text = __sqlReader["ComposeDepiction"].ToString();
                        }
                        else
                        {
                            this.rbl_SubsetOffset.SelectedValue = "0";
                            this.txtComposeDepiction.Text = string.Empty;
                        }
                    }
                }
            }
            catch (Exception __exp)
            {
                this.rbl_SubsetOffset.SelectedValue = "0";
                this.txtComposeDepiction.Text = string.Empty;
                this.lblError.Text = __exp.Message;
                this.pnlResultFail.Visible = true;
            }
        }


}

    //public class Big5StringWriter : StringWriter
    //{
    //    public override Encoding Encoding
    //    {
    //        // Set encoding to big5
    //        get { return Encoding.GetEncoding(950); }
    //    }
    //}

    //private void serializer_UnknownNode(object sender, XmlNodeEventArgs e)
    //{
    //}

    //private void serializer_UnknownAttribute(object sender, XmlNodeEventArgs e)
    //{
    //}

}