using System;

namespace MigrationDemo
{
    public partial class Orders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            try { dsOrders.DataBind(); GridView1.PageIndex = 0; GridView1.DataBind(); } catch { }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            try { txtSearch.Text = string.Empty; dsOrders.DataBind(); GridView1.PageIndex = 0; GridView1.DataBind(); } catch { }
        }
    }
}


