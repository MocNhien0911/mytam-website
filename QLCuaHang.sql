create database QLCuaHang
go
--drop database QLCuaHang
use QLCuaHang
go

--use master
--drop database QLCuaHang

create table KhachHang
(
	MaKH int identity(1,1) not null,
	TenKH nvarchar(30),
	TenDangNhap nvarchar(50),
	MatKhau nvarchar(50),
	GioiTinh nvarchar(4),
	DienThoai char(12),
	Email nchar(30),
	DiaChi nvarchar(50),
	primary key(MaKH)
)

create table NhanVien
(
	MaNV int identity(1,1) not null,
	TenNV nvarchar(50),
	TenDangNhap nvarchar(50),
	MatKhau nvarchar(50),
	GioiTinh nvarchar(4),
	DienThoai char(12),
	Email nchar(30),
	DiaChi nvarchar(50),
	primary key (MaNV)
)

create table LoaiHang
(
	MaLoai int identity(1,1) not null,
	TenLoai nvarchar(20),
	primary key (MaLoai)
)

create table MatHang
(
	MaHang int identity(1,1) not null,
	MaLoai int,
	TenHang nvarchar(50),
	MoTa nText,
	HinhAnh nchar(20),
	Gia float,
	SoLuong int,
	primary key (MaHang)
)

create table HoaDon
(
	MaHD int identity(1,1) not null,
	MaKH int,
	NgayHoaDon date,
	NgayGiao date,
	NgayThanhToan date,
	primary key (MaHD)
)

create table ChiTiet
(
	MaHD int not null,
	MaHang int not null,
	SoLuong int,
	primary key (MaHD, MaHang)
)
----
create table NhaPhanPhoi
	(
		MaNPP int identity(1,1) not null,
		TenNPP Nvarchar(50),
		primary key (MaNPP)
	)

create table HoaDonNhapHang
(
	MaNPP int,
	MHDNhapHang int identity(1,1) not null,
	MaHang int,
	SoLuong int,
	DonViTinh varchar(15),
	NgayNhapHang date,
	primary key (MHDNhapHang)
)

alter table HoaDonNhapHang
add constraint fk_HoaDonNhapHang_NhaPhanPhoi foreign key (MaNPP) references NhaPhanPhoi(MaNPP)

create table ThongKeDoanhThu
(
	Ngay Date,
	TongTien float,
	primary key (Ngay)
)

---
alter table ChiTiet
add constraint fk_ChiTiet_HoaDon foreign key (MaHD) references HoaDon(MaHD)
alter table ChiTiet
add constraint fk_ChiTiet_MatHang foreign key (MaHang) references MatHang(MaHang)

alter table HoaDon
add constraint fk_HoaDon_KhachHang foreign key (MaKH) references KhachHang(MaKH)

alter table MatHang
add constraint pk_MatHang_LoaiHang foreign key (MaLoai) references LoaiHang(MaLoai)
---
insert into LoaiHang values (N'Rau củ');
insert into LoaiHang values (N'Thịt');
insert into LoaiHang values (N'Trái cây');
insert into LoaiHang values (N'Cá')
insert into LoaiHang values (N'Hạt Giống')
---
insert into KhachHang values(N'Đỗ Duy Phương','duyphuong','123456','Nam','0397896666','olale19999@gmail.com',N'Bình Thuận')
insert into KhachHang values(N'Huỳnh Kiến Phúc','kienphuc','123456','Nam','0221241546','kienphuc@gmail.com',N'Vĩnh Phúc')
insert into KhachHang values(N'Lý Uyễn Nhi','uyennhi','123456','Nu','0352364522','nhiuyen@gmail.com',N'Thành phố Hồ Chí Minh')
insert into KhachHang values(N'phong','phong123','123456','Nam','0945435345','phongdeptry@gmail.com',N'Bình Định')
---

insert into NhanVien values (N'Huỳnh Kiến Phúc', 'phuc123', '12345', 'Nam', '123456789', 'kienphuc@gmail.com', N'Vĩnh Phúc');

