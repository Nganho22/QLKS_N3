-- THEM SAN PHAM
DELIMITER $$
DROP PROCEDURE IF EXISTS THEM_SANPHAM;
CREATE PROCEDURE THEM_SANPHAM (
  IN NTENSP VARCHAR(50),
  IN NGIA FLOAT
)
BEGIN
  DECLARE NMASP INT;
  SELECT MAX(RIGHT(MASP, 3)) INTO NMASP FROM SANPHAM;
  IF NMASP IS NULL THEN
    SET NMASP = 0;
  END IF;
  SET NMASP = NMASP + 1;
  INSERT INTO SANPHAM (MASP, TENSP, GIA) VALUES (CONCAT('SP', LPAD(NMASP, 3, '0')), NTENSP, NGIA);
  SELECT CONCAT('SP', LPAD(lastID, 3, '0')) AS 'MASP', NTENSP AS 'TENSP', NGIA AS 'GIA' FROM dual;
END$$
DELIMITER ;
CALL THEM_SANPHAM('NUOC BONG CUC','10000');
-- ----------------------------------------------------------------------------------------------------------------
-- THEM KHACH HANG
DELIMITER $$
DROP PROCEDURE IF EXISTS THEM_KHACHHANG;
CREATE PROCEDURE THEM_KHACHHANG (
    IN NTENKH VARCHAR(50),
    IN NDIACHI VARCHAR(50),
    IN NSDT VARCHAR(5),
    IN NEMAIL VARCHAR(50),
    IN NNGAYDK DATE,
    IN NNGAYDEN DATE,
    IN NNGAYTRAPHONG DATE,
    IN NSODEMLUUTRU INT,
    IN NMAHOCHIEU VARCHAR(5),
    IN NCMND VARCHAR(5),
    IN NMADLTG VARCHAR(5),
    IN NMADOAN VARCHAR(5),
	OUT NMAKH VARCHAR(5)
)
BEGIN
	IF NMAKH IN (SELECT MAKH FROM KHACHHANG)
		THEN 
        BEGIN 
			SELECT 'KHACH HANG DA TON TAI' AS '';
			ROLLBACK;
		END;
    ELSE 
		BEGIN
			DECLARE NUM INT;
			SELECT SUBSTR(MAKH, 3) INTO NUM FROM KHACHHANG WHERE MAKH LIKE 'KH%' ORDER BY MAKH DESC LIMIT 1;
			SET NUM = NUM + 1;
			INSERT INTO KHACHHANG (MAKH, TENKH, DIACHI, SDT, EMAIL, NGAYDK, NGAYDEN, NGAYTRAPHONG, SODEMLUUTRU, MAHOCHIEU, CMND, MADLTG, MADOAN) VALUES 
						(CONCAT('KH', LPAD(NUM, 3, '0')), NTENKH, NDIACHI, NSDT, NEMAIL, NNGAYDK, NNGAYDEN, NNGAYTRAPHONG, NSODEMLUUTRU, NMAHOCHIEU, NCMND, NMADLTG, NMADOAN);
			SELECT CONCAT('KH', LPAD(NUM, 3, '0')) INTO NMAKH;
			SELECT 'THANH CONG' AS '';
		END;
    END IF;
END$$
DELIMITER ;
CALL THEM_KHACHHANG('John Smith','23 BUI THI XUAN PHUONG 2 TP DA LAT TINH LAM DONG', '10241', 'john@example.com', '2023-01-21', '2023-01-19', '2023-01-19', '0', NULL, NULL, NULL, NULL, @NMAKH);
SELECT @NMAKH;
-- ----------------------------------------------------------------------------------------------------
-- THEM PHONG
DELIMITER $$
DROP PROCEDURE IF EXISTS THEM_PHONG;
CREATE PROCEDURE THEM_PHONG (
  IN NTINHTRANG VARCHAR(20), IN NLOAIPHONG VARCHAR(50), IN NCANDONPHONG VARCHAR(5), IN NGIAPHONG FLOAT, IN NTANG INT, OUT NMAPHONG VARCHAR(5)
)
BEGIN
	DECLARE NUM INT;
	IF NGIAPHONG <0
	THEN
		BEGIN 
			SELECT 'GIA PHONG PHAI LON HON 0' AS '';
			ROLLBACK;
        END;
	ELSEIF NTANG NOT IN (1,2,3)
	THEN
		BEGIN 
			SELECT 'TANG KHONG TON TAI' AS '';
			ROLLBACK;
        END;
	ELSE
		SELECT SUBSTR(MAPHONG, 2) INTO NUM FROM PHONG WHERE MAPHONG LIKE 'P%' ORDER BY MAPHONG DESC LIMIT 1;
		SET NUM = NUM + 1;
		INSERT INTO PHONG (MAPHONG, TINHTRANG, LOAIPHONG,CANDONPHONG,GIAPHONG,TANG) VALUES 
							(CONCAT('P', LPAD(NUM, 4, '0')), NTINHTRANG, NLOAIPHONG, NCANDONPHONG, NGIAPHONG, NTANG);
		SELECT CONCAT('P', LPAD(NUM, 4, '0')) INTO NMAPHONG;
		SELECT 'THANH CONG' AS '';
	END IF;
