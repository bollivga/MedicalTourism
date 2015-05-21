<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MedicalTourism.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <h1>Register for a hospital account</h1>
    <p><b>Your account will be approved within 1-2 days</b></p>
    <form id="form1" runat="server">
    <div>
        <p>
            <asp:TextBox runat="server" ID="username"/>
            <asp:TextBox runat="server" ID="password" TextMode="Password"/>
            <asp:Button runat="server" ID="register" Text="Register" OnClick="reg"/>
        </p>
        <p><asp:PlaceHolder runat="server" ID="message"/></p>
    </div>
    </form>
</body>
</html>
