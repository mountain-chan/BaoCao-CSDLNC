-- drop database HeThongQuanLyGiaoVienDB

CREATE DATABASE HeThongQuanLyGiaoVienDB
go

USE HeThongQuanLyGiaoVienDB
go

---------------Thông Tin Cá Nhân Và Thông Tin Liên Quan

Create table GiaoVien
(
	Id int Identity Primary key,
	Ma Varchar(6),
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
	Ma Varchar(6),
	Ten Nvarchar(50)
)
go

Create table CN_Khoa
(
	Id int Identity Primary key,
	IdChuNghiem int references GiaoVien(Id),
	IdKhoa int references Khoa(Id),
	NgayBatDau Date,
	NgayKetThuc Date
)
go

Create table BoMon
(
	Id int Identity Primary key,
	Ma Varchar(6),
	Ten Nvarchar(50),
	IdKhoa int references Khoa(Id)
)
go

Create table CN_BoMon
(
	Id int Identity Primary key,
	IdChuNghiem int references GiaoVien(Id),
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
	DMGiangDay float default 0,
	DMNghienCuu float default 0
)
go
Create table GV_ChucDanhChMNV
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdChucDanh int references ChucDanh_ChMonNV(Id),
	NgayNhan Date,
	NoiBoNhiem Nvarchar(100),
	DMNghienCuu float default 0
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
	NoiBoNhiem Nvarchar(200),
	DMGiangDay float default 0
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
	NgayKetThuc Date,
	TLMienGiam float default 0
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
	NgayNhan Date,
	TLMienGiam float default 0
)
go
Create table NgoaiNgu
(
	Id int Identity Primary key,
	Ma Varchar(6),
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
	NamTotNghiep int
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
	Ma Varchar(6),
	Te Nvarchar(50),
	SiSo int,
	IdHe int references He(Id)
)
go
Create table HocVien
(
	Id int Identity Primary key,
	Ma Varchar(6),
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
	NamHoc varchar(10),
	KiHoc int,
	Solan int,
	SoGio float
)
go

-----------------------------------------Huong Dan

Create table LoaiHuongDan
(
	Id int Identity Primary key,
	Ten Nvarchar(200),
	DonViTinh float check (DonViTinh <> 0),
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
	BaoVeThanhCong Bit, -- 1 là bảo vệ thành công, 0 là đang hướng dẫn hoặc bảo vệ thất bại
	SoGio float default 0
)
go
---------------------------------Giang day

Create table LoaiDayHoc
(
	Id int Identity Primary key,
	Ten Nvarchar(200),
	GioChuan float,
	DonViTinh float check (DonViTinh <> 0)
)
go
Create table HocPhan
(
	Id int Identity Primary key,
	Ma Varchar(6),
	Ten Nvarchar(100),
	SoTinChi int,
	IdDoiTuongHoc int references He(Id),
	IdLoaiDayHoc int references LoaiDayHoc(Id)
)
go 

Create table LopHocPhan
(
	Id int Identity Primary key,
	Ma Varchar(6),
	SiSo int,
	KiHoc int,
	NamHoc varchar(10),
	IdHocPhan int references HocPhan(Id)
)
go
Create table GV_LopHocPhan
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdLopHocPhan int references LopHocPhan(Id),
	SoTiet int,
	SoGio float default 0
)
go
--------------------------------------Khao Thi

Create table LoaiChamThi
(
	Id int Identity Primary key,
	Ten Nvarchar(200),
	DonViTinh float check (DonViTinh <> 0),
	GioChuan float
)
go

Create table GV_ChamThi
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdLoaiChamThi int references LoaiChamThi(Id),
	SoLuong int,
	NamHoc varchar(10),
	KiHoc int,
	SoGio float default 0
)
go

----------------------------------------NGHIÊN CỨU KHOA HỌC

Create table LoaiSach
(
	Id int Identity Primary key,
	Ten Nvarchar(200),
	DonViTinh float check (DonViTinh <> 0),
	GioChuan float,
	GhiChu Ntext
)
go
Create table Sach
(
	Id int Identity Primary key,
	Ma Varchar(6),
	Ten Nvarchar(100),
	NoiXuatBan Nvarchar(100),
	NgayXuatBan Date,
	SoTinChi int default 0,
	SoThanhVien int check (SoThanhVien <> 0),
	IdLoaiSach int references LoaiSach(Id)
)
go

