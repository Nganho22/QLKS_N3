USE `DA_PTTK`;

-- KHACH HANG DANG KY TAI KHOAN
DELIMITER $$  
drop procedure if exists DANG_KY;
CREATE PROCEDURE DANG_KY_KHACHHANG(
	IN NTENKH varchar(50) ,
    IN NDIACHI VARCHAR(50),
	IN NSDT varchar(5) ,
	IN NEMAIL varchar(50) , 
	IN NMAHOCHIEU varchar(5) ,
	IN NCMND varchar(5) ,
	IN NMADLTG varchar(5) , 
	IN NMADOAN varchar(5) )
BEGIN
	SET @NMAKH=NULL;
	 CALL THEM_KHACHHANG(NTENKH, NDIACHI, NSDT , NEMAIL, NULL, NULL, NULL, '0', NMAHOCHIEU, NCMND, NMADLTG, NMADOAN, @NMAKH);
     IF @NMAKH IS NOT NULL 
	THEN
		SELECT 'DANG KI THANH CONG' AS '';
	ELSE SELECT 'DANG KI THAT BAI' AS '';
	END IF;
End $$
DELIMITER ;

-- TIM THONG TIN KHACH HANG
-- XEM THONG TIN KHACH HANG
CALL XEM_TT_KHACHHANG('KH001');

-- XEM DANH SACH PHONG
CALL XEM_DS_PHONG('PHONG DON');
-- XEM DANH SACH PHONG TRONG
CALL XEM_DS_PHONG_TRONG('PHONG DON');

-- KHACH HANG DAT PHONG (MAKH, LOAI PHONG, SL, OUT MSG)
DELIMITER $$  
drop procedure if exists DAT_PHONG;
CREATE PROCEDURE DAT_PHONG(
	IN NMAKH varchar(5) ,
    IN NLOAIPHONG VARCHAR(50),
	IN NSL INT,
    IN NMANV VARCHAR(5),
    OUT MSG VARCHAR(5))
BEGIN
	DECLARE n INT;
	IF NSL<1
    THEN
		SELECT 'SO LUONG PHAI LON HON 0' AS '';
        ROLLBACK;
	ELSEIF NLOAIPHONG NOT IN ('PHONG DON', 'PHONG DOI', 'PHONG GIA DINH')
	THEN 
		SELECT 'LOAI PHONG KHONG PHU HOP' AS '';
        ROLLBACK;
	ELSEIF NSL > (SELECT SOLUONGPHONGTRONG FROM LOAIPHONG_COUNT WHERE LOAIPHONG=NLOAIPHONG)
    THEN
		SELECT 'SO LUONG PHONG TRONG KHONG DU' AS '';
        ROLLBACK;
	ELSEIF NMAKH NOT IN (SELECT MAKH FROM PHIEUDATPHONG) OR (SELECT COUNT(TINHTRANG) FROM PHIEUDATPHONG WHERE MAKH=NMAKH AND TINHTRANG ='DANG DAT')=0
    -- NEU KHACH HANG CHUA CO PHIEU DAT PHONG THI TIEN HANH TAO PHIEU DAT PHONG
    THEN
		CALL THEM_PHIEUDATPHONG(CURDATE(), NULL, NSL, NULL, NMAKH, NMANV, @NMAPDP);
	ELSE
    -- NEU KHACH HANG DA CO PHIEU DAT THI TAO CHI TIET PHIEU DAT MOI
		SET n = 0;
		WHILE n <NSL DO
			CALL LAY_MAPHONG_TRONG(NLOAIPHONG, @MAPHONGTRONG);
			CALL LAY_MAPHIEUDATPHONG(NMAKH, @MAPHIEU);
			CALL THEM_CHITIETPHIEUDAT(NLOAIPHONG,NULL,NULL,NULL,NULL,NULL,@MAPHONGTRONG,@MAPHIEU, @MACTPD);
			CALL CAPNHAT_TT_PHONG(@MAPHONGTRONG, 'DANG DAT');
			SET n = n +1;
		END WHILE;
        SELECT 'DAT PHONG THANH CONG' AS '';
	END IF;
End $$
DELIMITER ;
CALL DAT_PHONG('KH004', 'PHONG DOI', 2,'LT001',@MSG);


-- -------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------
DELIMITER $$  
drop procedure if exists XEM_DS_PHIEUSUDUNG_CUA_PDP;
CREATE PROCEDURE DAT_DICH_VU(IN NMAKH VARCHAR(5))
BEGIN
	SELECT * FROM PHIEUSUDUNG WHERE 
End $$
DELIMITER ;
SELECT * FROM PHIEUSUDUNG;
SELECT * FROM PHIEUSUDUNG PSD, PHIEUDATPHONG PDP WHERE PSD.MAPDP=PDP.MAPHIEU AND PDP.MAKH;
SELECT * FROM CHITIETPHIEUDAT;

SELECT * FROM LOAIPHONG_COUNT;
SET SQL_SAFE_UPDATES = 0;
UPDATE PHONG SET TINHTRANG = 'TRONG';
SET SQL_SAFE_UPDATES = 1;

