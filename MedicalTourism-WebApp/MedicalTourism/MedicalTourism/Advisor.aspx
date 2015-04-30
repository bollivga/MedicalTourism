<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Advisor.aspx.cs" Inherits="MedicalTourism.Advisor" %>

<!DOCTYPE html>

<html>
<head>
    <title>Medical Tourism Advisor</title>
</head>
<body>

    <h1>Medical Tourism Advisor</h1>
    <p><b>Please fill out this form regarding your desired medical procedure</b></p>
    <form method="post" action="Advisor.aspx">
    <p>Surgery Category:</p>
    <select name="category">
        <option value="Neurosrgy">Neurosurgery</option>
        <option value="Cosmetic">Cosmetic</option>
        <option value="Organ trns">Organ Transplant</option>
        <option value="Orthopedic">Orthopedic</option>
        <option value="Thoracic">Thoracic</option>
        <option value="Endocrine">Endocrine</option>
    </select>
    <p>Country Preferred:</p>
    <select name="country">
        <option value="--">--</option>
        <option value="Austria">Austria</option>
        <option value="Brazil">Brazil</option>
        <option value="Bulgaria">Bulgaria</option>
        <option value="Chile">Chile</option>
        <option value="China">China</option>
        <option value="Egypt">Egypt</option>
        <option value="England">England</option>
        <option value="France">France</option>
        <option value="Germany">Germany</option>
        <option value="India">India</option>
        <option value="Ireland">Ireland</option>
        <option value="Italy">Italy</option>
        <option value="Japan">Japan</option>
        <option value="Norway">Norway</option>
        <option value="S.Korea">South Korea</option>
        <option value="Scotland">Scotland</option>
        <option value="Spain">Spain</option>
        <option value="Sweden">Sweden</option>
        <option value="Ukraine">Ukraine</option>
    </select>
    <p>Minimum Rating (Out of 5):</p>
    <select name="rating">
        <option value="0">0</option>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
    </select>
    <p></p>
    <input type="submit" id="submit" value="Submit"/>
    </form>
    <p><asp:PlaceHolder ID = "PlaceHolder1" runat="server" /></p>
</body>
</html>
