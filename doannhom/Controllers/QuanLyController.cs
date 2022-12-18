using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using doannhom.Models;
using System.IO;

namespace doannhom.Controllers
{
    public class QuanLyController : Controller
    {
        //
        // GET: /QuanLy/

        DataClasses1DataContext data = new DataClasses1DataContext();

        public ActionResult QLyDonHang()
        {
            NhanVien nv = Session["nhanvien"] as NhanVien;

            if (nv == null)
            {
                return RedirectToAction("DangNhap", "QuanLy");
            }

            List<HoaDon> dshd = data.HoaDons.ToList();

            return View(dshd);
        }

        public ActionResult ThongKe(int mhd)
        {
            List<ChiTiet> dsct = data.ChiTiets.Where(c => c.MaHD == mhd).ToList();

            //thong ke thanh tien
            var thanhtien = dsct.Sum(ct => ct.SoLuong * ct.MatHang.Gia);

            ViewBag.tt = thanhtien;
            return PartialView(dsct);
        }

        [HttpPost]
        public ActionResult GiaoHang(FormCollection c)
        {
            int sopt = int.Parse(c["tong"]);
            for (int i = 1; i <= sopt; i++)
            {
                if (c[i.ToString()] != null)
                {
                    int mhd = int.Parse(c[i.ToString()]);
                    HoaDon hd = data.HoaDons.SingleOrDefault(h => h.MaHD == mhd);
                    hd.NgayThanhToan = DateTime.Now;
                    UpdateModel(hd);
                }
                data.SubmitChanges();
            }
            return RedirectToAction("QLyDonHang", "QuanLy");
        }

        public ActionResult LietKeHoaDon(int mhd)
        {
            List<ChiTiet> dsct = data.ChiTiets.Where(c => c.MaHD == mhd).ToList();


            return PartialView(dsct);
        }

        [HttpPost]
        public ActionResult CapNhatGiaoHang(FormCollection c)
        {
            int n = int.Parse(c["tong"]);
            
            for (int i = 0; i <= n; i++)
            {
                string tenck = i.ToString();
                if (c[tenck] != null)//duoc chon
                {
                    //cap nhat tinh trang giao hang tai hoa don co ma hoa don la gia tri nut checkbox
                    int mhd = int.Parse(c[tenck]);
                    HoaDon hd = data.HoaDons.SingleOrDefault(h => h.MaHD == mhd);
                    hd.NgayThanhToan = DateTime.Now;

                    UpdateModel(hd);
                    data.SubmitChanges();
                }
            }


            return RedirectToAction("QLyDonHang", "QuanLy");
        }

        public ActionResult SanPham()
        {
            NhanVien nv = Session["nhanvien"] as NhanVien;

            if (nv == null)
            {
                return RedirectToAction("DangNhap", "QuanLy");
            }

            List<MatHang> ds = data.MatHangs.ToList();
            return View(ds);
        }

