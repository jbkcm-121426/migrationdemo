using System;
using System.Web.UI.WebControls;

namespace MigrationDemo
{
    public partial class CustomersManage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try { dsManage.DataBind(); GridView1.PageIndex = 0; GridView1.DataBind(); } catch { }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            try { txtSearch.Text = string.Empty; dsManage.DataBind(); GridView1.PageIndex = 0; GridView1.DataBind(); } catch { }
        }

        protected void dsManage_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            try
            {
                if (e.Exception != null)
                {
                    lblAddStatus.Text = "Error: " + e.Exception.Message;
                    lblAddStatus.ForeColor = System.Drawing.Color.Red;
                    e.ExceptionHandled = true;
                    ClientScript.RegisterStartupScript(GetType(), "showAddError", "showAdd();", true);
                    return;
                }

                lblAddStatus.Text = "Customer added successfully.";
                lblAddStatus.ForeColor = System.Drawing.Color.Green;
                dsManage.DataBind();
                GridView1.DataBind();
                ClientScript.RegisterStartupScript(GetType(), "hideAddSuccess", "showAdd(); setTimeout(hideAdd, 800);", true);
            }
            catch { }
        }
    }
}