insert into MatHang values
(1, N'Mướp Hương', N'Mướp là một loại cây thảo dạng dây leo, được trồng để lấy quả xanh. Với nhiều chất dinh dưỡng và công dụng đặc biệt tốt cho sức khỏe, mướp được nhiều người lựa chọn trong bữa ăn gia đình.Mướp hương có vị thơm ngát, ăn ngọt mát. Công dụng của mướpTất cả bộ phận của mướp đều là thảo dược', 'muophuong.png', 3700, 100),
(2, N'Thịt diềm bò', N'Vĩnh Tường, Vĩnh Phúc từ lâu đã là địa danh nổi tiếng về nghề mua, bán, giết mổ trâu bò để cung cấp cho thị trường Hà Nội. Để được những miếng thịt bò thơm ngon, các “nghệ nhân” Vĩnh Tường phải có kinh nghiệm tối thiểu 5 năm để có thể thực hiện chuẩn quy trình mổ thịt bò, đem lại những phần bò ngon', 'thitdiembo.jpg', 315000, 100),
(3, N'Quả chanh', N'Không có', 'quachanh.jpg', 52000, 100),
(3, N'Cà chua', N'Không có', 'cachua.jpg', 25600, 100),
(1, N'Nấm kim châm', N'Không có', 'namkimcham.jpg', 23800, 100),
(1, N'Rau lang 500g', N'Không có', 'raulang.jpg', 19000, 100),
(1, N'Ngò gai 100g', N'Không có', 'ngogai.jpg', 9000, 100),
(2, N'Sườn non heo nóng', N'Không có', 'suonnonheonong.jpg', 106000, 100),
(2, N'Ba chỉ bò Mỹ - cắt dày', N'Không có', 'bachibomy.jpg', 99000, 100),
(1, N'Cà rốt', N'Không có', 'carot.jpg', 19000, 50),
(1, N'Cà tím', N'Không có', 'catim.jpg', 19000, 50),
 (1, N'Bí đao', N'Không có', 'bidao.jpg', 19000, 50),
 (1, N'Bí ngòi', N'Không có', 'bingoi.jpg', 19000, 50),
 (1, N'Củ cải trắng', N'Không có', 'cucaitrang.jpg', 19000, 50),
 (1, N'Củ gừng', N'Không có', 'cugung.png', 19000, 50),
 (1, N'Tỏi', N'Không có', 'toi.jpg', 19000, 50),
 (1, N'Tỏi cô đơn', N'Không có', 'toicodon.jpg', 19000, 50),
 (2, N'Thịt bò thăn', N'Không có', 'thitbothan.jpg', 106000, 100),
 (2, N'Thịt nai', N'Không có', 'thitnai.jpg', 106000, 100),
 (2, N'Thịt nạc thăn bò', N'Không có', 'thitnacthanbo.jpg', 106000, 100),
 (2, N'Thịt nạc thăn heo', N'Không có', 'thitnacthanheo.jpg', 106000, 100),
 (2, N'Thịt gà', N'Không có', 'thitga.jpg', 106000, 100),
 (2, N'Đùi gà', N'Không có', 'thitduiga.jpg', 106000, 100),
(3, N'Ổi nữ hoàng', N'Không có', 'oinuhoang.jpg', 17000, 100),
(3, N'Táo', N'Không có', 'tao.jpg', 17000, 100),
(3, N'Bơ', N'Không có', 'bo.jpg', 17000, 100),
(3, N'Chuối', N'Không có', 'chuoi.jpg', 17000, 100),
(3, N'Kiwi', N'Không có', 'kiwi.jpg', 17000, 100),
(3, N'Lựu', N'Không có', 'luu.jpg', 17000, 100),
(4, N'Cá chép', N'Không có', 'cachep.jpg', 207000, 100),
(4, N'Cá dứa', N'Không có', 'cadua.jpg', 120000, 100),
(4, N'Cá hồi', N'Không có', 'cahoi.jpg', 170000, 100),
(4, N'Cá hú', N'Không có', 'cahu.jpg', 70000, 100),
(4, N'Cá rô phi', N'Không có', 'carophi.jpg', 50000, 100),
(4, N'Cá lóc', N'Nướng mía, nấu canh hoặc ăn với lẩu cá', 'catrau.jpg', 100000, 100),
(1, N'Bí đỏ', N'Không có', 'bido.jpg', 19000, 50),
(1, N'Củ dền', N'Không có', 'cuden.jpg', 19000, 50),
(1, N'Rau húng quế', N'Không có', 'rauhungque.jpg', 19000, 50),
(1, N'Rau má', N'Không có', 'rauma.jpg', 19000, 50),
(1, N'Rau mồng tơi', N'Không có', 'raumongtoi.jpg', 19000, 50),
(1, N'Rau muống', N'Không có', 'raumuong.jpg', 19000, 50),
(1, N'Ngò', N'Không có', 'raungo.jpg', 19000, 50),
(5,N'Hạt bí',N'Dùng để gieo trồng','hatbi.jpg',20000,50),
(5,N'Hạt đu đủ',N'Dùng để gieo trồng','hatdudu.jpg',20000,50),
(5,N'Hạt rau muống',N'Dùng để gieo trồng','hatraumuong.jpg',20000,50),
(5,N'Hạt bưởi',N'Dùng để gieo trồng','hatbuoi.jpg',20000,50),
(5,N'Hạt khổ qua',N'Dùng để gieo trồng','khoqua.jpg',20000,50),
(5,N'Hạt ngô tím',N'Dùng để gieo trồng','hatngotim.jpg',20000,50),
(5,N'Hạt rau má',N'Dùng để gieo trồng','hatrauma.jpg',20000,50),
(5,N'Hạt cải ngọt',N'Dùng để gieo trồng','hatcaingot.jpg',20000,50),
(5,N'Hạt cải chíp',N'Dùng để gieo trồng','hatcaichip.jpg',20000,50);
--select* from KhachHang
--select* from MatHang
--select* from NhanVien
--select* from HoaDon
--select* from ChiTiet
--select* from ThongKeDoanhThu

insert into NhaPhanPhoi values (N'Nhà phân phối số 1');
insert into NhaPhanPhoi values (N'Nhà phân phối số 2');
insert into NhaPhanPhoi values (N'Nhà phân phối số 3');

--select* from HoaDonNhapHang