END$$
DELIMITER ;
CALL THEM_PHONG('A','A','A',0,1, @MAPHONG);
-- ----------------------------------------------------------------------------------------------------
-- THEM DICH VU LU HANH
DELIMITER $$
DROP PROCEDURE IF EXISTS THEM_DICHVULUHANH;
CREATE PROCEDURE THEM_DICHVULUHANH (
	IN NTENDV VARCHAR(50), IN NDIADIEM VARCHAR(50), IN NSONGAY INT, IN NMADT VARCHAR(5), OUT NMADV VARCHAR(5)
)
BEGIN
	DECLARE NUM INT;
	IF NSONGAY <1
	THEN
		BEGIN 
			SELECT 'SO NGAY PHAI LON HON 0' AS '';
			ROLLBACK;
        END;
	ELSEIF NMADT NOT IN (SELECT MADT FROM DOITACLUHANH)
	THEN
		BEGIN 
			SELECT 'DOI TAC KHONG TON TAI' AS '';
			ROLLBACK;
        END;
	ELSE
		SELECT SUBSTR(MADV, 3) INTO NUM FROM DICHVULUHANH WHERE MADV LIKE 'LH%' ORDER BY MADV DESC LIMIT 1;
		SET NUM = NUM + 1;
		INSERT INTO DICHVULUHANH (MADV, TENDV, DIADIEM, SONGAY, MADT) VALUES 
							(CONCAT('LH', LPAD(NUM, 3, '0')), NTENDV, NDIADIEM, NSONGAY, NMADT);
		SELECT CONCAT('LH', LPAD(NUM, 3, '0')) INTO NMADV;
		SELECT 'THANH CONG' AS '';
	END IF;
END$$
DELIMITER ;
CALL THEM_DICHVULUHANH('A','A',0,'DT001', @MADV);
-- ----------------------------------------------------------------------------------------------------
-- THEM DICH VU KHACH SAN
DELIMITER $$
DROP PROCEDURE IF EXISTS THEM_DICHVUKHACHSAN;
CREATE PROCEDURE THEM_DICHVUKHACHSAN (
	IN NTENDV VARCHAR(50), IN NGIA FLOAT, IN NSLMAX INT, IN NTINHTRANG VARCHAR(20), OUT NMADV VARCHAR(5)
)
BEGIN
	DECLARE NUM INT;
	IF NGIA <1
	THEN
		BEGIN 
			SELECT 'GIA DICH VU PHAI LON HON 0' AS '';
			ROLLBACK;
        END;
	ELSEIF NSLMAX <1 
	THEN
		BEGIN 
			SELECT 'SO LUONG TOI DA PHAI LON HON 0' AS '';
			ROLLBACK;
        END;
	ELSE
		SELECT SUBSTR(MADV, 3) INTO NUM FROM DICHVUKHACHSAN WHERE MADV LIKE 'DV%' ORDER BY MADV DESC LIMIT 1;
		SET NUM = NUM + 1;
		INSERT INTO DICHVUKHACHSAN (MADV, TENDV, GIA, SLMAX, TINHTRANG) VALUES 
							(CONCAT('DV', LPAD(NUM, 3, '0')), NTENDV, NGIA, NSLMAX, NTINHTRANG);
		SELECT CONCAT('LH', LPAD(NUM, 3, '0')) INTO NMADV;
		SELECT 'THANH CONG' AS '';
	END IF;
