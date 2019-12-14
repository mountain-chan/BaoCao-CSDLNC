CREATE DATABASE HeThongQuanLyGiaoVienDB
go

USE HeThongQuanLyGiaoVienDB
go

---------------Thông Tin Cá Nhân Và Thông Tin Liên Quan

Create table GiaoVien
(
	Id int Identity Primary key,
	Ma char(6),
	Ten Nvarchar(40),
	GioiTinh Bit, 
	NgaySinh Date,
	QueQuan Nvarchar(100),
	DiaChi Nvarchar(100),
	DienThoai varchar(12),
	Email varchar(50)
)
go

Create table Khoa
(
	Id int Identity Primary key,
	Ma char(6),
	Ten Nvarchar(50)
)
go

Create table CN_Khoa
(
	Id int Identity Primary key,
	IdChuNhiem int references GiaoVien(Id),
	IdKhoa int references Khoa(Id),
	NgayBatDau Date,
	NgayKetThuc Date
)
go

Create table BoMon
(
	Id int Identity Primary key,
	Ma char(6),
	Ten Nvarchar(50),
	IdKhoa int references Khoa(Id)
)
go

Create table CN_BoMon
(
	Id int Identity Primary key,
	IdChuNhiem int references GiaoVien(Id),
	IdBoMon int references BoMon(Id),
	NgayBatDau Date,
	NgayKetThuc Date
)
go

Create table GV_BoMon
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdBoMon int references BoMon(Id),
	NgayChuyenDen Date,
	NgayChuyenDi Date
)
go

Create table DinhMucNghienCuu
(
	Id int Identity Primary key,
	DinhMucGioChuan float
)
go
Create table DinhMucGiangDay
(
	Id int Identity Primary key,
	QuyDinhChung float
)
go
Create table TyLeMienGiam
(
	Id int Identity Primary key,
	TyLe float
)
go
Create table HocHam
(
	Id int Identity Primary key,
	Ten Nvarchar(50),
	IdDMGiangDay int references DinhMucGiangDay(Id),
	IdDMNghCuu int references DinhMucNghienCuu(Id),
)
go
Create table ChucDanh_ChMonNV
(
	Id int Identity Primary key,
	Ten Nvarchar(50),
	IdDMNghCuu int references DinhMucNghienCuu(Id)
)

go
Create table GV_HocHam
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdHocHam int references HocHam(Id),
	NgayNhan Date,
)
go
Create table GV_ChucDanhChMNV
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdChucDanh int references ChucDanh_ChMonNV(Id),
	NgayNhan Date,
	NoiBoNhiem Nvarchar(100)
)
go
Create table ChucVu_ChMonKT
(
	Id int Identity Primary key,
	Ten Nvarchar(50),
	IdDMGiangDay int references DinhMucGiangDay(Id),
)
go
Create table GV_ChucVuChMKT
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdChucVu int references ChucVu_ChMonKT(Id),
	NgayNhan Date,
	NoiBoNhiem Nvarchar(200)
)
go
Create table HocVi
(
	Id int Identity Primary key,
	Ten Nvarchar(50)
)
go
Create table GV_HocVi
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdHocVi int references HOCVI(Id),
	NgayNhan Date
)
go
Create table ChucVuChinhQuyen
(
	Id int Identity Primary key,
	Ten Nvarchar(50),
	IdTLMienGiam int references TyLeMienGiam(Id)
)
go

Create table DonViHoatDong
(
	Id int Identity Primary key,
	Ten Nvarchar(50),
	GhiChu Ntext
)
go

Create table GV_ChucVuChQ
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdChucVu int references ChucVuChinhQuyen(Id),
	IdDonVi int references DonViHoatDong(Id),
	NgayNhan Date,
	NgayKetThuc Date
)
go

Create table ChucVuDang
(
	Id int Identity Primary key,
	Ten Nvarchar(50),
	IdTLMienGiam int references TyLeMienGiam(Id)
)
go
Create table GV_ChucVuDang
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdChucVuDang int references ChucVuDang(Id),
	NgayNhan Date
)
go
Create table NgoaiNgu
(
	Id int Identity Primary key,
	Ma char(6),
	Ten Nvarchar(50)
)
go
Create table GV_NgoaiNgu
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdNgoaiNgu int references NgoaiNgu(Id),
	NgayCapChungChi Date
)
go



------------------Qua Trinh Dao Tao

Create table DaiHoc
(
	Id int Identity Primary key,
	NoiDTao Nvarchar(100),
	HeDaoTao Nvarchar(50),
	NganhHoc Nvarchar(100),
	NuocDaoTao Nvarchar(50)
)
go
Create table GV_DaiHoc
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdDaiHoc int references daihoc(Id),
	NamTotNghiem int
)
go
Create table ThacSi
(
	Id int Identity Primary key,
	ChuyenNganh Nvarchar(80),
	NoiDaoTao Nvarchar(100),
	TenLuanVan Nvarchar(100)
)
go
Create table GV_ThacSi
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdThacSi int references thacsi(Id),
	NamCapBang int
)
go
Create table TienSi
(
	Id int Identity Primary key,
	ChuyenNganh Nvarchar(80),
	NoiDaoTao Nvarchar(100),
	TenLuanAn Nvarchar(100)
)
go
Create table GV_TienSi
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdTienSi int references TienSi(Id),
	NamCapBang int
)
go



