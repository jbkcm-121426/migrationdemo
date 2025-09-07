<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MigrationDemo.Default" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>MigrationDemo - Home</title>
    <meta charset="utf-8" />
    <style>
        :root { --primary:#2563eb; --border:#e5e7eb; --text:#111827; --muted:#6b7280; }
        html, body { height:100%; }
        body { font-family: Segoe UI, Arial, sans-serif; margin: 0; color: var(--text); background:#f9fafb; }
        .container { max-width: 1000px; margin: 56px auto; padding: 0 20px; }
        .hero { padding: 32px; border-radius: 14px; background: linear-gradient(135deg, #eef2ff, #f0f9ff); border:1px solid var(--border); box-shadow: 0 10px 30px rgba(0,0,0,.06); }
        h1 { margin: 0 0 10px; font-weight:700; font-size: 28px; }
        p.lead { color: var(--muted); margin: 0 0 20px; font-size: 15px; }
        .menu { display:grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap:16px; margin-top: 20px; }
        .tile { display:block; padding:16px; border:1px solid var(--border); border-radius:12px; background:#fff; color:var(--text); text-decoration:none; transition:.15s ease-in-out; box-shadow: 0 1px 2px rgba(0,0,0,.04); }
        .tile:hover { transform: translateY(-2px); box-shadow: 0 6px 16px rgba(0,0,0,.08); }
        .tile h3 { margin:0 0 6px; font-size:16px; }
        .tile p { margin:0; color: var(--muted); font-size:13px; }
        .badge { display:inline-block; padding:6px 10px; background:#eef2ff; color:#3730a3; border-radius:999px; font-size:12px; }
    </style>
    <asp:PlaceHolder runat="server"> </asp:PlaceHolder>
    <script runat="server">
    </script>
    
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
        <div class="hero">
            <h1>MigrationDemo</h1>
            <p class="lead">Lightweight ASP.NET WebForms app over AdventureWorks with CRUD, search, and file logging.</p>
            <span class="badge"><asp:Label ID="lblSession" runat="server" /></span>
            <div class="menu">
                <a class="tile" href="Products.aspx">
                    <h3>Products</h3>
                    <p>Browse, edit, and add products.</p>
                </a>
                <a class="tile" href="Sales.aspx">
                    <h3>Sales Territories</h3>
                    <p>Maintain sales regions and groups.</p>
                </a>
                <a class="tile" href="Customers.aspx">
                    <h3>Customers</h3>
                    <p>Search individual customers.</p>
                </a>
                <a class="tile" href="CustomersManage.aspx">
                    <h3>Manage Customers</h3>
                    <p>Full CRUD via stored procedures.</p>
                </a>
                <a class="tile" href="Orders.aspx">
                    <h3>Orders</h3>
                    <p>View recent sales orders.</p>
                </a>
            </div>
        </div>
        </div>
    </form>
</body>
</html>




