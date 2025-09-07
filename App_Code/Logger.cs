using System;
using System.IO;
using System.Web;

namespace MigrationDemo
{
    public static class Logger
    {
        private static readonly object _sync = new object();

        public static void Log(string message)
        {
            try
            {
                string root;
                if (HttpContext.Current != null && HttpContext.Current.Server != null)
                {
                    root = HttpContext.Current.Server.MapPath("~");
                }
                else
                {
                    root = AppDomain.CurrentDomain.BaseDirectory;
                }
                string logsDir = Path.Combine(root, "App_Data", "logs");
                Directory.CreateDirectory(logsDir);
                string file = Path.Combine(logsDir, DateTime.UtcNow.ToString("yyyyMMdd") + ".log");
                string line = DateTime.UtcNow.ToString("o") + "\t" + message;

                lock (_sync)
                {
                    File.AppendAllText(file, line + Environment.NewLine);
                }
            }
            catch
            {
                // Avoid throwing from logger in web app
            }
        }

        public static void LogError(string message, Exception ex)
        {
            Log("ERROR: " + message + " | " + ex);
        }
    }
}


