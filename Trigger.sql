

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

--Trigger update for table LopHocPhan
create trigger update_LopHocPhan on LopHocPhan for update
as
begin
	declare @IdLopHocPhan int, @IdHocPhan int, @GioChuan float, @DonViTinh float
	select @IdLopHocPhan=Id, @IdHocPhan=IdHocPhan from inserted

	select @GioChuan=GioChuan, @DonViTinh=DonViTinh from LoaiDayHoc join HocPhan 
	on LoaiDayHoc.Id=HocPhan.IdLoaiDayHoc where HocPhan.Id=@IdHocPhan
	update GV_LopHocPhan set SoGio=@GioChuan*SoTiet/@DonViTinh  where IdLopHocPhan=@IdLopHocPhan
end
go

--Trigger update for table HocPhan
create trigger update_HocPhan on HocPhan for update
as
begin
	declare @IdHocPhan int, @IdLopHocPhan int, @IdLoaiDayHoc int, @GioChuan float, @DonViTinh float
	select @IdHocPhan=Id, @IdLoaiDayHoc=IdLoaiDayHoc from inserted

	select @GioChuan=GioChuan, @DonViTinh=DonViTinh from LoaiDayHoc where Id=@IdLoaiDayHoc
	select @IdLopHocPhan=Id from LopHocPhan where IdHocPhan=@IdHocPhan
	update GV_LopHocPhan set SoGio=@GioChuan*SoTiet/@DonViTinh  where IdLopHocPhan=@IdLopHocPhan 
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

--Trigger update for table DinhMucNghienCuu
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
