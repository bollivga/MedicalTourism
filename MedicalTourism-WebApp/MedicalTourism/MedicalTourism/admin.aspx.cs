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

        }

        protected void login(object sender, EventArgs e)
        {

            string user = String.Format("{0}", username.Text);
            string pinNumber = String.Format("{0}", pin.Text);

            if (user == "hospital" && pinNumber == "0000") 
            {

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
            else
            {

                StringBuilder html = new StringBuilder();
                html.Append("<div style=\"color:#FF0000\"><p>Invalid username or password.</p></div>");
                editForm.Controls.Add(new Literal { Text = html.ToString() });

            }

            

        }

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

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    addedHospital.Controls.Add(new Literal { Text = "Hospital added successfully." });

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

                using (SqlCommand cmd = new SqlCommand("AddOffers", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Surgery", surgery);
                    cmd.Parameters.AddWithValue("@HospitalID", name);
                    cmd.Parameters.AddWithValue("@Offer_Price", price);
                    cmd.Parameters.AddWithValue("@PIN", 0000);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                    addedSurgery.Controls.Add(new Literal { Text = "Surgery added successfully." });

                }

            }

        }

    }

}