---------------------Thong Tin Hoc Vien
Create table He
(
	Id int Identity Primary key,
	Ten Nvarchar(50)
)
go
Create table Lop
(
	Id int Identity Primary key,
	Ma char(6),
	Te Nvarchar(50),
	SiSo int,
	IdHe int references He(Id)
)
go
Create table HocVien
(
	Id int Identity Primary key,
	Ma char(6),
	Ten Nvarchar(40),
	GioiTinh Bit,
	NgaySinh Date,
	Diachi Nvarchar(100),
	IdLop int references Lop(Id)
)
go
-----------------------Tham Gia Hoi Dong

Create table LoaiHoiDong
(
	Id int Identity Primary key,
	Ten Nvarchar(100)
)
go
Create table HoiDong
(
	Id int Identity Primary key,
	Ten Nvarchar(50),
	GhiChu Ntext,
	IdLoaiHoiDong int references LoaiHoiDong(Id)
)
go
Create table GV_HoiDong
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdHoiDong int references HOIDONG(Id),
	VaiTro Nvarchar(20),
	NamHoc int,
	KiHoc int,
	Solan int,
	SoGio int
)
go

-----------------------------------------Huong Dan

Create table LoaiHuongDan
(
	Id int Identity Primary key,
	Ten Nvarchar(200),
	DonViTinh float,
	GioChuan float
)
go

Create table GV_HuongDan
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdLoaiHuongDan int references LoaiHuongDan(Id),
	IdHocVien int references HocVien(Id),
	TenDeTai Nvarchar(50),
	NgayBatDau Date,
	NgayKetThuc Date,
	BaoVeThanhCong Bit -- 1 là bảo vệ thành công, 0 là đang hướng dẫn hoặc bảo vệ thất bại
)
go
---------------------------------Giang day

Create table LoaiDayHoc
(
	Id int Identity Primary key,
	Ten Nvarchar(200),
	GioChuan float,
	DonViTinh float
)
go
Create table HocPhan
(
	Id int Identity Primary key,
	Ma char(6),
	Ten Nvarchar(100),
	SoTinChi int,
	IdDoiTuongHoc int references He(Id),
	IdLoaiDayHoc int references LoaiDayHoc(Id)
)
go 

Create table LopHocPhan
(
	Id int Identity Primary key,
	Ma char(6),
	SiSo int,
	KiHoc int,
	NamHoc int,
	IdHocPhan int references HocPhan(Id)
)
go
Create table GV_LopHocPhan
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdLopHocPhan int references LopHocPhan(Id),
	SoTiet int
)
go
--------------------------------------Khao Thi

Create table LoaiChamThi
(
	Id int Identity Primary key,
	Ten Nvarchar(200),
	DonViTinh float,
	GioChuan float
)
go

Create table GV_ChamThi
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdLoaiChamThi int references LoaiChamThi(Id),
	SoLuong int,
	NamHoc int,
	KiHoc int
)
go

----------------------------------------NGHIÊN CỨU KHOA HỌC

Create table LoaiSach
(
	Id int Identity Primary key,
	Ten Nvarchar(200),
	DonViTinh float,
	GioChuan float,
	GhiChu Ntext
)
go
Create table Sach
(
	Id int Identity Primary key,
	Ma char(6),
	Ten Nvarchar(100),
	NoiXuatBan Nvarchar(100),
	NgayXuatBan Date,
	SoTinChi int default 0,
	SoThanhVien int default 0,
	IdLoaiSach int references LoaiSach(Id)
)
go

Create table GV_BienSoanSach
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdSach int references Sach(Id),
	LaChuBien int check (0 <= LaChuBien and LaChuBien <= 1) default 0, -- 1 là cán bộ chủ biên
	SoTrangDaViet int default 0
)
go

Create table LoaiBaiBao
(
	Id int Identity Primary key,
	Ten Nvarchar(300),
	DonViTinh float,
	GioChuan float,
	GhiChu Ntext
)
go
Create table BaiBao
(
	Id int Identity Primary key,
	Ma char(6),
	Ten Nvarchar(100),
	TenTapChiCongBo Nvarchar(150),
	NgayCongBo Date,
	IdLoaiBaiBao int references LoaiBaiBao(Id),
)
go
Create table GV_BaiBao
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdBaiBao int references BaiBao(Id),
	VaiTro Nvarchar(50)
)
go

Create table LoaiDeTai
(
	Id int Identity Primary key,
	Ten Nvarchar(200),
	DonViTinh float,
	GioChuan float,
	GhiChu Ntext
)
go
Create table DeTai
(
	Id int Identity Primary key,
	Ma char(6),
	Ten Nvarchar(200),
	NgayBatDau Date,
	NgayKetThuc Date,
	CoQuanQuanLy Nvarchar(200),
	TinhTrang bit, -- 1 đã nghiệm thu, 0 chưa nghiệm thu
	SoThanhVien int,
	IdLoaiDeTai int references LoaiDeTai(Id)
)
go
Create table GV_DeTaiNghienCuu
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdDeTai int references DeTai(Id),
	LaChuTri int check (0 <= LaChuTri and LaChuTri <= 1) default 0 -- 1 là cán bộ chủ trì
)
