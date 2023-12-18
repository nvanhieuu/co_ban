CREATE DATABASE LAYLOIHOI
USE LAYLOIHOI
CREATE TABLE PHONG(
MaPhong VARCHAR(5) PRIMARY KEY NOT NULL,
LoaiPHong VARCHAR(10),
SoKhachToiDa INT,
GiaPhong MONEY,
MoTa VARCHAR(50)
)
CREATE TABLE KHACH_HANG(
MaKH VARCHAR(6) PRIMARY KEY NOT NULL,
TenKH VARCHAR(50),
DiaChi VARCHAR(50),
SoDT VARCHAR(20)
)
CREATE TABLE DICH_VU_DI_KEM(
MaDV VARCHAR(5) PRIMARY KEY NOT NULL,
TenDV VARCHAR(50),
DonViTinh VARCHAR(10),
DonGia MONEY
)
CREATE TABLE DAT_PHONG(
MaDatPhong VARCHAR(6) PRIMARY KEY NOT NULL,
MaPhong VARCHAR(5) FOREIGN KEY(MaPhong) REFERENCES PHONG(MaPhong),
MaKH VARCHAR(6) FOREIGN KEY (MaKH) REFERENCES KHACH_HANG(MaKH),
NgayDat DATE,
GioBatDau TIME,
GioKetThuc TIME,
TienDatCoc MONEY,
GhiChu VARCHAR(50),
TrangThaiDat VARCHAR(10)
)

CREATE TABLE CHI_TIET_SU_DUNG_DICH_VU(
MaDatPhong VARCHAR(6),
MaDV VARCHAR(5),
CONSTRAINT FK_CHI_TIET_SU_DUNG_DICH_VU PRIMARY KEY(MaDatPhong, MaDV),
CONSTRAINT FK_CHI_TIET_SU_DUNG_DICH_VU_MaDatPhong FOREIGN KEY (MaDatPhong) REFERENCES DAT_PHONG(MaDatPhong),
CONSTRAINT FK_CHI_TIET_SU_DUNG_DICH_VU_MaDV FOREIGN KEY (MaDV) REFERENCES DICH_VU_DI_KEM(MaDV),
SoLuong INT
)

select * from [dbo].[PHONG]
INSERT INTO [dbo].[PHONG]
VALUES
('P0001', 'Loai 1', 20, '60.000', ''),
('P0002', 'Loai 1', 25, '80.000', ''),
('P0003', 'Loai 2', 15, '50.000', ''),
('P0004', 'Loai 3', 20, '50.000', '');

select * from [dbo].[KHACH_HANG]
INSERT INTO [dbo].[KHACH_HANG]
VALUES
('KH0001', 'Nguyen Van A', 'Hoa Xuan', '1111111111'),
('KH0002', 'Nguyen Van B', 'Hoa Hai', '11111111112'),
('KH0003', 'Phan Van A', 'Cam Le', '1111111113'),
('KH0004', 'Phan Van B', 'Hoa Xuan', '1111111114');

select * from [dbo].[DICH_VU_DI_KEM]
INSERT INTO [dbo].[DICH_VU_DI_KEM]
VALUES
('DV001', 'Beer', 'Lon', '10.000'),
('DV002', 'Nuoc Ngot', 'Lon', '8.000'),
('DV003', 'Trai Cay','Dia', '35.000'),
('DV004', 'Khan uot', 'Cai', '2.000'),
('DV005', 'Tay vin', 'Con', '1.000.000');

select * from [dbo].[DAT_PHONG]
INSERT INTO [dbo].[DAT_PHONG]
VALUES
('DP0001', 'P0001', 'KH0002', '20180326', '11:00:00', '13:00:00', '100.000', '', 'Da dat'),
('DP0002', 'P0001', 'KH0003', '20180327', '17:15:00', '19:15:00', '50.000', '', 'Da huy'),
('DP0003', 'P0002', 'KH0002', '20180326', '20:30:00', '22:15:00', '100.000', '', 'Da dat'),
('DP0004', 'P0003', 'KH0001', '20180401', '19:30:00', '21:15:00', '200.000', '', 'Da dat');

select * from [dbo].[CHI_TIET_SU_DUNG_DICH_VU]
INSERT INTO [dbo].[CHI_TIET_SU_DUNG_DICH_VU]
VALUES
('DP0001', 'DV001', 20),
('DP0001', 'DV003', 10),
('DP0001', 'DV002', 3),
('DP0002', 'DV002', 10),
('DP0002', 'DV003', 1),
('DP0003', 'DV003', 2),
('DP0003', 'DV004', 10);

