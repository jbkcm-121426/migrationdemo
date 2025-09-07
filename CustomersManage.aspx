<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomersManage.aspx.cs" Inherits="MigrationDemo.CustomersManage" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Manage Customers</title>
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
        .grid { margin-top: 12px; background:#fff; border:1px solid var(--border); border-radius:8px; padding: 0; overflow:hidden; }
        .grid table { width:100%; border-collapse: separate; border-spacing:0; }
        .grid th { background: var(--header); text-align:left; padding:10px 12px; font-weight:600; border-bottom:1px solid var(--border); }
        .grid td { padding:10px 12px; border-bottom:1px solid var(--border); vertical-align: middle; }
        .grid tr:nth-child(even) td { background: var(--alt); }
        h2 { margin: 0 0 12px; font-weight:600; }
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
                    <h2>Manage Customers</h2>
                    <div class="search">
                        <asp:TextBox ID="txtSearch" runat="server" Placeholder="Search by name, email or phone" />
                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn" OnClick="btnClear_Click" />
                    </div>
                    <div>
                        <a href="Default.aspx" class="btn">Home</a>
                        <a href="#" class="btn primary" onclick="showAdd();return false;">Add Customer</a>
                    </div>
                </div>

                <asp:SqlDataSource ID="dsManage" runat="server" ConnectionString="<%$ ConnectionStrings:AdventureWorks %>" CancelSelectOnNullParameter="false"
                    SelectCommand="SELECT TOP 200 p.BusinessEntityID, p.FirstName, p.LastName, ea.EmailAddress, ph.PhoneNumber FROM Person.Person p LEFT JOIN Person.EmailAddress ea ON ea.BusinessEntityID = p.BusinessEntityID LEFT JOIN Person.PersonPhone ph ON ph.BusinessEntityID = p.BusinessEntityID AND ph.PhoneNumberTypeID=1 WHERE EXISTS (SELECT 1 FROM Sales.Customer c WHERE c.PersonID = p.BusinessEntityID) AND (@q IS NULL OR @q = '' OR p.FirstName LIKE '%' + @q + '%' OR p.LastName LIKE '%' + @q + '%' OR ea.EmailAddress LIKE '%' + @q + '%' OR ph.PhoneNumber LIKE '%' + @q + '%') ORDER BY p.BusinessEntityID DESC"
                    InsertCommand="dbo.usp_Customer_Insert" InsertCommandType="StoredProcedure"
                    UpdateCommand="dbo.usp_Customer_Update" UpdateCommandType="StoredProcedure"
                    DeleteCommand="dbo.usp_Customer_Delete" DeleteCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="txtSearch" Name="q" PropertyName="Text" Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="FirstName" Type="String" />
                        <asp:Parameter Name="LastName" Type="String" />
                        <asp:Parameter Name="EmailAddress" Type="String" />
                        <asp:Parameter Name="PhoneNumber" Type="String" />
                        <asp:Parameter Name="BusinessEntityID" Type="Int32" Direction="Output" />
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="BusinessEntityID" Type="Int32" />
                        <asp:Parameter Name="FirstName" Type="String" />
                        <asp:Parameter Name="LastName" Type="String" />
                        <asp:Parameter Name="EmailAddress" Type="String" />
                        <asp:Parameter Name="PhoneNumber" Type="String" />
                    </UpdateParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="BusinessEntityID" Type="Int32" />
                    </DeleteParameters>
                </asp:SqlDataSource>

                <asp:GridView ID="GridView1" runat="server" CssClass="grid" DataSourceID="dsManage" AutoGenerateColumns="False" DataKeyNames="BusinessEntityID" AllowPaging="true" PageSize="20" AllowSorting="true" AutoGenerateEditButton="True" AutoGenerateDeleteButton="True">
                    <Columns>
                        <asp:BoundField DataField="BusinessEntityID" HeaderText="ID" ReadOnly="True" SortExpression="BusinessEntityID" />
                        <asp:BoundField DataField="FirstName" HeaderText="First" SortExpression="FirstName" />
                        <asp:BoundField DataField="LastName" HeaderText="Last" SortExpression="LastName" />
                        <asp:BoundField DataField="EmailAddress" HeaderText="Email" SortExpression="EmailAddress" />
                        <asp:BoundField DataField="PhoneNumber" HeaderText="Phone" SortExpression="PhoneNumber" />
                    </Columns>
                </asp:GridView>

                <div id="addModal" class="modal">
                    <div class="modal-content">
                        <div class="modal-header">
                            <strong>Add Customer</strong>
                            <a href="#" class="btn" onclick="hideAdd();return false;">Close</a>
                        </div>
                        <div class="modal-body">
                            <asp:Label ID="lblAddStatus" runat="server" EnableViewState="false" />
                            <asp:DetailsView ID="DetailsView1" runat="server" DataSourceID="dsManage" DefaultMode="Insert" AutoGenerateRows="False">
                                <Fields>
                                    <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                                    <asp:BoundField DataField="LastName" HeaderText="Last Name" />
                                    <asp:BoundField DataField="EmailAddress" HeaderText="Email" />
                                    <asp:BoundField DataField="PhoneNumber" HeaderText="Phone" />
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


