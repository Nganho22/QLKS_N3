using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLKS_N3
{
    public class KHACHHANG
    {
        public string MAKH { get; set; }
        public string TENKH { get; set; }
        public string DIACHI { get; set; }
        public string SDT { get; set; }
        public string EMAIL { get; set; }
        public string NGAYDK { get; set; }
        public string NGAYDEN { get; set; }
        public string NGAYTRAPHONG { get; set; }
        public int SODEMLUUTRU { get; set; }
        public string MAHOCHIEU { get; set; }
        public string CMND { get; set; }
        public string MADLTG { get; set; }
        public string MADOAN { get; set; }

        public KHACHHANG()
        {
        }

        public KHACHHANG(string makh)
        {
            this.MAKH = makh;
        }
        public KHACHHANG(string makh,string ten, string dc, string sdt, string email, string cmd, string hochieu)
        {
            this.MAKH = makh;
            this.TENKH = ten;
            this.DIACHI = dc;
            this.SDT = sdt;
            this.EMAIL = email;
            this.CMND = cmd;
            this.MAHOCHIEU = hochieu;
        }
        public KHACHHANG(string ten, string sdt, string email, string cmd, string hochieu)
        {
            this.TENKH = ten;
            this.SDT = sdt;
            this.EMAIL = email;
            this.CMND = cmd;
            this.MAHOCHIEU = hochieu;
        }
    }
    
   
}
