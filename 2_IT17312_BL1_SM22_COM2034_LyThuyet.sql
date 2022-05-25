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

-- 1.7 Begin và End
/* T-SQL tổ chức theo từng khối lệnh
   Một khối lệnh có thể lồng bên trong một khối lệnh khác
   Một khối lệnh bắt đầu bởi BEGIN và kết thúc bởi
   END, bên trong khối lệnh có nhiều lệnh, và các
   lệnh ngăn cách nhau bởi dấu chấm phẩy	
   BEGIN
    { sql_statement | statement_block}
   END
*/
BEGIN
	SELECT Id,SoLuongTon,GiaNhap
	FROM ChiTietSP
	WHERE SoLuongTon > 1000

	IF @@ROWCOUNT = 0
	PRINT N'Không có sản phẩm nào số lượng tồn lớn hơn 900'
	ELSE
	PRINT N'Có sản phẩm số lượng tồn lớn hơn 900'
END
-- 1.8 Begin va End có thể lồng nhau.
BEGIN
	DECLARE @MaNV VARCHAR(50)
	SELECT TOP 1
	@MaNV = Ma
	FROM NhanVien
	WHERE Ten LIKE 'T%'

	IF @@ROWCOUNT <> 0
	BEGIN
		PRINT N'Tìm thấy nhân viên có chữ T đứng đầu: ' + @MaNV
	END
	ELSE
	BEGIN
		PRINT N'Không tìm thấy nhân viên nào có chữ T đứng đầu'
	END
END
-- 1.9 CAST ÉP KIỂU DỮ LIỆU
-- Hàm CAST trong SQL Server chuyển đổi một biểu thức từ một kiểu dữ liệu này sang kiểu dữ liệu khác. 
-- Nếu chuyển đổi không thành công, CAST sẽ báo lỗi, ngược lại nó sẽ trả về giá trị chuyển đổi tương ứng.
-- CAST(bieuthuc AS kieudulieu [(do_dai)])
SELECT CAST(4.9 AS INT)-- 4
SELECT CAST(13.1 AS FLOAT)
SELECT CAST(13.3 AS VARCHAR)
SELECT CAST('13.3' AS FLOAT)
SELECT CAST('2022-05-20' AS DATE)

-- 2.0 CONVERT 
-- Hàm CONVERT trong SQL Server cho phép bạn có thể chuyển đổi một biểu thức nào đó sang một kiểu dữ liệu 
-- bất kỳ mong muốn nhưng có thể theo một định dạng nào đó (đặc biệt đối với kiểu dữ liệu ngày).
-- Nếu chuyển đổi không thành công, CONVERT sẽ báo lỗi, ngược lại nó sẽ trả về giá trị chuyển đổi tương ứng.
-- CONVERT(kieudulieu(do_dai), bieuthuc, dinh_dang)
-- dinh_dang (không bắt buộc): là một con số chỉ định việc định dạng cho việc chuyển đổi dữ liệu từ dạng ngày sang dạng chuỗi.
SELECT CONVERT(int,4.9) -- = 4
SELECT CONVERT(float,5.8)
SELECT CONVERT(date,'2022-05-20')

SELECT CONVERT(varchar,'05/20/2022',101)
SELECT CONVERT(date,'2022.05.20',102)
SELECT CONVERT(date,'20/05/2022',103)

-- Ví dụ hiển thị ngày sinh của nhân viên:
SELECT NgaySinh,
	CONVERT(VARCHAR,NgaySinh,101) AS '101',
	CONVERT(VARCHAR,NgaySinh,102) AS '102',
	CONVERT(VARCHAR,NgaySinh,103) AS '103'
FROM NhanVien

