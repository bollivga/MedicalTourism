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
            <div runat="server" visible="false" id="adminForm">
                <h2>Edit the database below:</h2>

                    <!--AIRLINES-->
                    <div>
                    <h3>Current airlines:</h3>
                        <p><asp:GridView runat="server" ID="currentAirlines"/></p>
                    <h3>Add a new airline:</h3>
                        <p>Airline Name:</p>
                            <asp:TextBox runat="server" ID="adminAddAirlineName"/>
                        <asp:Button runat="server" Text="Add" ID="adminAddAirline" OnClick="addAirline"/> 
                        <asp:PlaceHolder runat="server" ID="adminAddedAirline"/>
                    <h3>Edit an airline:</h3>
                        <p>Select an airline ID from above:</p>
                            <p><asp:TextBox runat="server" ID="adminEditAirlineID"/></p>
                        <p>Select a new name for an airline:</p>
                            <p><asp:TextBox runat="server" ID="adminEditAirlineName"/></p>
                        <p><asp:Button Text="Update" runat="server" ID="adminEditAirline" OnClick="editAirline"/></p>
                        <asp:PlaceHolder runat="server" ID="adminEditedAirline"/>
                    <h3>Delete an airline:</h3>
                        <p>Select an airline ID from above:</p>
                            <p><asp:TextBox runat="server" ID="adminDeleteAirlineID"/></p>
                        <p><asp:Button runat="server" Text="Delete" ID="adminDeleteAirline" OnClick="deleteAirline"/></p>
                        <p><asp:PlaceHolder runat="server" ID="adminDeletedAirline"/></p>
                    </div>
                    
                    <!--CITIES-->
                    <div>
                    <h3>Current cities:</h3>
                        <p><asp:GridView runat="server" ID="currentCities"/></p>

                    <h3>Add a new city:</h3>
                        <p>City name:</p>
                            <p><asp:TextBox runat="server" ID="adminAddCityName"/></p>
                        <p>Rating:</p>
                            <p><asp:DropDownList runat="server" ID="adminAddCityRating">
                                <asp:ListItem Text="--" Value="--"></asp:ListItem>
                                <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                <asp:ListItem Text="5" Value="5"></asp:ListItem>
                            </asp:DropDownList></p>
                        <p>Country:</p>
                            <p><asp:TextBox runat="server" ID="adminAddCityCountry"/></p>
                        <p><asp:Button runat="server" Text="Add" ID="adminAddCity" OnClick="addCity"/></p>
                        <p><asp:PlaceHolder runat="server" ID="adminAddedCity"/></p>

                    <h3>Edit a city:</h3>
                        <p>Select a city ID from above:</p>
                            <p><asp:TextBox runat="server" ID="adminEditCityID"/></p>
                        <p>New city name:</p>
                            <p><asp:TextBox runat="server" ID="adminEditCityName"/></p>
                        <p>New city rating:</p>
                            <p><asp:DropDownList runat="server" ID="adminEditCityRating">
                                <asp:ListItem Text="--" Value="--"></asp:ListItem>
                                <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                <asp:ListItem Text="5" Value="5"></asp:ListItem>
                            </asp:DropDownList></p>
                        <p>New country name:</p>
                            <p><asp:TextBox runat="server" ID="adminEditCityCountry"/></p>
                        <p><asp:Button runat="server" Text="Update" ID="adminEditCity" OnClick="editCity"/></p>
                        <p><asp:PlaceHolder runat="server" ID="adminEditedCity"/></p>
                    
                    <h3>Delete a city:</h3>
                        <p>Select a city ID from above:</p>
                            <p><asp:TextBox runat="server" ID="adminDeleteCityID"/></p>
                        <p><asp:Button runat="server" Text="Delete" ID="adminDeleteCity" OnClick="deleteCity"/></p>
                        <p><asp:PlaceHolder runat="server" ID="adminDeletedCity"/></p>
                    </div>
                    
                    <!--HOSPITALS-->
                    <div>
                        <h3>Current hospitals:</h3>
                            <p><asp:GridView runat="server" ID="currentHospitals"/></p>

                        <h3>Add a new hospital:</h3>
                            <p>Hospital Name:</p>
                                <p><asp:TextBox runat="server" ID="adminAddHospitalName"/></p>
                            <p>Rating:</p>
                                <p><asp:DropDownList runat="server" ID="adminAddHospitalRating">
                                    <asp:ListItem Text="--" Value="--"></asp:ListItem>
                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                </asp:DropDownList></p>
                            <p>City ID:</p>
                                <p><asp:TextBox runat="server" ID="adminAddHospitalCityID"/></p>
                            <p><asp:Button runat="server" Text="Add" id="adminAddHospital" OnClick="addHospitalAdmin"/></p>
                            <p><asp:PlaceHolder runat="server" ID="adminAddedHospital"/></p>

                        <h3>Edit a hospital:</h3>
                            <p>Select a hospital ID from above:</p>
                                <p><asp:TextBox runat="server" ID="adminEditHospitalID"/></p>
                            <p>Enter a new rating for this hospital:</p>
                                <p><asp:DropDownList runat="server" ID="adminEditHospitalRating">
                                    <asp:ListItem Text="--" Value="--"></asp:ListItem>
                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                </asp:DropDownList></p>
                            <p>Enter a new name for this hospital:</p>
                                <p><asp:TextBox runat="server" ID="adminEditHospitalName"/></p>
                            <p>Enter a new city ID for this hospital:</p>
                                <p><asp:DropDownList runat="server" ID="adminEditHospitalCityID"></asp:DropDownList></p>
                            <p><asp:Button runat="server" Text="Update" ID="adminEditHospital" OnClick="editHospitalAdmin"/></p>
                            <p><asp:PlaceHolder runat="server" ID="adminEditedHospital"/></p>

                        <h3>Delete a hospital:</h3>
                            <p>Select a hospital ID from above:</p>
                                <p><asp:TextBox runat="server" ID="adminDeleteHospitalID"/></p>
                            <p><asp:Button runat="server" Text="Delete" ID="adminDeleteHospital" OnClick="deleteHospitalAdmin"/></p>
                            <p><asp:PlaceHolder runat="server" ID="adminDeletedHospital"/></p>
                    </div>

                    <!--HOTELS-->
                    <div>
                        <h3>Current hotels:</h3>
                            <p><asp:GridView runat="server" ID="currentHotels"/></p>

                        <h3>Add a hotel:</h3>
                            <p>Hotel name:</p>
                                <p><asp:TextBox runat="server" ID="adminAddHotelName"/></p>
                            <p>City ID:</p>
                                <p><asp:TextBox runat="server" ID="adminAddHotelCityID"/></p>
                            <p>Cost per night:</p>
                                <p><asp:TextBox runat="server" ID="adminAddHotelCost"/></p>
                            <p><asp:Button runat="server" Text="Add" ID="adminAddHotel" OnClick="addHotel"/></p>
                            <p><asp:PlaceHolder runat="server" ID="adminAddedHotel"/></p>
                        
                        <h3>Edit a hotel:</h3>
                            <p>Select a hotel ID from above:</p>
                                <p><asp:TextBox runat="server" ID="adminEditHotelID"/></p>
                            <p>Enter a new name for this hotel:</p>
                                <p><asp:TextBox runat="server" ID="adminEditHotelName"/></p>
                            <p>Enter a new cost per night for this hotel:</p>
                                <p><asp:TextBox runat="server" ID="adminEditHotelCost"/></p>
                            <p>Enter a new city ID for this hotel:</p>
                                <p><asp:TextBox runat="server" ID="adminEditHotelCityID"/></p>
                            <p><asp:Button runat="server" Text="Update" ID="adminEditHotel" OnClick="editHotel"/></p>
                            <p><asp:PlaceHolder runat="server" ID="adminEditedHotel"/></p>

                        <h3>Delete a hotel:</h3>
                            <p>Select a hotel ID from above:</p>
                                <p><asp:TextBox runat="server" ID="adminDeleteHotelID"/></p>
                            <p><asp:Button runat="server" Text="Delete" ID="adminDeleteHotel" OnClick="deleteHotel"/></p>
                            <p><asp:PlaceHolder runat="server" ID="adminDeletedHotel"/></p>
                    </div>
                    
                    <!--OFFERS-->
                    <div>
                        <h3>Current surgeries offered:</h3>
                            <p><asp:GridView runat="server" ID="currentOffers"/></p>
                        <h3>Add an offer:</h3>
                            <p>Surgery name:</p>
                                <p><asp:TextBox runat="server" ID="adminAddOfferSurgName"/></p>
                            <p>Hospital ID:</p>
                                <p><asp:TextBox runat="server" ID="adminAddOfferHospitalID"/></p>
                            <p>Price:</p>
                                <p><asp:TextBox runat="server" ID="adminAddOfferPrice"/></p>
                            <p><asp:Button runat="server" Text="Add" ID="adminAddOffer" OnClick="addOfferAdmin"/></p>
                            <p><asp:PlaceHolder runat="server" ID="adminAddedOffer"/></p>

                        <h3>Edit an offer:</h3>
                            <p>Select a surgery name from above:</p>
                                <p><asp:TextBox runat="server" ID="adminEditOfferSurgName"/></p>
                            <p>Enter a hospital ID:</p>
                                <p><asp:TextBox runat="server" ID="adminEditOfferHospitalID"/></p>
                            <p>Enter the cost:</p>
                                <p><asp:TextBox runat="server" ID="adminEditOfferCost"/></p>
                            <p><asp:Button runat="server" Text="Update" ID="adminEditOffer" OnClick="editOfferAdmin"/></p>
                            <p><asp:PlaceHolder runat="server" ID="adminEditedOffer"/></p>

                        <h3>Delete an offer:</h3>
                            <p>Select a surgery name from above:</p>
                                <p><asp:TextBox runat="server" ID="adminDeleteOfferSurgName"/></p>
                            <p>Select a hospital ID:</p>
                                <p><asp:TextBox runat="server" ID="adminDeleteOfferHospitalID"/></p>
                            <p><asp:Button runat="server" Text="Delete" ID="adminDeleteOffer" OnClick="deleteOfferAdmin"/></p>
                            <p><asp:PlaceHolder runat="server" ID="adminDeletedOffer"/></p>
                    </div>

                    <!--SURGERIES-->
                    <div>
                        <h3>Current surgeries:</h3>
                            <p><asp:GridView runat="server" ID="currentSurg"/></p>
                        <h3>Add a new surgery:</h3>
                            <p>Surgery name:</p>
                                <p><asp:TextBox runat="server" ID="adminAddSurgName"/></p>
                            <p>Surgery type:</p>
                                <p><asp:TextBox runat="server" ID="adminAddSurgType"/></p>
                            <p>Huge cost:</p>
                                <p><asp:TextBox runat="server" ID="adminAddSurgHugeCost"/></p>
                            <p>Recovery time:</p>
                                <p><asp:TextBox runat="server" ID="adminAddSurgRecTime"/></p>
                            <p><asp:Button runat="server" Text="Add" ID="adminAddSurg" OnClick="addSurgery"/></p>
                            <p><asp:PlaceHolder runat="server" ID="adminAddedSurg"/></p>

                        <h3>Edit a surgery:</h3>
                            <p>Select a surgery name from above:</p>
                                <p><asp:TextBox runat="server" ID="adminEditSurgName"/></p>
                            <p>Enter a surgery type:</p>
                                <p><asp:TextBox runat="server" ID="adminEditSurgType"/></p>
                            <p>Enter the cost in USD:</p>
                                <p><asp:TextBox runat="server" ID="adminEditSurgCost"/></p>
                            <p>Enter the recovery time:</p>
                                <p><asp:TextBox runat="server" ID="adminEditSurgRecTime"/></p>
                            <p><asp:Button runat="server" Text="Update" ID="adminEditSurg" OnClick="editSurgery"/></p>
                            <p><asp:PlaceHolder runat="server" ID="adminEditedSurg"/></p>

                        <h3>Delete a surgery:</h3>
                            <p>Select a surgery name from above:</p>
                                <p><asp:TextBox runat="server" ID="adminDeleteSurgName"/></p>
                           <p><asp:Button runat="server" Text="Delete" ID="adminDeleteSurg" OnClick="deleteSurgery"/></p>
                           <p><asp:PlaceHolder runat="server" ID="adminDeletedSurg"/></p>

                    </div>

                    <!--VISITS-->
                    <div>
                        <h3>Current visits:</h3>
                            <p><asp:GridView runat="server" ID="currentVisits"/></p>
                        <h3>Add a new visit:</h3>
                            <p>Airline ID:</p>
                                <p><asp:TextBox runat="server" ID="adminAddVisitAirlineID"/></p>
                            <p>City ID:</p>
                                <p><asp:TextBox runat="server" ID="adminAddVisitCityID"/></p>
                            <p>Cost:</p>
                                <p><asp:TextBox runat="server" ID="adminAddVisitCost"/></p>
                            <p><asp:Button runat="server" Text="Add" ID="adminAddVisit" OnClick="addVisit"/></p>
                            <p><asp:PlaceHolder runat="server" ID="adminAddedVisit"/></p>
                        <h3>Edit a visit:</h3>
                            <p>Select an airline ID:</p>
                                <p><asp:TextBox runat="server" ID="adminEditVisitAirlineID"/></p>
                            <p>Select a city ID:</p>
                                <p><asp:TextBox runat="server" ID="adminEditVisitCityID"/></p>
                            <p>Enter a new cost:</p>
                                <p><asp:TextBox runat="server" ID="adminEditVisitCost"/></p>
                            <p><asp:Button runat="server" Text="Edit" ID="adminEditVisit" OnClick="editVisit"/></p>
                            <p><asp:PlaceHolder runat="server" ID="adminEditedVisit"/></p>
                        <h3>Delete a visit:</h3>
                            <p>Select an airline ID from above:</p>
                                <p><asp:TextBox runat="server" ID="adminDeleteVisitAirlineID"/></p>
                            <p>Select a city ID from above:</p>
                                <p><asp:TextBox runat="server" ID="adminDeleteVisitCityID"/></p>
                            <p><asp:Button runat="server" Text="Delete" ID="adminDeleteVisit" OnClick="deleteVisit"/></p>
                            <p><asp:PlaceHolder runat="server" ID="adminDeletedVisit"/></p>
                    </div>
                    
            </div>
        </div>
        <p></p>
    </form>
</body>
</html>
