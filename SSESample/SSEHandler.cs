using System;
using System.Web;

namespace SSESample
{
    public class SSEHandler : IHttpHandler
    {
        /// <summary>
        /// You will need to configure this handler in the Web.config file of your 
        /// web and register it with IIS before being able to use it. For more information
        /// see the following link: http://go.microsoft.com/?linkid=8101007
        /// </summary>
        #region IHttpHandler Members

        public bool IsReusable
        {
            // Return false in case your Managed Handler cannot be reused for another request.
            // Usually this would be false in case you have some state information preserved per request.
            get { return false; }
        }

        public void ProcessRequest(HttpContext context)
        {
            HttpResponse Response = context.Response;
            DateTime startDate = DateTime.Now;
            Response.ContentType = "text/event-stream";
            //this only works for 1 minute
            while (startDate.AddSeconds(20) > DateTime.Now)
            {
                var rnd = new Random();
                //Send a color
                Response.Write(string.Format("data: {{\"r\":{0}, \"g\":{1}, \"b\":{2}}}\n\n", rnd.Next(0, 255), rnd.Next(0, 255), rnd.Next(0, 255)));
                try
                {
                    Response.Flush();
                }
                catch { }
                
                System.Threading.Thread.Sleep(1000);
            }
            //Even that the response is closed, SSE provides auto reconnect so the handler is requested again automatically
            Response.Close();
        }

        #endregion
    }
}
