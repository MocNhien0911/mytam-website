using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using doannhom.Models;
using System.IO;

namespace doannhom.Controllers
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/
        DataClasses1DataContext data = new DataClasses1DataContext();

        public ActionResult TrangChu()
        {
            
            List<MatHang> dsmh = data.MatHangs.Take(6).ToList();
            return View(dsmh);
        }

        public ActionResult SanPham()
        {
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
            return RedirectToAction("SanPham", "Home");
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
            ViewBag.MaHang = mh.MaHang;
            if (mh == null)
            {
                Response.StatusCode = 404;
                return null;
            }
            data.MatHangs.DeleteOnSubmit(mh);
            data.SubmitChanges();
            return RedirectToAction("SanPham");
        }

        public ActionResult LienHe()
        {
            return View();
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
            if(fileUpload == null)
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
        public ActionResult DangKy()
        {
            return View();
        }

        [HttpPost]
        public ActionResult XLDK(FormCollection col)
        {
            KhachHang kh = new KhachHang();

            kh.TenKH = col["txtten"];
            kh.TenDangNhap = col["txtkh"];
            kh.MatKhau = col["txtpass"];
            kh.GioiTinh = col["gioitinh"];
            kh.DienThoai = col["txtdt"];
            kh.Email = col["txtemail"];
            kh.DiaChi = col["txtdiachi"];
            data.KhachHangs.InsertOnSubmit(kh);
            data.SubmitChanges();

            // đăng ký thành công
            Session["khachhang"] = kh;

            return RedirectToAction("TrangChu", "Home");
        }

        [HttpGet]
        public ActionResult DangNhap()
        {
            return View();
        }

        [HttpPost]
        public ActionResult XLDN(FormCollection col)
        {
            string ten = col["txtkh"];
            string p = col["txtpass"];
            KhachHang kh = data.KhachHangs.SingleOrDefault(k => k.TenDangNhap == ten && k.MatKhau == p);
            if (kh == null) // đăng nhập không thành công
            {
                SetAlert("Tên đăng nhập hoặc mật khẩu không đúng", 2);
                return RedirectToAction("DangNhap", "Home");
            }              
            //thành công
            Session["khachhang"] = kh;
            return RedirectToAction("TrangChu", "Home");
        }

        public ActionResult DangXuat()
        {
            Session["khachhang"] = null;
            return RedirectToAction("TrangChu", "Home");
        }

        public ActionResult Welcome()
        {
            return View();
        }

        public ActionResult HTLoaiHang()
        {
            List<LoaiHang> dslh = data.LoaiHangs.ToList();
            return PartialView(dslh);
        }

        public ActionResult HTTheoLoaiHang(int id)
        {
            List<MatHang> dsmh = data.MatHangs.Where(t => t.MaLoai == id).ToList();
            return View("TrangChu", dsmh);
        }

        public ActionResult ChiTiet(int id)
        {
            MatHang mh = data.MatHangs.FirstOrDefault(t => t.MaHang == id);

            List<MatHang> ds1 = data.MatHangs.Where(t => t.MaLoai == mh.MaLoai).Take(6).ToList();
            ViewBag.list1 = ds1;

            return View(mh);
        }

        public ActionResult ChonMua(int id)
        {
            GioHang gh = Session["gio"] as GioHang;
            if (gh == null)
            {
                gh = new GioHang();
            }

            //Thêm mặt hàng vào giỏ
            gh.Them(id);

            Session["gio"] = gh;


            return RedirectToAction("TrangChu", "Home");
        }

        public ActionResult HTGioHang()
        {
            GioHang gh = Session["gio"] as GioHang;

            return View(gh);
        }

        public ActionResult XacNhanThongTin()
        {
            KhachHang khach = Session["khachhang"] as KhachHang;

            if (khach == null)
            {
                return RedirectToAction("DangNhap", "Home");
            }


            return View(khach);
        }

        public ActionResult LuuDatHang(FormCollection col)
        {
            GioHang gh = (GioHang)Session["gio"];
            KhachHang kh = (KhachHang)Session["khachhang"];
            if (Session["khachhang"] == null)
                return RedirectToAction("DangNhap", "Home");
            if (Session["gio"] == null || gh.lst.Count == 0)
                return RedirectToAction("HTGioHang", "Home");

            //lay thong tin ngay giao
            DateTime ngaygiao;
            if (col["txtNgayHen"] == "")
            {
                ngaygiao = DateTime.Now;
            }
            else
            {
                ngaygiao = DateTime.Parse(col["txtNgayHen"]);
            }

            //luu vao bang dat hang
            HoaDon hd = new HoaDon();
            hd.MaKH = kh.MaKH;
            hd.NgayHoaDon = DateTime.Now;
            hd.NgayGiao = ngaygiao;
            data.HoaDons.InsertOnSubmit(hd);
            data.SubmitChanges();
            //luu thong tin vao bang chi tiet dat hang
            foreach (CartItem sp in gh.lst)
            {
                ChiTiet ct = new ChiTiet();
                ct.MaHD = hd.MaHD;
                ct.MaHang = sp.iMaHang;
                ct.SoLuong = sp.iSoLuong;
                data.ChiTiets.InsertOnSubmit(ct);
            }
            data.SubmitChanges();

            //luu vao bang thong ke doanh thu

            List<ThongKeDoanhThu> listdt = data.ThongKeDoanhThus.Where(n => n.Ngay == DateTime.Now).ToList();

            if (listdt.Count == 0)
            {
                ThongKeDoanhThu tk = new ThongKeDoanhThu();
                tk.Ngay = DateTime.Now;
                tk.TongTien = gh.TongThanhTien();
                data.ThongKeDoanhThus.InsertOnSubmit(tk);
                
            }
            else
            {
                foreach (ThongKeDoanhThu tk in listdt)
                {
                    tk.TongTien = tk.TongTien + gh.TongThanhTien();
                }
            }
            data.SubmitChanges();

            //làm trống giỏ hàng
            Session["gio"] = null;

            return RedirectToAction("TrangChu", "Home");
        }

        public void showMessage(string mess)
        {
            string strBuilder = "<script language='javascript'>alert('" + mess + "')</script>";
            Response.Write(strBuilder);
        }

        public ActionResult XoaGioHang()
        {
            Session["gio"] = null;
            return RedirectToAction("HTGioHang", "Home");
        }

        public ActionResult Xoa1MatHang(int id)
        {
            GioHang gh = (GioHang)Session["gio"];
            gh.Xoa(id);
            return RedirectToAction("HTGioHang", "Home");
        }

        public ActionResult LichSuMuaHang()
        {
            KhachHang khach = Session["khachhang"] as KhachHang;

            if (khach == null)
            {
                return RedirectToAction("DangNhap", "Home");
            }
            
            List<HoaDon> ds = data.HoaDons.Where(t => t.MaKH == khach.MaKH).ToList();
            return View(ds);
        }

        public ActionResult ThongKe(int mhd)
        {
            List<ChiTiet> dsct = data.ChiTiets.Where(c => c.MaHD == mhd).ToList();

            //thong ke thanh tien
            var thanhtien = dsct.Sum(ct => ct.SoLuong * ct.MatHang.Gia);

            ViewBag.tt = thanhtien;
            return PartialView(dsct);
        }

        public ActionResult LietKeHoaDon(int mhd)
        {
            List<ChiTiet> dsct = data.ChiTiets.Where(c => c.MaHD == mhd).ToList();


            return PartialView(dsct);
        }

        [HttpPost]
        public ActionResult XuLyTK(FormCollection c)
        {
            string tensp = c["txtSearch"].ToString();
            if (tensp == null)
            {
                return RedirectToAction("TrangChu", "Home");
            }
            List<MatHang> ds = data.MatHangs.Where(n => n.TenHang.Contains(tensp) == true).ToList();
            return View("TrangChu", ds);
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
    }
}
