using System;
using System.Data;
using System.Data.SqlClient;

namespace XIPS.Data
{
    /// <summary>
    /// XipsData XIPS Data Access Layer
    /// </summary>
    public class XipsDAL: IDisposable
    {
        private bool   m__isDisposed = false;        
        private string m__lastError=string.Empty;
        private string m__db_CNNSTR = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["DATACNNSTR__SQLEXP_XIPS"].ConnectionString;
    
        public enum DataType
        {
            ComposeMaster,
            ComposeDetail,
            StockLibrary,            
            User,
            UserBrief,
            Customer
        }

        public enum ComposeSequenceMode
        {
            IncreaseOrder,
            DecreaseOrder
        }

        public enum XmlReportType
        {
            PrintJob = 1,
            StatisticReport =2
        }

        public XipsDAL()
        {
        }

        ~XipsDAL()
        {
            this.Dispose(false);
        }

        public string ErrorMessage
        {
            get
            {
                return (this.m__lastError);
            }
        }

        public bool ChangeUserPassword(string UserID, string newPass)
        {
            this.m__lastError = string.Empty;
            bool __myReturn = false;

            try
            {
                using (SqlConnection ___sqlCnn = new SqlConnection(m__db_CNNSTR))
                {
                    ___sqlCnn.Open();

                    //using (SqlCommand ___sqlCmd = new SqlCommand(string.Format("UPDATE User_Information SET UserPassword = '{0}' WHERE UserID='{1}'", newPass, UserID), ___sqlCnn))
                    //{
                    //    ___sqlCmd.ExecuteNonQuery();
                    //    __myReturn = true;
                    //}

                    using (SqlCommand ___sqlCmd = new SqlCommand())
                    {
                        ___sqlCmd.Connection = ___sqlCnn;
                        ___sqlCmd.CommandType = CommandType.StoredProcedure;
                        ___sqlCmd.CommandText = "[dbo].[usp__UpdateUserPassword]";
                        ___sqlCmd.Parameters.Add(new SqlParameter("@UserID", SqlDbType.NVarChar,20));
                        ___sqlCmd.Parameters["@UserID"].Direction = ParameterDirection.Input;
                        ___sqlCmd.Parameters["@UserID"].Value = UserID.Trim();
                        ___sqlCmd.Parameters.Add(new SqlParameter("@NewPassword", SqlDbType.NVarChar, 20));
                        ___sqlCmd.Parameters["@NewPassword"].Direction = ParameterDirection.Input;
                        ___sqlCmd.Parameters["@NewPassword"].Value = newPass.Trim();
                        ___sqlCmd.ExecuteNonQuery();
                        __myReturn = true;
                    }
                }
            }
            catch (SqlException dbexp)
            {
                this.m__lastError = "[XipsDAL.ChangeUserPassword] DB.Error : " + dbexp.Message;
            }
            catch (Exception exp)
            {
                this.m__lastError = "[XipsDAL.ChangeUserPassword] Error : " + exp.Message;
            };
            return (__myReturn);
        }

