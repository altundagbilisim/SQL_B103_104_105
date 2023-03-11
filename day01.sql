--DATABASE(VeriTabanı) Oluşturma
create database evren;

create database erol;

--DDL - DATA DEFINITION LANG.
--CREATE - TABLO OLUSTURMA
CREATE TABLE ogrenciler2
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real,   --ondalıklı sayılar için kullanılır(double gibi)
kayit_tarih date
);

--VAROLAN TABLODAN YENİ BİR TABLO OLUŞTURMA
CREATE TABLE ogrenci_notlari
AS --Benzer tablodaki başlıklarla ve data tipleriyle yeni bir tablo oluşturmak için 
   --normal tablo oluştururken ki parantezler yerine AS kullanıp SELECT komutuyla almak istediğimiz verielri alırız.
SELECT isim,soyisim,not_ort FROM ogrenciler2;

-- DML - DATA MANUPULATION LANG.
-- INSERT (Database'e veri ekleme)

INSERT INTO ogrenciler2 Values('1234567','Said','ILHAN',85.5,now());
INSERT INTO ogrenciler2 Values('1234567','Said','ILHAN',85.5,'2020-12-11');

--BIR TABLOYA PARÇALI VERİ EKLEMEK ISTERSEK

INSERT INTO ogrenciler2(isim,soyisim) VALUES ('Erol','Evren');


--DQL - DATA QUERY LANG.
--SELECT

select * from ogrenciler2;--Buradaki * sembolü herşeyi anlamındadır.