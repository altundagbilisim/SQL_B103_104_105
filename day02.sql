CREATE TABLE ogrenciler5
(
ogrenci_no char(7),     --Uzunluğunu bildiğimiz stringler için CHAR kullanılır.
isim varchar(20),       --Uzunluğunu bilmediğimiz stringler için VARCHAR kullanılır.
soyisim varchar(25),
not_ort real,           --Ondalıklı sayılar için kullanılır(double gibi)
kayit_tarih date);

--VAROLAN BİR TABLODAN YENİ BİR TABLO OLUSTURMA
CREATE TABLE NOTLAR
AS
SELECT isim,not_ort FROM ogrenciler5;

select * from ogrenciler5;

--INSERT - TABLO İÇİNE VERİ EKLEME

INSERT INTO notlar VALUES('Orhan',95.5);
INSERT INTO notlar VALUES('Ali',75.5);
INSERT INTO notlar VALUES('Musa',45.5);
INSERT INTO notlar VALUES('Hakan',65.5);
INSERT INTO notlar VALUES('Adem',75.5);
INSERT INTO notlar VALUES('Sumeyye',85.5);

select * from notlar;

create table talebeler
(
isim varchar(10),
notlar real
);
INSERT INTO talebeler VALUES('Orhan',95.5);
INSERT INTO talebeler VALUES('Ali',75.5);
INSERT INTO talebeler VALUES('Musa',45.5);
INSERT INTO talebeler VALUES('Hakan',65.5);
INSERT INTO talebeler VALUES('Adem',75.5);
INSERT INTO talebeler VALUES('Sumeyye',85.5);

select * from talebeler;

select isim from notlar;

--CONSTRAINT
--UNIQUE
--NOT NULL
CREATE TABLE ogrenciler7
(
ogrenci_no char(7) unique,  
isim varchar(20) not null,     
soyisim varchar(25),
not_ort real,           
kayit_tarih date);

select * from ogrenciler7;

INSERT INTO ogrenciler7 VALUES('1234567','Erol','Evren',75.5,now());
INSERT INTO ogrenciler7 VALUES('1234568','Ali','Veli',75.5,now());
INSERT INTO ogrenciler7 (ogrenci_no,soyisim,not_ort) VALUES ('1234569','Evren',85.5);--NOT NULL kısıtlaması olduğu için buveri eklenemez

--PRIMARY KEY ataması
CREATE TABLE ogrenciler8
(
ogrenci_no char(7) PRIMARY KEY,  
isim varchar(20) ,     
soyisim varchar(25),
not_ort real,           
kayit_tarih date);

--PRIMARY KEY ataması 2.yol
CREATE TABLE ogrenciler9
(
ogrenci_no char(7),  
isim varchar(20),     
soyisim varchar(25),
not_ort real,           
kayit_tarih date,
CONSTRAINT ogr PRIMARY KEY(ogrenci_no)
);

--PRIMARY KEY ataması 3.yol
CREATE TABLE ogrenciler10
(
ogrenci_no char(7),  
isim varchar(20),     
soyisim varchar(25),
not_ort real,           
kayit_tarih date,
PRIMARY KEY(ogrenci_no)
);

--FOREIGN KEY
/*
"tedarikciler3" isimli bir tablo oluşturun. Tablo "tedarikci_id", "tedarikci_ismi",
"iletisim_isim" field'ları olsun ve "tedarikci_id" yi Primary Key yapın.
"urunler" isminde başka bir tablo oluşturun "tedarikci_id" ve "urun_id" field'ları olsun ve
"tedarikci_id" yi Foreign Key yapın.
*/

CREATE TABLE tedarikciler3
(
tedarikci_id char(5) PRIMARY KEY,
tedarikci_ismi varchar(20),
iletisim_isim varchar(20)
);

CREATE TABLE urunler
(
tedarikci_id char(5),
urun_id char(5),
FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)
);

CREATE TABLE urunler
(
tedarikci_id char(5),
urun_id char(5),
CONSTRAINT urn_fk FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler3(tedarikci_id)
);

select * from tedarikciler3;
select * from urunler;

/*
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama” 
field’lari olsun. “id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”,“sokak”, “cadde” ve 
“sehir” fieldlari olsun. “adres_id” field‘i ile Foreign Key oluşturun.
*/

CREATE TABLE calisanlar
(
id char(5) PRIMARY KEY,
isim varchar(20) unique,
maas int not null,
ise_baslama date
);

Create table adresler
(
adres_id char(5),
sokak varchar(15),
cadde varchar(15),
sehir varchar(15),
FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); --UNIQUE CONS. Kabul etmez.
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --NOT NULL CONS. Kabul etmez.
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --UNIQUE CONS. Kabul etmez.
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --String dedik.
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');--PRIMARY KEY
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --PRIMARY KEY
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');--PRIMARY KEY

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');

-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

SELECT * FROM calisanlar;
select * from adresler;

--CHECK CONSTRAINT

CREATE TABLE calisanlar2
(
id char(5) PRIMARY KEY,
isim varchar(20) unique,
maas int CHECK(maas>10000)not null,
ise_baslama date
);

INSERT INTO calisanlar1 VALUES('10002', 'Mehmet Yılmaz' ,19000, '2018-04-14');

SELECT * from calisanlar1;

-- DQL --WHERE KULLANIMI

SELECT * FROM calisanlar;
SELECT isim FROM calisanlar;

--calisanlar tablosundan maaşı 5000'den büyük olan isimleri listeleryiniz.
SELECT isim,maas FROM calisanlar WHERE maas>5000;

--calisanlar tablsoundan ismi 'Veli Han' olan tüm verileri listeleyiniz.
SELECT * FROM calisanlar WHERE isim='Veli Han';

--calisanlar tablosundan maaşı 5000 olan tüm verileri listeleryiniz.
SELECT * FROM calisanlar WHERE maas=5000;

-- DML -- DELETE KOMUTU
 DELETE FROM calisanlar;--eğer parent tablo başka bir child tablo ile ilişkiliyse önce child tablo silinmelidir.
 DELETE FROM adresler;
 SELECT * FROM adresler;
 
 --adresler tablosundan sehri Antep olan verileri silelim
 DELETE FROM adresler WHERE sehir='Antep';
 
 
 CREATE TABLE ogrenciler3
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int 
);
INSERT INTO ogrenciler3 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler3 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler3 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler3 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Ali', 99);

-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
