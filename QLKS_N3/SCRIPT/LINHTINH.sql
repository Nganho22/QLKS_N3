USE `DA_PTTK`;
CREATE TABLE LOAIPHONG_COUNT(
	LOAIPHONG VARCHAR(20),
    SOLUONGPHONGTRONG INT
);

INSERT INTO LOAIPHONG_COUNT (LOAIPHONG) VALUE ('PHONG DON');
INSERT INTO LOAIPHONG_COUNT (LOAIPHONG) VALUE ('PHONG DOI');
INSERT INTO LOAIPHONG_COUNT (LOAIPHONG) VALUE ('PHONG GIA DINH');
SELECT * FROM LOAIPHONG_COUNT;
SET SQL_SAFE_UPDATES = 0;
UPDATE LOAIPHONG_COUNT SET LOAIPHONG_COUNT.SOLUONGPHONGTRONG = (SELECT COUNT(MAPHONG) FROM PHONG WHERE LOAIPHONG = 'PHONG DON' AND TINHTRANG='TRONG') WHERE LOAIPHONG_COUNT.LOAIPHONG ='PHONG GIA DINH';
SET SQL_SAFE_UPDATES = 1;

-- PROC DEM SO LUONG PHONG TRONG
DELIMITER $$  
drop procedure if exists CAPNHAT_LOAIPHONG_COUNT;
CREATE PROCEDURE CAPNHAT_LOAIPHONG_COUNT()
BEGIN
	DECLARE SL INT;
	SET SQL_SAFE_UPDATES = 0;
    
    SET SL=(SELECT COUNT(MAPHONG) FROM PHONG WHERE LOAIPHONG = 'PHONG DOI' AND TINHTRANG='TRONG');
    UPDATE LOAIPHONG_COUNT SET SOLUONGPHONGTRONG = SL WHERE LOAIPHONG = 'PHONG DOI';
    
    SET SL=(SELECT COUNT(MAPHONG) FROM PHONG WHERE LOAIPHONG = 'PHONG DON' AND TINHTRANG='TRONG');
    UPDATE LOAIPHONG_COUNT SET SOLUONGPHONGTRONG = SL WHERE LOAIPHONG = 'PHONG DON';
    
    SET SL=(SELECT COUNT(MAPHONG) FROM PHONG WHERE LOAIPHONG = 'PHONG GIA DINH' AND TINHTRANG='TRONG');
    UPDATE LOAIPHONG_COUNT SET SOLUONGPHONGTRONG = SL WHERE LOAIPHONG = 'PHONG GIA DINH';
    SET SQL_SAFE_UPDATES = 1;
End $$
DELIMITER ;
CALL CAPNHAT_LOAIPHONG_COUNT();
-- LAY MA PHONG TRONG DE THEM CHI TIET PHIEU DAT
DELIMITER $$  
drop procedure if exists LAY_MAPHONG_TRONG;
CREATE PROCEDURE LAY_MAPHONG_TRONG(IN NLOAIPHONG VARCHAR(20), OUT NMAPHONG VARCHAR(5))
BEGIN
	SELECT MAPHONG
	FROM PHONG
	WHERE LOAIPHONG = NLOAIPHONG AND TINHTRANG='TRONG'
	LIMIT 1
    INTO NMAPHONG;
End $$
DELIMITER ;
CALL LAY_MAPHONG_TRONG('PHONG DON', @NMAPHONG);
SELECT @NMAPHONG;

-- TRA VE MA PHIEU DAT PHONG CUA KHACH
DELIMITER $$  
drop procedure if exists LAY_MAPHIEUDATPHONG;
CREATE PROCEDURE LAY_MAPHIEUDATPHONG(IN NMAKH VARCHAR(5), OUT NMAPDP VARCHAR(5))
BEGIN
	SELECT MAPDP
	FROM PHIEUDATPHONG
	WHERE MAKH = NMAKH AND TINHTRANG='DANG DAT'
	LIMIT 1
    INTO NMAPDP;
End $$
DELIMITER ;



CALL LAY_MAPHIEUDATPHONG('KH004', @NMAPDP);
SELECT @NMAPDP;
CALL XEM_DS_PHONG('ALL');


-- CAP NHAT TINH TRANG CUA 1 PHONG VA UPDATE DANH SACH PHONG TRONG
DELIMITER $$  
drop procedure if exists CAPNHAT_TT_PHONG;
CREATE PROCEDURE CAPNHAT_TT_PHONG(IN NMAPHONG VARCHAR(5), IN NTINHTRANG VARCHAR(20))
BEGIN
	SET SQL_SAFE_UPDATES = 0;
	IF NMAPHONG NOT IN (SELECT MAPHONG FROM PHONG)
    THEN
		SELECT 'MA PHONG KHONG TON TAI' AS '';
        ROLLBACK;
	ELSEIF NTINHTRANG NOT IN ('TRONG', 'DANG DAT')
    THEN
		SELECT 'TINH TRANG KHONG HOP LE' AS '';
        ROLLBACK;
	ELSE 
		UPDATE PHONG SET TINHTRANG=NTINHTRANG WHERE MAPHONG = NMAPHONG;
        IF NTINHTRANG = 'TRONG'
        THEN
			UPDATE LOAIPHONG_COUNT SET SOLUONGPHONGTRONG = SOLUONGPHONGTRONG+1 WHERE LOAIPHONG IN (SELECT LOAIPHONG FROM PHONG WHERE MAPHONG=NMAPHONG);
		ELSE UPDATE LOAIPHONG_COUNT SET SOLUONGPHONGTRONG = SOLUONGPHONGTRONG-1 WHERE LOAIPHONG IN (SELECT LOAIPHONG FROM PHONG WHERE MAPHONG=NMAPHONG);
        END IF;
        SELECT 'THANH CONG' AS '';
	END IF;
    SET SQL_SAFE_UPDATES = 1;