END$$
DELIMITER ;
CALL THEM_DICHVUKHACHSAN('A',1,1,'A', @MADV);
-- ----------------------------------------------------------------------------------------------------
-- THEM DOI TAC LU HANH
DELIMITER $$
DROP PROCEDURE IF EXISTS THEM_DOITACLUHANH;
CREATE PROCEDURE THEM_DOITACLUHANH (
	IN NTENDT VARCHAR(50), IN NSDT VARCHAR(10), IN NDIACHI VARCHAR(50), IN NEMAIL VARCHAR(20), IN NNGAYHOPTAC DATE, OUT NMADT VARCHAR(5)
)
BEGIN
	DECLARE NUM INT;
	SELECT SUBSTR(MADT, 3) INTO NUM FROM DOITACLUHANH WHERE MADT LIKE 'DT%' ORDER BY MADT DESC LIMIT 1;
	SET NUM = NUM + 1;
	INSERT INTO DOITACLUHANH (MADT, TENDT, SDT, DIACHI, EMAIL, NGAYHOPTAC) VALUES 
							(CONCAT('DT', LPAD(NUM, 3, '0')), NTENDT, NSDT, NDIACHI, NEMAIL, NNGAYHOPTAC);
	SELECT CONCAT('DT', LPAD(NUM, 3, '0')) INTO NMADT;
	SELECT 'THANH CONG' AS '';
END$$
DELIMITER ;
CALL THEM_DOITACLUHANH('A','1','A','A',DATE('2023-03-03'), @NMADT);
-- ----------------------------------------------------------------------------------------------------
-- THEM NHANVIEN
DELIMITER $$
DROP PROCEDURE IF EXISTS THEM_NHANVIEN;
CREATE PROCEDURE THEM_NHANVIEN (
    IN NTENNV VARCHAR(50),
    IN NSDT VARCHAR(5),
    IN NCHUCVU VARCHAR(20),
    IN NLUONG FLOAT,
    OUT NMANV VARCHAR(5)
)
BEGIN
	DECLARE NUM INT;
	CASE 
	WHEN NCHUCVU = 'LE TAN' THEN
		BEGIN
			SELECT SUBSTR(MANV, 3) INTO NUM FROM NHANVIEN WHERE MANV LIKE 'LT%' ORDER BY MANV DESC LIMIT 1;
			SET NUM = NUM + 1;
			INSERT INTO NHANVIEN (MANV, TENNV, SDT, CHUCVU, LUONG) VALUES 
						(CONCAT('LT', LPAD(NUM, 3, '0')), NMANV, NTENNV, NSDT, NCHUCVU, NLUONG);
			SELECT CONCAT('LT', LPAD(NUM, 3, '0')) INTO NMANV;
			SELECT 'THANH CONG' AS '';
		END;
	WHEN NCHUCVU = 'KE TOAN' THEN
		BEGIN
			SELECT SUBSTR(MANV, 3) INTO NUM FROM NHANVIEN WHERE MANV LIKE 'KT%' ORDER BY MANV DESC LIMIT 1;
			SET NUM = NUM + 1;
			INSERT INTO NHANVIEN (MANV, TENNV, SDT, CHUCVU, LUONG) VALUES 
						(CONCAT('KT', LPAD(NUM, 3, '0')), NMANV, NTENNV, NSDT, NCHUCVU, NLUONG);
			SELECT CONCAT('KT', LPAD(NUM, 3, '0')) INTO NMANV;
			SELECT 'THANH CONG' AS '';
		END;
	WHEN NCHUCVU = 'DICH VU' THEN
		BEGIN
			SELECT SUBSTR(MANV, 3) INTO NUM FROM NHANVIEN WHERE MANV LIKE 'DV%' ORDER BY MANV DESC LIMIT 1;
			SET NUM = NUM + 1;
			INSERT INTO NHANVIEN (MANV, TENNV, SDT, CHUCVU, LUONG) VALUES 
						(CONCAT('DV', LPAD(NUM, 3, '0')), NMANV, NTENNV, NSDT, NCHUCVU, NLUONG);
			SELECT CONCAT('DV', LPAD(NUM, 3, '0')) INTO NMANV;
			SELECT 'THANH CONG' AS '';
		END;
	WHEN NCHUCVU = 'BAO VE' THEN
		BEGIN
			SELECT SUBSTR(MANV, 3) INTO NUM FROM NHANVIEN WHERE MANV LIKE 'BV%' ORDER BY MANV DESC LIMIT 1;
			SET NUM = NUM + 1;
			INSERT INTO NHANVIEN (MANV, TENNV, SDT, CHUCVU, LUONG) VALUES 
						(CONCAT('BV', LPAD(NUM, 3, '0')), NMANV, NTENNV, NSDT, NCHUCVU, NLUONG);
			SELECT CONCAT('BV', LPAD(NUM, 3, '0')) INTO NMANV;
			SELECT 'THANH CONG' AS '';
		END;
	WHEN NCHUCVU = 'BELLMAN' THEN
		BEGIN
			SELECT SUBSTR(MANV, 3) INTO NUM FROM NHANVIEN WHERE MANV LIKE 'BM%' ORDER BY MANV DESC LIMIT 1;
			SET NUM = NUM + 1;
			INSERT INTO NHANVIEN (MANV, TENNV, SDT, CHUCVU, LUONG) VALUES 
						(CONCAT('BM', LPAD(NUM, 3, '0')), NMANV, NTENNV, NSDT, NCHUCVU, NLUONG);
			SELECT CONCAT('BM', LPAD(NUM, 3, '0')) INTO NMANV;
			SELECT 'THANH CONG' AS '';
		END;
	WHEN NCHUCVU = 'VE SINH' THEN
		BEGIN
			SELECT SUBSTR(MANV, 3) INTO NUM FROM NHANVIEN WHERE MANV LIKE 'VS%' ORDER BY MANV DESC LIMIT 1;
			SET NUM = NUM + 1;
			INSERT INTO NHANVIEN (MANV, TENNV, SDT, CHUCVU, LUONG) VALUES 
						(CONCAT('VS', LPAD(NUM, 3, '0')), NMANV, NTENNV, NSDT, NCHUCVU, NLUONG);
			SELECT CONCAT('VS', LPAD(NUM, 3, '0')) INTO NMANV;
			SELECT 'THANH CONG' AS '';
		END;
	ELSE
		BEGIN
			SELECT SUBSTR(MANV, 3) INTO NUM FROM NHANVIEN WHERE MANV LIKE 'NV%' ORDER BY MANV DESC LIMIT 1;
			SET NUM = NUM + 1;
			INSERT INTO NHANVIEN (MANV, TENNV, SDT, CHUCVU, LUONG) VALUES 
						(CONCAT('NV', LPAD(NUM, 3, '0')), NMANV, NTENNV, NSDT, NCHUCVU, NLUONG);
			SELECT CONCAT('NV', LPAD(NUM, 3, '0')) INTO NMANV;
			SELECT 'THANH CONG' AS '';
		END;
	END CASE;