Create table GV_BienSoanSach
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdSach int references Sach(Id),
	LaChuBien int check (0 <= LaChuBien and LaChuBien <= 1) default 0, -- 1 là cán bộ chủ biên
	SoTrangDaViet int default 0,
	SoGio float default 0
)
go

Create table LoaiBaiBao
(
	Id int Identity Primary key,
	Ten Nvarchar(300),
	DonViTinh float check (DonViTinh <> 0),
	GioChuan float,
	GhiChu Ntext
)
go
Create table BaiBao
(
	Id int Identity Primary key,
	Ma Varchar(6),
	Ten Nvarchar(100),
	TenTapChiCongBo Nvarchar(150),
	NgayCongBo Date,
	SoThanhVien int check (SoThanhVien <> 0) not null,
	IdLoaiBaiBao int references LoaiBaiBao(Id),
)
go
Create table GV_BaiBao
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdBaiBao int references BaiBao(Id),
	VaiTro Nvarchar(50),
	SoGio float default 0
)
go

Create table LoaiDeTai
(
	Id int Identity Primary key,
	Ten Nvarchar(200),
	DonViTinh float check (DonViTinh <> 0),
	GioChuan float,
	GhiChu Ntext
)
go
Create table DeTai
(
	Id int Identity Primary key,
	Ma Varchar(6),
	Ten Nvarchar(200),
	NgayBatDau Date,
	NgayKetThuc Date,
	CoQuanQuanLy Nvarchar(200),
	TinhTrang bit, -- 1 đã nghiệm thu, 0 chưa nghiệm thu
	SoThanhVien int check (SoThanhVien <> 0) not null,
	IdLoaiDeTai int references LoaiDeTai(Id)
)
go
Create table GV_DeTaiNghienCuu
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdDeTai int references DeTai(Id),
	LaChuTri int check (0 <= LaChuTri and LaChuTri <= 1) default 0, -- 1 là cán bộ chủ trì
	SoGio float default 0
)
go

--======================================== Create trigger ==============

--=================================Ly Chan==

--Trigger insert for table GV_HocHam
create trigger Insert_GV_HocHam on GV_HocHam for insert
as
begin
	declare @Id int, @IdHocHam int, @DinhMucGiangDay float, @DinhMucNghCuu float
	select @Id=Id, @IdHocHam=IdHocHam from inserted

	select @DinhMucGiangDay=QuyDinhChung from DinhMucGiangDay join HocHam 
	on DinhMucGiangDay.Id=HocHam.IdDMGiangDay where HocHam.Id=@IdHocHam
	update GV_HocHam set DMGiangDay=@DinhMucGiangDay where Id=@Id 

	select @DinhMucNghCuu=DinhMucGioChuan from DinhMucNghienCuu join HocHam 
	on DinhMucNghienCuu.Id=HocHam.IdDMNghCuu where HocHam.Id=@IdHocHam
	update GV_HocHam set DMNghienCuu=@DinhMucNghCuu where Id=@Id 
end
go


--Trigger insert for table GV_ChucVuChMKT
create trigger Them_GV_ChucVuCMKT on GV_ChucVuChMKT for insert
as
begin
	declare @Id int, @IdChucVu int, @DinhMucGiangDay float
	select @Id=Id, @IdChucVu=IdChucVu from inserted

	select @DinhMucGiangDay=QuyDinhChung from DinhMucGiangDay join ChucVu_ChMonKT 
	on DinhMucGiangDay.Id=ChucVu_ChMonKT.IdDMGiangDay where ChucVu_ChMonKT.Id=@IdChucVu

	update GV_ChucVuChMKT set DMGiangDay=@DinhMucGiangDay where Id=@Id 
end
go

--Trigger update for table ChucVuDang
create trigger update_ChucVuDang on ChucVuDang for update
as
begin
	declare @IdChucVuDang int, @IdTyLeMienGiam int, @TyLeMienGiam float
	select @IdChucVuDang=Id, @IdTyLeMienGiam=IdTLMienGiam from inserted

	select @TyLeMienGiam=TyLe from TyLeMienGiam where TyLeMienGiam.Id=@IdTyLeMienGiam

	update GV_ChucVuDang set TLMienGiam=@TyLeMienGiam where IdChucVuDang=@IdChucVuDang 