        public DataTable getDetailedList(DataType Type)
        {
            DataTable ____returnDT = new DataTable();
            string ____sql= string.Empty;
           
            this.m__lastError = string.Empty;

            switch (Type)
            {
                case DataType.ComposeMaster:
                    ____sql = @"SELECT T1.ComposeID AS  [項次],  T2.CustomerName AS [客戶名稱], T1.ComposeName AS [配頁名稱], T1.ComposeDepiction AS [配頁描述] 
                                    FROM [Compose_Master] T1  WITH(NOLOCK) LEFT JOIN [Customer_Information] T2  WITH(NOLOCK) ON T1.CustomerID = T2.CustomerID ORDER BY 1";
                    break;
                case DataType.Customer:
                    ____sql = @"SELECT  ROW_NUMBER() OVER(ORDER BY CustomerID ) AS 序號, CustomerID AS 統一編號, CustomerName AS 客戶名稱 
                                    FROM Customer_Information WITH(NOLOCK) ORDER BY   序號";
                    break;
                case DataType.StockLibrary:
                    ____sql = @"SELECT StockID AS [項次], StockName AS [紙張名稱], StockWidth AS [紙張寬度(mm)],
                                    StockHeight AS [紙張高度(mm)], StockWeight AS [紙張重量(gsm)], IIF(StockCoated > 0, '是', '否') AS [紙張塗布] 
                                    FROM [Stock_Library]  WITH(NOLOCK)";
                    break;
                case DataType.User:
                    ____sql = @"SELECT ROW_NUMBER() OVER(ORDER BY UserID ) AS [項次],
                                    T1.UserID AS [使用者代碼], T1.UserName AS [使用者名稱], T2.GroupName AS [使用者群組]
                                    FROM [User_Information] T1  WITH(NOLOCK) LEFT JOIN [Group_Information] T2  WITH(NOLOCK) ON T1.GroupID=T2.GroupID ORDER BY [項次]";
                    break;
                case DataType.UserBrief:
                    ____sql = @"SELECT UserID, UserName FROM User_Information  WITH(NOLOCK)";               
                    break;
                default:
                    throw new System.Exception("Invalid Enumeration Parameter - DataType ");
            };
            
            try
            {
                using (SqlConnection ___sqlCnn = new SqlConnection(m__db_CNNSTR))
                {
                    ___sqlCnn.Open();

                    using (SqlCommand ___sqlCmd = new SqlCommand(____sql, ___sqlCnn))
                    {
                        ___sqlCmd.CommandTimeout = 120;

                        using (SqlDataAdapter ___sqlDA = new SqlDataAdapter(___sqlCmd))
                        {
                            ____returnDT.BeginLoadData();
                            ___sqlDA.Fill(____returnDT);
                            ____returnDT.EndLoadData();
                        }
                    }
                }
            }
            catch (Exception exp)
            {
                this.m__lastError = "[XipsDAL.getDetailedList] Error : " + exp.Message;
                throw new Exception(this.m__lastError);
            };

            return (____returnDT);
        }

