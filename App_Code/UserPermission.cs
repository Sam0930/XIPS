using System;

namespace XIPS.Data
{
    public class UserPermission: IDisposable
    {
        private string __MPID;
        private int __SPID;
        private string __programName = string.Empty;
        private string __programDepiction = string.Empty;
        private bool __Granted = false;
        private bool __isDisposed = false;

        public UserPermission()
        {    
        }

        ~UserPermission()
        {
            this.Dispose(false);
        }

        public string MianProgramID
        {
            get
            {
                return (this.__MPID);
            }
            set
            {
                this.__MPID = value;
            }
        }

        public int SubProgramID
        {
            get
            {
                return (this.__SPID);
            }
            set
            {
                this.__SPID = value;
            }
        }

        public string ProgramName
        {
            get
            {
                return (this.__programName);
            }
            set
            {
                this.__programName = value;
            }
        }

        public string ProgramDepiction
        {
            get
            {
                return (this.__programDepiction);
            }
            set
            {
                this.__programDepiction = value;
            }
        }

        public bool Granted
        {
            get
            {
                return (this.__Granted);
            }
            set
            {
                this.__Granted = value;
            }
        }

        #region IDisposable Members

        private void Dispose(bool disposing)
        {
            if (disposing) { };
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