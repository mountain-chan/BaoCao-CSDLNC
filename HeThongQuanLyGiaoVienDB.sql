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
	DinhMucGiangDay float default 0,
	DinhMucNghienCuu float default 0
)
go
Create table GV_ChucDanhChMNV
(
	Id int Identity Primary key,
	IdGiaoVien int references GiaoVien(Id),
	IdChucDanh int references ChucDanh_ChMonNV(Id),
	NgayNhan Date,
	NoiBoNhiem Nvarchar(100),
	DinhMucNghienCuu float default 0
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
	DinhMucGiangDay float default 0
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
	TyLeMienGiam float default 0
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
	TyLeMienGiam float default 0
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
	NamHoc int,
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
	Ma char(6),
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
	Ma char(6),
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
	Ma char(6),
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

--Trigger insert for table GV_ChucVuChMKT
create trigger Them_GV_ChucVuCMKT on GV_ChucVuChMKT for insert
as
begin
	declare @Id int, @IdChucVu int, @DinhMucGiangDay float
	select @Id=Id, @IdChucVu=IdChucVu from inserted

	select @DinhMucGiangDay=QuyDinhChung from DinhMucGiangDay join ChucVu_ChMonKT 
	on DinhMucGiangDay.Id=ChucVu_ChMonKT.IdDMGiangDay where ChucVu_ChMonKT.Id=@IdChucVu
	update GV_ChucVuChMKT set DinhMucGiangDay=@DinhMucGiangDay where Id=@Id 
end
go

--Trigger insert for table GV_HocHam
create trigger Insert_GV_HocHam on GV_HocHam for insert
as
begin
	declare @Id int, @IdHocHam int, @DinhMucGiangDay float, @DinhMucNghCuu float
	select @Id=Id, @IdHocHam=IdHocHam from inserted

	select @DinhMucGiangDay=QuyDinhChung from DinhMucGiangDay join HocHam 
	on DinhMucGiangDay.Id=HocHam.IdDMGiangDay where HocHam.Id=@IdHocHam
	update GV_HocHam set DinhMucGiangDay=@DinhMucGiangDay where Id=@Id 

	select @DinhMucNghCuu=DinhMucGioChuan from DinhMucNghienCuu join HocHam 
	on DinhMucNghienCuu.Id=HocHam.IdDMNghCuu where HocHam.Id=@IdHocHam
	update GV_HocHam set DinhMucNghienCuu=@DinhMucNghCuu where Id=@Id 
end
go

--Trigger insert for table GV_ChucDanhChMNV
create trigger Insert_GV_ChucDanhChMNV on GV_ChucDanhChMNV for insert
as
begin
	declare @Id int, @IdChucDanh int, @DinhMucNghienCuu  float
	select @Id=Id, @IdChucDanh=IdChucDanh from inserted

	select @DinhMucNghienCuu=DinhMucGioChuan from DinhMucNghienCuu join ChucDanh_ChMonNV 
	on DinhMucNghienCuu.Id=ChucDanh_ChMonNV.IdDMNghCuu where ChucDanh_ChMonNV.Id=@IdChucDanh
	update GV_ChucDanhChMNV set DinhMucNghienCuu=@DinhMucNghienCuu where Id=@Id 
end
go

--Trigger update for table DinhMucGiangDay
create trigger update_DinhMucGiangDay on DinhMucGiangDay for update
as
begin
	declare @Id int, @IdChucVu int, @IdHocHam int, @DinhMucGiangDay float
	select @Id=Id, @DinhMucGiangDay=QuyDinhChung from inserted

	select @IdChucVu=ChucVu_ChMonKT.Id from DinhMucGiangDay join ChucVu_ChMonKT 
	on DinhMucGiangDay.Id=ChucVu_ChMonKT.IdDMGiangDay where DinhMucGiangDay.Id=@Id
	update GV_ChucVuChMKT set DinhMucGiangDay=@DinhMucGiangDay where IdChucVu=@IdChucVu 

	select @IdHocHam=HocHam.Id from DinhMucGiangDay join HocHam 
	on DinhMucGiangDay.Id=HocHam.IdDMGiangDay where DinhMucGiangDay.Id=@Id
	update GV_HocHam set DinhMucGiangDay=@DinhMucGiangDay where IdHocHam=@IdHocHam 
end
go

--Trigger update for table DinhMucGiangDay
create trigger update_DinhMucNghienCuu on DinhMucNghienCuu for update
as
begin
	declare @Id int, @IdChucDanh int, @IdHocHam int, @DinhMucNghienCuu float
	select @Id=Id, @DinhMucNghienCuu=DinhMucGioChuan from inserted

	select @IdChucDanh=ChucDanh_ChMonNV.Id from DinhMucNghienCuu join ChucDanh_ChMonNV 
	on DinhMucNghienCuu.Id=ChucDanh_ChMonNV.IdDMNghCuu where DinhMucNghienCuu.Id=@Id
	update GV_ChucDanhChMNV set DinhMucNghienCuu=@DinhMucNghienCuu where IdChucDanh=@IdChucDanh 

	select @IdHocHam=HocHam.Id from DinhMucNghienCuu join HocHam 
	on DinhMucNghienCuu.Id=HocHam.IdDMNghCuu where DinhMucNghienCuu.Id=@Id
	update GV_HocHam set DinhMucNghienCuu=@DinhMucNghienCuu where IdHocHam=@IdHocHam 
end
go


--Trigger insert for table GV_ChucVuChQ
create trigger Insert_GV_ChucVuChQ on GV_ChucVuChQ for insert
as
begin
	declare @Id int, @IdChucVu int, @TyLeMienGiam   float
	select @Id=Id, @IdChucVu=IdChucVu from inserted

	select @TyLeMienGiam=TyLe from TyLeMienGiam  join ChucVuChinhQuyen 
	on TyLeMienGiam.Id=ChucVuChinhQuyen.IdTLMienGiam where ChucVuChinhQuyen.Id=@IdChucVu
	update GV_ChucVuChQ set TyLeMienGiam=@TyLeMienGiam  where Id=@Id 
end
go

--Trigger insert for table GV_ChucVuChQ
create trigger Insert_GV_ChucVuDang on GV_ChucVuDang for insert
as
begin
	declare @Id int, @IdChucVu int, @TyLeMienGiam   float
	select @Id=Id, @IdChucVu=IdChucVuDang from inserted

	select @TyLeMienGiam=TyLe from TyLeMienGiam  join ChucVuDang 
	on TyLeMienGiam.Id=ChucVuDang.IdTLMienGiam where ChucVuDang.Id=@IdChucVu
	update GV_ChucVuDang set TyLeMienGiam=@TyLeMienGiam  where Id=@Id 
end
go

--Trigger update for table TyLeMienGiam
create trigger update_TyLeMienGiam on TyLeMienGiam for update
as
begin
	declare @Id int, @IdChucVuDang int, @IdChucVuChQ int, @TyLeMienGiam float
	select @Id=Id, @TyLeMienGiam=TyLe from inserted

	select @IdChucVuDang=ChucVuDang.Id from TyLeMienGiam join ChucVuDang 
	on TyLeMienGiam.Id=ChucVuDang.IdTLMienGiam where TyLeMienGiam.Id=@Id
	update GV_ChucVuDang set TyLeMienGiam=@TyLeMienGiam where IdChucVuDang=@IdChucVuDang 

	select @IdChucVuChQ=ChucVuChinhQuyen.Id from TyLeMienGiam join ChucVuChinhQuyen 
	on TyLeMienGiam.Id=ChucVuChinhQuyen.IdTLMienGiam where TyLeMienGiam.Id=@Id
	update GV_ChucVuChQ set TyLeMienGiam=@TyLeMienGiam where IdChucVu=@IdChucVuChQ 
end
go


--Trigger insert for table GV_ChamThi
create trigger Insert_GV_ChamThi on GV_ChamThi for insert
as
begin
	declare @Id int, @IdLoaiChamThi int, @SoGio float
	select @Id=Id, @IdLoaiChamThi=IdLoaiChamThi from inserted

	select @SoGio=GioChuan*SoLuong/DonViTinh from LoaiChamThi join GV_ChamThi 
	on LoaiChamThi.Id=GV_ChamThi.IdLoaiChamThi where LoaiChamThi.Id=@IdLoaiChamThi
	update GV_ChamThi set SoGio=@SoGio  where Id=@Id 
end
go

--Trigger update for table LoaiChamThi
create trigger update_LoaiChamThi on LoaiChamThi for update
as
begin
	declare @Id int, @GioChuan float, @DonViTinh float
	select @Id=Id, @GioChuan=GioChuan, @DonViTinh=DonViTinh from inserted
	update GV_ChamThi set SoGio=@GioChuan*SoLuong/@DonViTinh  where IdLoaiChamThi=@Id 
end
go


--Trigger insert for table GV_HuongDan
create trigger Insert_GV_HuongDan on GV_HuongDan for insert
as
begin
	declare @Id int, @IdLoaiHuongDan int, @SoGio float
	select @Id=Id, @IdLoaiHuongDan=IdLoaiHuongDan from inserted

	select @SoGio=GioChuan/DonViTinh from LoaiHuongDan join GV_HuongDan 
	on LoaiHuongDan.Id=GV_HuongDan.IdLoaiHuongDan where LoaiHuongDan.Id=@IdLoaiHuongDan
	update GV_HuongDan set SoGio=@SoGio  where Id=@Id
end
go

--Trigger update for table LoaiHuongDan
create trigger update_LoaiHuongDan on LoaiHuongDan for update
as
begin
	declare @Id int, @GioChuan float, @DonViTinh float
	select @Id=Id, @GioChuan=GioChuan, @DonViTinh=DonViTinh from inserted
	update GV_HuongDan set SoGio=@GioChuan/@DonViTinh  where IdLoaiHuongDan=@Id 
end
go

--Trigger insert for table GV_LopHocPhan
create trigger Insert_GV_LopHocPhan on GV_LopHocPhan for insert
as
begin
	declare @Id int, @IdLopHocPhan int, @SoGio float
	select @Id=Id, @IdLopHocPhan=IdLopHocPhan from inserted

	select @SoGio=GioChuan*SoTiet/DonViTinh from LoaiDayHoc join HocPhan 
	on LoaiDayHoc.Id=HocPhan.IdLoaiDayHoc join LopHocPhan on LopHocPhan.IdHocPhan=HocPhan.Id
	join GV_LopHocPhan on GV_LopHocPhan.IdLopHocPhan=LopHocPhan.Id where LopHocPhan.Id=@IdLopHocPhan
	update GV_LopHocPhan set SoGio=@SoGio  where Id=@Id
end
go

--Trigger update for table LoaiDayHoc
create trigger update_LoaiDayHoc on LoaiDayHoc for update
as
begin
	declare @Id int, @IdLopHocPhan int, @GioChuan float, @DonViTinh float
	select @Id=Id, @GioChuan=GioChuan, @DonViTinh=DonViTinh from inserted

	select @IdLopHocPhan=LopHocPhan.Id from HocPhan join LopHocPhan 
	on LopHocPhan.IdHocPhan=HocPhan.Id where HocPhan.IdLoaiDayHoc=@Id
	update GV_LopHocPhan set SoGio=@GioChuan*SoTiet/@DonViTinh  where IdLopHocPhan=@IdLopHocPhan 
end
go


--Trigger insert for table GV_DeTaiNghienCuu
create trigger Insert_GV_DeTaiNghienCuu on GV_DeTaiNghienCuu for insert
as
begin
	declare @Id int, @IdDeTai int, @SoGio float
	select @Id=Id, @IdDeTai=IdDeTai from inserted

	select @SoGio=(LaChuTri*GioChuan/5 + GioChuan*4/(5*SoThanhVien)) from LoaiDeTai 
	join DeTai on LoaiDeTai.Id=DeTai.IdLoaiDeTai join GV_DeTaiNghienCuu 
	on GV_DeTaiNghienCuu.IdDeTai = DeTai.Id where DeTai.Id=@IdDeTai
	update GV_DeTaiNghienCuu set SoGio=@SoGio  where Id=@Id
end
go

--Trigger update for table LoaiDeTai
create trigger update_LoaiDeTai on LoaiDeTai for update
as
begin
	declare @Id int, @IdDeTai int, @SoThanhVien int, @GioChuan float, @DonViTinh  float
	select @Id=Id, @GioChuan=GioChuan, @DonViTinh=DonViTinh from inserted

	select @IdDeTai=DeTai.Id, @SoThanhVien=SoThanhVien from LoaiDeTai 
	join DeTai on LoaiDeTai.Id=DeTai.IdLoaiDeTai where LoaiDeTai.Id=@Id
	update GV_DeTaiNghienCuu set SoGio=(LaChuTri*@GioChuan/5 + @GioChuan*4/(5*@SoThanhVien)) where IdDeTai=@IdDeTai 
end
go

--Trigger update for table DeTai
create trigger update_DeTai on DeTai for update
as
begin
	declare @Id int, @SoThanhVien int, @GioChuan float, @DonViTinh  float
	select @Id=Id, @SoThanhVien=SoThanhVien from inserted

	select @GioChuan=GioChuan, @DonViTinh=DonViTinh from LoaiDeTai 
	join DeTai on LoaiDeTai.Id=DeTai.IdLoaiDeTai where DeTai.Id=@Id
	update GV_DeTaiNghienCuu set SoGio=(LaChuTri*@GioChuan/5 + @GioChuan*4/(5*@SoThanhVien)) where IdDeTai=@Id 
end
go



--Trigger insert for table GV_BaiBao
create trigger Insert_GV_BaiBao on GV_BaiBao for insert
as
begin
	declare @Id int, @IdBaiBao int, @SoGio float
	select @Id=Id, @IdBaiBao=IdBaiBao from inserted

	select @SoGio=GioChuan/SoThanhVien from LoaiBaiBao join BaiBao 
	on LoaiBaiBao.Id=BaiBao.IdLoaiBaiBao where BaiBao.Id=@IdBaiBao
	update GV_BaiBao set SoGio=@SoGio  where Id=@Id
end
go

--Trigger update for table LoaiBaiBao
create trigger update_LoaiBaiBao on LoaiBaiBao for update
as
begin
	declare @Id int, @IdBaiBao int, @SoThanhVien int, @GioChuan float, @DonViTinh  float
	select @Id=Id, @GioChuan=GioChuan, @DonViTinh=DonViTinh from inserted

	select @IdBaiBao=BaiBao.Id, @SoThanhVien=SoThanhVien from LoaiBaiBao 
	join BaiBao on LoaiBaiBao.Id=BaiBao.IdLoaiBaiBao where LoaiBaiBao.Id=@Id
	update GV_BaiBao set SoGio=@GioChuan/@SoThanhVien where IdBaiBao=@IdBaiBao 
end
go

--Trigger update for table BaiBao
create trigger update_BaiBao on BaiBao for update
as
begin
	declare @Id int, @SoThanhVien int, @GioChuan float, @DonViTinh  float
	select @Id=Id, @SoThanhVien=SoThanhVien from inserted

	select @GioChuan=GioChuan, @DonViTinh=DonViTinh from LoaiBaiBao 
	join BaiBao on LoaiBaiBao.Id=BaiBao.IdLoaiBaiBao where BaiBao.Id=@Id
	update GV_BaiBao set SoGio=@GioChuan/@SoThanhVien where IdBaiBao=@Id 
end
go


--Trigger insert for table GV_BienSoanSach
create trigger Insert_GV_BienSoanSach on GV_BienSoanSach for insert
as
begin
	declare @Id int, @IdSach int, @IdLoaiSach int, @GioChuan float, @DonViTinh float, @SoTinChi float, @SoThanhVien float
	select @Id=Id, @IdSach=IdSach from inserted

	select @IdLoaiSach=LoaiSach.Id, @GioChuan=GioChuan, @DonViTinh=DonViTinh, @SoTinChi=SoTinChi, @SoThanhVien=SoThanhVien 
	from LoaiSach join Sach on LoaiSach.Id=Sach.IdLoaiSach  where Sach.Id=@IdSach

	if(@IdLoaiSach = 1)
		update GV_BienSoanSach set SoGio=@GioChuan*SoTrangDaViet/@DonViTinh  where Id=@Id
	else
		update GV_BienSoanSach set SoGio=(LaChuBien*@GioChuan*@SoTinChi/5+@GioChuan*@SoTinChi*4/(5*@SoThanhVien)) where Id=@Id
end
go

--Trigger update for table LoaiSach
create trigger update_LoaiSach on LoaiSach for update
as
begin
	declare @Id int, @IdSach int, @SoThanhVien int, @GioChuan float, @DonViTinh  float,  @SoTinChi float
	select @Id=Id, @GioChuan=GioChuan, @DonViTinh=DonViTinh from inserted

	select @IdSach=Sach.Id, @SoThanhVien=SoThanhVien, @SoTinChi=SoTinChi from LoaiSach 
	join Sach on LoaiSach.Id=Sach.IdLoaiSach where LoaiSach.Id=@Id

	if(@Id = 1)
		update GV_BienSoanSach set SoGio=@GioChuan*SoTrangDaViet/@DonViTinh  where IdSach=@IdSach
	else
		update GV_BienSoanSach set SoGio=(LaChuBien*@GioChuan*@SoTinChi/5+@GioChuan*@SoTinChi*4/(5*@SoThanhVien)) where IdSach=@IdSach
end
go

--Trigger update for table Sach
create trigger update_Sach on Sach for update
as
begin
	declare @Id int, @IdLoaiSach int, @SoThanhVien int, @GioChuan float, @DonViTinh  float,  @SoTinChi float
	select @Id=Id, @SoThanhVien=SoThanhVien, @SoTinChi=SoTinChi from inserted

	select @IdLoaiSach=LoaiSach.Id, @GioChuan=GioChuan, @DonViTinh=DonViTinh from LoaiSach 
	join Sach on LoaiSach.Id=Sach.IdLoaiSach where Sach.Id=@Id

	if(@IdLoaiSach = 1)
		update GV_BienSoanSach set SoGio=@GioChuan*SoTrangDaViet/@DonViTinh  where IdSach=@Id
	else
		update GV_BienSoanSach set SoGio=(LaChuBien*@GioChuan*@SoTinChi/5+@GioChuan*@SoTinChi*4/(5*@SoThanhVien)) where IdSach=@Id
end
go

--======================================== Add some data for test ==============


INSERT [dbo].[LoaiSach] ([Ten], [DonViTinh], [GioChuan], [GhiChu]) VALUES (N'Sách chuyên khảo', 1, 3, N'Mỗi cán bộ căn cứ vào số trang để tính giờ chuẩn')
INSERT [dbo].[LoaiSach] ([Ten], [DonViTinh], [GioChuan], [GhiChu]) VALUES (N'Giáo trình mới', 1, 150, N'Nếu sách do tập thể thực hiện thì cán bộ chủ trì đc hưởng 1/5 số giờ chuẩn, còn lại 4/5 số giờ chuẩn được chia đều cho tất cả những người tham gia cả bán bộ chủ trì')
INSERT [dbo].[LoaiSach] ([Ten], [DonViTinh], [GioChuan], [GhiChu]) VALUES (N'Giáo trình tái bản', 1, 120, N'Nếu sách do tập thể thực hiện thì cán bộ chủ trì đc hưởng 1/5 số giờ chuẩn, còn lại 4/5 số giờ chuẩn được chia đều cho tất cả những người tham gia cả bán bộ chủ trì')
INSERT [dbo].[LoaiSach] ([Ten], [DonViTinh], [GioChuan], [GhiChu]) VALUES (N'Tài liệu biên dịch, sách tham khảo', 1, 100, N'Nếu sách do tập thể thực hiện thì cán bộ chủ trì đc hưởng 1/5 số giờ chuẩn, còn lại 4/5 số giờ chuẩn được chia đều cho tất cả những người tham gia cả bán bộ chủ trì')
INSERT [dbo].[LoaiSach] ([Ten], [DonViTinh], [GioChuan], [GhiChu]) VALUES (N'Sách hướng dẫn, bài giảng với học phần chưa có giáo trình', 1, 75, N'Nếu sách do tập thể thực hiện thì cán bộ chủ trì đc hưởng 1/5 số giờ chuẩn, còn lại 4/5 số giờ chuẩn được chia đều cho tất cả những người tham gia cả bán bộ chủ trì')

insert into TyLeMienGiam values(0.1),(0.2),(0.3),(0.4),(0.5),(0.6),(0.7),(0.8),(0.9),(0)
insert into DinhMucGiangDay values(280),(320),(360)
insert into DinhMucNghienCuu values(150),(210),(280)
go
INSERT [dbo].[Khoa]  VALUES ('K00001', N'Khoa Công Nghệ Thông Tin')
INSERT [dbo].[Khoa]  VALUES ('K00002', N'Khoa Cơ Khí')
go
INSERT [dbo].[BoMon] VALUES ('BM0001', N'Bộ Môn An Toàn Thông Tin', 1)
INSERT [dbo].[BoMon] VALUES ('BM0002', N'Bộ Môn Hệ Thống Thông Tin', 1)
INSERT [dbo].[BoMon] VALUES ('BM0003', N'Bộ Môn Kỹ Thuật Phần Mềm', 1)
INSERT [dbo].[BoMon] VALUES ('BM0004', N'Bộ Môn Cơ Học Máy', 2)
INSERT [dbo].[BoMon] VALUES ('BM0005', N'Bộ Môn Chế Tạo Máy', 2)
go
INSERT [dbo].[HocHam]  VALUES (N'Giáo Sư', 3, 3)
INSERT [dbo].[HocHam]  VALUES (N'Phó Giáo Sư', 2, 2)

INSERT [dbo].[ChucDanh_ChMonNV] VALUES (N'Nghiên cứu viên cao cấp', 3)
INSERT [dbo].[ChucDanh_ChMonNV]  VALUES (N'Nghiên cứu viên chính', 2)
INSERT [dbo].[ChucDanh_ChMonNV]  VALUES (N'Nghiên cứu viên', 1)
INSERT [dbo].[ChucDanh_ChMonNV]  VALUES (N'Trợ lý Nghiên cứu', 1)

INSERT [dbo].[ChucVu_ChMonKT] VALUES (N'Giảng viên cao cấp', 3)
INSERT [dbo].[ChucVu_ChMonKT]  VALUES (N'Giảng viên chính', 2)
INSERT [dbo].[ChucVu_ChMonKT]  VALUES (N'Giảng viên', 1)
INSERT [dbo].[ChucVu_ChMonKT] VALUES (N'Trợ giảng', 1)

INSERT [dbo].[HocVi]  VALUES (N'Tiến Sĩ Khoa Học')
INSERT [dbo].[HocVi]  VALUES (N'Tiến sĩ')
INSERT [dbo].[HocVi]  VALUES (N'Thạc sỹ')
INSERT [dbo].[HocVi]  VALUES (N'Kỹ sư')
INSERT [dbo].[HocVi]  VALUES (N'Cử nhân')

INSERT [dbo].[ChucVuChinhQuyen] VALUES (N'Giáo viên chủ nghiệm', 1)
INSERT [dbo].[ChucVuChinhQuyen] VALUES (N'Giáo viên đang học cao học', 5)
INSERT [dbo].[ChucVuChinhQuyen] VALUES (N'Giáo viên đang nghiên cứu sinh', 7)
INSERT [dbo].[ChucVuChinhQuyen] VALUES (N'Chủ nghiệm Khoa', 2)
INSERT [dbo].[ChucVuChinhQuyen] VALUES (N'Giáo viên', 10)

INSERT [dbo].[ChucVuDang]  VALUES (N'Đảng viên', 10)
INSERT [dbo].[ChucVuDang]  VALUES (N'Bí thư đoàn cơ sở', 2)
INSERT [dbo].[ChucVuDang]  VALUES (N'Bí thư Chi bộ cơ sở', 2)
INSERT [dbo].[ChucVuDang]  VALUES (N'Bí thư Đảng ủy', 3)

INSERT [dbo].[DonViHoatDong] VALUES (N'Đơn Vị 1', 'Note')
INSERT [dbo].[DonViHoatDong] VALUES (N'Đơn Vị 2', 'Note')

INSERT [dbo].[NgoaiNgu]  VALUES ('NN0001', N'Toeic 500')
INSERT [dbo].[NgoaiNgu]  VALUES ('NN0002', N'Toeic 700')
INSERT [dbo].[NgoaiNgu]  VALUES ('NN0003', N'IELTS 5.0')
INSERT [dbo].[NgoaiNgu]  VALUES ('NN0004', N'IELTS 7.0')
INSERT [dbo].[NgoaiNgu]  VALUES ('NN0005', N'IELTS 8.0')

INSERT [dbo].[DaiHoc]  VALUES (N'Đại học Quốc Gia Hà Nội', N'Kỹ sư', N'An Toàn Thông Tin', N'Việt Nam')
INSERT [dbo].[DaiHoc]  VALUES (N'Đại học Bách Khoa', N'Kỹ sư', N'Công Nghệ Dữ Liệu', N'Việt Nam')
INSERT [dbo].[DaiHoc]  VALUES (N'Học viện kỹ Thuật Quân Sự', N'Kỹ Sư', N'Công Nghệ Phần Mềm', N'Việt Nam')
INSERT [dbo].[DaiHoc]  VALUES (N'Đại Học Sư Phạm Hà Nội', N'Kỹ sư', N'Triết học', N'Việt Nam')

INSERT [dbo].[ThacSi]  VALUES (N'Toán Học', N'Học viện Kỹ thuật Quân Sự', N'Chứng Minh Công Thức abc')
INSERT [dbo].[ThacSi]  VALUES (N'Công Nghệ Thông Tin', N'Đại học bách Khoa hà Nội', N'Phần Mềm tự Làm')
INSERT [dbo].[ThacSi]  VALUES (N'Cơ khí', N'Đại học Bách khoa Hà nội', N'Động cơ abc')

INSERT [dbo].[TienSi]  VALUES (N'An Toàn Thông Tin', N'Học Viện Kỹ Thuật Quân Sự', N'Phần mềm an toàn tự làm')
INSERT [dbo].[TienSi]  VALUES (N'Toán học', N'Đại học sư phạm Hà Nội', N'Công Thức abc')
INSERT [dbo].[TienSi]  VALUES (N'Vật lý học', N'Đại học bách Khoa Hà Nội', N'Định luật abc')

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


INSERT [dbo].[GV_ChucVuChMKT] ([IdGiaoVien], [IdChucVu], [NgayNhan], [NoiBoNhiem])  VALUES (1,3, CAST(N'2006-01-01' AS Date), N'Học Viện Kỹ Thuật Quân Sự')
INSERT [dbo].[GV_ChucVuChMKT] ([IdGiaoVien], [IdChucVu], [NgayNhan], [NoiBoNhiem]) VALUES (2,3, CAST(N'2007-01-01' AS Date), N'Học Viện Kỹ Thuật Quân Sự')
INSERT [dbo].[GV_ChucVuChMKT] ([IdGiaoVien], [IdChucVu], [NgayNhan], [NoiBoNhiem]) VALUES (3,3, CAST(N'2008-01-01' AS Date), N'Học Viện Kỹ Thuật Quân Sự')
INSERT [dbo].[GV_ChucVuChMKT] ([IdGiaoVien], [IdChucVu], [NgayNhan], [NoiBoNhiem]) VALUES (4,3, CAST(N'2002-01-01' AS Date), N'Học Viện Kỹ Thuật Quân Sự')
INSERT [dbo].[GV_ChucVuChMKT] ([IdGiaoVien], [IdChucVu], [NgayNhan], [NoiBoNhiem]) VALUES (5,3, CAST(N'2005-01-01' AS Date), N'Học Viện Kỹ Thuật Quân Sự')
INSERT [dbo].[GV_ChucVuChMKT] ([IdGiaoVien], [IdChucVu], [NgayNhan], [NoiBoNhiem]) VALUES (6,3, CAST(N'2009-01-01' AS Date), N'Học Viện Kỹ Thuật Quân Sự')
INSERT [dbo].[GV_ChucVuChMKT] ([IdGiaoVien], [IdChucVu], [NgayNhan], [NoiBoNhiem]) VALUES (7,3, CAST(N'2009-01-01' AS Date), N'Học Viện Kỹ Thuật Quân Sự')