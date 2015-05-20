<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Advisor.aspx.cs" Inherits="MedicalTourism.Advisor" %>

<!DOCTYPE html>

<html>
<head>
    <title>Medical Tourism Advisor</title>
</head>
<body>

    <h1>Medical Tourism Advisor</h1>
    <p><b>Please fill out this form regarding your desired medical procedure</b></p>
    <form runat="server">
        <p>Surgery Category:</p>
        <asp:DropDownList runat="server" id="category"></asp:DropDownList>
        <p>Country Preferred:</p>
        <asp:DropDownList runat="server" id="country"></asp:DropDownList>
        <p>Minimum Rating (Out of 5):</p>
        <select id="rating" runat="server">
            <option value="0">0</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
        </select>
        <p></p>
        <asp:Button runat="server" Text="Submit" ID="aspsubmit" OnClick="aspsubmit_Click"/>
        <p><asp:PlaceHolder ID = "PlaceHolder1" runat="server"/></p>
        <div runat="server" visible="false" ID="secondForm">
            <p>Select a city from the results:</p>
            <p><asp:DropDownList runat="server" ID="city"/></p>
            <p>Select a surgery form the results:</p>
            <p><asp:DropDownList runat="server" ID="surgery"/></p>
            <p><asp:Button runat="server" Text="Submit" ID="submitFirstResults" OnClick="resultSubmit"/></p>
        </div>
        <div runat="server" visible="false" ID="thirdForm">
            <p>Trip info:</p>
            <p><asp:GridView runat="server" ID="tripInfo"/></p>
            <p>Price info:</p>
            <p><asp:GridView runat="server" ID="priceInfo"/></p>
        </div>
    </form>
    <div class="footer" style="position:absolute; bottom:0;">
        <p><asp:HyperLink runat="server" Text="Admin login" NavigateUrl="~/admin.aspx"/></p>
        <p><asp:HyperLink runat="server" Text="Register as a hospital" NavigateUrl="~/Register.aspx"/></p>
    </div>
</body>
</html>