-- 2.1 Các hàm toán học Các hàm toán học (Math) được dùng để thực hiện các phép toán số học trên các giá trị. 
-- Các hàm toán học này áp dụng cho cả SQL SERVER và MySQL.
-- 1. ABS() Hàm ABS() dùng để lấy giá trị tuyệt đối của một số hoặc biểu thức.
-- Hàm ABS() dùng để lấy giá trị tuyệt đối của một số hoặc biểu thức.
SELECT ABS(-3)
-- 2. CEILING()
-- Hàm CEILING() dùng để lấy giá trị cận trên của một số hoặc biểu thức, tức là lấy giá trị số nguyên nhỏ nhất nhưng lớn hơn số hoặc biểu thức tương ứng.
-- CEILING(num_expr)
SELECT CEILING(3.1)
-- 3. FLOOR()
-- Ngược với CEILING(), hàm FLOOR() dùng để lấy cận dưới của một số hoặc một biểu thức, tức là lấy giá trị số nguyên lớn nhất nhưng nhỏ hơn số hoặc biểu thức tướng ứng.
-- FLOOR(num_expr)
SELECT FLOOR(9.9)
-- 4. POWER()
-- POWER() dùng để tính luỹ thừa của một số hoặc biểu thức.
-- POWER(num_expr,luỹ_thừa)
SELECT POWER(3,2)
-- 5. ROUND()
-- Hàm ROUND() dùng để làm tròn một số hay biểu thức.
-- ROUND(num_expr,độ_chính_xác)
SELECT ROUND(9.123456,2)-- = 9.123500
-- 6. SIGN()
-- Hàm SIGN() dùng để lấy dấu của một số hay biểu thức. Hàm trả về +1 nếu số hoặc biểu thức có giá trị dương (>0),
-- -1 nếu số hoặc biểu thức có giá trị âm (<0) và trả về 0 nếu số hoặc biểu thức có giá trị =0.
SELECT SIGN(-99)
SELECT SIGN(100-50)
-- 7. SQRT()
-- Hàm SQRT() dùng để tính căn bậc hai của một số hoặc biểu thức, giá trị trả về của hàm là số có kiểu float.
-- Nếu số hay biểu thức có giá trị âm (<0) thì hàm SQRT() sẽ trả về NULL đối với MySQL, trả về lỗi đối với SQL SERVER.
-- SQRT(float_expr)
SELECT SQRT(9)
SELECT SQRT(9-5)
-- 8. SQUARE()
-- Hàm này dùng để tính bình phương của một số, giá trị trả về có kiểu float. Ví dụ:
SELECT SQUARE(9)
-- 9. LOG()
-- Dùng để tính logarit cơ số E của một số, trả về kiểu float. Ví dụ:
SELECT LOG(9) AS N'Logarit cơ số E của 9'
-- 10. EXP()
-- Hàm này dùng để tính luỹ thừa cơ số E của một số, giá trị trả về có kiểu float. Ví dụ:
SELECT EXP(2)
-- 11. PI()
-- Hàm này trả về số PI = 3.14159265358979.
SELECT PI()
-- 12. ASIN(), ACOS(), ATAN()
-- Các hàm này dùng để tính góc (theo đơn vị radial) của một giá trị. Lưu ý là giá trị hợp lệ đối với 
-- ASIN() và ACOS() phải nằm trong đoạn [-1,1], nếu không sẽ phát sinh lỗi khi thực thi câu lệnh. Ví dụ:
SELECT ASIN(1) as [ASIN(1)], ACOS(1) as [ACOS(1)], ATAN(1) as [ATAN(1)];

-- 2.2 Các hàm xử lý chuỗi làm việc với kiểu chuỗi
/*
 LEN(string)  Trả về số lượng ký tự trong chuỗi, tính cả ký tự trắng đầu chuỗi
 LTRIM(string) Loại bỏ khoảng trắng bên trái
 RTRIM(string)  Loại bỏ khoảng trắng bên phải
 LEFT(string,length) Cắt chuỗi theo vị trí chỉ định từ trái
 RIGHT(string,legnth) Cắt chuỗi theo vị trí chỉ định từ phải
 TRIM(string) Cắt chuỗi 2 đầu nhưng từ bản SQL 2017 trở lên mới hoạt động
*/
SELECT LEN('Học lại')--=7
SELECT LTRIM('  Học lại')
SELECT RTRIM('  Học lại     ')
/*Nếu chuỗi gồm hai hay nhiều thành phần, bạn có thể phân
tách chuỗi thành những thành phần độc lập.
Sử dụng hàm CHARINDEX để định vị những ký tự phân tách.
Sau đó, dùng hàm LEFT, RIGHT, SUBSTRING và LEN để trích ra
những thành phần độc lập*/
DECLARE @TB_NAMES TABLE(Ten NVARCHAR(MAX))
INSERT INTO @TB_NAMES
VALUES(N'Nguyễn Thanh Hiếu'),(N'Võ Hữu Huyên')
SELECT Ten,
	LEN(Ten) AS N'Độ dài chuỗi',
	CHARINDEX(' ',Ten) AS 'CHARINDEX',
	LEFT(Ten,CHARINDEX(' ',Ten) - 1) AS N'Họ',
	RIGHT(Ten,LEN(Ten) - CHARINDEX(' ',Ten)) AS N'Tên', -- = Thanh Hiếu