END$$
DELIMITER ;
CALL THEM_NHANVIEN ('LE TAN 6', '12', 'LE TAN', 1.0, @NMANV);
-- ----------------------------------------------------------------------------------------------------
-- THEM DOAN
DELIMITER $$
DROP PROCEDURE IF EXISTS THEM_DOAN;
CREATE PROCEDURE THEM_DOAN (
	IN NTENDOAN VARCHAR(20), IN NSLKHACH FLOAT, IN NNGAYDEN DATE, IN NSODEMLUUTRU INT, IN NMADLTG VARCHAR(5), OUT NMADOAN VARCHAR(5)
)
BEGIN
	DECLARE NUM INT;
    IF NSLKHACH < 1
    THEN 
		BEGIN
			SELECT 'SO LUONG KHACH PHAI LON HON 0' AS '';
            ROLLBACK;
        END;
	ELSEIF NSODEMLUUTRU <1
    THEN 
		BEGIN
			SELECT 'SO DEM LUU TRU PHAI LON HON 0' AS '';
            ROLLBACK;
        END;
	ELSEIF NMADLTG NOT IN (SELECT MADLTG FROM DAILYTRUNGGIAN)
    THEN 
		BEGIN
			SELECT 'DAI LY TRUNG GIAN KHONG TON TAI' AS '';
            ROLLBACK;
        END;
	ELSE
		BEGIN
			SELECT SUBSTR(MADOAN, 2) INTO NUM FROM DOAN WHERE MADOAN LIKE 'D%' ORDER BY MADOAN DESC LIMIT 1;
			SET NUM = NUM + 1;
			INSERT INTO DOAN (MADOAN, TENDOAN, SLKHACH, NGAYDEN, SODEMLUUTRU, MADLTG) VALUES 
									(CONCAT('D', LPAD(NUM, 4, '0')), NTENDOAN, NSLKHACH, NNGAYDEN, NSODEMLUUTRU, NMADLTG);
			SELECT CONCAT('D', LPAD(NUM, 4, '0')) INTO NMADOAN;
			SELECT 'THANH CONG' AS '';
        END;
	END IF;
