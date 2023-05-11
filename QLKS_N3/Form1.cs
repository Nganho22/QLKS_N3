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
    public partial class Form1 : Form
    {
        MySqlConnection connection;
        MySqlCommand cmd;
        MySqlDataAdapter adapter;
        private string server;
        private string database;
        private string user;
        private string password;
        private string port;
        string connectionString;
        private string sslM;
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            server = "127.0.0.1";
            database = "DA_PTTK";
            user = "N03";
            password = "123";
            port = "3306";
            sslM = "none";

            connectionString = String.Format("server={0};port={1};user id={2}; password={3}; database={4}; SslMode={5}", server, port, user, password, database, sslM);

            connection = new MySqlConnection(connectionString);
            connection.Open();
            cmd = new MySqlCommand("CALL XEM_DS_SANPHAM;", connection);
            adapter = new MySqlDataAdapter(cmd);
            DataTable table = new DataTable();
            adapter.Fill(table);
            dataGridView1.DataSource = table;
            connection.Close();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
    }
}
