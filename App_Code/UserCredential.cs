using System;
using System.Data;
using System.Collections.Generic;

namespace XIPS.Data
{
    /// <summary>
    /// Static Class UserCredential 
    /// </summary>
    public  class UserCredential:IDisposable
    {
        private bool __isDisposed = false;
        private bool __checkValidity = false;        
        private string __id = string.Empty;
        private string __password = string.Empty;
        private string __name = string.Empty;
        private string __depiction = string.Empty;
        private string __groupId = string.Empty;
        private string __groupName = string.Empty;
        private string __groupDepiction = string.Empty;
        private string __error = string.Empty;
        private  List<UserPermission> __permission = new List<UserPermission>();

        public UserCredential()
        {
        }

        ~UserCredential()
        {
            this.Dispose(false);
        }

        public bool Login(string ID, string Password)
        {
            try
            {
                this.__id = ID.Trim();
                this.__error = string.Empty;

                using (XipsDAL __xips = new XipsDAL())
                {
                    using (DataTable __dtUser = __xips.UserInformation(this.__id))
                    {
                            if (__dtUser.Rows.Count > 0)
                            {    
                                this.__name = __dtUser.Rows[0] ["UserName"].ToString();
                                this.__password = __dtUser.Rows[0] ["UserPassword"].ToString();
                                this.__depiction = __dtUser.Rows[0] ["UserDepiction"].ToString();
                                this.__groupId = __dtUser.Rows[0] ["GroupID"].ToString();
                                this.__groupName = __dtUser.Rows[0] ["GroupName"].ToString();
                                this.__groupDepiction = __dtUser.Rows[0] ["GroupDepiction"].ToString();
                            }
                            else
                            {
                                throw new Exception("使用者帳號不正確.");
                            }
                    }
     
                    if (__password.Equals(Password))
                    {                           
                        using (DataTable __dtPermission = __xips.GroupPermission(this.__groupId))
                        {
                            if (__dtPermission.Rows.Count > 0)
                            {
                                foreach (DataRow ____daRow in __dtPermission.Rows)
                                {
                                    using (UserPermission ____up = new UserPermission())
                                    {
                                        ____up.MianProgramID = ____daRow["MPID"].ToString();
                                        ____up.SubProgramID = System.Convert.ToInt32(____daRow["SPID"]);
                                        ____up.ProgramName = ____daRow["ProgramName"].ToString();
                                        ____up.ProgramDepiction = ____daRow["ProgramDepiction"].ToString();
                                        ____up.Granted = System.Convert.ToInt16(____daRow["Granted"]) > 0 ? true : false;
                                        this.__permission.Add(____up);
                                    }
                                };

                                this.__checkValidity = true;                                    
                            }
                            else
                            {
                                throw new Exception("使用者群組未授權.");
                            }
                        }
                    }
                    else
                    {
                        throw new Exception("帳號或密碼不正確.");
                    }
                }

            }
            catch (Exception exp)
            {
                this.__error = exp.Message;
            };

            return (this.__checkValidity);
        }

        public bool ChangePassword(string oldPass, string newPass)
        {
            this.__error = string.Empty;
            bool __myRet = false;

            try
            {
                if (!oldPass.Equals(this.Password))
                    throw new Exception("舊密碼錯誤.");

                if (newPass.Trim().Length == 0)
                    throw new Exception("新密碼不正確. ");

                using (XipsDAL __xips = new XipsDAL())
                {
                    if(!__xips.ChangeUserPassword(this.__id, newPass))
                        throw new Exception(__xips.ErrorMessage);

                    this.__password = newPass;
                }
                __myRet = true;
            }
            catch (Exception __e)
            {
                this.__error = __e.Message;
            }

            return (__myRet);
        }

        public bool IsCheckValidity
        {
            get
            {
                return (this.__checkValidity);
            }
        }

        public string ID
        {
            get
            {
                return (this.__id);
            }
        }

        public string Password
        {
            get
            {
                return (this.__password);
            }
        }

        public string Name
        {
            get
            {
                return (this.__name);
            }
        }

        public string Depiction
        {
            get
            {
                return (this.__depiction);
            }
        }

        public string GroupID
        {
            get
            {
                return (this.__groupId);
            }
        }

        public string GroupName
        {
            get
            {
                return (this.__groupName);
            }
        }

        public string GroupDepiction
        {
            get
            {
                return (this.__groupDepiction);
            }
        }
        
        public string ErrorMessage
        {
            get
            {
                return (this.__error);
            }
        }

        public List<UserPermission> Permission
        {
            get
            {
                return (__permission);
            }
        }

        #region IDisposable Members

        public void Dispose(bool disposing)
        {
            if (disposing) 
            {
                this.__permission.Clear();
                this.__permission = null;
            };
            this.__isDisposed = true;
        }

        void IDisposable.Dispose()
        {
            //
            // Do not change this code.  Put cleanup code in Dispose(ByVal disposing As Boolean) above.
            //
            this.Dispose(true);
            //
            // This object will be cleaned up by the Dispose method.
            // Therefore, you should call GC.SupressFinalize to
            // take this object off the finalization queue 
            // and prevent finalization code for this object
            // from executing a second time.
            //
            if (!this.__isDisposed) GC.SuppressFinalize(this);
        }

        #endregion     
    
    }
}