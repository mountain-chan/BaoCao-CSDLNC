
create or alter function tyLeChuBien()
returns float
as 
begin
	declare @tyLe float 
	select @tyLe = cast((TyLePhanChiaNCKH.TyLeTruongNhom) as float)/(TyLePhanChiaNCKH.TongTyLe) from TyLePhanChiaNCKH 
	where TyLePhanChiaNCKH.LoaiNCKH =N'Viết sách'
	if(@tyLe is null) return 1
	return @tyLe
end
go

create or alter function tyLeChuTri()
returns float
as 
begin
	declare @tyLe float 
	select @tyLe = cast((TyLePhanChiaNCKH.TyLeTruongNhom )as float)/(TyLePhanChiaNCKH.TongTyLe) from TyLePhanChiaNCKH 
	where TyLePhanChiaNCKH.LoaiNCKH =N'Nghiên cứu'
	if(@tyLe is null) return 1
	return @tyLe
end
go

create or alter function kiemTraThoiGianBatDau(@namHoc varchar(10), @kiHoc nvarchar(10), @ngayLay date) returns bit
as
begin
	declare @result bit=0
	declare @soTuanTrong1Ky int = 19

	if(LEFT(@namHoc, 4) >= RIGHT(@namHoc ,4) )
		set @result = 0
	else begin
		declare @ngayBatDau date = CONVERT(date ,substring(@namHoc , 1, 4) +'/9/2')
		if(@kiHoc = '2')
			set @ngayBatDau = DATEADD(DD , @soTuanTrong1Ky*7 , @ngayBatDau)

		declare @ngayKetThuc date = DATEADD(DD , @soTuanTrong1Ky*7 , @ngayBatDau)

		if(@ngayLay between @ngayBatDau and @ngayKetThuc)  
			set @result = 1
	end 
	return @result 
end
go

select dbo.kiemTraThoiGianBatDau('2018-2019' , '1' , '2019-1-13') go 

create or alter function kiemTraThoiGianKhoang(@namHoc varchar(10), @kiHoc nvarchar(10), @ngayNhan date, @ngayHoanThanh date) 
returns int
as
begin
	declare @result int =0
	declare @soTuanTrong1Ky int = 19

	if (@ngayHoanThanh is null ) set @ngayHoanThanh = GETDATE();

	if((@ngayNhan >= @ngayHoanThanh) or (LEFT(@namHoc, 4) >= RIGHT(@namHoc ,4)) )
		set @result = 0
	else begin 
		declare @ngayBatDauMin  date ;
		declare @ngayKetThucMin	date ;

		declare @ngayBatDau date = CONVERT(date ,substring(@namHoc , 1, 4) +'/9/2')
		
		if(@kiHoc = '2')
			set @ngayBatDau = DATEADD(DD , @soTuanTrong1Ky*7 , @ngayBatDau)
		
		declare @ngayKetThuc date = DATEADD(DD , @soTuanTrong1Ky*7 , @ngayBatDau)

		if(@ngayBatDau < @ngayHoanThanh and @ngayNhan < @ngayKetThuc ) begin
			set @ngayBatDauMin = IIF(@ngayBatDau >= @ngayNhan , @ngayBatDau , @ngayNhan)
			set @ngayKetThucMin = IIF(@ngayKetThuc <= @ngayHoanThanh , @ngayKetThuc , @ngayHoanThanh )
			set @result = DATEDIFF(DD, @ngayBatDauMin , @ngayKetThucMin)
		end 
	
	end
	if (@result < 0) set @result = 0;
	return @result
end
go
select dbo.kiemTraThoiGianKhoang('2023-2024' ,'2' , '2019/1/13' , '2019/5/12')
go 