        public DataTable UserInformation(string UserID)
        {
            DataTable ____returnDT = new DataTable();

            this.m__lastError = string.Empty;
            string ____sql = string.Format(
                @"SELECT T1.UserName, T1.UserPassword, T1.UserDepiction, T1.GroupID, T2.GroupName, T2.GroupDepiction
                FROM [User_Information] T1  WITH(NOLOCK) LEFT JOIN [Group_Information] T2  WITH(NOLOCK) ON T1.GroupID = T2.GroupID WHERE T1.UserID = '{0}'", UserID);

            try
            {
                using (SqlConnection ___sqlCnn = new SqlConnection(m__db_CNNSTR))
                {
                    ___sqlCnn.Open();

                    using (SqlCommand ___sqlCmd = new SqlCommand(____sql, ___sqlCnn))
                    {
                        ___sqlCmd.CommandTimeout = 120;

                        using (SqlDataAdapter ___sqlDA = new SqlDataAdapter(___sqlCmd))
                        {
                            ____returnDT.BeginLoadData();
                            ___sqlDA.Fill(____returnDT);
                            ____returnDT.EndLoadData();
                        }
                    }
                };
            }
            catch (Exception exp)
            {
                this.m__lastError = "[XipsDAL.UserInformation] Error : " + exp.Message;
                throw new Exception(this.m__lastError);
            };

            return (____returnDT);
        }

        public DataTable GroupPermission(String GroupID)
        {
            DataTable ____returnDT = new DataTable();

            this.m__lastError = string.Empty;
            string ____sql = string.Format(
                @"SELECT T1.MPID, T1.SPID, T1.ProgramName, T1.ProgramDepiction, ISNULL(T2.Granted, 0) [Granted] FROM[Program_List] T1  WITH(NOLOCK) 
                LEFT JOIN  [Group_Permission] T2  WITH(NOLOCK) ON T1.MPID = T2.MPID AND  T1.SPID = T2.SPID AND T2.GroupID='{0}'", GroupID);

            try
            {
                using (SqlConnection ___sqlCnn = new SqlConnection(m__db_CNNSTR))
                {
                    ___sqlCnn.Open();

                    using (SqlCommand ___sqlCmd = new SqlCommand(____sql, ___sqlCnn))
                    {
                        ___sqlCmd.CommandTimeout = 120;

                        using (SqlDataAdapter ___sqlDA = new SqlDataAdapter(___sqlCmd))
                        {
                            ____returnDT.BeginLoadData();
                            ___sqlDA.Fill(____returnDT);
                            ____returnDT.EndLoadData();
                        }
                    }
                }
            }
            catch (Exception exp)
            {
                this.m__lastError = "[XipsDAL.GroupPermission] Error : " + exp.Message;
                throw new Exception(this.m__lastError);
            };

            return (____returnDT);
        }
        
        public DataTable JobStatisticReport(DateTime Start, DateTime End, string UserID)
        {
            DataTable ____returnDT = new DataTable();

            this.m__lastError=string.Empty;
            string ____sql = string.Format(
                @"SELECT T1.DatePrinted AS [列印日期/時間], T1.JobID AS [列印檔案名稱], T2.UserName AS [列印人員], T1.TotalPages AS [列印總頁數], T1.DeductPages AS [空白頁數] 
                FROM [Job_Statistic] T1  WITH(NOLOCK) LEFT JOIN [User_Information] T2  WITH(NOLOCK) ON T1.UserID = T2.UserID 
                WHERE T1.DatePrinted >= '{0}' AND T1.DatePrinted <= '{1}' AND T1.UserID {2}", 
                Start.ToString("yyyy/MM/dd 00:00:00"), End.ToString("yyyy/MM/dd 23:59:59"), UserID.Trim().Length>0 ? " = '"+UserID.Trim() +"'": " LIKE '%'");

            try
            {
                using (SqlConnection ___sqlCnn = new SqlConnection(m__db_CNNSTR))
                {
                    ___sqlCnn.Open();

                    using (SqlCommand ___sqlCmd = new SqlCommand(____sql, ___sqlCnn))
                    {
                        ___sqlCmd.CommandTimeout = 300;

                        using (SqlDataAdapter ___sqlDA = new SqlDataAdapter(___sqlCmd))
                        {
                            ____returnDT.BeginLoadData();
                            ___sqlDA.Fill(____returnDT);
                            ____returnDT.EndLoadData();
                        }
                    }
                }
            }
            catch (Exception exp)
            {
                this.m__lastError = "[XipsDAL.JobStatisticReport] Error : " + exp.Message;
                throw new Exception(this.m__lastError);
            };

            return (____returnDT);
        }

        public string GetLastComposeID()
        {
            this.m__lastError = string.Empty;
            string ____composeid = string.Empty;

            try
            {
                using (SqlConnection ___sqlCnn = new SqlConnection(m__db_CNNSTR))
                {
                    ___sqlCnn.Open();

                    using (SqlCommand ___sqlCmd = new SqlCommand(@"SELECT TOP 1 ComposeID FROM [Compose_Master] WITH (NOLOCK) ORDER BY ComposeID DESC", ___sqlCnn))
                    {
                        using (SqlDataReader ___dr = ___sqlCmd.ExecuteReader(CommandBehavior.SingleRow))
                        {
                            while (___dr.Read())
                            {
                                ____composeid = ___dr[0].ToString();
                                break;
                            };
                        }

                    //    using (SqlDataAdapter ___oleda = new SqlDataAdapter(___sqlCmd))
                    //    {
                    //        using (DataTable __dt = new DataTable())
                    //        {
                    //            ___oleda.Fill(__dt);
                    //            ____composeid = __dt.Rows[0][0].ToString();
                    //        }                           
                    //    }

                    }
                };
            }
            catch (SqlException dbexp)
            {
                this.m__lastError = "[XipsDAL.GetLastComposeID] DB.Error : " + dbexp.Message;
            }
            catch (Exception exp)
            {
                this.m__lastError = "[XipsDAL.GetLastComposeID] Error : " + exp.Message;
            };

            return (____composeid);
        }
               
        public string GetXmlOutputPath(XmlReportType ReportType)
        {
            this.m__lastError = string.Empty;
            string ____outputpath = string.Empty;

            try
            {
                using (SqlConnection ___sqlCnn = new SqlConnection(m__db_CNNSTR))
                {
                    ___sqlCnn.Open();

                    using (SqlCommand ___sqlCmd = new SqlCommand(
                        string.Format(@"SELECT TOP 1 [ParameterValue] FROM [System_Parameter]  WITH(NOLOCK) WHERE [Section] = 'XMLPath' AND [ParameterKey] = {0}", (int) ReportType), ___sqlCnn))
                    {
                        using (SqlDataReader ___dr = ___sqlCmd.ExecuteReader(CommandBehavior.SingleRow))
                        {
                            while (___dr.Read())
                            {
                                ____outputpath=___dr[0].ToString();
                                break;
                            };
                        }
                    }
                };
            }
            catch (SqlException dbexp)
            {
                this.m__lastError = "[XipsDAL.GetXmlOutputPath] DB.Error : " + dbexp.Message;
            }
            catch (Exception exp)
            {
                this.m__lastError = "[XipsDAL.GetXmlOutputPath] Error : " + exp.Message;
            };

            return (____outputpath);
        }

        public bool SwapComposeItemSequence(string DetailID, string UserID, ComposeSequenceMode Mode)
        {
            this.m__lastError = string.Empty;
            bool __myReturn = false;

            try
            {
                using (SqlConnection ___sqlCnn = new SqlConnection(m__db_CNNSTR))
                {
                    ___sqlCnn.Open();

                    using (SqlCommand ___sqlCmd = new SqlCommand())
                    {
                        ___sqlCmd.Connection = ___sqlCnn;
                        ___sqlCmd.CommandType = CommandType.StoredProcedure;
                        ___sqlCmd.CommandText = "[dbo].[usp__SwapComposeItemSequence]";
                        ___sqlCmd.CommandTimeout = 60;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int));
                        ___sqlCmd.Parameters["@RETURN_VALUE"].Direction = ParameterDirection.ReturnValue;
                        ___sqlCmd.Parameters["@RETURN_VALUE"].Value = null;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@DetailID", SqlDbType.Int));
                        ___sqlCmd.Parameters["@DetailID"].Direction = ParameterDirection.Input;
                        ___sqlCmd.Parameters["@DetailID"].Value = DetailID;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@Direction", SqlDbType.SmallInt));
                        ___sqlCmd.Parameters["@Direction"].Direction = ParameterDirection.Input;
                        ___sqlCmd.Parameters["@Direction"].Value = Mode == ComposeSequenceMode.IncreaseOrder? 1:0;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@UserID", SqlDbType.NVarChar, 20));
                        ___sqlCmd.Parameters["@UserID"].Direction = ParameterDirection.Input;
                        ___sqlCmd.Parameters["@UserID"].Value = UserID;
                        ___sqlCmd.ExecuteNonQuery();

                        __myReturn = System.Convert.ToInt16(___sqlCmd.Parameters["@RETURN_VALUE"].Value) > 0 ? true : false;
                    }
                }
            }
            catch (SqlException dbexp)
            {
                this.m__lastError = "[XipsDAL.AdjustComposeItemSequence] DB.Error : " + dbexp.Message;
            }
            catch (Exception exp)
            {
                this.m__lastError = "[XipsDAL.AdjustComposeItemSequence] Error : " + exp.Message;
            };
            return (__myReturn);
        }