END$$
DELIMITER ;
CALL THEM_DOAN('A',1,DATE('2023-03-03'),1,'DL001', @NMADT);
-- ----------------------------------------------------------------------------------------------------
-- THEM PHIEU SU DUNG
DELIMITER $$
DROP PROCEDURE IF EXISTS THEM_PHIEUSUDUNG;
CREATE PROCEDURE THEM_PHIEUSUDUNG (
	IN NMAPHONG VARCHAR(5), IN NMANV VARCHAR(5), IN NMADV VARCHAR(5), IN NMASP VARCHAR(5), IN NNGAYDANGKY DATE, IN NGIA FLOAT, IN NSOLUONG INT, OUT NMAPHIEUSD VARCHAR(5)
)
BEGIN
	DECLARE NUM INT;
    IF NMAPHONG NOT IN (SELECT MAPHONG FROM PHONG) OR (SELECT TINHTRANG FROM PHONG WHERE MAPHONG=NMAPHONG) = 'TRONG'
    THEN
		BEGIN
			SELECT 'PHONG KHONG TON TAI' AS '';
            ROLLBACK;
        END;
	ELSEIF NMANV NOT IN (SELECT MANV FROM NHANVIEN)
    THEN 
		BEGIN
			SELECT 'NHAN VIEN KHONG TON TAI'AS'';
            ROLLBACK;
        END;
	ELSEIF NMADV IS NOT NULL AND NMASP IS NOT NULL
    THEN
		BEGIN
			SELECT 'CHI CHON MOT LOAI DICH VU' AS '';
            ROLLBACK;
		END;
	ELSEIF NMADV NOT IN (SELECT MADV FROM DICHVUKHACHSAN) 
	THEN 
		BEGIN
			SELECT 'DICH VU KHONG TON TAI' AS '';
            ROLLBACK;
        END;
	ELSEIF NMASP NOT IN (SELECT MASP FROM SANPHAM) 
	THEN 
		BEGIN
			SELECT 'SAN PHAM KHONG TON TAI' AS '';
            ROLLBACK;
        END;
	ELSEIF (NMADV IS NOT NULL AND NSOLUONG > (SELECT SLMAX FROM DICHVUKHACHSAN WHERE MADV=NMADV)) OR NSOLUONG <1
	THEN 
		BEGIN
			SELECT 'SO LUONG KHONG DUNG' AS '';
            ROLLBACK;
        END;
	ELSE
		SELECT SUBSTR(MAPHIEUSD, 4,5) INTO NUM FROM PHIEUSUDUNG WHERE MAPHIEUSD LIKE 'PSD%' ORDER BY MAPHIEUSD DESC LIMIT 1;
		SET NUM = NUM + 1;
		INSERT INTO PHIEUSUDUNG (MAPHIEUSD, MAPHONG, MANV, MADV, MASP, NGAYDANGKY, GIA, SOLUONG) VALUES 
								(CONCAT('PSD', NUM), NMAPHONG, NMANV, NMADV, NMASP, NNGAYDANGKY, NGIA, NSOLUONG);
		SELECT CONCAT('PSD', NUM) INTO NMAPHIEUSD;
		SELECT 'THANH CONG' AS '';
	END IF;
END$$
DELIMITER ;
CALL XEM_DS_DICHVUKHACHSAN;
CALL XEM_DS_PHIEUSUDUNG;
CALL THEM_PHIEUSUDUNG('P0001','LT001','DV001',NULL,DATE('2001-01-01'),1,1,@NMAPHIEUSD);

