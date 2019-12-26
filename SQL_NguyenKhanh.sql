-- Thực hiện chức năng thêm một giáo viên chấm thi
-- Thực hiện chức năng cập nhật thông tin một loại sách
-- Tổng hợp tải khảo thí của một giáo viên theo năm học và kì học

-- Thủ tục thêm một giáo viên chấm thi theo một loại chấm thi
create proc sp_Insert_GV_ChamThi
	@IdGiaoVien int,
	@IdLoaiChamThi int,
	@SoLuong int,
	@NamHoc varchar(10),
	@KiHoc int
as
begin
	insert into GV_ChamThi(IdGiaoVien, IdLoaiChamThi, SoLuong, NamHoc, KiHoc)
	values(@IdGiaoVien, @IdLoaiChamThi, @SoLuong, @NamHoc, @KiHoc)
end

-- Khi insert dữ liệu vào bảng GV_ChamThi sẽ cần cập nhật lại trường dư thừa Số Giờ chấm thi bằng 1 trigger
-- Số giờ chấm thi sẽ được tính bằng Số lượng bài thi * Giờ chuẩn / Đơn vị tính của Loại chấm thi
create trigger trg_Insert_GV_ChamThi on GV_ChamThi for insert
as
begin
	declare @Id int, @IdLoaiChamThi int, @SoGio float
	select @Id=Id, @IdLoaiChamThi=IdLoaiChamThi from inserted
	select @SoGio=GioChuan*SoLuong/DonViTinh from LoaiChamThi join GV_ChamThi 
	on LoaiChamThi.Id=GV_ChamThi.IdLoaiChamThi where LoaiChamThi.Id=@IdLoaiChamThi
	update GV_ChamThi set SoGio=@SoGio  where Id=@Id 
end
go

-- Khi bảng Loại chấm thi được cập nhật cũng cần cập nhật lại số giờ chấm thi của bàng GV_ChamThi bằng một trigger update
create trigger trg_Update_LoaiChamThi on LoaiChamThi for update
as
begin
	declare @Id int, @GioChuan float, @DonViTinh float
	select @Id=Id, @GioChuan=GioChuan, @DonViTinh=DonViTinh from inserted
	update GV_ChamThi set SoGio=@GioChuan*SoLuong/@DonViTinh  where IdLoaiChamThi=@Id 
end
go

-- Thủ tục Tìm kiếm giáo viên theo Mã hoặc Tên
create proc sp_TimKiemGiaoVien
	@TuKhoa nvarchar(40)
as
begin
	declare @SameTuKhoa nvarchar(42)
	set @SameTuKhoa='%'+@TuKhoa+'%'
	select Id, Ma, Ten from GiaoVien where Ma like @SameTuKhoa or Ten like @SameTuKhoa
end

-- Thủ tục cập nhật thông tin một loại sách
create proc sp_Update_LoaiSach
	@Id int,
	@Ten Nvarchar(100),
	@DonViTinh Float,
	@GioChuan Float,
	@GhiChu Ntext
as
begin
	update LoaiSach
	set Ten=@Ten, DonViTinh=@DonViTinh, GioChuan=@GioChuan, GhiChu=@GhiChu
	where Id=@Id
end

-- Khi sửa một Loại sách, trường SoGio biên soạn sách của Giáo viên sẽ bị thay đổi nên cần dùng một trigger để cập nhật trường SoGio
create trigger trg_Update_LoaiSach on LoaiSach for update
as
begin
	declare @Id int, @IdSach int, @SoThanhVien int, @GioChuan float, @DonViTinh float, @SoTinChi float
	select @Id=Id, @GioChuan=GioChuan, @DonViTinh=DonViTinh from inserted

	select @IdSach=Sach.Id, @SoThanhVien=SoThanhVien, @SoTinChi=SoTinChi from LoaiSach 
	join Sach on LoaiSach.Id=Sach.IdLoaiSach where LoaiSach.Id=@Id

	if(@Id = 1)
		update GV_BienSoanSach set SoGio=@GioChuan*SoTrangDaViet/@DonViTinh  where IdSach=@IdSach
	else
		update GV_BienSoanSach set SoGio=(LaChuBien*@GioChuan*@SoTinChi/5+@GioChuan*@SoTinChi*4/(5*@SoThanhVien)) where IdSach=@IdSach
end
go

-- Thủ tục tính tải khảo thí của một giáo viên theo một năm học và kì học
create proc sp_TaiKhaoThiTheoGV
	@IdGiaoVien int,
	@NamHoc varchar(10),
	@KiHoc int
as
begin
	select COALESCE(sum(SoGio), 0) from GV_ChamThi join LoaiChamThi
	on GV_ChamThi.IdLoaiChamThi=LoaiChamThi.Id
	where GV_ChamThi.IdGiaoVien = @IdGiaoVien 
	and NamHoc=@NamHoc and KiHoc=@KiHoc
end

-- Thủ tục tính tải khảo thí của toàn bộ giáo viên theo một năm học và kì học
create proc sp_TongHopTaiKhaoThi
	@NamHoc varchar(10),
	@KiHoc int
as
begin
	select Ma, GiaoVien.Ten, COALESCE(sum(SoGio), 0) as Tai from GiaoVien
	left join GV_ChamThi on GiaoVien.Id=GV_ChamThi.IdGiaoVien and NamHoc=@NamHoc and KiHoc=@KiHoc
	left join LoaiChamThi on GV_ChamThi.IdLoaiChamThi=LoaiChamThi.Id 
	group by Ma, GiaoVien.Ten, IdGiaoVien
end

-- Trong đó trường Số giờ của bảng Chấm thi sẽ được cập nhật khi bảng GV_ChamThi có thêm Giáo viên hoặc bảng Loại chấm thi được cập nhật

-- Trigger insert cho bảng GV_ChamThi
create trigger trg_Insert_GV_ChamThi on GV_ChamThi for insert
as
begin
	declare @Id int, @IdLoaiChamThi int, @SoGio float
	select @Id=Id, @IdLoaiChamThi=IdLoaiChamThi from inserted
	
	select @SoGio=GioChuan*SoLuong/DonViTinh from LoaiChamThi join GV_ChamThi 
	on LoaiChamThi.Id=GV_ChamThi.IdLoaiChamThi where LoaiChamThi.Id=@IdLoaiChamThi
	update GV_ChamThi set SoGio=@SoGio  where Id=@Id 
end
go

-- Trigger update cho bảng LoaiChamThi
create trigger trg_Update_LoaiChamThi on LoaiChamThi for update
as
begin
	declare @Id int, @GioChuan float, @DonViTinh float
	select @Id=Id, @GioChuan=GioChuan, @DonViTinh=DonViTinh from inserted
	update GV_ChamThi set SoGio=@GioChuan*SoLuong/@DonViTinh where IdLoaiChamThi=@Id 
end
go

insert into LoaiChamThi values
('Loai 1', 1.0, 10),
('Loai 2', 1.2, 20),
('Loai 3', 1.4, 30)
go
sp_Insert_GV_ChamThi 1, 1, 20, '2019-2020', 1
go
sp_Insert_GV_ChamThi 2, 2, 20, '2019-2020', 1
go
sp_Insert_GV_ChamThi 2, 3, 20, '2019-2020', 1
go
sp_Insert_GV_ChamThi 3, 3, 20, '2019-2020', 1
go
sp_TaiKhaoThiTheoGV 1, '2019-2020', 1
go
sp_TongHopTaiKhaoThi '2019-2020', 1
go