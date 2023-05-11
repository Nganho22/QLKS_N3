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
    public class DB
    {
        private MySqlConnection conn;
        private string server;
        private string database;
        private string user;
        private string password;
        private string port;
        private string sslM;


        public DB()
        {
            server = "127.0.0.1";
            database = "DA_PTTK";
            user = "KHACHHANG";
            password = "123";
            port = "3306";
            sslM = "none";
            string connectionString = String.Format("server={0};port={1};user id={2}; password={3}; database={4}; SslMode={5}; charset=utf8mb4", server, port, user, password, database, sslM);
            conn = new MySqlConnection(connectionString);
        }
        public MySqlConnection GETconnection()
        {
            return conn;
        }

        public bool OpenConnection()
        {
            try
            {
                conn.Open();
                return true;
            }
            catch (MySqlException ex)
            {
                // Xử lý lỗi
                MessageBox.Show("ERROR!" + ex.Message);
                return false;
            }
        }

        public bool CloseConnection()
        {
            try
            {
                conn.Close();
                return true;
            }
            catch (MySqlException ex)
            {
                MessageBox.Show("ERROR!" + ex.Message);
                return false;
            }
        }




        public DataTable ExecuteSelectCommand(string commandText, CommandType commandType)
        {
            MySqlCommand cmd = new MySqlCommand(commandText, conn);
            cmd.CommandType = commandType;
            DataTable dt = new DataTable();

            try
            {
                OpenConnection();
                MySqlDataAdapter da = new MySqlDataAdapter(cmd);
                da.Fill(dt);
            }
            catch (Exception ex)
            {
                // Handle exception
            }
            finally
            {
                CloseConnection();
            }

            return dt;
        }

        public bool ExecuteNonQuery(string commandText, CommandType commandType)
        {
            MySqlCommand cmd = new MySqlCommand(commandText, conn);
            cmd.CommandType = commandType;

            try
            {
                OpenConnection();
                int result = cmd.ExecuteNonQuery();
                return result > 0;
            }
            catch (Exception ex)
            {
                // Handle exception
                return false;
            }
            finally
            {
                CloseConnection();
            }
        }

        public object ExecuteScalar(string commandText, CommandType commandType)
        {
            MySqlCommand cmd = new MySqlCommand(commandText, conn);
            cmd.CommandType = commandType;

            try
            {
                OpenConnection();
                return cmd.ExecuteScalar();
            }
            catch (Exception ex)
            {
                // Handle exception
                return null;
            }
            finally
            {
                CloseConnection();
            }
        }

        public string DBcheck(string MAKH)
        {

            OpenConnection();
            MySqlCommand cmd = new MySqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "KT_NGUOIDUNG";
            cmd.Connection = conn;
            cmd.Parameters.AddWithValue("@NMA", MAKH);
            cmd.Parameters.Add("@mess", MySqlDbType.VarChar);
            cmd.Parameters["@mess"].Direction = ParameterDirection.Output;
            cmd.ExecuteNonQuery();
            string mess = cmd.Parameters["@mess"].Value.ToString();
            CloseConnection();
            return mess;
        }

    }
}
