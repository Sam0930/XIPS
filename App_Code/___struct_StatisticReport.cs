namespace XIPS.Data
{
    using System;
    using System.Collections.Generic;
    using System.Xml.Serialization;

    [Serializable]
    [XmlRootAttribute("Report", IsNullable = false)]
    public class StructOfStatisticReport : IDisposable
    {
        private bool m__isDisposed = false;
        private List<StatisticRecord> m__StatisticReocrds = new List<StatisticRecord>();

        [XmlElement("Sender")]
        public string Sender { get; set; }

        [XmlElement("Record")]
        public List<StatisticRecord> Statistics
        {
            get
            {
                return (m__StatisticReocrds);
            }

            set
            {
                m__StatisticReocrds = value;
            }
        }

        #region IDisposable Members
        protected void Dispose(bool disposing)
        {
            if (disposing) { };
            this.m__isDisposed = true;
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
            if (!this.m__isDisposed) GC.SuppressFinalize(this);
        }
        #endregion
    }

    public class StatisticRecord : IDisposable
    {
        private bool m__isDisposed = false;

        [XmlElement("JobID")]
        public string JobID { get; set; }

        [XmlElement("UserName")]
        public string UserName { get; set; }

        [XmlElement("PrintDate")]
        public string DatePrinted { get; set; }

        [XmlElement("TotalPages")]
        public string TotalPages { get; set; }

        [XmlElement("DeductPages")]
        public string DeductPages { get; set; }

        #region IDisposable Members
        protected void Dispose(bool disposing)
        {
            if (disposing) { };
            this.m__isDisposed = true;
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
            if (!this.m__isDisposed) GC.SuppressFinalize(this);
        }
        #endregion
    }
}