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
    public partial class QLKS_DANGKY : Form
    {
        MySqlConnection conn;
        public QLKS_DANGKY(MySqlConnection conn)
        {
            InitializeComponent();
            this.conn = conn;
        }

        private void QLKS_DANGKY_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            if(textBox1.Text == "" || textBox2.Text =="" || textBox3.Text =="" || textBox4.Text == "" || textBox5.Text =="")
            {
                MessageBox.Show("Tai khoan hoac mat khau khong dung!");
            }
            else
            {
                BUS_KHACHHANG busKH = new BUS_KHACHHANG();
                string mess = busKH.KHACHHANG_DK(textBox1.Text, textBox2.Text,textBox3.Text,textBox4.Text,textBox5.Text);
                int a = mess.Length;
                if(a <10)
                {
                    string b = mess + " la ma khach hang dang nhap cua ban, mat khau 123";
                    MessageBox.Show(b);
                    QLKS_KH_INFO USER = new QLKS_KH_INFO(conn,mess);
                    this.Hide();
                    USER.ShowDialog();
                }
                
            }
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox5_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
