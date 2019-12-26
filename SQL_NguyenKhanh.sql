-- Thực hiện chức năng thêm một giáo viên chấm thi
-- Thực hiện chức năng cập nhật thông tin một loại sách
-- Tổng hợp tải khảo thí của một giáo viên theo năm học và kì học

-- Thủ tục thêm một giáo viên hướng dẫn
create proc sp_Insert_GV_HuongDan
	@IdGiaoVien int,
	@IdHocVien int,
	@IdLoaiHuongDan int,
	@TenDeTai nvarchar(100),
	@NgayBatDau Date,
	@NgayKetThuc Date,
	@BaoVeThanhCong bit
as
begin
	insert into GV_HuongDan(IdGiaoVien, IdHocVien, IdLoaiHuongDan, TenDeTai, NgayBatDau, NgayKetThuc, BaoVeThanhCong)
	values(@IdGiaoVien, @IdHocVien, @IdLoaiHuongDan, @TenDeTai, @NgayBatDau, @NgayKetThuc, @BaoVeThanhCong)
end
go

-- Khi insert dữ liệu vào bảng GV_HuongDan sẽ cần cập nhật lại trường dư thừa Số Giờ hướng dẫn bằng 1 trigger
-- Số giờ hướng dẫn sẽ được tính bằng Giờ chuẩn / Đơn vị tính của Loại hướng dẫn
create trigger trg_Insert_GV_HuongDan on GV_HuongDan for insert
as
begin
	declare @Id int, @IdLoaiHuongDan int, @SoGio float
	select @Id=Id, @IdLoaiHuongDan=IdLoaiHuongDan from inserted
	select @SoGio=GioChuan/DonViTinh from LoaiHuongDan join GV_HuongDan 
	on LoaiHuongDan.Id=GV_HuongDan.IdLoaiHuongDan where LoaiHuongDan.Id=@IdLoaiHuongDan
	update GV_HuongDan set SoGio=@SoGio  where Id=@Id
end
go

-- Khi bảng Loại hướng dẫn được cập nhật cũng cần cập nhật lại số giờ hướng dẫn của bàng GV_HuongDan bằng một trigger update
create trigger update_LoaiHuongDan on LoaiHuongDan for update
as
begin
	declare @Id int, @GioChuan float, @DonViTinh float
	select @Id=Id, @GioChuan=GioChuan, @DonViTinh=DonViTinh from inserted
	update GV_HuongDan set SoGio=@GioChuan/@DonViTinh  where IdLoaiHuongDan=@Id 
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
go

-- Thủ tục cập nhật thông tin một đề tài
create proc sp_Update_DeTai
	@Id int,
	@IdLoaiDeTai int,
	@Ma varchar(6),
	@Ten nvarchar(100),
	@NgayBatDau Date,
	@NgayKetThuc Date,
	@CoQuanQuanLy nvarchar(50),
	@TinhTrang bit
as
begin
	update DeTai
	set IdLoaiDeTai=@IdLoaiDeTai, Ma=@Ma, Ten=@Ten,
	NgayBatDau=@NgayBatDau, NgayKetThuc=@NgayKetThuc,
	CoQuanQuanLy=@CoQuanQuanLy, TinhTrang=@TinhTrang
	where Id=@Id
end
go

-- Khi sửa thông tin bảng đề tài, do trường số giờ nghiên cứu của bảng
-- GV_DeTaiNghienCuu phụ thuộc vào IdDeTai nên cần tính lại số giờ
create trigger trg_Update_DeTai on DeTai for update
as
begin
	declare @Id int, @SoThanhVien int, @GioChuan float, @DonViTinh  float
	select @Id=Id, @SoThanhVien=SoThanhVien from inserted
	select @GioChuan=GioChuan, @DonViTinh=DonViTinh from LoaiDeTai 
	join DeTai on LoaiDeTai.Id=DeTai.IdLoaiDeTai where DeTai.Id=@Id
	update GV_DeTaiNghienCuu set SoGio=(LaChuTri*@GioChuan/5 + @GioChuan*4/(5*@SoThanhVien)) where IdDeTai=@Id 
end
go

-- Khi bảng GV_DeTaiNghienCuu có thay đổi (thêm, bớt hoặc sửa thành viên) cần cập nhật lại
-- bảng DeTai trường SoThanhVien bằng một trigger
alter trigger trg_Update_GV_DeTaiNghienCuu on GV_DeTaiNghienCuu for insert, update, delete
as
begin
	if (select count(*) from inserted) > 0
		update DeTai
		set SoThanhVien=SoThanhVien+(select count(IdDeTai) from inserted where IdDeTai=DeTai.Id)
	if (select count(*) from deleted) > 0
		update DeTai
		set SoThanhVien=SoThanhVien-(select count(IdDeTai) from deleted where IdDeTai=DeTai.Id)
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
go

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
go

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


insert into DeTai(Ma, IdLoaiDeTai, Ten, NgayBatDau, NgayKetThuc, CoQuanQuanLy, SoThanhVien, TinhTrang) values
('DT001', 1, 'De Tai 1', '2019-12-26', '2020-06-26', 'ABC', 1, 0)
go
insert into DeTai(Ma, IdLoaiDeTai, Ten, NgayBatDau, NgayKetThuc, CoQuanQuanLy, SoThanhVien, TinhTrang) values
('DT002', 1, 'De Tai 2', '2019-12-26', '2020-06-26', 'DEF', 1, 0)
go
insert into GV_DeTaiNghienCuu values
(1, 17, 1, 10),
(1, 16, 1, 20)
go
update GV_DeTaiNghienCuu set IdDeTai=16 where IdDeTai=17
go
delete from GV_DeTaiNghienCuu where id=1
go
insert into LoaiChamThi values ('Loai 1', 1.0, 10)
insert into LoaiChamThi values ('Loai 2', 1.2, 20)
insert into LoaiChamThi values ('Loai 3', 1.4, 30)
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