using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;
using System.Data;

namespace QLKS_N3
{
    class BUS_PHONG
    {
        private string conn;
        DB db = new DB();
        public DataTable getPhong_theo_dk(string LP, string TT)
        {
            db.OpenConnection();
            MySqlCommand cmd = new MySqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "XEM_DS_PHONG_THEO_DK_1";
            cmd.Connection = db.GETconnection();
            cmd.Parameters.AddWithValue("@NLOAIPHONG", LP);
            cmd.Parameters.AddWithValue("@NTINHTRANG", TT);
            //cmd.Parameters.Add("p_input1", MySqlDbType.VarChar).Value = "LT001";
            cmd.ExecuteNonQuery();
            //cmd.Parameters.Add("p_table_output", MySqlDbType.VarChar).Value = ParameterDirection.Output;
            MySqlDataAdapter ad = new MySqlDataAdapter(cmd);
            DataTable ds = new DataTable();
            ad.Fill(ds);
            //MessageBox.Show(ds.Rows[0][0].ToString());
            db.CloseConnection();
            return ds;
        }


    }
}
