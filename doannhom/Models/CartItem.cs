using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace doannhom.Models
{
    public class CartItem
    {
        public int iMaHang { get; set; }
        public int iMaLoai { get; set; }
        public string sTenHang { get; set; }
        public string sMoTa { get; set; }
        public string sHinhAnh { get; set; }
        public float fGia { get; set; }
        public int iSoLuong { get; set; }

        public double ThanhTien
        {
            get { return iSoLuong * fGia; }
        }

        DataClasses1DataContext data = new DataClasses1DataContext();

        //Hàm tạo cho giỏ hàng
        public CartItem(int mh)
        {
            MatHang mathang = data.MatHangs.Single(n => n.MaHang == mh);

            if (mathang != null)
            {
                iMaHang = mh;
                iMaLoai = int.Parse(mathang.MaLoai.ToString());
                sTenHang = mathang.TenHang;
                sMoTa = mathang.MoTa;
                sHinhAnh = mathang.HinhAnh;
                fGia = float.Parse(mathang.Gia.ToString());
                iSoLuong = 1;
            }
        }
    }

    public class GioHang
    {
        public List<CartItem> lst;
        //Hàm tạo cho giỏ hàng
        public GioHang()
        {
            lst = new List<CartItem>();
        }
        public GioHang(List<CartItem> lstGH)
        {
            if (lstGH == null)
                lst = new List<CartItem>();
            else
                lst = lstGH;
        }
        //Tính số mặt hàng
        public int SoMatHang()
        {
            if (lst == null)
                return 0;
            return lst.Count;
        }
        //Tính tổng số lượng mặt hàng
        public int TongSLHang()
        {
            int iTongSoLuong = 0;
            if (lst != null)
            {
                iTongSoLuong = lst.Sum(n => n.iSoLuong);
            }
            return iTongSoLuong;
        }
        //tính tổng thành tiền
        public double TongThanhTien()
        {
            double iTongTien = 0;
            if (lst != null)
            {
                iTongTien = lst.Sum(n => n.ThanhTien);
            }
            return iTongTien;
        }
        //Thêm sản phẩm
        public int Them(int iMaHang)
        {
            //kiểm tra sản phẩm có trong danh sách chưa?
            CartItem sanpham = lst.Find(n => n.iMaHang == iMaHang);

            if (sanpham == null)//chưa có
            {
                CartItem sach = new CartItem(iMaHang); //tạo mới
                if (sach == null)
                    return -1;
                lst.Add(sach);
            }
            else //có rồi
            {
                sanpham.iSoLuong++;//tăng số lượng lên 1
            }
            return 1;
        }

        //Xóa sản phẩm
        public int Xoa(int iMaHang)
        {
            //kiểm tra sản phẩm có trong danh sách chưa?
            CartItem sanpham = lst.Find(n => n.iMaHang == iMaHang);

            if (sanpham == null)//chưa có
            {
                return -1;
            }
            else //có rồi
            {
                lst.Remove(sanpham);
            }
            return 1;
        }
    }
}