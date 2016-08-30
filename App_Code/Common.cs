using System;
using System.Xml;
using System.Xml.Serialization;
using System.IO;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace XIPS.Data
{
    /// <summary>
    /// Common 
    /// </summary>
    public sealed class Common
    {
        private static volatile Common ____self = null;
        private static readonly object Mutex = new object();

        public static Common Instance
        {
            get
            {
                if (____self == null)
                {
                    lock (Mutex)
                    {
                        if (____self == null)
                            ____self = new Common();
                    }
                };

                return (____self);          
            }
        }

        public Common()
        {
        }

        public string displayGridviewRecordCount(GridView SourceGridView)
        {
            string __myReturn;
            try
            {
                DataView __dv;
                if( SourceGridView.DataSource != null)
                {
                    __dv=((DataView)SourceGridView.DataSource);
                }
                else
                {
                    __dv = ((SqlDataSource) SourceGridView.DataSourceObject).Select(DataSourceSelectArguments.Empty) as DataView;
                }

                int __rec_Total = __dv.Count;
                int __rec_End = SourceGridView.PageSize * (SourceGridView.PageIndex + 1);
                int __rec_Start = __rec_End - SourceGridView.PageSize;

                __rec_End = __rec_End > __rec_Total || __rec_End == 0 ? __rec_Total : __rec_End;
                __rec_Start = __rec_Start == 0 ? 1 : __rec_Start;
                __myReturn = string.Format("{0} - {1} , Total : {2}", __rec_Start.ToString("#,#"), __rec_End.ToString("#,#"), __rec_Total.ToString("#,#"));
            }      
            catch
            {
                __myReturn = string.Empty;
            }
            return (__myReturn);
        }

        public string GetUniqueXmlFileNameByTime()
        {
            return (string.Format("{0}.xml", System.DateTime.Now.ToString("yyyyMMddHHmmss")));
        }

        public List<string> DropdownListCountOfGridviewPager()
        {
            List<string> __list = new List<string>();
            __list.Add("10");
            __list.Add("20");
            __list.Add("30");
            __list.Add("40");
            __list.Add("50");
            return (__list);
        }

        public string getFormViewModeDepiction(FormViewMode Mode, string MainHeaderText)
        {
            string __depiction;

            switch (Mode)
            {
                case FormViewMode.ReadOnly:
                    __depiction = "詳細資料";
                    break;
                case FormViewMode.Edit:
                    __depiction = "修改資料";
                    break;
                case FormViewMode.Insert:
                    __depiction = "新增資料";
                    break;
                default:
                    __depiction = "詳細資料";
                    break;
            };
            
            return (string.Format("{0} - {1}", MainHeaderText, __depiction));
        }

        public string SerializeObjectAsXml(Object o, System.Text.Encoding encoding)
        {
            string __encodingString = string.Empty;

            try
            {
                XmlWriterSettings xmlWriterSettings = new XmlWriterSettings
                {
                    Indent = true,
                    OmitXmlDeclaration = false,
                    Encoding = encoding,
                    NewLineOnAttributes = true
                };

                XmlSerializer __xmlSerialier = new XmlSerializer(o.GetType());

                using (MemoryStream __ms = new MemoryStream())
                {
                    using (XmlWriter __xmlWriter = XmlWriter.Create(__ms, xmlWriterSettings))
                    {
                        __xmlSerialier.Serialize(__xmlWriter, o);
         
                        // rewind the stream before reading back.
                        __ms.Position = 0;

                        __encodingString = encoding.GetString(__ms.ToArray());
                    }
                }
            }
            catch
            {
                throw;
            }

            return (__encodingString);
        }

        public void SerializeObjectToXmlFile(Object o, string OutputFileName, System.Text.Encoding encoding)
        {
            try
            {
                this.WriteStringToFile(this.SerializeObjectAsXml(o, encoding), OutputFileName, encoding);
            }
            catch (Exception __e)
            {
                throw new Exception(__e.Message);
            }
        }

        public void WriteStringToFile(string xml, string OutputFileName, System.Text.Encoding encoding)
        {
            try
            {
                string __directory = new FileInfo(OutputFileName).DirectoryName;

                if (!Directory.Exists(__directory)) Directory.CreateDirectory(__directory);

                using (StreamWriter __streamW = new StreamWriter(OutputFileName, false, encoding))
                {
                    __streamW.Write(xml);
                    __streamW.Flush();
                    __streamW.Close();
                }
            }
            catch
            {
                throw;
            }
        }
    }
}