-- ----------------------------------------------------------------------------------------------------
-- THEM PHIEU DAT PHONG
DROP PROCEDURE IF EXISTS THEM_PHIEUDATPHONG;
DELIMITER $$
CREATE PROCEDURE THEM_PHIEUDATPHONG (
    IN NNGAYDAT DATE,
    IN NYEUCAU  VARCHAR(50),
    IN NSLPHONG INT,
    IN NMADLTG VARCHAR(5),
    IN NMAKH VARCHAR(5),
    IN NMANV VARCHAR(5),
    OUT NMAPDP VARCHAR(5)
)
BEGIN
	IF NMAKH NOT IN (SELECT MAKH FROM KHACHHANG)
	THEN 
        BEGIN 
            SELECT 'KHACH HANG KHONG TON TAI' AS '';
            ROLLBACK;
        END;
    ELSEIF NMANV NOT IN (SELECT MANV FROM NHANVIEN)
    THEN
        BEGIN 
            SELECT 'NHAN VIEN KHONG TON TAI' AS '';
            ROLLBACK;
        END;
    ELSEIF NMADLTG NOT IN (SELECT MADLTG FROM DAILYTRUNGGIAN)
    THEN
        BEGIN 
            SELECT 'DAI LY TRUNG GIAN KHONG TON TAI' AS '';
            ROLLBACK;
        END;
    ELSE 
		BEGIN
			DECLARE NUM INT;
			SELECT SUBSTR(MAPDP, 3) INTO NUM FROM PHIEUDATPHONG WHERE MAPDP LIKE 'DP%' ORDER BY MAPDP DESC LIMIT 1;
			SET NUM = NUM + 1;
			INSERT INTO PHIEUDATPHONG (MAPDP, NGAYDAT, YEUCAU, SLPHONG, MADLTG, MAKH, MANV, TINHTRANG) VALUES 
						(CONCAT('DP', LPAD(NUM, 3, '0')), NNGAYDAT, NYEUCAU, NSLPHONG, NMADLTG, NMAKH, NMANV, 'DANG DAT');
			SELECT CONCAT('DP', LPAD(NUM, 3, '0')) INTO NMAPDP;
		END;
	END IF;
END$$
DELIMITER ;
CALL THEM_PHIEUDATPHONG('2023-10-03', 'PHONG KHONG NOI THAT', 2, 'DL001', 'KH009', 'LT004', @MAPDP);
-- ----------------------------------------------------------------------------------------------------
-- THEM PHIEU DANG KY
DELIMITER $$
DROP PROCEDURE IF EXISTS THEM_PHIEUDANGKYNHANPHONG; 
CREATE PROCEDURE THEM_PHIEUDANGKYNHANPHONG(
		IN NTINHTRANG varchar(20),
		IN NSLTHIEU int, 
		IN NSLHANHLY int, 
		IN NYEUCAUDACBIET varchar(50), 
		IN NDANHGIA varchar(50), 
		IN NMANVLETAN varchar(5), 
		IN NMANVBELLMAN varchar(5), 
		IN NMAPDP varchar(5),
        OUT NMACTPD VARCHAR(5))
BEGIN
	IF NMANVLETAN NOT IN (SELECT MANV FROM NHANVIEN) OR NMANVLETAN NOT LIKE 'LT%' OR NMANVLETAN IS NULL
	THEN   
		BEGIN 
			SELECT 'MA LE TAN KHONG TON TAI' AS '';
			ROLLBACK;
        END;
	ELSEIF NMANVBELLMAN NOT IN (SELECT MANV FROM NHANVIEN) OR NMANVBELLMAN NOT LIKE 'BM%'OR NMANVBELLMAN IS NULL
    THEN
		BEGIN
			SELECT 'MA NV BELLMAN KHONG TON TAI' AS '';
            ROLLBACK;
		END;
	ELSEIF NSLHANHLY <1
    THEN
		BEGIN
			SELECT 'SO LUONG HANH LY PHAI LON HON 0' AS '';
            ROLLBACK;
		END;
	ELSEIF NMAPDP NOT IN (SELECT MAPDP FROM PHIEUDATPHONG) OR NMAPDP IS NULL
    THEN
		BEGIN
			SELECT 'PHIEU DAT PHONG KHONG TON TAI' AS '';
            ROLLBACK;
		END;
	ELSE
	BEGIN
			DECLARE NUM INT;
			SELECT SUBSTR(MACTPD, 4) INTO NUM FROM PHIEUDANGKYNHANPHONG WHERE MACTPD LIKE 'PDK%' ORDER BY MACTPD DESC LIMIT 1;
			SET NUM = NUM + 1;
			INSERT INTO PHIEUDANGKYNHANPHONG (MACTPD, TINHTRANG, SLTHIEU, SLHANHLY, YEUCAUDACBIET, DANHGIA, MANVLETAN, MANVBELLMAN, MAPDP) VALUES 
						(CONCAT('PDK', NUM), NTINHTRANG, NSLTHIEU, NSLHANHLY, NYEUCAUDACBIET, NDANHGIA, NMANVLETAN, NMANVBELLMAN, NMAPDP);
			SELECT CONCAT('PDK',NUM) INTO NMACTPD;
            SELECT 'THANH CONG' AS '';
		END;
    END IF;
