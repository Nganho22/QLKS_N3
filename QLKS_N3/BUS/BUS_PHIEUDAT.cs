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
   
    public class BUS_PHIEUDAT
    {
        private string conn;
        DB db = new DB();

        public DataTable DS_PHIEUDAT_THEO_MAKH(string MAKH)
        {
            db.OpenConnection();
            MySqlCommand cmd = new MySqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "XEM_DS_PHIEUDATPHONG_THEO_MAKH";
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
            cmd.CommandText = "XEM_DS_CHITIETPHIEUDAT_THEO_MAPDP";
            cmd.Connection = db.GETconnection();
            cmd.Parameters.AddWithValue("@NMAPDP", MAPH);
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

        public DataTable DS_DV_THEO_MPD(string MAPH)
        {
            db.OpenConnection();
            MySqlCommand cmd = new MySqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "XEM_DS_CHITIETPHIEUDAT_THEO_MAPDP";
            cmd.Connection = db.GETconnection();
            cmd.Parameters.AddWithValue("@NMAPDP", MAPH);
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

        public DataTable DS_HD_THEO_MAKH(string MAKH)
        {
            db.OpenConnection();
            MySqlCommand cmd = new MySqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "XEM_DS_HD_CUA_KH";
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
    }

}
