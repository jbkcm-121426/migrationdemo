<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Customers.aspx.cs" Inherits="MigrationDemo.Customers" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Customers</title>
    <meta charset="utf-8" />
    <style>
        :root { --primary:#2563eb; --border:#e5e7eb; --text:#111827; --muted:#6b7280; --header:#f3f4f6; --alt:#fafafa; }
        body { font-family: Segoe UI, Arial, sans-serif; margin: 0; color: var(--text); background:#f9fafb; }
        .wrap { max-width: 1200px; margin: 36px auto; padding: 0 20px; }
        .card { padding: 20px; border: 1px solid var(--border); border-radius: 10px; background:#fff; box-shadow: 0 1px 2px rgba(0,0,0,.04); }
        .toolbar { display:flex; justify-content: space-between; align-items:center; gap:12px; margin-bottom: 10px; }
        .toolbar a.btn { display:inline-block; padding:8px 12px; background:var(--primary); color:#fff; border-radius:8px; text-decoration:none; }
        .search { display:flex; gap:8px; align-items:center; background:#fff; border:1px solid var(--border); border-radius:10px; padding:8px; }
        .search input[type=text] { padding:8px 10px; border:1px solid transparent; border-radius:8px; min-width: 320px; outline:none; }
        .search input[type=text]:focus { box-shadow: 0 0 0 3px rgba(37,99,235,.15); border-color:#93c5fd; }
        .search .btn { padding:8px 12px; border-radius:8px; border:1px solid var(--border); background:#f9fafb; color:var(--text); text-decoration:none; cursor:pointer; }
        .search .btn:hover { background:#eef2ff; border-color:#c7d2fe; }
        .grid { margin-top: 12px; background:#fff; border:1px solid var(--border); border-radius:8px; padding: 0; overflow:hidden; }
        .grid table { width:100%; border-collapse: separate; border-spacing:0; }
        .grid th { background: var(--header); text-align:left; padding:10px 12px; font-weight:600; border-bottom:1px solid var(--border); }
        .grid td { padding:10px 12px; border-bottom:1px solid var(--border); vertical-align: middle; }
        .grid tr:nth-child(even) td { background: var(--alt); }
        .grid .aspnet-pager { padding:10px 12px; }
        .grid .aspnet-pager a, .grid .aspnet-pager span { display:inline-block; margin-right:6px; padding:6px 10px; border:1px solid var(--border); border-radius:6px; text-decoration:none; color:var(--text); background:#fff; }
        .grid .aspnet-pager span { background: var(--header); font-weight:600; }
        h2 { margin: 0 0 12px; font-weight:600; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrap">
            <div class="card">
                <div class="toolbar">
                    <h2>Customers</h2>
                    <div class="search">
                        <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search by name or email" />
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" OnClick="btnClear_Click" />
                    </div>
                    <a href="Default.aspx" class="btn">Home</a>
                </div>

                <asp:SqlDataSource ID="dsCustomers" runat="server" ConnectionString="<%$ ConnectionStrings:AdventureWorks %>" CancelSelectOnNullParameter="false"
                    SelectCommand="SELECT TOP 200 BusinessEntityID, FirstName + ' ' + LastName AS FullName, EmailAddress, PhoneNumber AS Phone FROM Sales.vIndividualCustomer WHERE (@q IS NULL OR @q = '' OR FirstName LIKE '%' + @q + '%' OR LastName LIKE '%' + @q + '%' OR EmailAddress LIKE '%' + @q + '%' OR PhoneNumber LIKE '%' + @q + '%') ORDER BY BusinessEntityID DESC">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtSearch" Name="q" PropertyName="Text" Type="String" />
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:GridView ID="GridView1" runat="server" CssClass="grid" DataSourceID="dsCustomers" AutoGenerateColumns="False" DataKeyNames="BusinessEntityID" AllowPaging="true" PageSize="20" AllowSorting="true" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="BusinessEntityID" HeaderText="ID" ReadOnly="True" SortExpression="BusinessEntityID" />
                        <asp:BoundField DataField="FullName" HeaderText="Name" SortExpression="FullName" />
                        <asp:BoundField DataField="EmailAddress" HeaderText="Email" SortExpression="EmailAddress" />
                        <asp:BoundField DataField="Phone" HeaderText="Phone" SortExpression="Phone" />
                    </Columns>
                    <HeaderStyle BackColor="#f3f4f6" />
                    <RowStyle BackColor="#ffffff" />
                    <AlternatingRowStyle BackColor="#fafafa" />
                    <PagerStyle CssClass="aspnet-pager" />
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>