--câu 1:
SELECT MaDatPhong, MaDV, SoLuong
FROM [dbo].[CHI_TIET_SU_DUNG_DICH_VU]
WHERE SoLuong > 3 AND	SoLuong < 10 

--câu 2:
UPDATE [dbo].[PHONG]
SET GiaPhong = GiaPhong + 10000
WHERE SoKhachToiDa > 10

--câu 3:
DELETE FROM [dbo].[DAT_PHONG]
WHERE TrangThaiDat = 'Da huy'

--câu 4:
SELECT TenKH
FROM [dbo].[KHACH_HANG]
WHERE TenKH LIKE 'H%' OR TenKH LIKE 'N%' OR TenKH LIKE 'M%'
   AND LEN(TenKH) <= 20

--Câu 5:
SELECT DISTINCT TenKH
FROM [dbo].[KHACH_HANG]

--câu 6:
SELECT MaDV, TenDV, DonViTinh, DonGia
FROM [dbo].[DICH_VU_DI_KEM]
WHERE (DonViTinh = 'lon' AND DonGia > 10000) OR (DonViTinh = 'Cai' AND DonGia < 5000)

--câu 7:
SELECT dp.MaDatPhong, p.MaPhong, p.LoaiPhong, p.SoKhachToiDa, p.GiaPhong, kh.MaKH, kh.TenKH, kh.SoDT, dp.NgayDat, dp.GioBatDau, dp.GioKetThuc, ctsddv.MaDV, ctsddv.SoLuong, dvdk.DonGia
FROM [dbo].[DAT_PHONG] dp
JOIN [dbo].[PHONG] p ON dp.MaPhong = p.MaPhong
JOIN [dbo].[KHACH_HANG] kh ON dp.MaKH = kh.MaKH
JOIN [dbo].[CHI_TIET_SU_DUNG_DICH_VU] ctsddv ON ctsddv.MaDatPhong = dp.MaDatPhong
JOIN [dbo].[DICH_VU_DI_KEM] dvdk ON ctsddv.MaDV = dvdk.MaDV
WHERE YEAR(dp.NgayDat) IN ('2016', '2017') AND p.GiaPhong > 50000

--câu 8:
SELECT dp.MaDatPhong, dp.MaPhong, p.LoaiPhong, p.GiaPhong, kh.TenKH, dp.NgayDat,
       (p.GiaPhong * DATEDIFF(hour, dp.GioBatDau, dp.GioKetThuc)) AS TongTienHat,
       SUM(dv.SoLuong * dv.DonGia) AS TongTienSuDungDichVu,
       (p.GiaPhong * DATEDIFF(hour, dp.GioBatDau, dp.GioKetThuc)) + SUM(dv.SoLuong * dv.DonGia) AS TongTienThanhToan
FROM DAT_PHONG dp
JOIN [dbo].[PHONG] p ON dp.MaPhong = p.MaPhong
JOIN [dbo].[KHACH_HANG] kh ON dp.MaKH = kh.MaKH
LEFT JOIN [dbo].[CHI_TIET_SU_DUNG_DICH_VU] dv ON dp.MaDatPhong = dv.MaDatPhong
GROUP BY dp.MaDatPhong, dp.MaPhong, p.LoaiPhong, p.GiaPhong, kh.TenKH, dp.NgayDat, dp.GioBatDau, dp.GioKetThuc

--câu 9:
SELECT kh.MaKH, kh.TenKH, kh.DiaChi, kh.SoDT
FROM [dbo].[KHACH_HANG] kh
WHERE kh.MaKH IN (
    SELECT dp.MaKH
    FROM [dbo].[DAT_PHONG] dp
    JOIN PHONG p ON dp.MaPhong = p.MaPhong
    WHERE p.LoaiPhong = 'Loai 1' AND kh.DiaChi = 'Hoa xuan'
)
--câu 10:
SELECT p.MaPhong, p.LoaiPhong, p.SoKhachToiDa, p.GiaPhong, COUNT(*) AS SoLanDat
FROM PHONG p
JOIN DAT_PHONG dp ON p.MaPhong = dp.MaPhong
WHERE dp.TrangThaiDat = 'Da dat'
GROUP BY p.MaPhong, p.LoaiPhong, p.SoKhachToiDa, p.GiaPhong
HAVING COUNT(*) > 2