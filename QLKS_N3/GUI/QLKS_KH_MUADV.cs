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
    public partial class QLKS_KH_MUADV : Form
    {
        MySqlConnection conn;
        public QLKS_KH_MUADV(MySqlConnection conn)
        {
            InitializeComponent();
            this.conn = conn;
        }

        private void QLKS_KH_MUADV_Load(object sender, EventArgs e)
        {

        }
    }
}
