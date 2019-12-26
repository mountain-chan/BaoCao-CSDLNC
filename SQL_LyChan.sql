USE HeThongQuanLyGiaoVienDB
go

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

select GiaoVien.Id as IdGV, GiaoVien.Ten as TenGV, HocHam.Ten as HocHam, NgayNhan  
from GiaoVien join GV_HocHam on GiaoVien.Id=GV_HocHam.IdGiaoVien 
join HocHam on HocHam.Id=GV_HocHam.IdHocHam
select * from GV_HocHam

insert into GV_HocHam(IdGiaoVien, IdHocHam, NgayNhan) values(6, 1, '2019-01-01')

select * from GV_HocHam where IdGiaoVien=6

select HocHam.Id, HocHam.Ten as HocHam, QuyDinhChung as DinhMucGiangDay, DinhMucGioChuan as DinhMucNghienCuu 
from HocHam join DinhMucGiangDay on HocHam.IdDMGiangDay=DinhMucGiangDay.Id 
join DinhMucNghienCuu on DinhMucNghienCuu.Id=HocHam.IdDMNghCuu


---------------------------------------------------------------------------------------------

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


select * from GV_ChucVuDang

select * from ChucVuDang

update ChucVuDang set IdTLMienGiam = 10 where Id = 1


--------------------------------------------------------------------------------------------



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

select DinhMucGiangDay = dbo.TinhDinhMucGiangDay(2, '2018-2019', 2)
select * from GV_HocHam
select * from GV_ChucVuChMKT


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



---------------------------------------------------------------------------

--create procedure thống kê tải dạy học của một giáo viên theo năm học và kì học
create proc ThongKeTaiDayHoc
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



ThongKeTaiDayHoc 1, '2018-2019', 1, 2

select IdGiaoVien, IdLopHocPhan, SoTiet, SoGio, NamHoc, KiHoc 
from GV_LopHocPhan join LopHocPhan on LopHocPhan.Id=GV_LopHocPhan.IdLopHocPhan 
join HocPhan on HocPhan.Id=LopHocPhan.IdHocPhan 
where IdGiaoVien=1 and NamHoc='2018-2019' and KiHoc=1 and IdDoiTuongHoc=2