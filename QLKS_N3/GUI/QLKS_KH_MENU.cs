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
    public partial class QLKS_KH_MENU : Form
    {
        MySqlConnection conn;
        public QLKS_KH_MENU(MySqlConnection conn)
        {
            InitializeComponent();
            this.conn = conn;
        }

        private void label8_Click(object sender, EventArgs e)
        {

        }

        private void button4_Click(object sender, EventArgs e)
        {
            QLKS_KH_DATPHONG USER = new QLKS_KH_DATPHONG(conn);
            this.Hide();
            USER.ShowDialog();
        }

        private void QLKS_KH_MENU_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (textBox1.Text =="")
            {
                MessageBox.Show("Ban chua nhap so luong!");
            }
            else if(comboBox2.Text =="31" &&(comboBox3.Text =="2" || comboBox3.Text =="4" || comboBox3.Text =="6" || comboBox3.Text =="9" || comboBox3.Text =="11"))
            {
                MessageBox.Show("Sai nguyen tat ngay thang nam!");
            }
            else if (comboBox4.Text == "31" && (comboBox5.Text == "2" || comboBox5.Text == "4" || comboBox5.Text == "6" || comboBox5.Text == "9" || comboBox5.Text == "11"))
            {
                MessageBox.Show("Sai nguyen tat ngay thang nam!");
            }
            else if ((comboBox2.Text == "30" || comboBox2.Text == "29") && comboBox3.Text == "2")
            {
                MessageBox.Show("Sai nguyen tat ngay thang nam!");
            }
            else if ((comboBox4.Text == "30" || comboBox4.Text == "29") && comboBox5.Text == "2")
            {
                MessageBox.Show("Sai nguyen tat ngay thang nam!");
            }
            else if(comboBox2.Text == comboBox4.Text && comboBox3.Text == comboBox5.Text)
            {
                MessageBox.Show("Ngay checkin va ngay checkout khong hop le!");
            }
            else MessageBox.Show("Ban da dat thanh cong!");
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void comboBox2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void comboBox3_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void comboBox5_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void comboBox4_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            QLKS_KH_MUADV USER = new QLKS_KH_MUADV(conn);
            this.Hide();
            USER.ShowDialog();

        }

        private void button3_Click(object sender, EventArgs e)
        {
            QLKS_KH_INFO USER = new QLKS_KH_INFO(conn);
            this.Hide();
            USER.ShowDialog();
        }
    }
}
