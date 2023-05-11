using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLKS_N3
{
    public class PHONG
    {
        public string MAPHONG { get; set; }
        public string TINHTRANG { get; set; }
        public string LOAIPHONG { get; set; }
        public string CANDONPHONG { get; set; }
        public float GIAPHONG { get; set; }
        public int TANG { get; set; }

        public PHONG()
        { }

        public PHONG(string maph)
        {
            this.MAPHONG = maph;
        }
    }
   

}