end
go

--Trigger insert for table GV_LopHocPhan
create trigger Insert_GV_LopHocPhan on GV_LopHocPhan for insert
as
begin
	declare @Id int, @IdLopHocPhan int, @GioChuan float, @DonViTinh float
	select @Id=Id, @IdLopHocPhan=IdLopHocPhan from inserted

	select @GioChuan=GioChuan, @DonViTinh=DonViTinh from LoaiDayHoc join HocPhan 
	on LoaiDayHoc.Id=HocPhan.IdLoaiDayHoc join LopHocPhan on LopHocPhan.IdHocPhan=HocPhan.Id
	where LopHocPhan.Id=@IdLopHocPhan

	update GV_LopHocPhan set SoGio=@GioChuan*SoTiet/@DonViTinh  where Id=@Id
end
go


---Hàm kiểm tra ngày nhận có trước năm học và kì học đang xét hay không.
create function CheckTimeBegin(@namHoc varchar(10), @kiHoc int, @ngayNhan date) returns bit
as
begin
	declare @result bit
	
	set @result = 0
	if(@kiHoc = 1)
		if(datepart(year, @ngayNhan)<LEFT(@namHoc, 4))
			set @result = 1
		else if(datepart(year, @ngayNhan)=LEFT(@namHoc, 4) and datepart(month, @ngayNhan) < 8) 
			set @result = 1		
	if(@kiHoc = 2)
		if(datepart(year, @ngayNhan)<RIGHT(@namHoc, 4)) set @result = 1		

	return @result
end
go


----Dịnh mức tải giảng dạy của giáo viên theo năm học và kì học
Create function TinhDinhMucGiangDay(@IdGiaoVien int, @NamHoc varchar(10), @KiHoc int) returns float
as
begin
	declare  @DMHocHam float, @DhMChucVuChMKT float, @KetQua float

	select top 1 @DMHocHam = DMGiangDay from GV_HocHam 
	where IdGiaoVien = @IdGiaoVien and dbo.CheckTimeBegin(@NamHoc, @KiHoc, NgayNhan) = 1
	order by NgayNhan desc

	select top 1 @DhMChucVuChMKT = DMGiangDay from GV_ChucVuChMKT 
	where IdGiaoVien = @IdGiaoVien and dbo.CheckTimeBegin(@NamHoc, @KiHoc, NgayNhan) = 1
	order by NgayNhan desc

	if(@DMHocHam is null) set @DMHocHam = 0
	if(@DhMChucVuChMKT is null) set @DhMChucVuChMKT = 0

	if(@DhMChucVuChMKT > @DMHocHam) set @ketQua = @DhMChucVuChMKT
	else set @KetQua = @DMHocHam

	return @KetQua
end
go
-- select dinhmuc = dbo.TinhDinhMucGiangDay(2, '2017-2018', 1)



--create procedure thống kê tải dạy học của một giáo viên theo năm học và kì học
alter proc ThongKeTaiDayHoc
	@IdGiaoVien int,
	@NamHoc varchar(10),
	@KiHoc int,
	@IdHe int

	as
	begin
		select sum(SoGio) as TaiDayHoc from LopHocPhan join GV_LopHocPhan 
		on LopHocPhan.Id=GV_LopHocPhan.IdLopHocPhan join HocPhan
		on HocPhan.Id=LopHocPhan.IdHocPhan
		where GV_LopHocPhan.IdGiaoVien = @IdGiaoVien 
		and NamHoc=@NamHoc and KiHoc=@KiHoc and IdDoiTuongHoc=@IdHe 
	end


-- ThongKeTaiDayHoc 1, '2018-2019', 1, 2


--======================================== Add some data for test ==============

insert into TyLeMienGiam values(0.1),(0.2),(0.3),(0.4),(0.5),(0.6),(0.7),(0.8),(0.9),(0)
insert into DinhMucGiangDay values(280),(320),(360)
insert into DinhMucNghienCuu values(150),(210),(280)
go 

