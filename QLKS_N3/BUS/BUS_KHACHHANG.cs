using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;
using System.Data;


namespace QLKS_N3
{

    public class BUS_KHACHHANG
    {
        private string conn;
        DB db = new DB();
        public DataTable getKHACHHANG(string MAKH)
        {
            db.OpenConnection();
            MySqlCommand cmd = new MySqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "XEM_TT_KHACHHANG";
            cmd.Connection = db.GETconnection();
            cmd.Parameters.AddWithValue("@NMAKH", MAKH);
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

       /* public DataTable DS_PHIEUDAT_THEO_MAKH(string MAKH)
        {
            db.OpenConnection();
            MySqlCommand cmd = new MySqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "XEM_DS_CHITIETPHIEUDAT_THEO_MAPDP";
            cmd.Connection = db.GETconnection();
            cmd.Parameters.AddWithValue("@NMAKH", MAKH);
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

        public DataTable DS_CTPHIEUDAT_THEO_MAPD(string MAPH)
        {
            db.OpenConnection();
            MySqlCommand cmd = new MySqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "XEM_DS_PHIEUDATPHONG_THEO_MAKH";
            cmd.Connection = db.GETconnection();
            cmd.Parameters.AddWithValue("@NMAKH", MAPH);
            //cmd.Parameters.Add("p_input1", MySqlDbType.VarChar).Value = "LT001";
            cmd.ExecuteNonQuery();
            //cmd.Parameters.Add("p_table_output", MySqlDbType.VarChar).Value = ParameterDirection.Output;
            MySqlDataAdapter ad = new MySqlDataAdapter(cmd);
            DataTable ds = new DataTable();
            ad.Fill(ds);
            //MessageBox.Show(ds.Rows[0][0].ToString());
            db.CloseConnection();
            return ds;
        }*/

        public string KHACHHANG_DK (string ten, string sdt, string hc, string cmnd, string email)
        {
            KHACHHANG kh = new KHACHHANG(ten, sdt, email, cmnd, hc);
            db.OpenConnection();
            MySqlCommand cmd = new MySqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "DANG_KY_KHACHHANG";
            cmd.Connection = db.GETconnection();
            cmd.Parameters.AddWithValue("@NTENKH",kh.TENKH);
            cmd.Parameters.AddWithValue("@NSDT", kh.SDT);
            cmd.Parameters.AddWithValue("@NEMAIL", kh.EMAIL);
            cmd.Parameters.AddWithValue("@NMAHOCHIEU", kh.MAHOCHIEU);
            cmd.Parameters.AddWithValue("@NCMND", kh.CMND);
            cmd.Parameters.Add("@mess", MySqlDbType.VarChar);
            cmd.Parameters["@MESS"].Direction = ParameterDirection.Output;
            //cmd.Parameters.Add("p_input1", MySqlDbType.VarChar).Value = "LT001";
            cmd.ExecuteNonQuery();
            //cmd.Parameters.Add("p_table_output", MySqlDbType.VarChar).Value = ParameterDirection.Output;
            string mess = cmd.Parameters["@mess"].Value.ToString();
           
            db.CloseConnection();
            //MessageBox.Show(mess);
            return mess;
        }
    }
}