create or alter procedure ThongKeNhanLucTheoKhoa (
	@makhoa nvarchar(100),
	@ngaylay date
)as begin
	select DanhSachChucDanh.ChucDanh , COUNT(DanhSachTheoKhoa.ChucDanh) as TongSo 
	from 
	(select Ten as ChucDanh from (select HocHam.Ten from HocHam union select HocVi.Ten from HocVi ) as DS1)as DanhSachChucDanh
	left join 
	(
		select COALESCE(HocHam.Ten , Hocvi.Ten) as ChucDanh 
		from Khoa	left join BoMon on Khoa.Id = BoMon.IdKhoa
					left join  GV_BoMon on GV_BoMon.IdBoMon = BoMon.Id
					left join GiaoVien on GiaoVien.Id = GV_BoMon.IdGiaoVien
									and dbo.kiemTraThoiGianLay( @ngaylay, GV_BoMon.NgayChuyenDen , GV_BoMon.NgayChuyenDi) =1
					left join GV_HocHam on GiaoVien.Id = GV_HocHam.IdGiaoVien
					left join HocHam on GV_HocHam.IdHocHam = HocHam.Id
					left join GV_HocVi on GiaoVien.Id = GV_HocVi.IdGiaoVien
									and GV_HocVi.NgayNhan <= @ngaylay
									and HocHam.Ten is null							
					left join HocVi on HocVi.Id = GV_HocVi.IdHocVi							
		where Khoa.Id = @makhoa
	) as DanhSachTheoKhoa
	on DanhSachTheoKhoa.ChucDanh = DanhSachChucDanh.ChucDanh
	group by DanhSachChucDanh.ChucDanh
end 
go



create or alter procedure LayDSHocViTheoKhoa (
	@idKhoa int,
	@ngayLay date
)
as 
begin
	select GiaoVien.Ma , GiaoVien.Ten , HocVi.Ten as ChucDanh  
	from Khoa	left join BoMon on Khoa.Id = BoMon.IdKhoa
				left join  GV_BoMon on GV_BoMon.IdBoMon = BoMon.Id
				left join GiaoVien on GiaoVien.Id = GV_BoMon.IdGiaoVien
									and dbo.kiemTraThoiGianLay( @ngayLay, GV_BoMon.NgayChuyenDen , GV_BoMon.NgayChuyenDi) =1
				left join (
						select GV_HocVi.*  from GV_HocVi
						, (select  GV_HocVi.IdGiaoVien  , MAX(GV_HocVi.NgayNhan) as NgayNhan
						from GV_HocVi 
						group by GV_HocVi.IdGiaoVien ) as HS
						where HS.IdGiaoVien = GV_HocVi.IdGiaoVien
						and HS.NgayNhan = GV_HocVi.NgayNhan 
				)as GVHOCVI on GiaoVien.Id = GVHOCVI.IdGiaoVien
								and GVHOCVI.NgayNhan <= @ngayLay					
				left join HocVi on HocVi.Id = GVHOCVI.IdHocVi
	where Khoa.Id = @idKhoa
	and HocVi.Ten is not null
end
go

exec LayDSHocVITheoKhoa 1, '10/9/2018'
go
	
create or alter procedure LayDSHocHamTheoKhoa (
	@idKhoa int,
	@ngayLay date
)
as 
begin
	select GiaoVien.Ma , GiaoVien.Ten , HocHam.Ten as ChucDanh  
	from Khoa	left join BoMon on Khoa.Id = BoMon.IdKhoa
				left join  GV_BoMon on GV_BoMon.IdBoMon = BoMon.Id
				left join GiaoVien on GiaoVien.Id = GV_BoMon.IdGiaoVien
								and dbo.kiemTraThoiGianLay( @ngayLay, GV_BoMon.NgayChuyenDen , GV_BoMon.NgayChuyenDi) =1
				left join (
							select GV_HocHam.*  from GV_HocHam
							, (select  GV_HocHam.IdGiaoVien  , MAX(GV_HocHam.NgayNhan) as NgayNhan
							from GV_HocHam 
							group by GV_HocHam.IdGiaoVien ) as HS
							where HS.IdGiaoVien = GV_HocHam.IdGiaoVien
							and HS.NgayNhan = GV_HocHam.NgayNhan 
				)as GVHOCHAM on GiaoVien.Id = GVHOCHAM.IdGiaoVien
									and GVHOCHAM.NgayNhan <= @ngayLay					
				left join HocHam on HocHam.Id = GVHOCHAM.IdHocHam
	where Khoa.Id = @idKhoa
	and HocHam.Ten is not null
end



exec LayDSHocHamTheoKhoa 1, '10/9/2018'
go 


