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
using PasswordHash;

namespace MedicalTourism
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void reg(object sender, EventArgs e)
        {
            string user = String.Format("{0}", username.Text);
            string pass = PasswordHash.PasswordHash.CreateHash(String.Format("{0}", password.Text));

            using (SqlConnection con = new SqlConnection("user id=333Spring2015Medical;password=v4rewrapHEgequbr;server=titan.csse.rose-hulman.edu;database=medicaltourism;connection timeout=30"))
            {

                using (SqlCommand cmd = new SqlCommand("NewLogin", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Username", user);
                    cmd.Parameters.AddWithValue("@HashedPassword", pass);

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                        message.Controls.Add(new Literal { Text = "Registered!" });
                    }
                    catch (SqlException ex)
                    {
                        message.Controls.Add(new Literal { Text = ex.Message });
                    }

                }

            }
        }

    }
}