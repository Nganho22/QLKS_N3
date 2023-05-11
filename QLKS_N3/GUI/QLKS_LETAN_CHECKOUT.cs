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
    public partial class QLKS_LETAN_CHECKOUT : Form
    {
        MySqlConnection conn;

        public QLKS_LETAN_CHECKOUT(MySqlConnection conn)
        {
            InitializeComponent();
            this.conn = conn;
        }

        private void QLKS_LETAN_CHECKOUT_Load(object sender, EventArgs e)
        {
           
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

        private void button4_Click(object sender, EventArgs e)
        {
            if (textBox1.Text =="")
            {
                MessageBox.Show("Ban chua nhap ma khach hang!");
            }
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void button5_Click(object sender, EventArgs e)
        {
            if (textBox2.Text == "")
            {
                MessageBox.Show("Ban chua nhap ma phong!");
            }
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void button2_Click_1(object sender, EventArgs e)
        {
            QLKS_LETAN_PHIEUDAT USER = new QLKS_LETAN_PHIEUDAT(conn);
            this.Hide();
            USER.ShowDialog();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Check out thanh cong");
            dataGridView5.ClearSelection();
            dataGridView4.ClearSelection();
            textBox2.Clear();
        }

        private void dataGridView5_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dataGridView4_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