INSERT [dbo].[HocHam] ([Ten], [IdDMGiangDay], [IdDMNghCuu]) VALUES (N'Giáo Sư', 3, 3)
INSERT [dbo].[HocHam] ([Ten], [IdDMGiangDay], [IdDMNghCuu]) VALUES (N'Phó Giáo Sư', 2, 2)
go
INSERT [dbo].[ChucVu_ChMonKT] ([Ten], [IdDMGiangDay]) VALUES (N'Giảng viên cao cấp', 3)
INSERT [dbo].[ChucVu_ChMonKT] ([Ten], [IdDMGiangDay]) VALUES (N'Giảng viên chính', 2)
INSERT [dbo].[ChucVu_ChMonKT] ([Ten], [IdDMGiangDay]) VALUES (N'Giảng viên', 1)
INSERT [dbo].[ChucVu_ChMonKT] ([Ten], [IdDMGiangDay]) VALUES (N'Trợ giảng', 1)
go

INSERT [dbo].[ChucVuDang] ([Ten], [IdTLMienGiam]) VALUES (N'Đảng viên', 10)
INSERT [dbo].[ChucVuDang] ([Ten], [IdTLMienGiam]) VALUES (N'Bí thư đoàn cơ sở', 2)
INSERT [dbo].[ChucVuDang] ([Ten], [IdTLMienGiam]) VALUES (N'Bí thư Chi bộ cơ sở', 2)
INSERT [dbo].[ChucVuDang] ([Ten], [IdTLMienGiam]) VALUES (N'Bí thư Đảng ủy', 3)
go
INSERT [dbo].[GiaoVien]  VALUES (N'GV0001', N'Lữ Thành K', 1, CAST(N'1975-05-10' AS Date), N'Hải Phòng', N'Xuân Mai Huyện Chươnng Mỹ Thành Phố Hà Nôi', N'0987389277', N'thanhlong@gmail.com')
INSERT [dbo].[GiaoVien]  VALUES (N'GV0002', N'Hà Văn A', 1, CAST(N'1976-03-01' AS Date), N'Ninh Bình', N'236 Hoàng Quốc Việt', N'123456678   ', N'gv02@gmail.com')
INSERT [dbo].[GiaoVien]  VALUES (N'GV0003', N'Chu Thị H', 0, CAST(N'1977-04-01' AS Date), N'Hà Nội', N'210 Cầu Giấy', N'123443221   ', N'gv03@gmail.com')
INSERT [dbo].[GiaoVien]  VALUES (N'GV0004', N'Tạ Văn N', 1, CAST(N'1975-05-01' AS Date), N'Bắc Giang', N'236 Hoàng Quốc Việt', N'123456789   ', N'gv04@gmail.com')
INSERT [dbo].[GiaoVien]  VALUES (N'GV0005', N'Nguyễn Văn B', 1, CAST(N'1980-02-01' AS Date), N'Hà Nội', N'117 Trần Cung', N'123456789   ', N'gv05@gmail.com')
INSERT [dbo].[GiaoVien]  VALUES (N'GV0006', N'Nguyễn Văn C', 1, CAST(N'1980-04-01' AS Date), N'Hà Nội', N'117 Trần Cung', N'123456789   ', N'gv06@gmail.com')
INSERT [dbo].[GiaoVien]  VALUES (N'GV0007', N'Chu Văn A', 1, CAST(N'1980-06-01' AS Date), N'Hà Nội', N'117 Trần Cung', N'123456789   ', N'gv07@gmail.com')
INSERT [dbo].[GiaoVien]  VALUES (N'GV0008', N'Nguyễn Văn C', 1, CAST(N'1980-01-05' AS Date), N'Hà Nội', N'117 Trần Cung', N'123456789   ', N'gv08@gmail.com')
INSERT [dbo].[GiaoVien]  VALUES (N'GV0009', N'Nguyễn Thị H', 0, CAST(N'1980-01-30' AS Date), N'Hà Nội', N'117 Trần Cung', N'123456789   ', N'gv09@gmail.com')
INSERT [dbo].[GiaoVien]  VALUES (N'GV0010', N'Nguyễn Thị K', 0, CAST(N'1980-01-24' AS Date), N'Hà Nội', N'117 Trần Cung', N'123456789   ', N'gv10@gmail.com')
INSERT [dbo].[GiaoVien]  VALUES (N'GV0011', N'Nguyễn Thị E', 0, CAST(N'1980-01-09' AS Date), N'Hà Nội', N'117 Trần Cung', N'123456789   ', N'gv10@gmail.com')
go
INSERT [dbo].[GV_ChucVuChMKT] ([IdGiaoVien], [IdChucVu], [NgayNhan], [NoiBoNhiem])  VALUES (1,3, CAST(N'2006-01-01' AS Date), N'Học Viện Kỹ Thuật Quân Sự')
INSERT [dbo].[GV_ChucVuChMKT] ([IdGiaoVien], [IdChucVu], [NgayNhan], [NoiBoNhiem]) VALUES (2,3, CAST(N'2007-01-01' AS Date), N'Học Viện Kỹ Thuật Quân Sự')
INSERT [dbo].[GV_ChucVuChMKT] ([IdGiaoVien], [IdChucVu], [NgayNhan], [NoiBoNhiem]) VALUES (3,3, CAST(N'2008-01-01' AS Date), N'Học Viện Kỹ Thuật Quân Sự')
INSERT [dbo].[GV_ChucVuChMKT] ([IdGiaoVien], [IdChucVu], [NgayNhan], [NoiBoNhiem]) VALUES (4,3, CAST(N'2002-01-01' AS Date), N'Học Viện Kỹ Thuật Quân Sự')
INSERT [dbo].[GV_ChucVuChMKT] ([IdGiaoVien], [IdChucVu], [NgayNhan], [NoiBoNhiem]) VALUES (5,3, CAST(N'2005-01-01' AS Date), N'Học Viện Kỹ Thuật Quân Sự')
INSERT [dbo].[GV_ChucVuChMKT] ([IdGiaoVien], [IdChucVu], [NgayNhan], [NoiBoNhiem]) VALUES (6,3, CAST(N'2009-01-01' AS Date), N'Học Viện Kỹ Thuật Quân Sự')
INSERT [dbo].[GV_ChucVuChMKT] ([IdGiaoVien], [IdChucVu], [NgayNhan], [NoiBoNhiem]) VALUES (7,3, CAST(N'2009-01-01' AS Date), N'Học Viện Kỹ Thuật Quân Sự')
go
INSERT [dbo].[GV_HocHam] ([IdGiaoVien], [IdHocHam], [NgayNhan]) VALUES (1, 1, CAST(N'2010-01-01' AS Date))
INSERT [dbo].[GV_HocHam] ([IdGiaoVien], [IdHocHam], [NgayNhan]) VALUES (2, 2, CAST(N'2011-01-02' AS Date))
INSERT [dbo].[GV_HocHam] ([IdGiaoVien], [IdHocHam], [NgayNhan]) VALUES (3, 2, CAST(N'2012-01-01' AS Date))
INSERT [dbo].[GV_HocHam] ([IdGiaoVien], [IdHocHam], [NgayNhan]) VALUES (4, 1, CAST(N'2010-01-01' AS Date))
INSERT [dbo].[GV_HocHam] ([IdGiaoVien], [IdHocHam], [NgayNhan]) VALUES (5, 2, CAST(N'2012-01-10' AS Date))
go

