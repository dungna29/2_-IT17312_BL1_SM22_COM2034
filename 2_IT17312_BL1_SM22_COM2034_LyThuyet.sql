-- SQLQuery_NangCao_DungNA29_IT17202_SP22_BL1
-- Các phím tắt cơ bản:
-- Ctrl + /: Dùng comment code
-- F5: Dùng để chạy câu lệnh SQL

-- Sử dụng SQL: 
-- Chạy câu lệnh SQL đang được chọn (Ctrl + E)
-- Chuyển câu lệnh đang chọn thành chữ hoa, chữ thường (Ctrl + Shift + U, Ctrl + Shift + L)
-- Comment và bỏ comment dòng lệnh ( Ctrl + K + C; Ctrl + K + U)

-- Bài 1 Tạo biến bằng lệnh Declare trong SQL SERVER
-- 1.1 Để khai báo biến thì các bạn sử dụng từ khóa Declare với cú pháp như sau:
-- DECLARE @var_name data_type;
-- @var_name là tên của biến, luôn luôn bắt đầu bằng ký tự @
-- data_type là kiểu dữ liệu của biến
-- Ví dụ:
DECLARE @YEAR AS INT
DECLARE @y1 AS INT, @y2 AS VARCHAR

-- 1.2 Gán giá trị cho biến
-- SQL Server để gán giá trị thì bạn sử dụng từ khóa SET và toán tử = với cú pháp sau
-- SET @var_name = value
SET @YEAR = 2022

-- 1.2 Truy xuất giá trị của biến SELECT @<Tên biến> 
SELECT @YEAR
--Bài tập: Tính tổng 3 số, Tính diện tích hình chữ nhật
DECLARE @a1 INT,@a2 INT,@a3 INT,@kq INT
SET @a1 =5
SET @a2 =5
SET @a3=5
SET @kq = @a1 + @a2 + @a3
SELECT (@a1 + @a2 + @a3)

-- 1.3 Lưu trữ câu truy vấn vào biến
DECLARE @SLTonMax INT
SET @SLTonMax = (SELECT MAX(SoLuongTon) FROM ChiTietSP)
--SELECT @SLTonMax
PRINT N'Tổng số lượng tồn lớn nhất: ' + CONVERT(VARCHAR(50),@SLTonMax)

-- 1.4 Biến bảng
DECLARE @TB_NhanVIen TABLE(Ma VARCHAR(50),Ten NVARCHAR(50))
--Chèn dữ liệu vào biến bảng
INSERT INTO @TB_NhanVIen
SELECT Ma,Ten FROM NhanVien
WHERE Ten LIKE 'T%'
-- Truy xuất dữ liệu biến bảng làm việc như với bản g bt
SELECT * FROM @TB_NhanVIen

-- Chèn dữ liệu vào biến bảng
DECLARE @TB_SINHVIEN TABLE(Id INT,Ma VARCHAR(50),Ten NVARCHAR(50))
INSERT INTO @TB_SINHVIEN
VALUES(1,'SV1',N'Dũng')
SELECT * FROM @TB_SINHVIEN
UPDATE @TB_SINHVIEN
SET Ten = N'Duy'
WHERE Id = 1
SELECT * FROM @TB_SINHVIEN
-- Thử can thiệp câu UPDATE vào Ví Dụ trên. Đổi tên Dũng thành tên của mình.