create or alter procedure ThongKeNhanLucTheoKhoaKhongTach(
	@idKhoa int,
	@ngayLay date
)
as 
begin
	declare @danhsachchucdanh table 
	(
		Ma varchar(50),
		Ten nvarchar(60),
		ChucDanh nvarchar(100)
	)

	insert @danhsachchucdanh  exec LayDSHocViTheoKhoa @idKhoa , @ngayLay
	insert @danhsachchucdanh  exec LayDSHocHamTheoKhoa @idKhoa , @ngayLay

	select DanhSachChucDanh.ChucDanh , COUNT(DanhSach.ChucDanh) as TongSo
	from (select Ten as ChucDanh from (select HocHam.Ten from HocHam union select HocVi.Ten from HocVi ) as DS1)as DanhSachChucDanh
	left join @danhsachchucdanh as DanhSach on DanhSach.ChucDanh = DanhSachChucDanh.ChucDanh
	group by DanhSachChucDanh.ChucDanh
end


exec ThongKeNhanLucTheoKhoaKhongTach 1, '12/12/2018' 
go
exec ThongKeNhanLucTheoKhoa 1, '12/12/2018' 
go




create or alter function kiemTraThoiGianLay (
	@ngayNhan date,
	@ngayChuyenDen date,
	@ngayChuyenDi date
)
returns bit
as begin
	declare @result bit = 0; 

	set @ngayChuyenDen = IIF(@ngayChuyenDen is null , GETDATE() , @ngayChuyenDen )
	set @ngayChuyenDi = IIF(@ngayChuyenDi is null , GETDATE() , @ngayChuyenDi)
	if( @ngayChuyenDen <= @ngayChuyenDi and (@ngayNhan between @ngayChuyenDen and @ngayChuyenDi)) 
		set @result = 1;

	return @result
end
go

select dbo.kiemTraThoiGianLay('12-4-2019' , '11/10/2018' , '12/3/2019')
go

create or alter trigger Insert_GVBienSoanSach on GV_BienSoanSach after INSERT 
as 
begin 
	declare @count int , @Id int, @IdSach int, @IdLoaiSach int, @GioChuan float, @DonViTinh float, @SoTinChi float, @SoThanhVien float
	select @Id=Id, @IdSach=IdSach from inserted
	select top 1 @IdLoaiSach = LoaiSach.Id, @GioChuan=GioChuan, @DonViTinh=DonViTinh, @SoTinChi=SoTinChi, @SoThanhVien=SoThanhVien 
	from Sach left join LoaiSach on LoaiSach.Id =Sach.IdLoaiSach  where Sach.Id=@IdSach  
		
	select @count = COUNT(*) from GV_BienSoanSach where GV_BienSoanSach.IdSach = @IdSach
 	if( @count <=  @SoThanhVien) begin
		declare @TyLeChuBien float  
		select @TyLeChuBien = dbo.tyLeChuBien() 

		if(@IdLoaiSach = 1) begin
			update GV_BienSoanSach 
			set SoGio= @GioChuan*SoTrangDaViet/@DonViTinh  
			where GV_BienSoanSach.Id =@Id
		end
		else begin
			update GV_BienSoanSach 
			set SoGio =(LaChuBien*@GioChuan*@SoTinChi*@TyLeChuBien +@GioChuan*@SoTinChi*(1- @TyLeChuBien)/@SoThanhVien) 
			where GV_BienSoanSach.Id = @Id
		end
	end
	else begin
		RAISERROR('[Error] Khong the them : Vuot qua so luong thanh vien',-1,-1);
		rollback tran
	end
end
go 

create or alter trigger Update_GVBienSoanSach on GV_BienSoanSach after UPDATE 
as 
begin 
	if UPDATE(LaChuBien) or UPDATE(SoTrangDaViet) or UPDATE(IdSach)  begin 

		declare @Id int, @IdSach int, @IdLoaiSach int, @GioChuan float, @DonViTinh float, @SoTinChi float, @SoThanhVien float
		select @Id = inserted.Id FROM inserted INNER JOIN deleted ON inserted.Id = deleted.Id
		
		select top 1 @IdSach =IdSach , @IdLoaiSach = LoaiSach.Id, @GioChuan=GioChuan, @DonViTinh=DonViTinh, @SoTinChi=SoTinChi, @SoThanhVien=SoThanhVien 
		from GV_BienSoanSach 
		join Sach  on GV_BienSoanSach.IdSach = Sach.Id
		join LoaiSach on LoaiSach.Id =Sach.IdLoaiSach  
		where GV_BienSoanSach.Id=@Id

		if(@IdLoaiSach = 1) begin
			update GV_BienSoanSach 
			set SoGio= @GioChuan*SoTrangDaViet/@DonViTinh  
			where GV_BienSoanSach.IdSach =@IdSach
		end
		else begin
			declare @TyLeChuBien float  
			select @TyLeChuBien = dbo.tyLeChuBien() 
			if(@SoThanhVien > 0 ) begin
				update GV_BienSoanSach 
				set SoGio= (LaChuBien*@GioChuan*@SoTinChi*@TyLeChuBien +@GioChuan*@SoTinChi*(1- @TyLeChuBien)/@SoThanhVien) 
				where GV_BienSoanSach.IdSach = @IdSach
			end
			else begin
				update GV_BienSoanSach 
				set SoGio=0
				where GV_BienSoanSach.IdSach = @IdSach
			end
		end
	end
