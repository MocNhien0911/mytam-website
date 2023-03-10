USE [master]
GO
/****** Object:  Database [QLCuaHang]    Script Date: 11/23/2021 8:30:34 PM ******/
CREATE DATABASE [QLCuaHang]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLCuaHang', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QLCuaHang.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QLCuaHang_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\QLCuaHang_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QLCuaHang] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLCuaHang].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLCuaHang] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLCuaHang] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLCuaHang] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLCuaHang] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLCuaHang] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLCuaHang] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QLCuaHang] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLCuaHang] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLCuaHang] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLCuaHang] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLCuaHang] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLCuaHang] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLCuaHang] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLCuaHang] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLCuaHang] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QLCuaHang] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLCuaHang] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLCuaHang] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLCuaHang] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLCuaHang] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLCuaHang] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLCuaHang] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLCuaHang] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QLCuaHang] SET  MULTI_USER 
GO
ALTER DATABASE [QLCuaHang] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLCuaHang] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLCuaHang] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLCuaHang] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [QLCuaHang]
GO
/****** Object:  Table [ChiTiet]    Script Date: 11/23/2021 8:30:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ChiTiet](
	[MaHD] [int] NOT NULL,
	[MaHang] [int] NOT NULL,
	[SoLuong] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC,
	[MaHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [HoaDon]    Script Date: 11/23/2021 8:30:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [HoaDon](
	[MaHD] [int] IDENTITY(1,1) NOT NULL,
	[MaKH] [int] NULL,
	[NgayHoaDon] [date] NULL,
	[NgayGiao] [date] NULL,
	[NgayThanhToan] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [HoaDonNhapHang]    Script Date: 11/23/2021 8:30:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [HoaDonNhapHang](
	[MaNPP] [int] NULL,
	[MHDNhapHang] [int] IDENTITY(1,1) NOT NULL,
	[MaHang] [int] NULL,
	[SoLuong] [int] NULL,
	[DonViTinh] [varchar](15) NULL,
	[NgayNhapHang] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[MHDNhapHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [KhachHang]    Script Date: 11/23/2021 8:30:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [KhachHang](
	[MaKH] [int] IDENTITY(1,1) NOT NULL,
	[TenKH] [nvarchar](30) NULL,
	[TenDangNhap] [nvarchar](50) NULL,
	[MatKhau] [nvarchar](50) NULL,
	[GioiTinh] [nvarchar](4) NULL,
	[DienThoai] [char](12) NULL,
	[Email] [nchar](30) NULL,
	[DiaChi] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [LoaiHang]    Script Date: 11/23/2021 8:30:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [LoaiHang](
	[MaLoai] [int] IDENTITY(1,1) NOT NULL,
	[TenLoai] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaLoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [MatHang]    Script Date: 11/23/2021 8:30:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [MatHang](
	[MaHang] [int] IDENTITY(1,1) NOT NULL,
	[MaLoai] [int] NULL,
	[TenHang] [nvarchar](50) NULL,
	[MoTa] [ntext] NULL,
	[HinhAnh] [nchar](20) NULL,
	[Gia] [float] NULL,
	[SoLuong] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [NhanVien]    Script Date: 11/23/2021 8:30:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [NhanVien](
	[MaNV] [int] IDENTITY(1,1) NOT NULL,
	[TenNV] [nvarchar](50) NULL,
	[TenDangNhap] [nvarchar](50) NULL,
	[MatKhau] [nvarchar](50) NULL,
	[GioiTinh] [nvarchar](4) NULL,
	[DienThoai] [char](12) NULL,
	[Email] [nchar](30) NULL,
	[DiaChi] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [NhaPhanPhoi]    Script Date: 11/23/2021 8:30:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [NhaPhanPhoi](
	[MaNPP] [int] IDENTITY(1,1) NOT NULL,
	[TenNPP] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNPP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [ThongKeDoanhThu]    Script Date: 11/23/2021 8:30:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ThongKeDoanhThu](
	[Ngay] [date] NOT NULL,
	[TongTien] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[Ngay] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [ChiTiet] ([MaHD], [MaHang], [SoLuong]) VALUES (1, 3, 1)
INSERT [ChiTiet] ([MaHD], [MaHang], [SoLuong]) VALUES (1, 19, 1)
INSERT [ChiTiet] ([MaHD], [MaHang], [SoLuong]) VALUES (2, 1, 1)
INSERT [ChiTiet] ([MaHD], [MaHang], [SoLuong]) VALUES (2, 2, 1)
INSERT [ChiTiet] ([MaHD], [MaHang], [SoLuong]) VALUES (2, 47, 1)
SET IDENTITY_INSERT [HoaDon] ON 

INSERT [HoaDon] ([MaHD], [MaKH], [NgayHoaDon], [NgayGiao], [NgayThanhToan]) VALUES (1, 1, CAST(N'2021-11-23' AS Date), CAST(N'2021-12-09' AS Date), CAST(N'2021-11-23' AS Date))
INSERT [HoaDon] ([MaHD], [MaKH], [NgayHoaDon], [NgayGiao], [NgayThanhToan]) VALUES (2, 1, CAST(N'2021-11-23' AS Date), CAST(N'2021-12-01' AS Date), NULL)
SET IDENTITY_INSERT [HoaDon] OFF
SET IDENTITY_INSERT [KhachHang] ON 

INSERT [KhachHang] ([MaKH], [TenKH], [TenDangNhap], [MatKhau], [GioiTinh], [DienThoai], [Email], [DiaChi]) VALUES (1, N'Đỗ Duy Phương', N'duyphuong', N'123456', N'Nam', N'0397896666  ', N'olale19999@gmail.com          ', N'Bình Thuận')
INSERT [KhachHang] ([MaKH], [TenKH], [TenDangNhap], [MatKhau], [GioiTinh], [DienThoai], [Email], [DiaChi]) VALUES (2, N'Huỳnh Kiến Phúc', N'kienphuc', N'123456', N'Nam', N'0221241546  ', N'kienphuc@gmail.com            ', N'Vĩnh Phúc')
INSERT [KhachHang] ([MaKH], [TenKH], [TenDangNhap], [MatKhau], [GioiTinh], [DienThoai], [Email], [DiaChi]) VALUES (3, N'Lý Uyễn Nhi', N'uyennhi', N'123456', N'Nu', N'0352364522  ', N'nhiuyen@gmail.com             ', N'Thành phố Hồ Chí Minh')
INSERT [KhachHang] ([MaKH], [TenKH], [TenDangNhap], [MatKhau], [GioiTinh], [DienThoai], [Email], [DiaChi]) VALUES (4, N'phong', N'phong123', N'123456', N'Nam', N'0945435345  ', N'phongdeptry@gmail.com         ', N'Bình Định')
SET IDENTITY_INSERT [KhachHang] OFF
SET IDENTITY_INSERT [LoaiHang] ON 

INSERT [LoaiHang] ([MaLoai], [TenLoai]) VALUES (1, N'Rau củ')
INSERT [LoaiHang] ([MaLoai], [TenLoai]) VALUES (2, N'Thịt')
INSERT [LoaiHang] ([MaLoai], [TenLoai]) VALUES (3, N'Trái cây')
INSERT [LoaiHang] ([MaLoai], [TenLoai]) VALUES (4, N'Cá')
INSERT [LoaiHang] ([MaLoai], [TenLoai]) VALUES (5, N'Hạt Giống')
SET IDENTITY_INSERT [LoaiHang] OFF
SET IDENTITY_INSERT [MatHang] ON 

INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (1, 1, N'Mướp Hương', N'Mướp là một loại cây thảo dạng dây leo, được trồng để lấy quả xanh. Với nhiều chất dinh dưỡng và công dụng đặc biệt tốt cho sức khỏe, mướp được nhiều người lựa chọn trong bữa ăn gia đình.Mướp hương có vị thơm ngát, ăn ngọt mát. Công dụng của mướpTất cả bộ phận của mướp đều là thảo dược', N'muophuong.png       ', 3700, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (2, 2, N'Thịt diềm bò', N'Vĩnh Tường, Vĩnh Phúc từ lâu đã là địa danh nổi tiếng về nghề mua, bán, giết mổ trâu bò để cung cấp cho thị trường Hà Nội. Để được những miếng thịt bò thơm ngon, các “nghệ nhân” Vĩnh Tường phải có kinh nghiệm tối thiểu 5 năm để có thể thực hiện chuẩn quy trình mổ thịt bò, đem lại những phần bò ngon', N'thitdiembo.jpg      ', 315000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (3, 3, N'Quả chanh', N'Không có', N'quachanh.jpg        ', 52000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (4, 3, N'Cà chua', N'Không có', N'cachua.jpg          ', 25600, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (5, 1, N'Nấm kim châm', N'Không có', N'namkimcham.jpg      ', 23800, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (6, 1, N'Rau lang 500g', N'Không có', N'raulang.jpg         ', 19000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (7, 1, N'Ngò gai 100g', N'Không có', N'ngogai.jpg          ', 9000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (8, 2, N'Sườn non heo nóng', N'Không có', N'suonnonheonong.jpg  ', 106000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (9, 2, N'Ba chỉ bò Mỹ - cắt dày', N'Không có', N'bachibomy.jpg       ', 99000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (10, 1, N'Cà rốt', N'Không có', N'carot.jpg           ', 19000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (11, 1, N'Cà tím', N'Không có', N'catim.jpg           ', 19000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (12, 1, N'Bí đao', N'Không có', N'bidao.jpg           ', 19000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (13, 1, N'Bí ngòi', N'Không có', N'bingoi.jpg          ', 19000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (14, 1, N'Củ cải trắng', N'Không có', N'cucaitrang.jpg      ', 19000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (15, 1, N'Củ gừng', N'Không có', N'cugung.png          ', 19000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (16, 1, N'Tỏi', N'Không có', N'toi.jpg             ', 19000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (17, 1, N'Tỏi cô đơn', N'Không có', N'toicodon.jpg        ', 19000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (18, 2, N'Thịt bò thăn', N'Không có', N'thitbothan.jpg      ', 106000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (19, 2, N'Thịt nai', N'Không có', N'thitnai.jpg         ', 106000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (20, 2, N'Thịt nạc thăn bò', N'Không có', N'thitnacthanbo.jpg   ', 106000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (21, 2, N'Thịt nạc thăn heo', N'Không có', N'thitnacthanheo.jpg  ', 106000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (22, 2, N'Thịt gà', N'Không có', N'thitga.jpg          ', 106000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (23, 2, N'Đùi gà', N'Không có', N'thitduiga.jpg       ', 106000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (24, 3, N'Ổi nữ hoàng', N'Không có', N'oinuhoang.jpg       ', 17000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (25, 3, N'Táo', N'Không có', N'tao.jpg             ', 17000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (26, 3, N'Bơ', N'Không có', N'bo.jpg              ', 17000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (27, 3, N'Chuối', N'Không có', N'chuoi.jpg           ', 17000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (28, 3, N'Kiwi', N'Không có', N'kiwi.jpg            ', 17000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (29, 3, N'Lựu', N'Không có', N'luu.jpg             ', 17000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (30, 4, N'Cá chép', N'Không có', N'cachep.jpg          ', 207000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (31, 4, N'Cá dứa', N'Không có', N'cadua.jpg           ', 120000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (32, 4, N'Cá hồi', N'Không có', N'cahoi.jpg           ', 170000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (33, 4, N'Cá hú', N'Không có', N'cahu.jpg            ', 70000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (34, 4, N'Cá rô phi', N'Không có', N'carophi.jpg         ', 50000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (35, 4, N'Cá lóc', N'Nướng mía, nấu canh hoặc ăn với lẩu cá', N'catrau.jpg          ', 100000, 100)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (36, 1, N'Bí đỏ', N'Không có', N'bido.jpg            ', 19000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (37, 1, N'Củ dền', N'Không có', N'cuden.jpg           ', 19000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (38, 1, N'Rau húng quế', N'Không có', N'rauhungque.jpg      ', 19000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (39, 1, N'Rau má', N'Không có', N'rauma.jpg           ', 19000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (40, 1, N'Rau mồng tơi', N'Không có', N'raumongtoi.jpg      ', 19000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (41, 1, N'Rau muống', N'Không có', N'raumuong.jpg        ', 19000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (42, 1, N'Ngò', N'Không có', N'raungo.jpg          ', 19000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (43, 5, N'Hạt bí', N'Dùng để gieo trồng', N'hatbi.jpg           ', 20000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (44, 5, N'Hạt đu đủ', N'Dùng để gieo trồng', N'hatdudu.jpg         ', 20000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (45, 5, N'Hạt rau muống', N'Dùng để gieo trồng', N'hatraumuong.jpg     ', 20000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (46, 5, N'Hạt bưởi', N'Dùng để gieo trồng', N'hatbuoi.jpg         ', 20000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (47, 5, N'Hạt khổ qua', N'Dùng để gieo trồng', N'khoqua.jpg          ', 20000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (48, 5, N'Hạt ngô tím', N'Dùng để gieo trồng', N'hatngotim.jpg       ', 20000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (49, 5, N'Hạt rau má', N'Dùng để gieo trồng', N'hatrauma.jpg        ', 20000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (50, 5, N'Hạt cải ngọt', N'Dùng để gieo trồng', N'hatcaingot.jpg      ', 20000, 50)
INSERT [MatHang] ([MaHang], [MaLoai], [TenHang], [MoTa], [HinhAnh], [Gia], [SoLuong]) VALUES (51, 5, N'Hạt cải chíp', N'Dùng để gieo trồng', N'hatcaichip.jpg      ', 20000, 50)
SET IDENTITY_INSERT [MatHang] OFF
SET IDENTITY_INSERT [NhanVien] ON 

INSERT [NhanVien] ([MaNV], [TenNV], [TenDangNhap], [MatKhau], [GioiTinh], [DienThoai], [Email], [DiaChi]) VALUES (1, N'Huỳnh Kiến Phúc', N'phuc123', N'12345', N'Nam', N'123456789   ', N'kienphuc@gmail.com            ', N'Vĩnh Phúc')
SET IDENTITY_INSERT [NhanVien] OFF
SET IDENTITY_INSERT [NhaPhanPhoi] ON 

INSERT [NhaPhanPhoi] ([MaNPP], [TenNPP]) VALUES (1, N'Nhà phân phối số 1')
INSERT [NhaPhanPhoi] ([MaNPP], [TenNPP]) VALUES (2, N'Nhà phân phối số 2')
INSERT [NhaPhanPhoi] ([MaNPP], [TenNPP]) VALUES (3, N'Nhà phân phối số 3')
SET IDENTITY_INSERT [NhaPhanPhoi] OFF
INSERT [ThongKeDoanhThu] ([Ngay], [TongTien]) VALUES (CAST(N'2021-11-23' AS Date), 496700)
ALTER TABLE [ChiTiet]  WITH CHECK ADD  CONSTRAINT [fk_ChiTiet_HoaDon] FOREIGN KEY([MaHD])
REFERENCES [HoaDon] ([MaHD])
GO
ALTER TABLE [ChiTiet] CHECK CONSTRAINT [fk_ChiTiet_HoaDon]
GO
ALTER TABLE [ChiTiet]  WITH CHECK ADD  CONSTRAINT [fk_ChiTiet_MatHang] FOREIGN KEY([MaHang])
REFERENCES [MatHang] ([MaHang])
GO
ALTER TABLE [ChiTiet] CHECK CONSTRAINT [fk_ChiTiet_MatHang]
GO
ALTER TABLE [HoaDon]  WITH CHECK ADD  CONSTRAINT [fk_HoaDon_KhachHang] FOREIGN KEY([MaKH])
REFERENCES [KhachHang] ([MaKH])
GO
ALTER TABLE [HoaDon] CHECK CONSTRAINT [fk_HoaDon_KhachHang]
GO
ALTER TABLE [HoaDonNhapHang]  WITH CHECK ADD  CONSTRAINT [fk_HoaDonNhapHang_NhaPhanPhoi] FOREIGN KEY([MaNPP])
REFERENCES [NhaPhanPhoi] ([MaNPP])
GO
ALTER TABLE [HoaDonNhapHang] CHECK CONSTRAINT [fk_HoaDonNhapHang_NhaPhanPhoi]
GO
ALTER TABLE [MatHang]  WITH CHECK ADD  CONSTRAINT [pk_MatHang_LoaiHang] FOREIGN KEY([MaLoai])
REFERENCES [LoaiHang] ([MaLoai])
GO
ALTER TABLE [MatHang] CHECK CONSTRAINT [pk_MatHang_LoaiHang]
GO
USE [master]
GO
ALTER DATABASE [QLCuaHang] SET  READ_WRITE 
GO

