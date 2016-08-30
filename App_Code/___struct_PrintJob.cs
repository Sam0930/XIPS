namespace XIPS.Data
{
    using System;
    using System.Collections.Generic;
    using System.Xml.Serialization;
    using System.IO;

    [Serializable]
    [XmlRootAttribute("PrintJob", IsNullable = false)]
    public class StructOfPrintJob: IDisposable
    {
        private bool m__isDisposed = false;
        private List<PrintItem> m__listitems = new List<PrintItem>();

        [XmlElement("Sender")]
        public string Sender { get; set; }

        [XmlElement("ComposeID")]
        public string ComposeID { get; set; }

        [XmlElement("SubsetOffset")]
        public string SubsetOffset { get; set; }

        //
        // Printer: new requirement for V2.3
        //
        [XmlElement("Printer")]
        public string PrinterIpAddress { get; set; }

        //
        // Queue: new requirement for V2.3
        //
        [XmlElement("Queue")]
        public string PrintQueue { get; set; }

        [XmlElement("TotalSet")]
        public string TotalSet { get; set; }

        [XmlElement("Item")]
        public List<PrintItem> ListItems
        {
            get
            {
                return (m__listitems);
            }

            set
            {
                m__listitems = value;
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

    public class PrintItem : IDisposable
    {
        private bool m__isDisposed = false;

        [XmlElement("ID")]
        public string ID  { get; set; }

        [XmlElement("PrintMethod")]
        public string PrintMethod  { get; set; }

        [XmlElement("PaperPerSet")]
        public string PaperPerSet  { get; set; }

        [XmlElement("Tray")]
        public string Tray  { get; set; }

        //
        // 2013/10/27
        // Remove <page> property and add page <Offset> property
        //
        //[XmlElement("Page")]
        //public PrintPage Page  { get; set; }

        [XmlElement("Offset")]
        public PrintOffset Offset  { get; set; }

        [XmlElement("Paper")]
        public PrintPaper Paper   { get; set; }

        [XmlElement("PDF")]
        public string PDF  { get; set; }

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

    //
    // 2013/10/27
    // Remove <page> property and add page <Offset> property
    //
    //public class PrintPage : IDisposable
    //{
    //   private bool m__isDisposed = false;
  
    //   [XmlElement("Width")]
    //    public string Width { get; set; }

    //   [XmlElement("Height")]
    //    public string Height { get; set; }

    //   #region IDisposable Members
    //   protected void Dispose(bool disposing)
    //   {
    //       if (disposing) { };
    //       this.m__isDisposed = true;
    //   }

    //   void IDisposable.Dispose()
    //   {
    //       //
    //       // Do not change this code.  Put cleanup code in Dispose(ByVal disposing As Boolean) above.
    //       //
    //       this.Dispose(true);
    //       //
    //       // This object will be cleaned up by the Dispose method.
    //       // Therefore, you should call GC.SupressFinalize to
    //       // take this object off the finalization queue 
    //       // and prevent finalization code for this object
    //       // from executing a second time.
    //       //
    //       if (!this.m__isDisposed) GC.SuppressFinalize(this);
    //   }
    //   #endregion
    //}

    public class PrintPaper : IDisposable
    {
        private bool m__isDisposed = false;

        [XmlElement("Width")]
        public string Width { get; set; }

        [XmlElement("Height")]
        public string Height { get; set; }  

       [XmlElement("Weight")]
        public string Weight { get; set; }  

       [XmlElement("Coated")]
       public string Coated { get; set; }

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

    //
    // 2013/10/27
    // Add page <Offset> property
    //
    public class PrintOffset : IDisposable
    {
        private bool m__isDisposed = false;

        [XmlElement("X")]
        public string X { get; set; }

        [XmlElement("Y")]
        public string Y { get; set; }

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