USE `DA_PTTK`;

-- XEM DANH SACH CAC PHONG KH DANG DAT
DELIMITER $$  
drop procedure if exists XEM_DS_PHONGDAT_KH;
CREATE PROCEDURE XEM_DS_PHONGDAT_KH(IN NMAKH VARCHAR(5))
BEGIN
	SELECT * FROM CHITIETPHIEUDAT CTPD, PHIEUDATPHONG PDP WHERE CTPD.MAPDP=PDP.MAPDP AND PDP.TINHTRANG='DANG DAT' AND PDP.MAKH=NMAKH;
End $$
DELIMITER ;

CALL XEM_DS_PHONGDAT_KH('KH004')

-- DAT DICH VU
DELIMITER $$  
drop procedure if exists DAT_DICH_VU;
CREATE PROCEDURE DAT_DICH_VU(IN NMADV VARCHAR(5), IN NMAPHONG VARCHAR(5),IN NSL INT, IN NVLETAN VARCHAR(5))
BEGIN
	DECLARE GIADV FLOAT;
	SET GIADV = (SELECT GIA FROM DICHVUKHACHSAN WHERE MADV=NMADV);
    IF NMAPHONG NOT IN (SELECT CTPD.MAPHONG FROM CHITIETPHIEUDAT CTPD, PHIEUDATPHONG PDP WHERE CTPD.MAPDP=PDP.MAPDP AND PDP.TINHTRANG='DANG DAT')
	THEN
		SELECT 'PHONG KHONG KHA DUNG DE DAT DICH VU' AS '';
        ROLLBACK;
    ELSEIF NSL > (SELECT SLMAX FROM DICHVUKHACHSAN WHERE MADV=NMADV)
    THEN
		SELECT 'SO LUONG KHONG DU' AS '';
        ROLLBACK;
	ELSE
		CALL THEM_PHIEUSUDUNG(NMAPHONG,NVLETAN,NMADV,NULL,CURDATE(),1,1,@NMAPSD);
        SELECT 'THANH CONG' AS '';
	END IF;
End $$
DELIMITER ;
SELECT * FROM DICHVUCUAPHONG;
CALL DAT_DICH_VU ('DV002', 'P0011',1, 'LT001');

-- XEM DANH SACH DICH VU CUA PHIEUDATPHONG
DELIMITER $$  
drop procedure if exists XEM_DS_DV_CUA_PDP;
CREATE PROCEDURE XEM_DS_DV_CUA_PDP(IN NMAPDP VARCHAR(5))
BEGIN
SELECT DISTINCT DVP.*, DV.GIA*0.7 FROM PHIEUDATPHONG PDP, CHITIETPHIEUDAT CTPD, DICHVUCUAPHONG DVP, DICHVUKHACHSAN DV WHERE PDP.MAPDP='DP001' AND CTPD.MAPDP= PDP.MAPDP AND DVP.MAPHONG = CTPD.MAPHONG AND DV.MADV=DVP.MADV;
End $$
DELIMITER ;
CALL XEM_DS_DV_CUA_PDP('DP001');

-- DANH SACH DICH VU DA DAT
DELIMITER $$  
drop procedure if exists XEM_DS_DV_DADAT;
CREATE PROCEDURE XEM_DS_DV_DADAT(IN NMAPDP VARCHAR(5))
BEGIN
	SELECT PSD.MAPHIEUSD,  FROM PHIEUSUDUNG PSD, PHIEUDATPHONG PDP, CHITIETPHIEUDAT CTPD WHERE PDP.MAPDP=NMAPDP AND CTPD.MAPDP=PDP.MAPDP AND PSD.MAPHONG=CTPD.MAPHONG;
End $$
DELIMITER ;
CALL XEM_DS_DV_DADAT('DP001');

SELECT * FROM PHIEUSUDUNG PSD, PHIEUDATPHONG PDP, CHITIETPHIEUDAT CTPD WHERE PDP.MAPDP='DP001' AND CTPD.MAPDP=PDP.MAPDP AND PSD.MAPHONG=CTPD.MAPHONG;

