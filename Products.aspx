<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="MigrationDemo.Products" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Products</title>
    <meta charset="utf-8" />
    <style>
        :root { --primary:#2563eb; --border:#e5e7eb; --text:#111827; --muted:#6b7280; --header:#f3f4f6; --alt:#fafafa; }
        body { font-family: Segoe UI, Arial, sans-serif; margin: 0; color: var(--text); background:#f9fafb; }
        .wrap { max-width: 1100px; margin: 36px auto; padding: 0 20px; }
        .card { padding: 20px; border: 1px solid var(--border); border-radius: 10px; background:#fff; box-shadow: 0 1px 2px rgba(0,0,0,.04); }
        .toolbar { display:flex; justify-content: space-between; align-items:center; gap:12px; margin-bottom: 10px; }
        .toolbar a { display:inline-block; padding:8px 12px; background:var(--primary); color:#fff; border-radius:8px; text-decoration:none; }
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
        .btn-link { display:inline-block; padding:6px 10px; border:1px solid var(--border); border-radius:6px; text-decoration:none; color:var(--text); }
        h2 { margin: 0 0 12px; font-weight:600; }
        h3 { margin: 18px 0 8px; }
        /* Modal */
        .modal { position: fixed; inset: 0; background: rgba(0,0,0,.35); display:none; align-items:center; justify-content:center; padding: 20px; }
        .modal.show { display:flex; }
        .modal-content { width: 520px; background:#fff; border-radius: 12px; border:1px solid var(--border); box-shadow: 0 10px 30px rgba(0,0,0,.15); overflow:hidden; }
        .modal-header { padding:14px 16px; background:#f8fafc; border-bottom:1px solid var(--border); display:flex; justify-content:space-between; align-items:center; }
        .modal-body { padding: 14px 16px; }
        .btn { padding:8px 12px; border-radius:8px; border:1px solid var(--border); background:#fff; color:var(--text); text-decoration:none; }
        .btn.primary { background: var(--primary); color:#fff; border-color: var(--primary); }
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
                    <h2>AdventureWorks Products</h2>
                    <a href="Default.aspx">Home</a>
                </div>
                <asp:SqlDataSource ID="dsProducts" runat="server" ConnectionString="<%$ ConnectionStrings:AdventureWorks %>" OnInserted="dsProducts_Inserted" CancelSelectOnNullParameter="false"
                    SelectCommand="SELECT TOP 100 ProductID, Name, ProductNumber, ListPrice FROM Production.Product WHERE (@q IS NULL OR @q = '' OR Name LIKE '%' + @q + '%' OR ProductNumber LIKE '%' + @q + '%') ORDER BY ProductID DESC"
                    InsertCommand="INSERT INTO Production.Product (Name, ProductNumber, SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, DaysToManufacture, SellStartDate) VALUES (@Name, @ProductNumber, @SafetyStockLevel, @ReorderPoint, @StandardCost, @ListPrice, @DaysToManufacture, @SellStartDate)"
                    UpdateCommand="UPDATE Production.Product SET Name=@Name, ProductNumber=@ProductNumber, ListPrice=@ListPrice WHERE ProductID=@ProductID"
                    DeleteCommand="DELETE FROM Production.Product WHERE ProductID=@ProductID">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtSearch" Name="q" PropertyName="Text" Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="Name" Type="String" />
                        <asp:Parameter Name="ProductNumber" Type="String" />
                        <asp:Parameter Name="SafetyStockLevel" Type="Int32" DefaultValue="10" />
                        <asp:Parameter Name="ReorderPoint" Type="Int32" DefaultValue="5" />
                        <asp:Parameter Name="StandardCost" Type="Decimal" DefaultValue="0" />
                        <asp:Parameter Name="ListPrice" Type="Decimal" />
                        <asp:Parameter Name="DaysToManufacture" Type="Int32" DefaultValue="0" />
                        <asp:Parameter Name="SellStartDate" Type="DateTime" DefaultValue="2005-07-01" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="Name" Type="String" />
                        <asp:Parameter Name="ProductNumber" Type="String" />
                        <asp:Parameter Name="ListPrice" Type="Decimal" />
                        <asp:Parameter Name="ProductID" Type="Int32" />
                    </UpdateParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="ProductID" Type="Int32" />
                    </DeleteParameters>
                </asp:SqlDataSource>

                <div class="toolbar">
                    <div class="search">
                        <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search by name or number" />
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" OnClick="btnClear_Click" />
                    </div>
                    <a href="#" class="btn primary" onclick="showAdd();return false;">Add Product</a>
                </div>
                <asp:GridView ID="GridView1" runat="server" CssClass="grid" DataSourceID="dsProducts" AutoGenerateColumns="False" DataKeyNames="ProductID" AllowPaging="true" PageSize="20" AllowSorting="true" GridLines="None">
                    <Columns>
                        <asp:BoundField DataField="ProductID" HeaderText="ID" ReadOnly="True" SortExpression="ProductID" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="ProductNumber" HeaderText="Number" SortExpression="ProductNumber" />
                        <asp:BoundField DataField="ListPrice" HeaderText="Price" DataFormatString="{0:C}" SortExpression="ListPrice" />
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
                            <strong>Add Product</strong>
                            <a href="#" class="btn" onclick="hideAdd();return false;">Close</a>
                        </div>
                        <div class="modal-body">
                            <asp:Label ID="lblAddStatus" runat="server" EnableViewState="false" />
                            <asp:DetailsView ID="DetailsView1" runat="server" DataSourceID="dsProducts" DefaultMode="Insert" AutoGenerateRows="False" CssClass="grid" GridLines="None">
                                <Fields>
                                    <asp:BoundField DataField="Name" HeaderText="Name" InsertVisible="True" />
                                    <asp:BoundField DataField="ProductNumber" HeaderText="Number" InsertVisible="True" />
                                    <asp:BoundField DataField="ListPrice" HeaderText="Price" InsertVisible="True" />
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




