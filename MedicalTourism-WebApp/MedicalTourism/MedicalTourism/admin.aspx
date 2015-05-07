<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="MedicalTourism.admin" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Admin Login</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <p>Please input your username and PIN number:</p>
            <asp:TextBox runat="server" id="username"/>
            <asp:TextBox runat="server" id="pin" TextMode="Password"/>
            <asp:Button runat="server" id="loginSubmit" Text="Submit" OnClick="login"/>
        </div>
        <div>
            <asp:PlaceHolder runat="server" id="editForm"/>
            <div runat="server" visible="false" id="addForm">
                <h3>Add a new hospital:</h3>
                <p>Hospital name:</p>
                <asp:TextBox runat="server" id="hospitalName"/>
                <p>City ID:</p>
                <asp:TextBox runat="server" id="cityName"/>
                <asp:Button runat="server" Text="Add" id="addH" OnClick="addHospital"/>
                <asp:PlaceHolder runat="server" ID="addedHospital"/>
                <h3>Add a new surgery:</h3>
                <p>Hospital ID:</p>
                <asp:TextBox runat="server" id="hospitalForSurgery"/>
                <p>Surgery name:</p>
                <asp:TextBox runat="server" id="surgeryName"/>
                <p>Price:</p>
                <asp:TextBox runat="server" id="surgeryPrice"/>
                <asp:Button runat="server" Text="Add" id="addS" OnClick="addOffer"/>
                <asp:PlaceHolder runat="server" ID="addedSurgery"/>
            </div>
        </div>
        <p></p>
    </form>
</body>
</html>
