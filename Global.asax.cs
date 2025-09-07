using System;
using System.Web;

namespace MigrationDemo
{
    public class Global : HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            Logger.Log("Application_Start");
        }

        protected void Session_Start(object sender, EventArgs e)
        {
            Session["StartedAt"] = DateTime.UtcNow;
            Logger.Log("Session_Start");
        }

        protected void Application_Error(object sender, EventArgs e)
        {
            Exception ex = Server.GetLastError();
            Logger.LogError("Unhandled exception", ex);
        }
    }
}




