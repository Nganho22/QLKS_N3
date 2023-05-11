using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLKS_N3
{
    public class PHIEUDATPHONG
    {
        public string MAPDP { get; set; }
        public string NGAYDAT { get; set; }
        public string YEUCAU { get; set; }
        public int SLPHONG { get; set; }
        public string MADLTG { get; set; }
        public string MAKH { get; set; }
        public string MANV { get; set; }
        public string TINHTRANG { get; set; }

        public PHIEUDATPHONG()
        {

        }

        public PHIEUDATPHONG(string mapd)
        {
            this.MAPDP = mapd;
        }
        public PHIEUDATPHONG(string mapd, string makh)
        {
            this.MAPDP = mapd;
            this.MAKH = makh;
        }

    }
}
