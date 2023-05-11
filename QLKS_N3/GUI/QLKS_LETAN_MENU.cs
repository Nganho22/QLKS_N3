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
    public partial class QLKS_LETAN_MENU : Form
    {
        MySqlConnection conn;
        List<string> listItem1 = new List<string>() {"all", "PHONG DON", "PHONG DOI", "PHONG GIA DINH"};
        List<string> listItem2 = new List<string>() { "all", "DANG DAT", "TRONG" };



        public QLKS_LETAN_MENU(MySqlConnection conn)
        {
            InitializeComponent();
            this.conn = conn;
        }

        private void QLKS_LETAN_MENU_Load(object sender, EventArgs e)
        {
            comboBox1.DataSource = listItem1;
            comboBox2.DataSource = listItem2;





        }

        private void button1_Click(object sender, EventArgs e)
        {
            QLKS_LETAN_MENU USER = new QLKS_LETAN_MENU(conn);
            this.Hide();
            USER.ShowDialog();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            QLKS_LETAN_PHIEUDAT USER = new QLKS_LETAN_PHIEUDAT(conn);
            this.Hide();
            USER.ShowDialog();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Hien tai chua ho tro!");
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string a = comboBox1.SelectedIndex.ToString();
         
            string b = comboBox2.SelectedIndex.ToString();
            if (a == "0")
            {
                a = "NULL";

            }
            else if (a == "1")
            {
                a = "PHONG DON";
            }
            else if (a == "2")
            {
                a = "PHONG DOI";
            }
            else if (a == "3")
            {
                a = "PHONG GIA DINH";
            }
            if (b == "0")
            {
                b = "NULL";
            }
            else if (b == "1")
            {
                b = "DANG DAT";
            }
            else if (b == "2")
            {
                b = "TRONG";
            }
            BUS_PHONG busP = new BUS_PHONG();
            dataGridView1.DataSource = busP.getPhong_theo_dk(a, b);

        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            string a = comboBox1.SelectedIndex.ToString();


            string b = comboBox2.SelectedIndex.ToString();
            if (a == "0")
            {
                a = "NULL";

            }
            else if (a == "1")
            {
                a = "PHONG DON";
            }
            else if (a == "2")
            {
                a = "PHONG DOI";
            }
            else if (a == "3")
            {
                a = "PHONG GIA DINH";
            }
            if (b == "0")
            {
                b = "NULL";
            }
            else if( b == "1")
            {
                b = "DANG DAT";
            }
            else if (b == "2")
            {
                b = "TRONG";
            }
            BUS_PHONG busP = new BUS_PHONG();
            dataGridView1.DataSource = busP.getPhong_theo_dk(a, b);

        }
    }
}
