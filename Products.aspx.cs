using System;
using System.Web.UI.WebControls;

namespace MigrationDemo
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void dsProducts_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            try
            {
                if (e.Exception != null)
                {
                    if (lblAddStatus != null)
                    {
                        lblAddStatus.Text = "Error: " + e.Exception.Message;
                        lblAddStatus.ForeColor = System.Drawing.Color.Red;
                    }
                    e.ExceptionHandled = true;
                    // keep modal open to show error
                    ClientScript.RegisterStartupScript(GetType(), "showAddError", "showAdd();", true);
                    return;
                }

                if (lblAddStatus != null)
                {
                    lblAddStatus.Text = "Product added successfully.";
                    lblAddStatus.ForeColor = System.Drawing.Color.Green;
                }

                dsProducts.DataBind();
                GridView1.DataBind();
                // briefly show success then hide
                ClientScript.RegisterStartupScript(GetType(), "hideAddSuccess", "showAdd(); setTimeout(hideAdd, 800);", true);
            }
            catch
            {
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try
            {
                dsProducts.DataBind();
                GridView1.PageIndex = 0;
                GridView1.DataBind();
            }
            catch { }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            try
            {
                txtSearch.Text = string.Empty;
                dsProducts.DataBind();
                GridView1.PageIndex = 0;
                GridView1.DataBind();
            }
            catch { }
        }
    }
}




