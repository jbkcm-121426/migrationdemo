using System;

namespace MigrationDemo
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var startedAt = Session["StartedAt"];
                lblSession.Text = startedAt == null ? "Session not started" : ("Session started at UTC: " + startedAt);
            }
        }
    }
}


