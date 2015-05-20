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
    public partial class Advisor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            //aspsubmit.Click += new EventHandler(aspsubmit_Click);
            if (!IsPostBack)
            {
                selectFromDatabase();
            }

        }

        private void selectFromDatabase()
        {
            SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=MedicalTourism;connection timeout=30");

            SqlCommand categorySelect = new SqlCommand() { CommandText = "SELECT DISTINCT Type FROM Surgery", CommandType = CommandType.Text, Connection = con };
            categorySelect.Connection.Open();
            using (SqlDataAdapter da = new SqlDataAdapter(categorySelect))
            {
                using (DataTable dt = new DataTable())
                {
                    da.Fill(dt);
                    category.DataSource = dt;
                    category.DataTextField = "Type";
                    category.DataValueField = "Type";
                    category.DataBind();
                }
            }
            categorySelect.Connection.Close();

            SqlCommand countrySelect = new SqlCommand() { CommandText = "SELECT CO_NAME FROM Country", CommandType = CommandType.Text, Connection = con };
            countrySelect.Connection.Open();
            using (SqlDataAdapter da = new SqlDataAdapter(countrySelect))
            {
                using (DataTable dt = new DataTable())
                {
                    da.Fill(dt);
                    country.DataSource = dt;
                    country.DataTextField = "CO_NAME";
                    country.DataValueField = "CO_NAME";
                    country.DataBind();
                }
            }
            countrySelect.Connection.Close();

        }

        protected void aspsubmit_Click(object sender, EventArgs e)
        {
                
            string category_val = String.Format("{0}", category.SelectedValue);
            string country_val = String.Format("{0}", country.SelectedValue);
            string rating_val = String.Format("{0}", rating.Value);


            //Populating a DataTable from database.
            DataTable dt = this.GetData(category_val, country_val, rating_val);

            //Building an HTML string.
            StringBuilder html = new StringBuilder();

            //Table start.
            html.Append("<table border = '1'>");

            //Building the Header row.
            html.Append("<tr>");
            foreach (DataColumn column in dt.Columns)
            {
                html.Append("<th>");
                html.Append(column.ColumnName);
                html.Append("</th>");
            }
            html.Append("</tr>");

            //Building the Data rows.
            foreach (DataRow row in dt.Rows)
            {
                html.Append("<tr>");
                foreach (DataColumn column in dt.Columns)
                {
                    html.Append("<td>");
                    html.Append(row[column.ColumnName]);
                    html.Append("</td>");
                }
                html.Append("</tr>");
            }

            //Table end.
            html.Append("</table>");

            //Append the HTML string to Placeholder.
            PlaceHolder1.Controls.Add(new Literal { Text = html.ToString() });

            city.DataSource = dt;
            city.DataTextField = "Name";
            city.DataValueField = "Name";
            city.DataBind();
            surgery.DataSource = dt;
            surgery.DataTextField = "Surgery";
            surgery.DataValueField = "Surgery";
            surgery.DataBind();

            secondForm.Visible = true;

        }

        protected void resultSubmit(object sender, EventArgs e)
        {

            string cityName = String.Format("{0}", city.SelectedValue);
            string surgeryName = String.Format("{0}", surgery.SelectedValue);

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=MedicalTourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("AllDetails", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SelectedCity", cityName);
                    cmd.Parameters.AddWithValue("@Surgery", surgeryName);

                    con.Open();

                    SqlDataReader dr = cmd.ExecuteReader();
                    tripInfo.DataSource = dr;
                    tripInfo.DataBind();
                    dr.NextResult();
                    priceInfo.DataSource = dr;
                    priceInfo.DataBind();
                    con.Close();

                    thirdForm.Visible = true;

                }
            }
        }
    
        private DataTable GetData(string category, string country, string rating) 
        {   
            

            //string constr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=MedicalTourism;connection timeout=30"))
            {
                
                using (SqlCommand cmd = new SqlCommand("DisplayCityResults", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Country", country);
                    cmd.Parameters.AddWithValue("@SurgeryType", category);
                    cmd.Parameters.AddWithValue("@Rating", rating);

                    con.Open();

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {   
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            con.Close();
                            return dt;
                        }
                    }


                }
            }
        }
    }

    

}