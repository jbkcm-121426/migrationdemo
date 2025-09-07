<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sales.aspx.cs" Inherits="MigrationDemo.Sales" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Sales Territories</title>
    <meta charset="utf-8" />
    <style>
        :root { --primary:#2563eb; --border:#e5e7eb; --text:#111827; --muted:#6b7280; --header:#f3f4f6; --alt:#fafafa; }
        body { font-family: Segoe UI, Arial, sans-serif; margin: 0; color: var(--text); background:#f9fafb; }
        .wrap { max-width: 1100px; margin: 36px auto; padding: 0 20px; }
        .card { padding: 20px; border: 1px solid var(--border); border-radius: 10px; background:#fff; box-shadow: 0 1px 2px rgba(0,0,0,.04); }
        .toolbar { display:flex; justify-content: space-between; align-items:center; gap:12px; margin-bottom: 10px; }
        .toolbar a.btn { display:inline-block; padding:8px 12px; background:var(--primary); color:#fff; border-radius:8px; text-decoration:none; }
        .search { display:flex; gap:8px; align-items:center; background:#fff; border:1px solid var(--border); border-radius:10px; padding:8px; }
        .search input[type=text] { padding:8px 10px; border:1px solid transparent; border-radius:8px; min-width: 280px; outline:none; }
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
        /* Modal */
        .modal { position: fixed; inset: 0; background: rgba(0,0,0,.35); display:none; align-items:center; justify-content:center; padding: 20px; }
        .modal.show { display:flex; }
        .modal-content { width: 520px; background:#fff; border-radius: 12px; border:1px solid var(--border); box-shadow: 0 10px 30px rgba(0,0,0,.15); overflow:hidden; }
        .modal-header { padding:14px 16px; background:#f8fafc; border-bottom:1px solid var(--border); display:flex; justify-content:space-between; align-items:center; }
        .modal-body { padding: 14px 16px; }
        .btn { padding:8px 12px; border-radius:8px; border:1px solid var(--border); background:#fff; color:var(--text); text-decoration:none; }
        .btn.primary { background: var(--primary); color:#fff; border-color: var(--primary); }
        h2 { margin: 0 0 12px; font-weight:600; }
    </style>
    <script type="text/javascript">
        function showAdd() { var m = document.getElementById('addModal'); if(m){ m.className = 'modal show'; } }
        function hideAdd() { var m = document.getElementById('addModal'); if(m){ m.className = 'modal'; } }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrap">
            <div class="card">
                <div class="toolbar">
                    <h2>Sales Territories</h2>
                    <div class="search">
                        <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search by name or country code" />
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" OnClick="btnClear_Click" />
                    </div>
                    <div>
                        <a href="Default.aspx" class="btn">Home</a>
                        <a href="#" class="btn primary" onclick="showAdd();return false;">Add Territory</a>
                    </div>
                </div>

                <asp:SqlDataSource ID="dsSales" runat="server" ConnectionString="<%$ ConnectionStrings:AdventureWorks %>" OnInserted="dsSales_Inserted" CancelSelectOnNullParameter="false"
                    SelectCommand="SELECT TOP 100 TerritoryID, Name, CountryRegionCode, [Group] FROM Sales.SalesTerritory WHERE (@q IS NULL OR @q = '' OR Name LIKE '%' + @q + '%' OR CountryRegionCode LIKE '%' + @q + '%') ORDER BY TerritoryID DESC"
                    InsertCommand="INSERT INTO Sales.SalesTerritory (Name, CountryRegionCode, [Group]) VALUES (@Name, @CountryRegionCode, @Group)"
                    UpdateCommand="UPDATE Sales.SalesTerritory SET Name=@Name, CountryRegionCode=@CountryRegionCode, [Group]=@Group WHERE TerritoryID=@TerritoryID"
                    DeleteCommand="DELETE FROM Sales.SalesTerritory WHERE TerritoryID=@TerritoryID">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtSearch" Name="q" PropertyName="Text" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Name" Type="String" />
                        <asp:Parameter Name="CountryRegionCode" Type="String" />
                        <asp:Parameter Name="Group" Type="String" />
                        <asp:Parameter Name="TerritoryID" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="Name" Type="String" />
                        <asp:Parameter Name="CountryRegionCode" Type="String" />
                        <asp:Parameter Name="Group" Type="String" />
                    </InsertParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="TerritoryID" Type="Int32" />
                    </DeleteParameters>
                </asp:SqlDataSource>

                <asp:GridView ID="GridView1" runat="server" CssClass="grid" DataSourceID="dsSales" AutoGenerateColumns="False" DataKeyNames="TerritoryID" AllowPaging="true" PageSize="20" AllowSorting="true" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="TerritoryID" HeaderText="ID" ReadOnly="True" SortExpression="TerritoryID" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="CountryRegionCode" HeaderText="Country" SortExpression="CountryRegionCode" />
                        <asp:BoundField DataField="Group" HeaderText="Group" SortExpression="Group" />
                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                    </Columns>
                    <HeaderStyle BackColor="#f3f4f6" />
                    <RowStyle BackColor="#ffffff" />
                    <AlternatingRowStyle BackColor="#fafafa" />
                    <SelectedRowStyle BackColor="#e0e7ff" />
                    <EditRowStyle BackColor="#fff7ed" />
                    <PagerStyle CssClass="aspnet-pager" />
                </asp:GridView>

                <div id="addModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <strong>Add Territory</strong>
                            <a href="#" class="btn" onclick="hideAdd();return false;">Close</a>
                        </div>
                        <div class="modal-body">
                            <asp:Label ID="lblAddStatus" runat="server" EnableViewState="false" />
                            <asp:DetailsView ID="DetailsView1" runat="server" DataSourceID="dsSales" DefaultMode="Insert" AutoGenerateRows="False" CssClass="grid" GridLines="None">
                                <Fields>
                                    <asp:BoundField DataField="Name" HeaderText="Name" />
                                    <asp:BoundField DataField="CountryRegionCode" HeaderText="Country Code" />
                                    <asp:BoundField DataField="Group" HeaderText="Group" />
                                    <asp:CommandField ShowInsertButton="True" />
                                </Fields>
                            </asp:DetailsView>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </form>
</body>
</html>