INSERT [dbo].[LoaiDayHoc] ([Ten], [GioChuan], [DonViTinh]) VALUES (N'Giảng dạy lý thuyết đối với lớp từ 75 học viên trở xuống', 1, 1)
INSERT [dbo].[LoaiDayHoc] ([Ten], [GioChuan], [DonViTinh]) VALUES (N'Giảng dạy lý thuyết đối với lớp nhiều hơn 75 học viên và ít hơn 100 học viên', 1.1, 1)
INSERT [dbo].[LoaiDayHoc] ([Ten], [GioChuan], [DonViTinh]) VALUES (N'Giảng dạy lý thuyết đối với lớp từ 100 học viên trở lên', 1.2, 1)
INSERT [dbo].[LoaiDayHoc] ([Ten], [GioChuan], [DonViTinh]) VALUES (N'Dạy ngoai ngữ cơ bản, cơ sở, ngành', 0.8, 1)
INSERT [dbo].[LoaiDayHoc] ([Ten], [GioChuan], [DonViTinh]) VALUES (N'Dạy ngoại ngữ chuyên ngành', 1, 1)
INSERT [dbo].[LoaiDayHoc] ([Ten], [GioChuan], [DonViTinh]) VALUES (N'Dạy phụ đạo', 0.5, 1)
INSERT [dbo].[LoaiDayHoc] ([Ten], [GioChuan], [DonViTinh]) VALUES (N'Dạy thể dục thể thao, lí thuyết trên lớp, giảng kỹ thuật ở sân bãi đối với lớp từ 40 học viên trở xuống', 1, 1)
INSERT [dbo].[LoaiDayHoc] ([Ten], [GioChuan], [DonViTinh]) VALUES (N'Dạy thể dục thể thao, lí thuyết trên lớp, giảng kỹ thuật ở sân bãi đối với lớp nhiều hơn 40 học viên', 1.2, 1)
INSERT [dbo].[LoaiDayHoc] ([Ten], [GioChuan], [DonViTinh]) VALUES (N'Bồi dưỡng cán sự thể dục thể thao với lớp từ 15 học viên trở xuống', 1, 1)
INSERT [dbo].[LoaiDayHoc] ([Ten], [GioChuan], [DonViTinh]) VALUES (N'Bồi dưỡng cán sự thể dục thể thao với lớp nhiều hơn 15 học viên trở lên', 1.2, 1)
INSERT [dbo].[LoaiDayHoc] ([Ten], [GioChuan], [DonViTinh]) VALUES (N'Dạy Vẽ Kỹ thuật', 0.75, 1)
INSERT [dbo].[LoaiDayHoc] ([Ten], [GioChuan], [DonViTinh]) VALUES (N'Hướng dẫn, kiểm tra, thực hành và chữa bài tập', 2.5, 1)
go
INSERT [dbo].[He] ([Ten]) VALUES (N'Hệ Cao Đẳng')
INSERT [dbo].[He] ([Ten]) VALUES (N'Hệ Đại Học')
INSERT [dbo].[He] ([Ten]) VALUES (N'Hệ Cao Học')
go
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP01', N'Tiếng anh B11', 3, 2, 5)
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP02', N'Thực Tập Cơ Sở Dữ Liệu', 3, 2, 2)
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP03', N'Kinh Tế Công Nghiệp', 2, 2, 2)
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP04', N'Toán Rời Rạc', 3, 2, 3)
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP05', N'Bóng Chuyền', 1, 2, 7)
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP06', N'Tương Tác Người Máy', 3, 2, 2)
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP07', N'Cơ sở dữ liệu', 3, 2, 3)
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP08', N'Thực Tập Nhóm', 3, 2, 2)
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP09', N'Công Nghệ Web', 3, 2, 3)
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP10', N'Công Nghệ Phần Mền', 3, 2, 2)
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP11', N'Nhảy xa', 1, 2, 8)
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP12', N'Tiếng Anh B12', 3, N'He02', 5)
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP13', N'Đạo đức nghề nghiệp', 3, 1, 1)
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP14', N'Lập trình cơ bản', 3, 1, 2)
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP15', N'Giải tích', 3, 1, 3)
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP16', N'Chuyên đề an toàn thông tin', 3, 3, 1)
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP17', N'Bảo Mật An Toàn Thông Tin', 2, 3, 1)
INSERT [dbo].[HocPhan] ([Ma], [Ten], [SoTinChi], [IdDoiTuongHoc], [IdLoaiDayHoc]) VALUES (N'HP18', N'Phòng chống tội phạm mạng', 2, 3, 1)
go
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP01', 40, 1, N'2018-2019', 1)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP02', 40, 1, N'2018-2019', 1)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP03', 100, 1, N'2018-2019', 7)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP04', 110, 1, N'2018-2019', 6)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP05', 110, 1, N'2018-2019', 8)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP06', 100, 1, N'2018-2019', 9)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP07', 100, 1, N'2018-2019', 10)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP08', 100, 1, N'2018-2019', 8)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP09', 100, 1, N'2018-2019', 9)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP10', 100, 1, N'2018-2019', 7)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP11', 40, 2, N'2017-2018', 1)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP12', 40, 2, N'2017-2018', 1)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP13', 100, 2, N'2017-2018', 4)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP14', 100, 2, N'2017-2018', 3)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP15', 100, 2, N'2017-2018', 2)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP16', 100, 1, N'2018-2019', 13)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP17', 100, 1, N'2018-2019', 14)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP18', 100, 1, N'2018-2019', 15)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP19', 20, 1, N'2018-2019', 16)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP20', 20, 1, N'2018-2019', 17)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP21', 20, 1, N'2018-2019', 18)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP22', 100, 2, N'2017-2018', 13)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP23', 100, 2, N'2017-2018', 14)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP24', 100, 2, N'2017-2018', 15)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP25', 20, 1, N'2017-2018', 18)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP26', 20, 1, N'2017-2018', 16)
INSERT [dbo].[LopHocPhan] ([Ma], [SiSo], [KiHoc], [NamHoc], [IdHocPhan]) VALUES (N'LHP27', 20, 1, N'2017-2018', 17)
go

INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (1, 1, 45)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (1, 2, 30)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (1, 3, 40)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (1, 11, 40)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (1, 14, 50)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (1, 21, 20)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (1, 25, 20)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (2, 4, 50)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (2, 12, 50)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (2, 16, 30)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (2, 22, 20)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (3, 5, 50)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (3, 13, 50)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (3, 17, 30)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (3, 23, 20)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (3, 27, 20)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (4, 6, 40)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (4, 14, 50)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (4, 18, 30)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (4, 24, 20)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (4, 26, 20)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (5, 2, 20)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (5, 19, 20)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (5, 23, 20)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (5, 3, 20)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (6, 20, 20)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (7, 7, 50)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (8, 8, 50)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (9, 9, 50)
INSERT [dbo].[GV_LopHocPhan] ([IdGiaoVien], [IdLopHocPhan], [SoTiet]) VALUES (10, 10, 50)





--INSERT [dbo].[LoaiSach] ([Ten], [DonViTinh], [GioChuan], [GhiChu]) VALUES (N'Sách chuyên khảo', 1, 3, N'Mỗi cán bộ căn cứ vào số trang để tính giờ chuẩn')
--INSERT [dbo].[LoaiSach] ([Ten], [DonViTinh], [GioChuan], [GhiChu]) VALUES (N'Giáo trình mới', 1, 150, N'Nếu sách do tập thể thực hiện thì cán bộ chủ trì đc hưởng 1/5 số giờ chuẩn, còn lại 4/5 số giờ chuẩn được chia đều cho tất cả những người tham gia cả bán bộ chủ trì')
--INSERT [dbo].[LoaiSach] ([Ten], [DonViTinh], [GioChuan], [GhiChu]) VALUES (N'Giáo trình tái bản', 1, 120, N'Nếu sách do tập thể thực hiện thì cán bộ chủ trì đc hưởng 1/5 số giờ chuẩn, còn lại 4/5 số giờ chuẩn được chia đều cho tất cả những người tham gia cả bán bộ chủ trì')
--INSERT [dbo].[LoaiSach] ([Ten], [DonViTinh], [GioChuan], [GhiChu]) VALUES (N'Tài liệu biên dịch, sách tham khảo', 1, 100, N'Nếu sách do tập thể thực hiện thì cán bộ chủ trì đc hưởng 1/5 số giờ chuẩn, còn lại 4/5 số giờ chuẩn được chia đều cho tất cả những người tham gia cả bán bộ chủ trì')
--INSERT [dbo].[LoaiSach] ([Ten], [DonViTinh], [GioChuan], [GhiChu]) VALUES (N'Sách hướng dẫn, bài giảng với học phần chưa có giáo trình', 1, 75, N'Nếu sách do tập thể thực hiện thì cán bộ chủ trì đc hưởng 1/5 số giờ chuẩn, còn lại 4/5 số giờ chuẩn được chia đều cho tất cả những người tham gia cả bán bộ chủ trì')