End $$
DELIMITER ;
CALL CAPNHAT_TT_PHONG('P0001','DANG DAT');
DELIMITER $$  
drop procedure if exists XEM_DS_CHITIETPHIEUDAT_THEO_MAPDP;
CREATE PROCEDURE XEM_DS_CHITIETPHIEUDAT_THEO_MAPDP(IN NMAPDP VARCHAR(5))
BEGIN
	SELECT * FROM CHITIETPHIEUDAT WHERE MAPDP=NMAPDP;
End $$
DELIMITER ;

CALL XEM_DS_CHITIETPHIEUDAT_THEO_MAPDP('DP001');

DELIMITER $$  
drop procedure if exists XEM_DS_PHIEUDATPHONG_THEO_MAKH;
CREATE PROCEDURE XEM_DS_PHIEUDATPHONG_THEO_MAKH(IN NMAKH VARCHAR(5))
BEGIN
	SELECT * FROM PHIEUDATPHONG WHERE MAKH=NMAKH;
End $$
DELIMITER ;
CALL XEM_DS_PHIEUDATPHONG_THEO_MAKH('KH004');

SELECT * FROM PHIEUDATPHONG;

SELECT * FROM DICHVUKHACHSAN;
SELECT DVP.* FROM PHIEUDATPHONG PDP, CHITIETPHIEUDAT CTPD, DICHVUCUAPHONG DVP WHERE PDP.MAPDP='DP001' AND CTPD.MAPDP= PDP.MAPDP AND DVP.MAPHONG = CTPD.MAPHONG;
SELECT * FROM DICHVUCUAPHONG;


SET SQL_SAFE_UPDATES = 0;
UPDATE DICHVUCUAPHONG SET TINHTRANG = '0';
SET SQL_SAFE_UPDATES = 1;

DELIMITER $$  
drop procedure if exists XEM_DS_DV_CUA_PDP;
CREATE PROCEDURE XEM_DS_DV_CUA_PDP(IN NMAPDP VARCHAR(5))
BEGIN
	SELECT DISTINCT DVP.* FROM PHIEUDATPHONG PDP, CHITIETPHIEUDAT CTPD, DICHVUCUAPHONG DVP WHERE PDP.MAPDP='DP001' AND CTPD.MAPDP= PDP.MAPDP AND DVP.MAPHONG = CTPD.MAPHONG;
End $$
DELIMITER ;

CALL XEM_DS_DV_CUA_PDP('DP001');

SELECT * FROM DICHVUCUAPHONG;

ALTER TABLE CHITIETPHIEUDAT ADD COLUMN A INT;

-- LICH SU PHIEU DAT PHONG
DELIMITER $$  
drop procedure if exists LICH_SU_PHIEU_DAT_PHONG;
CREATE PROCEDURE LICH_SU_PHIEU_DAT_PHONG(IN NMAKH VARCHAR(5))
BEGIN
	SELECT * FROM PHIEUDATPHONG WHERE MAKH=NMAKH;
End $$
DELIMITER ;

CALL LICH_SU_PHIEU_DAT_PHONG('KH001');

-- LICH SU HOA DON
DELIMITER $$  
drop procedure if exists LICH_SU_HOA_DON;
CREATE PROCEDURE LICH_SU_HOA_DON(IN NMAKH VARCHAR(5))
BEGIN
	SELECT * FROM HOADON WHERE MAKH=NMAKH;
End $$
DELIMITER ;

CALL LICH_SU_HOA_DON('KH001');

-- CHI TIET PHIEU DAT CUA PHIEU DAT
DELIMITER $$  
drop procedure if exists CTPD_CUA_PDP;
CREATE PROCEDURE CTPD_CUA_PDP(IN NMAPDP VARCHAR(5))
BEGIN
	SELECT * FROM CHITIETPHIEUDAT WHERE MAPDP=NMAPDP;
End $$
DELIMITER ;

CALL CTPD_CUA_PDP('DP011');

DELIMITER $$  
drop procedure if exists XEM_DS_DV_CUA_PDP;
CREATE PROCEDURE XEM_DS_DV_CUA_PDP(IN NMAPDP VARCHAR(5))
BEGIN
	SELECT DISTINCT DVP.* FROM PHIEUDATPHONG PDP, CHITIETPHIEUDAT CTPD, DICHVUCUAPHONG DVP WHERE PDP.MAPDP='DP001' AND CTPD.MAPDP= PDP.MAPDP AND DVP.MAPHONG = CTPD.MAPHONG;
End $$
DELIMITER ;

CALL XEM_DS_DV_CUA_PDP('DP001');






