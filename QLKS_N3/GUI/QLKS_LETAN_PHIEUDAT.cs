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
    public partial class QLKS_LETAN_PHIEUDAT : Form
    {
        MySqlConnection conn;

        public QLKS_LETAN_PHIEUDAT(MySqlConnection conn)
        {
            InitializeComponent();
            this.conn = conn;
        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void QLKS_LETAN_PHIEUDAT_Load(object sender, EventArgs e)
        {

        }
    }
}