        /// <summary>
        ///  Duplicate compose master and details
        /// </summary>
        /// <param name="ComposeID"></param>
        /// <param name="NewName"></param>
        /// <param name="NewDepiction"></param>
        /// <param name="NewCustomerID"></param>
        /// <param name="UserID"></param>
        /// <returns> new compose ID</returns>
        /// 
        public int DuplicateCompose(int ComposeID, string Name, string Depiction, int __newSubsetOffset, string CustomerID, string UserID)
        {
            this.m__lastError = string.Empty;
            int __newComposeID=0;
            string __outError = string.Empty;

            try
            {
                using (SqlConnection ___sqlCnn = new SqlConnection(m__db_CNNSTR))
                {
                    ___sqlCnn.Open();             
                    using (SqlCommand ___sqlCmd = new SqlCommand()) 
                    {
                        ___sqlCmd.Connection = ___sqlCnn;
                        ___sqlCmd.CommandType = CommandType.StoredProcedure;
                        ___sqlCmd.CommandText = "[dbo].[usp__DuplicateCompose]";
                        ___sqlCmd.CommandTimeout = 60;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int));
                        ___sqlCmd.Parameters["@RETURN_VALUE"].Direction = ParameterDirection.ReturnValue;
                        ___sqlCmd.Parameters["@RETURN_VALUE"].Value = null;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@SourceComposeID", SqlDbType.Int));
                        ___sqlCmd.Parameters["@SourceComposeID"].Direction = ParameterDirection.Input;
                        ___sqlCmd.Parameters["@SourceComposeID"].Value = ComposeID;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@Name", SqlDbType.NVarChar, 30));
                        ___sqlCmd.Parameters["@Name"].Direction = ParameterDirection.Input;
                        ___sqlCmd.Parameters["@Name"].Value = Name;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@Depiction", SqlDbType.NVarChar, 200));
                        ___sqlCmd.Parameters["@Depiction"].Direction = ParameterDirection.Input;
                        ___sqlCmd.Parameters["@Depiction"].Value = Depiction;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@SubsetOffset", SqlDbType.Int));
                        ___sqlCmd.Parameters["@SubsetOffset"].Direction = ParameterDirection.Input;
                        ___sqlCmd.Parameters["@SubsetOffset"].Value = __newSubsetOffset;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@CustomerID", SqlDbType.NVarChar, 20));
                        ___sqlCmd.Parameters["@CustomerID"].Direction = ParameterDirection.Input;
                        ___sqlCmd.Parameters["@CustomerID"].Value = CustomerID;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@UserID", SqlDbType.NVarChar, 20));
                        ___sqlCmd.Parameters["@UserID"].Direction = ParameterDirection.Input;
                        ___sqlCmd.Parameters["@UserID"].Value = UserID;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@Error", SqlDbType.NVarChar, 200));
                        ___sqlCmd.Parameters["@Error"].Direction = ParameterDirection.Output;
                        ___sqlCmd.Parameters["@Error"].Value = string.Empty;
                        ___sqlCmd.ExecuteNonQuery();

                        __newComposeID = System.Convert.ToInt16(___sqlCmd.Parameters["@RETURN_VALUE"].Value);

                        if (__newComposeID <= 0)
                            throw new System.Exception(___sqlCmd.Parameters["@Error"].Value.ToString().Length > 0 ? ___sqlCmd.Parameters["@Error"].Value.ToString() : "Failed to set the duplicate compose.");                      
                    }
                }
            }
            catch (SqlException dbexp)
            {
                this.m__lastError = "[XipsDAL.DuplicateCompose] DB.Error : " + dbexp.Message;
            }
            catch (Exception exp)
            {
                this.m__lastError = "[XipsDAL.DuplicateCompose] Error : " + exp.Message;
            };