end
go 




create or alter trigger Update_Sach on Sach after UPDATE 
as 
begin 
	SET NOCOUNT ON;
	declare @IdSach int, @IdLoaiSach int, @GioChuan float, @DonViTinh float, @SoTinChi float, @SoThanhVien float
	
	if UPDATE(SoTinChi) or UPDATE(SoThanhVien) or UPDATE(IdLoaiSach)  begin 

		select @IdSach = inserted.Id FROM inserted INNER JOIN deleted ON inserted.Id = deleted.Id
		select top 1 @IdLoaiSach = LoaiSach.Id, @GioChuan=GioChuan, @DonViTinh=DonViTinh, @SoTinChi=SoTinChi, @SoThanhVien=SoThanhVien 
		from Sach left join LoaiSach on LoaiSach.Id =Sach.IdLoaiSach  where Sach.Id=@IdSach

		if(@IdLoaiSach = 1) begin
			update GV_BienSoanSach 
			set SoGio= @GioChuan*SoTrangDaViet/@DonViTinh  
			where GV_BienSoanSach.IdSach =@IdSach
		end
		else begin
			if(@SoThanhVien > 0 ) begin
				update GV_BienSoanSach 
				set SoGio=(LaChuBien*@GioChuan*@SoTinChi/5+@GioChuan*@SoTinChi*4/(5*(@SoThanhVien))) 
				where GV_BienSoanSach.IdSach = @IdSach
			end
			else begin
				update GV_BienSoanSach 
				set SoGio=0
				where GV_BienSoanSach.IdSach = @IdSach
			end
		end
	end 
end 
go 


alter table Sach 
add constraint DF_SoTinChi default 0 for SoTinChi ,constraint DF_SoThanhVien 
default 0 for SoThanhVien 
go 




-- Thống kê nghiên cứu khoa học theo của giáo viện

create or alter procedure ThongKeNghienCuuDeTai
(
	@magiaovien int ,
	@namhoc varchar(10) ,
	@kyhoc varchar(10) 
)
as begin
	declare @TyLeChuTri int = dbo.tyLeChuTri()
	select DeTai.Ten as TenCongTrinhKhoaHoc, LoaiDeTai.Ten as Loai,
	case
        when  GV_DeTaiNghienCuu.LaChuTri = 1 then 'Chủ trì'
        else 'Thành viên'end as VaiTro, 
	DeTai.SoThanhVien as SoTacGia , (
		dbo.kiemTraThoiGianKhoang(@namhoc , @kyhoc , NgayBatDau , NgayKetThuc)*(1-@TyLeChuTri)*(GioChuan/(19*7*DonViTinh))/SoThanhVien + 
		(LaChuTri * @TyLeChuTri *GioChuan) 
	) as GioChuan
	from DeTai  join GV_DeTaiNghienCuu  on DeTai.Id=GV_DeTaiNghienCuu.IdDeTai 
				join LoaiDeTai on LoaiDeTai.Id =DeTai.IdLoaiDeTai 
	where IdGiaoVien = @magiaovien 
		and dbo.kiemTraThoiGianKhoang(@namhoc , @kyhoc , NgayBatDau , NgayKetThuc) >0
end
go

exec ThongKeNghienCuuDeTai 1 , '2018-2019' , '1' 
go





