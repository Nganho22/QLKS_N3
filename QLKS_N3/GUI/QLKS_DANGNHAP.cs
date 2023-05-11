using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;
using System.Data.SqlClient;

namespace QLKS_N3
{
    public partial class QLKS_DANGNHAP : Form
    {
        MySqlConnection conn1;
        MySqlConnection conn;
        MySqlCommand cmd;
        MySqlDataAdapter adapter;
        private string server;
        private string database;
        private string user;
        private string password;
        private string port;
        string connectionString;
        private string sslM;

        public QLKS_DANGNHAP()
        {
            InitializeComponent();
        }

        private void QLKS_DANGNHAP_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            if(textBox1.Text == "" || textBox2.Text != "123")
            {
                MessageBox.Show("Tai khoan hoac mat khau khong dung!");
            }
            else
            {
                /*server = "127.0.0.1";
                database = "DA_PTTK";
                user = "KHACHHANG";
                password = "123";
                port = "3306";
                sslM = "none";

                KHACHHANG kh = new KHACHHANG();
                
                connectionString = String.Format("server={0};port={1};user id={2}; password={3}; database={4}; SslMode={5}; charset=utf8mb4", server, port, user, password, database, sslM);
                conn = new MySqlConnection(connectionString);
                conn.Open();
                MySqlCommand cmd = new MySqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = "KT_NGUOIDUNG";
                cmd.Connection = conn;
                cmd.Parameters.AddWithValue("@NMA", textBox1.Text);
                cmd.Parameters.Add("@mess", MySqlDbType.VarChar);
                cmd.Parameters["@mess"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                string mess = cmd.Parameters["@mess"].Value.ToString();
                conn.Close();*/
                DB db = new DB();
                string mess = db.DBcheck(textBox1.Text);
                conn = db.GETconnection();
                if(mess == "1")
                {
                    QLKS_KH_INFO USER = new QLKS_KH_INFO(conn, textBox1.Text);
                    this.Hide();
                    USER.ShowDialog();
                }
                else if (mess == "2")
                {
                    QLKS_LETAN_MENU USER = new QLKS_LETAN_MENU(conn);
                    this.Hide();
                    USER.ShowDialog();
                }
                else
                {
                    MessageBox.Show("Tai khoan hoac mat khau khong dung!");
                }

                //cmd.Parameters.Add("p_table_output", MySqlDbType.VarChar).Value = ParameterDirection.Output;

            }


        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            QLKS_DANGKY USER = new QLKS_DANGKY(conn);
            this.Hide();
            USER.ShowDialog();
        }
    }
}