END$$
DELIMITER ;
CALL THEM_PHIEUDANGKYNHANPHONG('A',1,1,'1','1','LT001', 'BM001','DP001', @NMACTPD);
-- ----------------------------------------------------------------------------------------------------
-- THEM HANH LY
DELIMITER $$
DROP PROCEDURE IF EXISTS THEM_HANHLY;
CREATE PROCEDURE THEM_HANHLY (
	IN NMAU varchar(10) ,
	IN NTINHTRANGVANCHUYEN varchar(20), 
	IN NMAKH varchar(5) ,
	IN NMACTPD varchar(10),
    OUT NMAHANHLY varchar(5)
)
BEGIN
	IF NMAKH NOT IN (SELECT MAKH FROM KHACHHANG) OR NMAKH IS NULL
    THEN
		BEGIN
			SELECT 'KHACH HANG KHONG TON TAI' AS '';
            ROLLBACK;
		END;
	ELSEIF NMACTPD NOT IN (SELECT MACTPD FROM CHITIETPHIEUDAT) OR NMACTPD IS NULL
    THEN
		BEGIN
			SELECT 'PHIEU DAT KHONG TON TAI' AS '';
            ROLLBACK;
		END;
    ELSE 
		BEGIN
			DECLARE NUM INT;
			SELECT SUBSTR(MACTPD, 4) INTO NUM FROM PHIEUDANGKYNHANPHONG WHERE MACTPD LIKE 'PDK%' ORDER BY MACTPD DESC LIMIT 1;
			SET NUM = NUM + 1;
			INSERT INTO PHIEUDANGKYNHANPHONG (MACTPD, TINHTRANG, SLTHIEU, SLHANHLY, YEUCAUDACBIET, DANHGIA, MANVLETAN, MANVBELLMAN, MAPDP) VALUES 
						(CONCAT('PDK', NUM), NTINHTRANG, NSLTHIEU, NSLHANHLY, NYEUCAUDACBIET, NDANHGIA, NMANVLETAN, NMANVBELLMAN, NMAPDP);
			SELECT CONCAT('PDK',NUM) INTO NMACTPD;
            SELECT 'THANH CONG' AS '';
		END;
	END IF;
END$$
DELIMITER ;
CALL THEM_HANHLY ('DO','OK','KH001','CTPD1',@NMAHANHLY);
-- ----------------------------------------------------------------------------------------------------
-- THEM CHI TIET HOA DON
DELIMITER $$
DROP PROCEDURE IF EXISTS THEM_CHITIETHOADON;
CREATE PROCEDURE THEM_CHITIETHOADON(NMAHD varchar(5), NMAPHIEUSD varchar(5))
BEGIN
	IF NMAHD NOT IN (SELECT MAHD FROM HOADON)
    THEN
		BEGIN
			SELECT 'HOA DON KHONG TON TAI' AS '';
            ROLLBACK;
        END;
	ELSEIF NMAPHIEUSD NOT IN (SELECT MAPHIEUSD FROM PHIEUSUDUNG)
    THEN
		BEGIN
			SELECT 'PHIEU SU DUNG KHONG TON TAI' AS '';
            ROLLBACK;
        END;
	ELSEIF NMAPHIEUSD IN (SELECT MAPHIEUSD FROM CHITIETHOADON)
    THEN
		BEGIN
			SELECT 'PHIEU SU DUNG DA CO HOA DON' AS '';
            ROLLBACK;
        END;
	ELSE
		BEGIN
			INSERT INTO CHITIETHOADON VALUES (NMAHD, NMAPHIEUSD);
			SELECT 'THANH CONG' AS '';
		END;
    END IF;
END$$
DELIMITER ;
CALL THEM_CHITIETHOADON('HD19','PSD20');
SELECT * FROM CHITIETHOADON;
-- ----------------------------------------------------------------------------------------------------
-- THEM CHI TIET PHIEU DAT
DELIMITER $$
DROP PROCEDURE IF EXISTS THEM_CHITIETPHIEUDAT;
CREATE PROCEDURE THEM_CHITIETPHIEUDAT (
		IN NLOAIPHONG varchar(20) ,
		IN NSLNGUOILON int ,
		IN NSLTRE int ,
		IN NGIACOBAN float ,
		IN NTGBATDAU date ,
		IN NTGKETTHUC date ,
		IN NMAPHONG varchar(5) ,
		IN NMAPDP varchar(5),
        OUT NMACTPD VARCHAR(10))
