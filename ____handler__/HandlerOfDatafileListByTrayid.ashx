<%@ WebHandler Language="C#" Class="XIPS.HandlerOfDatafileListByTray" %>

using System;
using System.IO;
using System.Web;
using System.Linq;
using System.Collections.Generic;

namespace XIPS
{
    public class HandlerOfDatafileListByTray : IHttpHandler 
    {
        public void ProcessRequest (HttpContext context) 
        {
            string __response = string.Empty;
            string __traypah = context.Request["traypath"].ToString().Trim();
            string __trayfilter = context.Request["trayfilter"].ToString().Trim();
            string __delimiter = context.Request["delimiter"].ToString().Trim();   
            
            try
            {              
                if (Directory.Exists(__traypah))
                {
                    List<string> __fileList = new List<string>();
                    var __files = from __fileNames in Directory.EnumerateFiles(__traypah, __trayfilter.Length>0?__trayfilter:"*.*", SearchOption.TopDirectoryOnly)
                                  select new { filename = __fileNames };
                    
                    foreach (var f in __files)
                    {
                        __fileList.Add(new FileInfo(f.filename).Name.Trim());                       
                    };

                    __response = string.Join(__delimiter.Length> 0 ?__delimiter:",", __fileList);
                    
                    //foreach (string __filename in Directory.EnumerateFiles(__traypah, "*.pdf", SearchOption.TopDirectoryOnly))
                    //{
                    //    __response += new FileInfo(__filename).Name + ",";
                    //};
                    //if (__response.Length > 0 )
                    //{   
                    //    __response = __response.Substring(0, __response.Length - 1);
                    //}
                }
            }
            finally
            {
                context.Response.Clear();
                context.Response.ClearHeaders();
                context.Response.Buffer = false;
                context.Response.Expires = 0;
                context.Response.CacheControl = "no-cache";
                context.Response.AppendHeader("Pragma", "No-Cache");
                context.Response.HeaderEncoding = System.Text.Encoding.GetEncoding("big5");
                context.Response.ContentType = "text/plain";
                context.Response.Write(__response);
                context.Response.Flush();
            }                                        
        }
 
        public bool IsReusable 
        {
            get 
            {
                return false;
            }
        }
    }
}