--INSERT [dbo].[Khoa]  VALUES ('K00001', N'Khoa Công Nghệ Thông Tin')
--INSERT [dbo].[Khoa]  VALUES ('K00002', N'Khoa Cơ Khí')
--go

--INSERT [dbo].[BoMon] VALUES ('BM0001', N'Bộ Môn An Toàn Thông Tin', 1)
--INSERT [dbo].[BoMon] VALUES ('BM0002', N'Bộ Môn Hệ Thống Thông Tin', 1)
--INSERT [dbo].[BoMon] VALUES ('BM0003', N'Bộ Môn Kỹ Thuật Phần Mềm', 1)
--INSERT [dbo].[BoMon] VALUES ('BM0004', N'Bộ Môn Cơ Học Máy', 2)
--INSERT [dbo].[BoMon] VALUES ('BM0005', N'Bộ Môn Chế Tạo Máy', 2)
--go


--INSERT [dbo].[ChucDanh_ChMonNV] VALUES (N'Nghiên cứu viên cao cấp', 3)
--INSERT [dbo].[ChucDanh_ChMonNV]  VALUES (N'Nghiên cứu viên chính', 2)
--INSERT [dbo].[ChucDanh_ChMonNV]  VALUES (N'Nghiên cứu viên', 1)
--INSERT [dbo].[ChucDanh_ChMonNV]  VALUES (N'Trợ lý Nghiên cứu', 1)