BEGIN
	DECLARE NUM INT;
	IF NMAPHONG NOT IN (SELECT MAPHONG FROM PHONG) OR NMAPHONG IS NULL
	THEN   
		BEGIN 
			SELECT 'PHONG KHONG TON TAI' AS '';
			ROLLBACK;
        END;
	ELSEIF NMAPDP NOT IN (SELECT MAPDP FROM PHIEUDATPHONG) OR NMAPDP IS NULL
	THEN   
		BEGIN 
			SELECT 'PHIEU DAT PHONG KHONG TON TAI' AS '';
			ROLLBACK;
        END;
	ELSE
		BEGIN
			SELECT SUBSTR(MACTPD, 5) INTO NUM FROM CHITIETPHIEUDAT WHERE MACTPD LIKE 'CTPD%' ORDER BY A DESC LIMIT 1;
			SET NUM = NUM + 1;
			INSERT INTO CHITIETPHIEUDAT (MACTPD, LOAIPHONG, SLNGUOILON, SLTRE, GIACOBAN, TGBATDAU, TGKETTHUC, MAPHONG, MAPDP,A) VALUES 
						(CONCAT('CTPD', NUM), NLOAIPHONG, NSLNGUOILON, NSLTRE, NGIACOBAN, NTGBATDAU, NTGKETTHUC, NMAPHONG, NMAPDP,NUM);
			SELECT CONCAT('CTPD',NUM) INTO NMACTPD;
            SELECT 'THANH CONG' AS '';
		END;
    END IF;
END$$
DELIMITER ;
CALL THEM_CHITIETPHIEUDAT ('A',1,1,1,'2023-03-03','2023-03-03','P0001','DP001',@NMACTPD);

SELECT * FROM CHITIETPHIEUDAT;
SELECT @NMACTPD;
-- ----------------------------------------------------------------------------------------------------
-- THEM HOA DON
DELIMITER $$
DROP PROCEDURE IF EXISTS THEM_HOADON;
CREATE PROCEDURE THEM_HOADON (
		NNGAYLAP date ,
		NGIATONG float ,
		NTONGTIEN float ,
		NTINHTRANG varchar(20) ,
		NDANHGIA varchar(100) ,
		NMAKH varchar(5) ,
		NMANV varchar(5) ,
		NMAPHONG varchar(5) ,
        OUT NMAHD VARCHAR(5))
BEGIN
DECLARE NUM INT;
	IF NMAKH NOT IN (SELECT MAKH FROM KHACHHANG) OR NMAKH IS NULL
	THEN   
		BEGIN 
			SELECT 'KHACH HANG KHONG TON TAI' AS '';
			ROLLBACK;
        END;
	ELSEIF NMANV NOT IN (SELECT MANV FROM NHANVIEN) OR NMANV IS NULL
	THEN   
		BEGIN 
			SELECT 'NHAN VIEN KHONG TON TAI' AS '';
			ROLLBACK;
        END;
	ELSEIF NMAPHONG NOT IN (SELECT MAPHONG FROM PHONG) OR NMAPHONG IS NULL
	THEN   
		BEGIN 
			SELECT 'PHONG KHONG TON TAI' AS '';
			ROLLBACK;
        END;
	ELSE
		BEGIN
			SELECT SUBSTR(MAHD, 3) INTO NUM FROM HOADON WHERE MAHD LIKE 'HD%' ORDER BY A DESC LIMIT 1;
			SET NUM = NUM + 1;
			INSERT INTO HOADON (MAHD, NGAYLAP, GIATONG, TONGTIEN, TINHTRANG, DANHGIA, MAKH, MANV, MAPHONG) VALUES 
						(CONCAT('HD', NUM), NNGAYLAP, NGIATONG, NTONGTIEN, NTINHTRANG, NDANHGIA, NMAKH, NMANV, NMAPHONG,NUM);
						
			SELECT CONCAT('HD',NUM) INTO NMAHD;
			SELECT 'THANH CONG' AS '';
		END;
    END IF;
END$$
DELIMITER ;
CALL THEM_HOADON ('2023-03-03',1,1,'A','A','KH001','N001','P0001',@NMAHD);
CALL XEM_DS_HOADON;
SELECT * FROM HOADON ORDER BY A;
-- ----------------------------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------