            return (__newComposeID);
        }

        public bool DeleteComposeSet(string ComposeID)
        {
            this.m__lastError = string.Empty;
            bool __myReturn = false;

            try
            {
                using (SqlConnection ___sqlCnn = new SqlConnection(m__db_CNNSTR))
                {
                    ___sqlCnn.Open();
                    using (SqlCommand ___sqlCmd = new SqlCommand())
                    {
                        ___sqlCmd.Connection = ___sqlCnn;
                        ___sqlCmd.CommandType = CommandType.StoredProcedure;
                        ___sqlCmd.CommandText = "[dbo].[usp__DeleteComposeSet]";
                        ___sqlCmd.CommandTimeout = 60;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int));
                        ___sqlCmd.Parameters["@RETURN_VALUE"].Direction = ParameterDirection.ReturnValue;
                        ___sqlCmd.Parameters["@RETURN_VALUE"].Value = null;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@ComposeID", SqlDbType.Int));
                        ___sqlCmd.Parameters["@ComposeID"].Direction = ParameterDirection.Input;
                        ___sqlCmd.Parameters["@ComposeID"].Value = Convert.ToInt16(ComposeID);
                        ___sqlCmd.ExecuteNonQuery();
                        __myReturn = System.Convert.ToInt16(___sqlCmd.Parameters["@RETURN_VALUE"].Value) >0? true:false;
                    }

                    //using (SqlTransaction ___sqlTran = ___sqlCnn.BeginTransaction())
                    //{                   
                    //    using (SqlCommand ___sqlCmd = new SqlCommand()) 
                    //    {
                    //       try
                    //        {
                    //           ___sqlCmd.Transaction = ___sqlTran;
                    //           ___sqlCmd.Connection = ___sqlCnn;
                    //           ___sqlCmd.CommandText = string.Format("DELETE FROM [Compose_Detail] WHERE ([ComposeID] =  {0})", ComposeID);
                    //           ___sqlCmd.ExecuteNonQuery();
                    //           ___sqlCmd.CommandText = string.Format("DELETE FROM [Compose_Master] WHERE([ComposeID] =  {0})", ComposeID);
                    //           ___sqlCmd.ExecuteNonQuery();
                    //           ___sqlTran.Commit();
                    //           __myReturn = true;
                    //        }
                    //        catch (Exception __tranExp)
                    //        {
                    //            ___sqlTran.Rollback();
                    //            throw new Exception(__tranExp.Message);
                    //        }
                    //    }
                    //}
                }
            }
            catch (SqlException dbexp)
            {
                this.m__lastError = "[XipsDAL.DeleteComposeMaster] DB.Error : " + dbexp.Message;
            }
            catch (Exception exp)
            {
                this.m__lastError = "[XipsDAL.DeleteComposeMaster] Error : " + exp.Message;
            };
            return (__myReturn);
        }

        public bool ValidateToDeleteCustomerInformation(string CustomerID)
        {
            this.m__lastError = string.Empty;
            bool __myReturn = false;

            try
            {
                using (SqlConnection ___sqlCnn = new SqlConnection(m__db_CNNSTR))
                {
                    ___sqlCnn.Open();
                    using (SqlCommand ___sqlCmd = new SqlCommand())
                    {
                        ___sqlCmd.Connection = ___sqlCnn;
                        ___sqlCmd.CommandType = CommandType.StoredProcedure;
                        ___sqlCmd.CommandText = "[dbo].[usp__Validate__Customer_Information__DELETE]";
                        ___sqlCmd.CommandTimeout = 60;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int));
                        ___sqlCmd.Parameters["@RETURN_VALUE"].Direction = ParameterDirection.ReturnValue;
                        ___sqlCmd.Parameters["@RETURN_VALUE"].Value = null;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@CustomerID", SqlDbType.NVarChar, 20));
                        ___sqlCmd.Parameters["@CustomerID"].Direction = ParameterDirection.Input;
                        ___sqlCmd.Parameters["@CustomerID"].Value = CustomerID;
                        ___sqlCmd.ExecuteNonQuery();
                        __myReturn = System.Convert.ToInt16(___sqlCmd.Parameters["@RETURN_VALUE"].Value) > 0 ? true : false;
                    }
                }
            }
            catch (SqlException dbexp)
            {
                this.m__lastError = "[XipsDAL.ValidateToDeleteCustomerInformation] DB.Error : " + dbexp.Message;
            }
            catch (Exception exp)
            {
                this.m__lastError = "[XipsDAL.ValidateToDeleteCustomerInformation] Error : " + exp.Message;
            };
            return (__myReturn);
        }

        public bool ValidateToDeleteStockLibrary(string StockID)
        {
            this.m__lastError = string.Empty;
            bool __myReturn = false;

            try
            {
                using (SqlConnection ___sqlCnn = new SqlConnection(m__db_CNNSTR))
                {
                    ___sqlCnn.Open();
                    using (SqlCommand ___sqlCmd = new SqlCommand())
                    {
                        ___sqlCmd.Connection = ___sqlCnn;
                        ___sqlCmd.CommandType = CommandType.StoredProcedure;
                        ___sqlCmd.CommandText = "[dbo].[usp__Validate__Stock_Library__DELETE]";
                        ___sqlCmd.CommandTimeout = 60;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@RETURN_VALUE", SqlDbType.Int));
                        ___sqlCmd.Parameters["@RETURN_VALUE"].Direction = ParameterDirection.ReturnValue;
                        ___sqlCmd.Parameters["@RETURN_VALUE"].Value = null;
                        ___sqlCmd.Parameters.Add(new SqlParameter("@StockID", SqlDbType.Int));
                        ___sqlCmd.Parameters["@StockID"].Direction = ParameterDirection.Input;
                        ___sqlCmd.Parameters["@StockID"].Value = Convert.ToInt16( StockID);
                        ___sqlCmd.ExecuteNonQuery();
                        __myReturn = System.Convert.ToInt16(___sqlCmd.Parameters["@RETURN_VALUE"].Value) > 0 ? true : false;
                    }
                }
            }
            catch (SqlException dbexp)
            {
                this.m__lastError = "[XipsDAL.ValidateToDeleteStockLibrary] DB.Error : " + dbexp.Message;
            }
            catch (Exception exp)
            {
                this.m__lastError = "[XipsDAL.ValidateToDeleteStockLibrary] Error : " + exp.Message;
            };
            return (__myReturn);
        }

        public bool DeleteData(DataType Type, string UniqueID)
        {
            this.m__lastError = string.Empty;
            bool __myReturn = false;
            string ____sql = string.Empty;

            switch (Type)
            {
                case DataType.ComposeDetail:
                    ____sql = string.Format("DELETE FROM [Compose_Detail] WHERE ([DetailID] =  '{0}'", UniqueID);
                    break;
                case DataType.Customer:
                    ____sql = string.Format("DELETE FROM [Customer_Information] WHERE [CustomerID] =  '{0}'", UniqueID);
                    break;
                case DataType.StockLibrary:
                    ____sql = string.Format("DELETE FROM [Stock_Library] WHERE [StockID] =  '{0}'", UniqueID);
                    break;
                case DataType.User:
                    ____sql = string.Format("DELETE FROM [User_Information] WHERE [UserID] =  '{0}'", UniqueID);
                    break;
                default:
                    throw new System.Exception("Invalid Delete Enumeration Parameter - DataType ");
            };

            try
            {
                using (SqlConnection ___sqlCnn = new SqlConnection(m__db_CNNSTR))
                {
                    ___sqlCnn.Open();
                    using (SqlCommand ___sqlCmd = new SqlCommand(____sql, ___sqlCnn))
                    {
                        ___sqlCmd.ExecuteNonQuery();
                        __myReturn = true;
                    }
                }
            }
            catch (SqlException dbexp)
            {
                this.m__lastError = "DB.Error : " + dbexp.Message;
            }
            catch (Exception exp)
            {
                this.m__lastError = exp.Message;
            };
            return (__myReturn);
        }

       #region IDisposable Member

        protected void Dispose(bool disposing)
        {

            if (disposing) { }
            this.m__isDisposed = true;
        }

        void IDisposable.Dispose()
        {
            this.m__isDisposed = true;
            //
            // This object will be cleaned up by the Dispose method.
            // Therefore, you should call GC.SupressFinalize to
            // take this object off the finalization queue 
            // and prevent finalization code for this object
            // from executing a second time.
            //
            if (!this.m__isDisposed) GC.SuppressFinalize(this);
        }

        #endregion

    }
}