--INSERT [dbo].[HocVi]  VALUES (N'Tiến Sĩ Khoa Học')
--INSERT [dbo].[HocVi]  VALUES (N'Tiến sĩ')
--INSERT [dbo].[HocVi]  VALUES (N'Thạc sỹ')
--INSERT [dbo].[HocVi]  VALUES (N'Kỹ sư')
--INSERT [dbo].[HocVi]  VALUES (N'Cử nhân')

--INSERT [dbo].[DonViHoatDong] VALUES (N'Đơn Vị 1', 'Note')
--INSERT [dbo].[DonViHoatDong] VALUES (N'Đơn Vị 2', 'Note')

--INSERT [dbo].[ChucVuChinhQuyen] VALUES (N'Giáo viên chủ nghiệm', 1)
--INSERT [dbo].[ChucVuChinhQuyen] VALUES (N'Giáo viên đang học cao học', 5)
--INSERT [dbo].[ChucVuChinhQuyen] VALUES (N'Giáo viên đang nghiên cứu sinh', 7)
--INSERT [dbo].[ChucVuChinhQuyen] VALUES (N'Chủ nghiệm Khoa', 2)
--INSERT [dbo].[ChucVuChinhQuyen] VALUES (N'Giáo viên', 10)

--INSERT [dbo].[NgoaiNgu]  VALUES ('NN0001', N'Toeic 500')
--INSERT [dbo].[NgoaiNgu]  VALUES ('NN0002', N'Toeic 700')
--INSERT [dbo].[NgoaiNgu]  VALUES ('NN0003', N'IELTS 5.0')
--INSERT [dbo].[NgoaiNgu]  VALUES ('NN0004', N'IELTS 7.0')
--INSERT [dbo].[NgoaiNgu]  VALUES ('NN0005', N'IELTS 8.0')

--INSERT [dbo].[DaiHoc]  VALUES (N'Đại học Quốc Gia Hà Nội', N'Kỹ sư', N'An Toàn Thông Tin', N'Việt Nam')
--INSERT [dbo].[DaiHoc]  VALUES (N'Đại học Bách Khoa', N'Kỹ sư', N'Công Nghệ Dữ Liệu', N'Việt Nam')
--INSERT [dbo].[DaiHoc]  VALUES (N'Học viện kỹ Thuật Quân Sự', N'Kỹ Sư', N'Công Nghệ Phần Mềm', N'Việt Nam')
--INSERT [dbo].[DaiHoc]  VALUES (N'Đại Học Sư Phạm Hà Nội', N'Kỹ sư', N'Triết học', N'Việt Nam')

--INSERT [dbo].[ThacSi]  VALUES (N'Toán Học', N'Học viện Kỹ thuật Quân Sự', N'Chứng Minh Công Thức abc')
--INSERT [dbo].[ThacSi]  VALUES (N'Công Nghệ Thông Tin', N'Đại học bách Khoa hà Nội', N'Phần Mềm tự Làm')
--INSERT [dbo].[ThacSi]  VALUES (N'Cơ khí', N'Đại học Bách khoa Hà nội', N'Động cơ abc')

--INSERT [dbo].[TienSi]  VALUES (N'An Toàn Thông Tin', N'Học Viện Kỹ Thuật Quân Sự', N'Phần mềm an toàn tự làm')
--INSERT [dbo].[TienSi]  VALUES (N'Toán học', N'Đại học sư phạm Hà Nội', N'Công Thức abc')
--INSERT [dbo].[TienSi]  VALUES (N'Vật lý học', N'Đại học bách Khoa Hà Nội', N'Định luật abc')