        [HttpGet]
        public ActionResult ThemSanPham()
        {
            ViewBag.MaLoai = new SelectList(data.LoaiHangs.ToList(), "MaLoai", "TenLoai");
            return View();
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Them(MatHang mh, HttpPostedFileBase upHinh)
        {

            mh.HinhAnh = upHinh.FileName;
            upHinh.SaveAs(Server.MapPath("/Content/HinhAnh/" + upHinh.FileName));

            data.MatHangs.InsertOnSubmit(mh);
            data.SubmitChanges();
            return RedirectToAction("SanPham", "QuanLy");
        }

        public ActionResult ChiTietSanPham(int id)
        {
            MatHang mh = data.MatHangs.SingleOrDefault(n => n.MaHang == id);
            ViewBag.MaHang = mh.MaHang;
            if (mh == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(mh);
        }

        [HttpGet]
        public ActionResult XoaSanPham(int id)
        {
            MatHang mh = data.MatHangs.SingleOrDefault(n => n.MaHang == id);
            ViewBag.MaHang = mh.MaHang;
            if (mh == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(mh);
        }

        [HttpPost, ActionName("XoaSanPham")]
        public ActionResult XacNhanXoa(int id)
        {
            MatHang mh = data.MatHangs.SingleOrDefault(n => n.MaHang == id);
            List<ChiTiet> dsct = data.ChiTiets.Where(n => n.MaHang == id).ToList();
            ViewBag.MaHang = mh.MaHang;
            if (mh == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            if (dsct != null)
            {
                foreach(ChiTiet ct in dsct)
                {
                    data.ChiTiets.DeleteOnSubmit(ct);
                    data.SubmitChanges();
                }
            }
            data.MatHangs.DeleteOnSubmit(mh);
            data.SubmitChanges();
            return RedirectToAction("SanPham");
        }

        [HttpGet]
        public ActionResult SuaSanPham(int id)
        {
            MatHang mh = data.MatHangs.SingleOrDefault(n => n.MaHang == id);
            ViewBag.MaLoai = new SelectList(data.LoaiHangs.ToList(), "MaLoai", "TenLoai");
            ViewBag.MaHang = mh.MaHang;
            //ViewBag.MaLoai = new SelectList(data.LoaiHangs.ToList().OrderBy(n => n.TenLoai), "MaLoai", "TenLoai");

            if (mh == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            return View(mh);
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult SuaSanPham(MatHang mh, HttpPostedFileBase fileUpload)
        {
            ViewBag.MaLoai = new SelectList(data.LoaiHangs.ToList().OrderBy(n => n.TenLoai), "MaLoai", "TenLoai");
            if (fileUpload == null)
            {
                ViewBag.Thongbao = "Vui lòng chọn ảnh bìa!";
                return View();
            }
            //Them vao CSDL
            else
            {
                if (ModelState.IsValid)
                {
                    //Luu ten file, luu y bo sung thu vien using System.IO
                    var fileName = Path.GetFileName(fileUpload.FileName);
                    //Luu duong dan cua file
                    var path = Path.Combine(Server.MapPath("~/Content/HinhAnh"), fileName);
                    //Kiem tra hinh anh co ton tai khong?
                    if (System.IO.File.Exists(path))
                        ViewBag.Thongbao = "Hình ảnh đã tồn tại";
                    else
                    {
                        //Luu hinh anh vao duong dan
                        fileUpload.SaveAs(path);
                    }
                    mh.HinhAnh = fileName;
                    //Luu vao CSDL
                    UpdateModel(mh);
                    data.SubmitChanges();
                }
                return RedirectToAction("SanPham");
            }
        }

        [HttpGet]
        public ActionResult DangNhap()
        {
            return View();
        }

        [HttpPost]
        public ActionResult XLDN(FormCollection col)
        {
            string ten = col["txtnv"];
            string p = col["txtpass"];
            NhanVien nv = data.NhanViens.SingleOrDefault(k => k.TenDangNhap == ten && k.MatKhau == p);
            if (nv == null) // đăng nhập không thành công
            {
                SetAlert("Tên đăng nhập hoặc mật khẩu không đúng", 2);
                return RedirectToAction("DangNhap", "QuanLy");
            }
                
            //thành công
            Session["nhanvien"] = nv;
            return RedirectToAction("QLyDonHang", "QuanLy");
        }

        public ActionResult KhachHang()
        {

            NhanVien nv = Session["nhanvien"] as NhanVien;

            if (nv == null)
            {
                return RedirectToAction("DangNhap", "QuanLy");
            }

            List<KhachHang> ds = data.KhachHangs.ToList();
            return View(ds);
        }

        [HttpGet]
        public ActionResult DangKy()
        {
            return View();
        }

        [HttpPost]
        public ActionResult XLDK(FormCollection col)
        {
            NhanVien nv = new NhanVien();

            List<NhanVien> ds = data.NhanViens.Where(n => n.TenDangNhap == col["txtnv"]).ToList();

            if (ds.Count != 0)
            {
                SetAlert("Tên đăng nhập đã tồn tại", 2);
                return RedirectToAction("DangKy", "QuanLy");
            }

            nv.TenNV = col["txtten"];
            nv.TenDangNhap = col["txtnv"];
            nv.MatKhau = col["txtpass"];
            nv.GioiTinh = col["gioitinh"];
            nv.DienThoai = col["txtdt"];
            nv.Email = col["txtemail"];
            nv.DiaChi = col["txtdiachi"];
            data.NhanViens.InsertOnSubmit(nv);
            data.SubmitChanges();

            

            // đăng ký thành công
            Session["nhanvien"] = nv;

            return RedirectToAction("QLyDonHang", "QuanLy");
        }

        public ActionResult DangXuat()
        {
            Session["nhanvien"] = null;
            return RedirectToAction("DangNhap", "QuanLy");
        }

        public ActionResult ThongKeDoanhThu()
        {
            return View();
        }

        public ActionResult QLyDonHangChuaGiao()
        {
            List<HoaDon> dshd = data.HoaDons.Where(n => n.NgayThanhToan == null).ToList();

            return View(dshd);
        }

        public ActionResult QLyDonHangGiaoHT()
        {
            List<HoaDon> dshd = data.HoaDons.Where(n => n.NgayGiao == DateTime.Now).ToList();

            return View(dshd);
        }

        public ActionResult QLyDonHangDaGiao()
        {
            List<HoaDon> dshd = data.HoaDons.Where(n => n.NgayThanhToan != null).ToList();

            return View(dshd);
        }

        public ActionResult ThongKeBanHang()
        {
            List<ThongKeDoanhThu> ds = data.ThongKeDoanhThus.ToList();
            return View(ds);
        }

        [HttpGet]
        public ActionResult DatHang()
        {
            NhanVien nv = Session["nhanvien"] as NhanVien;

            if (nv == null)
            {
                return RedirectToAction("DangNhap", "QuanLy");
            }

            return View();
        }

        [HttpPost]
        public ActionResult XLDH(FormCollection c)
        {
            HoaDonNhapHang hd = new HoaDonNhapHang();

            if (c["txtmahang"] == null || c["txtmanhapp"] == null)
            {
                return RedirectToAction("DatHang", "QuanLy");
            }

            hd.MaHang = int.Parse(c["txtmahang"]);
            hd.MaNPP = int.Parse(c["txtmanhapp"]);

            if (int.Parse(c["txtsl"]) <= 0 || c["txtsl"] == null)
            {
                hd.SoLuong = 0;
            }
            else
            {
                hd.SoLuong = int.Parse(c["txtsl"]);
            }           
            hd.DonViTinh = c["cbbDVT"];

            hd.NgayNhapHang = DateTime.Now;
            

            List<MatHang> ds1 = data.MatHangs.Where(t => t.MaHang == hd.MaHang).ToList();
            List<NhaPhanPhoi> ds2 = data.NhaPhanPhois.Where(t => t.MaNPP == hd.MaNPP).ToList();

            if (ds1 == null || ds2 == null)
            {
                return RedirectToAction("DatHang", "QuanLy");
            }
            else
            {
                foreach(MatHang mh in ds1)
                {
                    mh.SoLuong = mh.SoLuong + hd.SoLuong;
                }                
                data.HoaDonNhapHangs.InsertOnSubmit(hd);
                data.SubmitChanges();
            }

            return RedirectToAction("SanPham", "QuanLy");
        }

        protected void SetAlert(string message, int type)
        {
            TempData["AlertMessage"] = message;
            if (type == 1)
            {
                TempData["AlertType"] = "alert-success";
            }
            else if (type == 2)
            {
                TempData["AlertType"] = "alert-warning";
            }
            else if (type == 3)
            {
                TempData["AlertType"] = "alert-danger";
            }
            else
            {
                TempData["AlertType"] = "alert-info";
            }
        }

        [HttpGet]
        public ActionResult ThemKH()
        {
            return View();
        }

        [HttpPost]
        public ActionResult XLThemKH(FormCollection c)
        {
            KhachHang kh = new KhachHang();

            List<KhachHang> ds = data.KhachHangs.Where(n => n.TenDangNhap == c["tendn"]).ToList();

            if (ds.Count != 0)
            {
                SetAlert("Tên đăng nhập đã tồn tại", 2);
                return RedirectToAction("ThemKH", "QuanLy");
            }

            kh.TenKH = c["tenkh"];
            kh.TenDangNhap = c["tendn"];
            kh.MatKhau = c["matkhau"];
            kh.GioiTinh = c["gioitinh"];
            kh.DienThoai = c["dienthoai"];
            kh.Email = c["email"];
            kh.DiaChi = c["diachi"];
            data.KhachHangs.InsertOnSubmit(kh);
            data.SubmitChanges();

            return RedirectToAction("KhachHang", "QuanLy");
        }

        [HttpGet]
        public ActionResult SuaKH(int id)
        {
            Session["idkh"] = id;
            return View();
        }

        [HttpPost]
        public ActionResult XLSuaKH(FormCollection c)
        {

            List<KhachHang> ds = data.KhachHangs.Where(n => n.TenDangNhap == c["tendn"]).ToList();

            if (ds.Count != 0)
            {
                SetAlert("Tên đăng nhập đã tồn tại", 2);
                return RedirectToAction("SuaKH", "QuanLy");
            }

            int idkh = int.Parse(Session["idkh"].ToString());

            List<KhachHang> ds1 = data.KhachHangs.Where(n => n.MaKH == idkh).ToList();

            if (ds1.Count == 0)
            {
                SetAlert("Khách hàng không tồn tại", 2);
                return RedirectToAction("SuaKH", "QuanLy");
            }
            else
            {
                foreach(KhachHang kh in ds1)
                {
                    kh.TenKH = c["tenkh"];
                    kh.TenDangNhap = c["tendn"];
                    kh.MatKhau = c["matkhau"];
                    kh.GioiTinh = c["gioitinh"];
                    kh.DienThoai = c["dienthoai"];
                    kh.Email = c["email"];
                    kh.DiaChi = c["diachi"];
                }
            }

            data.SubmitChanges();

            return RedirectToAction("KhachHang", "QuanLy");
        }

        public ActionResult XoaKH(int id)
        {
            List<KhachHang> ds = data.KhachHangs.Where(n => n.MaKH == id).ToList();
            List<HoaDon> dshd = data.HoaDons.Where(n => n.MaKH == id).ToList();
            foreach(KhachHang kh in ds)
            {
                data.KhachHangs.DeleteOnSubmit(kh);
                data.SubmitChanges();
            }
            foreach(HoaDon hd in dshd)
            {
                data.HoaDons.DeleteOnSubmit(hd);
                data.SubmitChanges();
            }
            return RedirectToAction("KhachHang", "QuanLy");
        }
    }
}
