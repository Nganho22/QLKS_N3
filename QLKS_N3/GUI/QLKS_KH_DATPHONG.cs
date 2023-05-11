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
    public partial class QLKS_KH_DATPHONG : Form
    {
        MySqlConnection conn;
        public QLKS_KH_DATPHONG(MySqlConnection conn)
        {
            InitializeComponent();
            this.conn = conn;
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void QLKS_KH_DATPHONG_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Da hoan tat dat phong!");
            QLKS_KH_MENU USER = new QLKS_KH_MENU(conn);
            this.Hide();
            USER.ShowDialog();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            QLKS_KH_MENU USER = new QLKS_KH_MENU(conn);
            this.Hide();
            USER.ShowDialog();
        }
    }
}
