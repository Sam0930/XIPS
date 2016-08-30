using System;

namespace XIPS.Data
{
    /// <summary>
    /// MyApplicationPermission 
    /// </summary>
    public class MyApplicationPermission:IDisposable
    {
        public class StringValueAttribute : Attribute
        {
            private string _value;

            public StringValueAttribute(string value)
            {
                this._value = value;
            }

            public string Value
            {
            get { return this._value; }
            }
        }

        //public enum ProgramPermission
        //{
        //    NEW = 1,
        //    DELETE = 2,
        //    UPDATE = 3,
        //    EXECUTE = 4
        //}

        public enum ApplicationName
        {
            [StringValue("PJ")]
            Print,
            [StringValue("SR")]
            JobStatistic,
            [StringValue("CP")]
            Compose,
            [StringValue("SL")]
            StockLibrary,
            [StringValue("CM")]
            Customer,
            [StringValue("US")]
            User,
            [StringValue("GP")]
            GroupPermission
        }

        public enum PermissionLevel
        {
            NotSet,              
            Yes,
            No
        }       
         
        private PermissionLevel _m_map_delete=PermissionLevel.NotSet;
        private PermissionLevel _m_map_update=PermissionLevel.NotSet;
        private PermissionLevel _m_map_insert=PermissionLevel.NotSet;
        private PermissionLevel _m_map_execute=PermissionLevel.NotSet;

        private bool _m_isDisposed = false;

        public MyApplicationPermission(ApplicationName AppName, UserCredential ucObject)
        {          
            foreach (UserPermission _up in ucObject.Permission)
            {
                switch(AppName)
                {
                    case ApplicationName.Print:
                        if(_up.MianProgramID == "PJ")
                        {
                            if (_up.SubProgramID == 4)
                            {
                                this._m_map_execute = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;
                                break;
                            }
                        }
                        break;
                    case ApplicationName.JobStatistic:
                        if(_up.MianProgramID == "SR")
                        {
                            if (_up.SubProgramID == 4)
                            {
                                this._m_map_execute = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;
                                break;
                            }
                        }
                        break;
                    case ApplicationName.Compose:
                        if (_up.MianProgramID == "CP")
                        {
                            if (_up.SubProgramID == 1)
                                this._m_map_insert = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;

                            if (_up.SubProgramID == 2)
                                this._m_map_delete = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;

                            if (_up.SubProgramID == 3)
                                this._m_map_update = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;

                            if (_up.SubProgramID == 4)
                                this._m_map_execute = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;
                        }
                        break;
                    case ApplicationName.StockLibrary:
                        if (_up.MianProgramID == "SL")
                        {
                            if (_up.SubProgramID ==1)
                                this._m_map_insert = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;

                            if (_up.SubProgramID == 2)
                                this._m_map_delete = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;

                            if (_up.SubProgramID == 3)
                                this._m_map_update = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;

                            if (_up.SubProgramID == 4)
                                this._m_map_execute = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;
                        }
                        break;
                    case ApplicationName.Customer:
                        if (_up.MianProgramID == "CM")
                        {
                            if (_up.SubProgramID == 1)
                                this._m_map_insert = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;

                            if (_up.SubProgramID == 2)
                                this._m_map_delete = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;

                            if (_up.SubProgramID == 3)
                                this._m_map_update = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;

                            if (_up.SubProgramID == 4)
                                this._m_map_execute = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;
                        }
                        break;
                    case ApplicationName.User:
                        if (_up.MianProgramID == "US")
                        {
                            if (_up.SubProgramID == 1)
                                this._m_map_insert = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;

                            if (_up.SubProgramID == 2)
                                this._m_map_delete = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;

                            if (_up.SubProgramID == 3)
                                this._m_map_update = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;

                            if (_up.SubProgramID == 4)
                                this._m_map_execute = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;
                        }
                        break;
                    case ApplicationName.GroupPermission:
                        if(_up.MianProgramID == "GP")
                        {
                            if (_up.SubProgramID == 4)
                            {
                                this._m_map_execute = _up.Granted ? PermissionLevel.Yes : PermissionLevel.No;
                                break;
                            }
                        }
                        break;
                    default:
                        this._m_map_delete= PermissionLevel.No;
                        this._m_map_update= PermissionLevel.No;
                        this._m_map_insert= PermissionLevel.No;
                        this._m_map_execute= PermissionLevel.No;
                        break;
                };
            }
        }
            
        ~MyApplicationPermission()
        {
            this.Dispose(false);
        }

        public PermissionLevel RightToDelete
        { 
            get 
            { 
                return(this._m_map_delete);
            } 
        }

        public PermissionLevel RightToUpdate
        { 
            get 
            { 
                return(this._m_map_update);
            } 
        }

        public PermissionLevel RightToInsert
        { 
            get 
            { 
                return(this._m_map_insert);
            } 
        }

        public PermissionLevel RightToExecute
        { 
            get 
            { 
                return(this._m_map_execute);
            } 
        }

        #region IDisposable Members
        private void Dispose(bool disposing)
        {
            if (disposing) { };
            this._m_isDisposed = true;
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
            if (!this._m_isDisposed) GC.SuppressFinalize(this);
        }
        #endregion   

    }

}