FROM @TB_NAMES
-- Làm thế nào tách nốt phần đệm trong tên thành 1 cột
-- Cách 1: Về đọc thêm về PARSENAME
DECLARE @TB_NAMES TABLE(Ten NVARCHAR(MAX))
INSERT INTO @TB_NAMES
VALUES(N'Nguyễn Thanh Hiếu'),(N'Võ Hữu Huyên')
SELECT Ten,
	LEN(Ten) AS N'Độ dài chuỗi',
	PARSENAME(REPLACE(Ten,' ','.'),3) AS N'Họ',
	PARSENAME(REPLACE(Ten,' ','.'),2) AS N'Đệm',
	PARSENAME(REPLACE(Ten,' ','.'),1) AS N'Tên'
FROM @TB_NAMES
-- Cách 2
DECLARE @TB_NAMES TABLE(Ten NVARCHAR(MAX))
INSERT INTO @TB_NAMES
VALUES(N'Nguyễn Thanh Hiếu'),(N'Võ Hữu Huyên')
SELECT Ten,
	LEN(Ten) AS N'Độ dài chuỗi',
	CHARINDEX(' ',Ten) AS 'CHARINDEX',
	LEFT(Ten,CHARINDEX(' ',Ten) - 1) AS N'Họ',
	 RTRIM(LTRIM(REPLACE(REPLACE(Ten,SUBSTRING(Ten , 1, CHARINDEX(' ', Ten) - 1),''),REVERSE( LEFT( REVERSE(Ten), CHARINDEX(' ', REVERSE(Ten))-1 ) ),'')))as N'TÊN ĐỆM',
	RIGHT(Ten,LEN(Ten) - CHARINDEX(' ',Ten)) AS N'Tên' -- = Thanh Hiếu
FROM @TB_NAMES

-- 2.3 Charindex Trả về vị trí được tìm thấy của một chuỗi trong chuỗi chỉ định, 
-- ngoài ra có thể kiểm tra từ vị trí mong  muốn
-- CHARINDEX ( string1, string2 ,[  start_location ] ) = 1 số nguyên
SELECT CHARINDEX(N'TR',N'PHÁT TRIỂN PHẦN MỀM')-- =?
SELECT CHARINDEX(N'TR',N'PHÁT TRIỂN PHẦN MỀM',7)--?

-- 2.4 Substring Cắt chuỗi bắt đầu từ vị trí và độ dài muốn lấy 
-- SUBSTRING(string,start,length)
SELECT SUBSTRING('FPT PTPMPOLY',5,LEN('FPT PTPMPOLY'))--PTPMPOLY
SELECT SUBSTRING('FPT PTPMPOLY',5,4)

-- 2.5 Replace Hàm thay thế chuỗi theo giá trị cần thay thế và cần thay thế
-- REPLACE(search,find,replace)
SELECT REPLACE('0912-456-789','-','.')

/* 2.6 
REVERSE(string) Đảo ngược chuỗi truyền vào
LOWER(string)	Biến tất cả chuỗi truyền vào thành chữ thường
UPPER(string)	Biến tất cả chuỗi truyền vào thành chữ hoa
SPACE(integer)	Đếm số lượng khoảng trắng trong chuỗi. 
*/
SELECT REVERSE('SQL')
SELECT 'SQ' + '           ' +'L'
SELECT 'SQ' + SPACE(20) +'L'

-- 2.7 Các hàm ngày tháng năm
SELECT GETDATE()
SELECT CONVERT(DATE,GETDATE())
SELECT CONVERT(TIME,GETDATE())

SELECT YEAR(GETDATE()) AS YEAR,
	MONTH(GETDATE()) AS MONTH,
	DAY(GETDATE()) AS DAY

-- DATENAME: truy cập tới các thành phần liên quan ngày tháng
SELECT 
	DATENAME(YEAR,GETDATE()) AS YEAR,
	DATENAME(MONTH,GETDATE()) AS MONTH,
	DATENAME(DAY,GETDATE()) AS DAY,
	DATENAME(WEEK,GETDATE()) AS WEEK,
	DATENAME(DAYOFYEAR,GETDATE()) AS DAYOFYEAR,
	DATENAME(WEEKDAY,GETDATE()) AS WEEKDAY