--------------------------Tải viết báo , báo cáo--------------------
create or alter procedure ThongKeBaiBao
(
	@magiaovien int ,
	@namhoc varchar(10) ,
	@kyhoc varchar(10) 
)
as begin
	select BaiBao.Ten as TenCongTrinhKhoaHoc, LoaiBaiBao.Ten as Loai , GV_BaiBao.VaiTro , BaiBao.SoThanhVien as SoTacGia , (GioChuan/BaiBao.SoThanhVien) as GioChuan
	from BaiBao join GV_BaiBao on GV_BaiBao.IdBaiBao=BaiBao.Id 
				join LoaiBaiBao on LoaiBaiBao.Id = BaiBao.IdLoaiBaiBao 
	where IdGiaoVien = @magiaovien and dbo.kiemTraThoiGianBatDau(@namhoc , @kyhoc, NgayCongBo)= 1
end
go

exec ThongKeBaiBao 1 , '2018-2019' , '1' 
go


------------------- Tải viết sách ,giáo trình -------------------
create or alter procedure ThongKeVietSach
(
	@magiaovien int ,
	@namhoc varchar(10) ,
	@kyhoc varchar(10) 
)
as begin
	declare @TyLeChuBien int = dbo.tyLeChuBien()
	select Sach.Ten +Coalesce(' ('+trim(str(GV_BienSoanSach.SoTrangDaViet))+' trang)','') as TenCongTrinhKhoaHoc, LoaiSach.Ten as Loai , 
	case 
		when GV_BienSoanSach.LaChuBien = 1 then 'Chủ biên'
		else 'Thành viên' end as VaiTro , 
	Sach.SoThanhVien as SoTacGia ,(SoTrangDaViet*GioChuan) as GioChuan
	from GV_BienSoanSach join Sach on GV_BienSoanSach.IdSach=Sach.Id 
						 join LoaiSach on LoaiSach.Id = Sach.IdLoaiSach 
	where GV_BienSoanSach.IdGiaoVien = @magiaovien 
		and  LoaiSach.Id = 1 
		and  GV_BienSoanSach.SoTrangDaViet > 0
		and dbo.kiemTraThoiGianBatDau(@namhoc , @kyhoc, NgayXuatBan)= 1
	union
	select Sach.Ten + Coalesce(' ('+trim(str(Sach.SoTinChi))+'TC)','') as TenCongTrinhKhoaHoc, LoaiSach.Ten as Loai, 
	case 
		when GV_BienSoanSach.LaChuBien = 1 then 'Chủ biên'
		else 'Thành viên' end as VaiTro ,
	Sach.SoThanhVien as SoTacGia , 
	((1-@TyLeChuBien)*SoTinChi*GioChuan/SoThanhVien)+@TyLeChuBien*LaChuBien*(SoTinChi*GioChuan) as GioChuan
	from Sach  join GV_BienSoanSach on GV_BienSoanSach.IdSach= Sach.Id 
			    join LoaiSach on LoaiSach.Id = Sach.IdLoaiSach 
	where GV_BienSoanSach.IdGiaoVien = @magiaovien 
		and  LoaiSach.Id <> 1 
		and dbo.kiemTraThoiGianBatDau(@namhoc , @kyhoc, NgayXuatBan)= 1
end
go

exec ThongKeVietSach 1 , '2018-2019' , '1' 
go


create or alter procedure ThongKeNghienCuuKhoaHoc 
(
	@magiaovien int ,
	@namhoc varchar(10) ,
	@kyhoc varchar(10) 
)
as begin 
	declare @danhsach table 
	(
		TenConTrinhKhoaHoc nvarchar(100) ,
		Loai nvarchar(100),
		VaiTro nvarchar(20) ,
		SoTacGia int ,
		GioChuan  float
	)

	insert @danhsach exec ThongKeNghienCuuDeTai @magiaovien , @namhoc, @kyhoc
	insert @danhsach exec ThongKeBaiBao @magiaovien , @namhoc, @kyhoc
	insert @danhsach exec ThongKeVietSach @magiaovien , @namhoc, @kyhoc
	select * from @danhsach
end

exec ThongKeNghienCuuKhoaHoc '1', '2018-2019' , '1'
go





alter table Sach 
add constraint DF_SoThanhVien_Pos check (SoThanhVien >= 0),
constraint DF_SoTinChi_Pos check (SoTinChi >= 0)
go 

alter table GV_BienSoanSach 
add constraint CK_SoGio_Pos check (SoGio >=0) 
go

