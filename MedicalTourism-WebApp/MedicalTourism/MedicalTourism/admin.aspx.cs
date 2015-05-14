using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.Configuration;
using System.Data.SqlClient;

namespace MedicalTourism
{
    public partial class admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            selectFromDatabase();
        }

        protected void login(object sender, EventArgs e)
        {

            string user = String.Format("{0}", username.Text);
            string pinNumber = String.Format("{0}", pin.Text);

            if (user == "hospital" && pinNumber == "0000") 
            {
                adminForm.Visible = false;
                addForm.Visible = true;

                ////Building an HTML string.
                //StringBuilder html = new StringBuilder();

                ////Text boxes and their headers:
                //html.Append("<h3>Add a new hospital:</h3>");
                //html.Append("<p>Hospital name:</p>");
                //html.Append("<asp:TextBox runat=\"server\" id=\"hospitalName\"/>");
                //html.Append("<p>City name:</p>");
                //html.Append("<asp:TextBox runat=\"server\" id=\"cityName\"/>");
                //html.Append("<asp:Button runat=\"server\" id=\"addH\" OnClick=\"addHospital\">");
                //html.Append("<h3>Add a new surgery:</h3>");
                //html.Append("<p>Hospital name:</p>");
                //html.Append("<asp:TextBox runat=\"server\" id=\"hospitalForSurgery\"/>");
                //html.Append("<p>Surgery name:</p>");
                //html.Append("<asp:TextBox runat=\"server\" id=\"surgeryName\"/>");
                //html.Append("<asp:Button runat=\"server\" id=\"addS\" OnClick=\"addSurgery\">");

                ////Append the HTML string to Placeholder.
                //editForm.Controls.Add(new Literal { Text = html.ToString() });


            }
            else if (user == "admin" && pinNumber == "1234") {

                addForm.Visible = false;
                adminForm.Visible = true;


            }
            else
            {

                StringBuilder html = new StringBuilder();
                html.Append("<div style=\"color:#FF0000\"><p>Invalid username or password.</p></div>");
                editForm.Controls.Add(new Literal { Text = html.ToString() });

            }

            

        }

        private void selectFromDatabase() {

            //Populating a DataTable from database.
            SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=MedicalTourism;connection timeout=30");
            SqlCommand airlineSelect = new SqlCommand();
            SqlCommand citySelect = new SqlCommand();
            SqlCommand hospitalSelect = new SqlCommand();
            SqlCommand hotelSelect = new SqlCommand();
            SqlCommand offersSelect = new SqlCommand();
            SqlCommand surgerySelect = new SqlCommand();
            SqlCommand visitsSelect = new SqlCommand();
            airlineSelect.CommandText = "SELECT A_ID AS AirlineID, Name AS AirlineName FROM Airline";
            airlineSelect.CommandType = CommandType.Text;
            airlineSelect.Connection = con;
            citySelect.CommandText = "SELECT * FROM CITY";
            citySelect.CommandType = CommandType.Text;
            citySelect.Connection = con;
            hospitalSelect.CommandText = "SELECT * FROM Hospital";
            hospitalSelect.CommandType = CommandType.Text;
            hospitalSelect.Connection = con;
            hotelSelect.CommandText = "SELECT * FROM Hotel";
            hotelSelect.CommandType = CommandType.Text;
            hotelSelect.Connection = con;
            offersSelect.CommandText = "SELECT * FROM Offers";
            offersSelect.CommandType = CommandType.Text;
            offersSelect.Connection = con;
            surgerySelect.CommandText = "SELECT * FROM Surgery";
            surgerySelect.CommandType = CommandType.Text;
            surgerySelect.Connection = con;
            visitsSelect.CommandText = "SELECT * FROM Visits";
            visitsSelect.CommandType = CommandType.Text;
            visitsSelect.Connection = con;
            

            airlineSelect.Connection.Open();
            SqlDataReader airlineDR = airlineSelect.ExecuteReader(CommandBehavior.CloseConnection);
            currentAirlines.DataSource = airlineDR;
            currentAirlines.DataBind();

            citySelect.Connection.Open();
            SqlDataReader cityDR = citySelect.ExecuteReader(CommandBehavior.CloseConnection);
            currentCities.DataSource = cityDR;
            currentCities.DataBind();

            hospitalSelect.Connection.Open();
            SqlDataReader hospitalDR = hospitalSelect.ExecuteReader(CommandBehavior.CloseConnection);
            currentHospitals.DataSource = hospitalDR;
            currentHospitals.DataBind();

            hotelSelect.Connection.Open();
            SqlDataReader hotelDR = hotelSelect.ExecuteReader(CommandBehavior.CloseConnection);
            currentHotels.DataSource = hotelDR;
            currentHotels.DataBind();

            offersSelect.Connection.Open();
            SqlDataReader offersDR = offersSelect.ExecuteReader(CommandBehavior.CloseConnection);
            currentOffers.DataSource = offersDR;
            currentOffers.DataBind();

            surgerySelect.Connection.Open();
            SqlDataReader surgeryDR = surgerySelect.ExecuteReader(CommandBehavior.CloseConnection);
            currentSurg.DataSource = surgeryDR;
            currentSurg.DataBind();

            visitsSelect.Connection.Open();
            SqlDataReader visitsDR = visitsSelect.ExecuteReader(CommandBehavior.CloseConnection);
            currentVisits.DataSource = visitsDR;
            currentVisits.DataBind();



        }

        //ADMIN FUNCTIONS

        //AIRLINE STORED PROCEDURE CALLS
        protected void addAirline(object sender, EventArgs e)
        {
            string name = String.Format("{0}", adminAddAirlineName.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("NewAirline", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@AirlineName", name);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminAddedAirline.Controls.Add(new Literal { Text = "Airline added successfully." });
                        selectFromDatabase();
                    }
                    catch(SqlException ex)
                    {
                        adminAddedAirline.Controls.Add(new Literal { Text = ex.Message });
                    }

                }

            }

        }

        protected void editAirline(object sender, EventArgs e)
        {
            string id = String.Format("{0}", adminEditAirlineID.Text);
            string name = String.Format("{0}", adminEditAirlineName.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("UpdateAirline", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@AirlineID", id);
                    cmd.Parameters.AddWithValue("@AirlineName", name);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminEditedAirline.Controls.Add(new Literal { Text = "Airline edited successfully." });
                        selectFromDatabase();
                    }
                    catch(SqlException ex) 
                    {
                        adminEditedAirline.Controls.Add(new Literal { Text = ex.Message });
                    }

                }

            }

        }

        protected void deleteAirline(object sender, EventArgs e)
        {
            string id = String.Format("{0}", adminDeleteAirlineID.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("DeleteAirline", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@AirlineID", id);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminDeletedAirline.Controls.Add(new Literal { Text = "Airline deleted successfully." });
                        selectFromDatabase();
                    }
                    catch (SqlException ex)
                    {
                        adminDeletedAirline.Controls.Add(new Literal { Text = ex.Message });
                    }

                }

            }

        }

        //CITY STORED PROCEDURE CALLS
        protected void addCity(object sender, EventArgs e)
        {
            string name = String.Format("{0}", adminAddCityName.Text);
            string rating = String.Format("{0}", adminAddCityRating.SelectedValue);
            string country = String.Format("{0}", adminAddCityCountry.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("NewCity", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CityName", name);
                    cmd.Parameters.AddWithValue("@Rating", rating);
                    cmd.Parameters.AddWithValue("@Country", country);
                    cmd.Parameters.AddWithValue("@PIN", 1234);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminAddedCity.Controls.Add(new Literal { Text = "City added successfully." });
                        selectFromDatabase();
                    }
                    catch (SqlException ex)
                    {
                        adminAddedCity.Controls.Add(new Literal { Text = ex.Message });
                    }
                }

            }

        }

        protected void editCity(object sender, EventArgs e)
        {
            string id = String.Format("{0}", adminEditCityID.Text);
            string name = String.Format("{0}", adminEditCityName.Text);
            string rating = String.Format("{0}", adminEditCityRating.SelectedValue);
            string country = String.Format("{0}", adminEditCityCountry.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("UpdateCity", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CityID", id);
                    cmd.Parameters.AddWithValue("@CityName", name);
                    cmd.Parameters.AddWithValue("@CityRating", rating);
                    cmd.Parameters.AddWithValue("@CountryName", country);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminEditedCity.Controls.Add(new Literal { Text = "City edited successfully." });
                        selectFromDatabase();
                    }
                    catch (SqlException ex)
                    {
                        adminEditedCity.Controls.Add(new Literal { Text = ex.Message });
                    }
                }

            }

        }

        protected void deleteCity(object sender, EventArgs e)
        {
            string id = String.Format("{0}", adminDeleteCityID.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("DeleteCity", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CityID", id);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminDeletedCity.Controls.Add(new Literal { Text = "City deleted successfully." });
                        selectFromDatabase();
                    }
                    catch (SqlException ex)
                    {
                        adminDeletedCity.Controls.Add(new Literal { Text = ex.Message });

                    }
                }

            }

        }

        //HOSPITAL STORED PROCEDURE CALLS
        protected void addHospitalAdmin(object sender, EventArgs e)
        {
            string name = String.Format("{0}", adminAddHospitalName.Text);
            string rating = String.Format("{0}", adminAddHospitalRating.SelectedValue);
            string cityid = String.Format("{0}", adminAddHospitalCityID.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("NewHospital", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@H_Name", name);
                    cmd.Parameters.AddWithValue("@CityID", cityid);
                    cmd.Parameters.AddWithValue("@Rating", rating);
                    cmd.Parameters.AddWithValue("@PIN", 1234);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminAddedHospital.Controls.Add(new Literal { Text = "Hospital added successfully." });
                        selectFromDatabase();
                    }
                    catch (SqlException ex)
                    {
                        adminAddedHospital.Controls.Add(new Literal { Text = ex.Message });
                    }
                }

            }

        }

        protected void editHospitalAdmin(object sender, EventArgs e)
        {
            string id = String.Format("{0}", adminEditHospitalID.Text);
            string rating = String.Format("{0}", adminEditHospitalRating.SelectedValue);
            string name = String.Format("{0}", adminEditHospitalName.Text);
            string cityid = String.Format("{0}", adminEditHospitalCityID.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("UpdateHospital", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@HospitalID", id);
                    cmd.Parameters.AddWithValue("@HospitalRating", rating);
                    cmd.Parameters.AddWithValue("@HospitalName", name);
                    cmd.Parameters.AddWithValue("@CityID", cityid);
                    cmd.Parameters.AddWithValue("@OwnerID", null);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminEditedHospital.Controls.Add(new Literal { Text = "Hospital edited successfully." });
                        selectFromDatabase();
                    }
                    catch (SqlException ex)
                    {
                        adminEditedHospital.Controls.Add(new Literal { Text = ex.Message });
                    }
                }

            }

        }

        protected void deleteHospitalAdmin(object sender, EventArgs e)
        {
            string id = String.Format("{0}", adminDeleteHospitalID.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("DeleteHospital", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@HospitalID", id);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminDeletedHospital.Controls.Add(new Literal { Text = "Hospital deleted successfully." });
                        selectFromDatabase();
                    }
                    catch (SqlException ex)
                    {
                        adminDeletedHospital.Controls.Add(new Literal { Text = ex.Message });
                    }
                }

            }

        }

        //HOTEL STORED PROCEDURE CALLS
        protected void addHotel(object sender, EventArgs e)
        {
            string name = String.Format("{0}", adminAddHotelName.Text);
            string cityid = String.Format("{0}", adminAddHotelCityID.Text);
            string cost = String.Format("{0}", adminAddHotelCost.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("NewHotel", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@CityID", cityid);
                    cmd.Parameters.AddWithValue("@CostPerNight", cost);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminAddedHotel.Controls.Add(new Literal { Text = "Hotel added successfully." });
                        selectFromDatabase();
                    }
                    catch (SqlException ex)
                    {
                        adminAddedHotel.Controls.Add(new Literal { Text = ex.Message });
                    }
                }

            }

        }

        protected void editHotel(object sender, EventArgs e)
        {
            string id = String.Format("{0}", adminEditHotelID.Text);
            string name = String.Format("{0}", adminEditHotelName.Text);
            string cost = String.Format("{0}", adminEditHotelCost.Text);
            string cityid = String.Format("{0}", adminEditHotelCityID.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("UpdateHotel", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@HotelID", id);
                    cmd.Parameters.AddWithValue("@HotelName", name);
                    cmd.Parameters.AddWithValue("@CostPerNight", cost);
                    cmd.Parameters.AddWithValue("@CityID", cityid);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminEditedHotel.Controls.Add(new Literal { Text = "Hotel edited successfully." });
                        selectFromDatabase();
                    }
                    catch (SqlException ex)
                    {
                        adminEditedHotel.Controls.Add(new Literal { Text = ex.Message });
                    }
                }

            }

        }

        protected void deleteHotel(object sender, EventArgs e)
        {
            string id = String.Format("{0}", adminDeleteHotelID.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("DeleteHotel", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@HotelID", id);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminDeletedHotel.Controls.Add(new Literal { Text = "Hotel deleted successfully." });
                        selectFromDatabase();
                    }
                    catch (SqlException ex)
                    {
                        adminDeletedHotel.Controls.Add(new Literal { Text = ex.Message });

                    }
                }

            }

        }

        //OFFERS STORED PROCEDURE CALLS
        protected void addOfferAdmin(object sender, EventArgs e)
        {
            string name = String.Format("{0}", adminAddOfferSurgName.Text);
            string hospid = String.Format("{0}", adminAddOfferHospitalID.Text);
            string price = String.Format("{0}", adminAddOfferPrice.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("NewOffer", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Surgery", name);
                    cmd.Parameters.AddWithValue("@HospitalID", hospid);
                    cmd.Parameters.AddWithValue("@Offer_Price", price);
                    cmd.Parameters.AddWithValue("@PIN", 1234);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminAddedOffer.Controls.Add(new Literal { Text = "Offer added successfully." });
                        selectFromDatabase();
                    }
                    catch (SqlException ex)
                    {
                        adminAddedOffer.Controls.Add(new Literal { Text = ex.Message });
                    }
                }

            }

        }

        protected void editOfferAdmin(object sender, EventArgs e)
        {
            string name = String.Format("{0}", adminEditOfferSurgName.Text);
            string hospid = String.Format("{0}", adminEditOfferHospitalID.Text);
            string cost = String.Format("{0}", adminEditOfferCost.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("UpdateOffer", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Surgery", name);
                    cmd.Parameters.AddWithValue("@HospitalID", hospid);
                    cmd.Parameters.AddWithValue("@Cost", cost);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminEditedOffer.Controls.Add(new Literal { Text = "Offer edited successfully." });
                        selectFromDatabase();
                    }
                    catch(SqlException ex) 
                    {
                        adminEditedOffer.Controls.Add(new Literal { Text = ex.Message });
                    }
                }

            }

        }

        protected void deleteOfferAdmin(object sender, EventArgs e)
        {
            string name = String.Format("{0}", adminDeleteOfferSurgName.Text);
            string hospid = String.Format("{0}", adminDeleteOfferHospitalID.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("DeleteOffer", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Surgery", name);
                    cmd.Parameters.AddWithValue("@HospitalID", hospid);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminDeletedOffer.Controls.Add(new Literal { Text = "Offer deleted successfully." });
                        selectFromDatabase();
                    }
                    catch (SqlException ex)
                    {
                        adminDeletedOffer.Controls.Add(new Literal { Text = ex.Message });
                    }
                }

            }

        }

        //SURGERY STORED PROCEDURE CALLS
        protected void addSurgery(object sender, EventArgs e)
        {
            string name = String.Format("{0}", adminAddSurgName.Text);
            string type = String.Format("{0}", adminAddSurgType.Text);
            string cost = String.Format("{0}", adminAddSurgHugeCost.Text);
            string rectime = String.Format("{0}", adminAddSurgRecTime.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("NewSurgery", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SurgeyName", name);
                    cmd.Parameters.AddWithValue("@SurgeryType", type);
                    cmd.Parameters.AddWithValue("@HugeCost", cost);
                    cmd.Parameters.AddWithValue("@RecoveryTime", rectime);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminAddedSurg.Controls.Add(new Literal { Text = "Surgery added successfully." });
                        selectFromDatabase();
                    }
                    catch (SqlException ex)
                    {
                        adminAddedSurg.Controls.Add(new Literal { Text = ex.Message });
                    }
                }

            }

        }

        protected void editSurgery(object sender, EventArgs e)
        {
            string name = String.Format("{0}", adminEditSurgName.Text);
            string type = String.Format("{0}", adminEditSurgType.Text);
            string cost = String.Format("{0}", adminEditSurgCost.Text);
            string rectime = String.Format("{0}", adminEditSurgRecTime.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("UpdateSurgery", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SurgeyName", name);
                    cmd.Parameters.AddWithValue("@SurgeryType", type);
                    cmd.Parameters.AddWithValue("@USCost", cost);
                    cmd.Parameters.AddWithValue("@RecoveryTime", rectime);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminEditedSurg.Controls.Add(new Literal { Text = "Surgery edited successfully." });
                        selectFromDatabase();
                    }
                    catch (SqlException ex)
                    {
                        adminEditedSurg.Controls.Add(new Literal { Text = ex.Message });

                    }
                }

            }

        }

        protected void deleteSurgery(object sender, EventArgs e)
        {
            string name = String.Format("{0}", adminDeleteSurgName.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("DeleteSurgery", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SurgeyName", name);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminDeletedSurg.Controls.Add(new Literal { Text = "Surgery deleted successfully." });
                        selectFromDatabase();
                    }
                    catch (SqlException ex)
                    {
                        adminDeletedSurg.Controls.Add(new Literal { Text = ex.Message });
                    }
                }

            }

        }

        //VISITS STORED PROCEDURE CALLS
        protected void addVisit(object sender, EventArgs e)
        {
            string airlineid = String.Format("{0}", adminAddVisitAirlineID.Text);
            string cityid = String.Format("{0}", adminAddVisitCityID.Text);
            string cost = String.Format("{0}", adminAddVisitCost.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("NewVisits", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@AirlineID", airlineid);
                    cmd.Parameters.AddWithValue("@CityID", cityid);
                    cmd.Parameters.AddWithValue("@Cost", cost);
                    cmd.Parameters.AddWithValue("@PIN", 1234);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminAddedVisit.Controls.Add(new Literal { Text = "Visit added successfully." });
                        selectFromDatabase();
                    }
                    catch(SqlException ex) 
                    {
                        adminAddedVisit.Controls.Add(new Literal { Text = ex.Message });
                    }
                }

            }

        }

        protected void editVisit(object sender, EventArgs e)
        {
            string airlineid = String.Format("{0}", adminEditVisitAirlineID.Text);
            string cityid = String.Format("{0}", adminEditVisitCityID.Text);
            string cost = String.Format("{0}", adminEditVisitCost.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("UpdateVisits", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@AirlineID", airlineid);
                    cmd.Parameters.AddWithValue("@CityID", cityid);
                    cmd.Parameters.AddWithValue("@Cost", cost);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminEditedVisit.Controls.Add(new Literal { Text = "Visit edited successfully." });
                        selectFromDatabase();
                    }
                    catch (SqlException ex)
                    {
                        adminEditedVisit.Controls.Add(new Literal { Text = ex.Message });
                    }
                }

            }

        }

        protected void deleteVisit(object sender, EventArgs e)
        {
            string airlineid = String.Format("{0}", adminDeleteVisitAirlineID.Text);
            string cityid = String.Format("{0}", adminDeleteVisitCityID.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("DeleteVisits", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@AirlineID", airlineid);
                    cmd.Parameters.AddWithValue("@CityID", cityid);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        adminDeletedVisit.Controls.Add(new Literal { Text = "Visit deleted successfully." });
                        selectFromDatabase();
                    }
                    catch (SqlException ex)
                    {
                        adminDeletedVisit.Controls.Add(new Literal { Text = ex.Message });

                    }
                }

            }

        }

        //HOSPITAL OWNER FUNCTIONS

        protected void addHospital(object sender, EventArgs e)
        {
            
            string name = String.Format("{0}", hospitalName.Text);
            string city = String.Format("{0}", cityName.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("NewHospital", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@h_name", name);
                    cmd.Parameters.AddWithValue("@CityID", city);
                    cmd.Parameters.AddWithValue("@rating", 5);
                    cmd.Parameters.AddWithValue("@PIN", 0000);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        addedHospital.Controls.Add(new Literal { Text = "Hospital added successfully." });
                    }
                    catch (SqlException ex)
                    {
                        addedHospital.Controls.Add(new Literal { Text = ex.Message });
                    }
                }

            }

        }

        protected void addOffer(object sender, EventArgs e)
        {

            string name = String.Format("{0}", hospitalForSurgery.Text);
            string surgery = String.Format("{0}", surgeryName.Text);
            string price = String.Format("{0}", surgeryPrice.Text);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("NewOffers", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Surgery", surgery);
                    cmd.Parameters.AddWithValue("@HospitalID", name);
                    cmd.Parameters.AddWithValue("@Offer_Price", price);
                    cmd.Parameters.AddWithValue("@PIN", 0000);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        addedSurgery.Controls.Add(new Literal { Text = "Surgery added successfully." });
                    }
                    catch (SqlException ex)
                    {
                        addedSurgery.Controls.Add(new Literal { Text = ex.Message });

                    }
                }

            }

        }


    }

}