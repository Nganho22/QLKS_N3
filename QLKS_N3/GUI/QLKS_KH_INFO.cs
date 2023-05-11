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
    public partial class QLKS_KH_INFO : Form
    {
        MySqlConnection conn;
        String MAKH = "";
        public QLKS_KH_INFO(MySqlConnection conn)
        {
            InitializeComponent();
            this.conn = conn;
        }
        public QLKS_KH_INFO(MySqlConnection conn, string Makh)
        {
            InitializeComponent();
            this.conn = conn;
            this.MAKH = Makh;
        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void QLKS_KH_INFO_Load(object sender, EventArgs e)
        {
            /*conn.Open();
             MySqlCommand cmd = new MySqlCommand();
             cmd.CommandType = CommandType.StoredProcedure;
             cmd.CommandText = "XEM_TT_NHANVIEN";
             cmd.Connection = conn;
             cmd.Parameters.AddWithValue("@NMANV", "LT001");
             //cmd.Parameters.Add("p_input1", MySqlDbType.VarChar).Value = "LT001";
             cmd.ExecuteNonQuery();
             //cmd.Parameters.Add("p_table_output", MySqlDbType.VarChar).Value = ParameterDirection.Output;
             MySqlDataAdapter ad = new MySqlDataAdapter(cmd);
             DataTable ds = new DataTable();
             ad.Fill(ds);
             dataGridView1.DataSource = ds;
             conn.Close();*/
            BUS_KHACHHANG busKH = new BUS_KHACHHANG();
            KHACHHANG KH = new KHACHHANG(MAKH);
            PHIEUDATPHONG PDP = new PHIEUDATPHONG(MAKH);
            BUS_PHIEUDAT busPDP = new BUS_PHIEUDAT();
            dataGridView1.DataSource = busKH.getKHACHHANG(MAKH);
            dataGridView2.DataSource = busPDP.DS_PHIEUDAT_THEO_MAKH(MAKH);
            dataGridView4.DataSource = busPDP.DS_HD_THEO_MAKH(MAKH);

        }

        private void button2_Click(object sender, EventArgs e)
        {
            QLKS_KH_MENU USER = new QLKS_KH_MENU(conn);
            this.Hide();
            USER.ShowDialog();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if(textBox1.Text == "")
            {
                MessageBox.Show("Ban chua nhap ma phieu dat phong!");
            }
            else
            {
                PHIEUDATPHONG PDP = new PHIEUDATPHONG(MAKH);
                BUS_PHIEUDAT busPDP = new BUS_PHIEUDAT();
                //MessageBox.Show(textBox1.Text);
                dataGridView3.DataSource = busPDP.DS_CTPHIEUDAT_THEO_MAPD(textBox1.Text);
                dataGridView5.DataSource = busPDP.DS_DV_THEO_MPD(textBox1.Text);
               
            }   

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            
        }

        private void dataGridView3_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void dataGridView5_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
