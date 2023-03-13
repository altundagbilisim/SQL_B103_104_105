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

select * from ogrenciler3

-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
DELETE FROM ogrenciler3 WHERE isim='Nesibe Yilmaz' or isim='Mustafa Bak';

--Veli ismi Hasan olan datayı silelim

delete from ogrenciler3 where veli_isim='Hasan';


--TRANCATE --
--Bir tablodaki tüm verileri geri alamayacağımız şekilde siler. Şartlı silme yapmaz

TRUNCATE TABLE ogrenciler3--truncate ogrenciler3 şeklinde de yapılabilir.

-- ON DELETE CASCADE
DROP TABLE if exists talebeler-- daha önce oluşturulan talebeler isimli tabloyu sildik.

CREATE TABLE talebe
(
id CHAR(3) primary key, 
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

CREATE TABLE not1( 
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebe(id)
on delete cascade
);

INSERT INTO talebe VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebe VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebe VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebe VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebe VALUES(127, 'Mustafa Bak', 'Can',99);

INSERT INTO not1 VALUES ('123','kimya',75);
INSERT INTO not1 VALUES ('124', 'fizik',65);
INSERT INTO not1 VALUES ('125', 'tarih',90);
INSERT INTO not1 VALUES ('126', 'Matematik',90); 

select * from talebe;
select * from not1;

--notlar tablosundan talebe_id'si 123 olan datayı silelim.
delete from notlar where talebe_id='123';

--talebe tablosundan id'si 126 olan datayı silelim.
delete from talebe where id='126';

/*
	Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE silme özelliği ile
parent tablodan da veri silebiliriz. Yalnız ON DELETE CASCADE komutu kullanımında parent tablodan sildiğimiz 
data child tablodan da silinir.
*/

--IN CONDITION
CREATE TABLE musteriler 
(
urun_id int, 
musteri_isim varchar(50), 
urun_isim varchar(50)
);

INSERT INTO musteriler VALUES (10, 'Mark', 'Orange'); 
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange'); 
INSERT INTO musteriler VALUES (20, 'John', 'Apple'); 
INSERT INTO musteriler VALUES (30, 'Amy',  'Palm'); 
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple'); 
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange'); 
INSERT INTO musteriler VALUES (40, 'John', 'Apricot'); 
INSERT INTO musteriler VALUES (20, 'Eddie','Apple');

SELECT * FROM musteriler;

--Musteriler tablosundan urun ismi orange, apple, apricot olan verileri listeleyiniz.

select*from musteriler where urun_isim='Orange' or urun_isim='Apple' or urun_isim='Apricot';

SELECT*FROM musteriler where urun_isim= 'Orange' and urun_id='10'

--IN CONDITION
select*from musteriler where urun_isim in ('Orange','Apple','Apricot'); --sadece yazılanları getirir.

--NOT IN
select*from musteriler where urun_isim NOT IN ('Orange','Apple','Apricot'); --sadece yazılanların dışındakileri getirir.

--BETWEEN CONDITION

--musteriler tablosundan id'si 20 ile 40 arasında olan tüm verileri listeleyiniz.

select * from musteriler where urun_id>=20 and urun_id<=40;

select * from musteriler where urun_id between 20 and 40;      --20 ile 40 arasını getir
select * from musteriler where urun_id not between 20 and 40;  --20 ile 40 arası hariç getir

--SUBQUERIES --> SORGU İÇİNDE SORGU
CREATE TABLE calisanlar2 
(
id int, 
isim VARCHAR(50), 
sehir VARCHAR(50), 
maas int, 
isyeri VARCHAR(20)
);
CREATE TABLE markalar
(
marka_id int, 
marka_isim VARCHAR(20), 
calisan_sayisi int
);

INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

SELECT*FROM calisanlar2;
select*from markalar;

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini 
--ve bu markada calisanlarin isimlerini ve maaşlarini listeleyin.

select isim,maas,isyeri from calisanlar2 
where isyeri in 
(select marka_isim from markalar where calisan_sayisi>15000)

-- marka_id’si 101’den büyük olan marka çalişanlarinin 
--isim, maaş ve şehirlerini listeleyiniz.

select isim,maas,sehir from calisanlar2
where isyeri in 
(select marka_isim from markalar where marka_id>101)


--AGGREGATE METHOD

--calisanlar tablosundan maksimum maasi listeleyelim.
SELECT MAX(maas) from calisanlar2;

/*
eğer bir sütuna geçici olarak bir isim vermek istersek as komutunu yazdıktan sonra 
vermek istediğimiz isimi yazarız.
*/
SELECT MAX(maas) as maksimum_maas from calisanlar2;

--calisanlar tablosundan minimum maasi listeleyelim
select min(maas) AS en_dusuk_maas from calisanlar2;

--calisanlar tablosundaki maasların toplamını listeleyiniz.
select sum(maas) from calisanlar2;

--calisanlar tablosundaki maasların ortalamasını listeleyiniz.
select avg(maas) from calisanlar2;
select round(avg(maas),2) from calisanlar2; --küsüratı silmek veya düzenlemek için round koyarız.

--calisanlar tablosundaki maasların sayısını listeleyiniz.
select count(maas) from calisanlar2;      --null deger varsa saymaz.
select count(*) from calisanlar2;         --count komutu satır sayısını verir.

select * from calisanlar2;

--AGGREGATE METHODLARDA SUBQUERY

-- Her markanin id’sini, ismini ve toplam kaç şehirde 
--bulunduğunu listeleyen bir SORGU yaziniz.


SELECT marka_id,marka_isim,
(select count(sehir)as sehir_sayisi from calisanlar2 where marka_isim=isyeri)
FROM markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin 
--toplam maaşini listeleyiniz

SELECT marka_isim,calisan_sayisi,
(select sum(maas)as toplam_maas from calisanlar2 where marka_isim=isyeri)
FROM markalar;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin 
--maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.

select marka_isim,calisan_sayisi, 
(select max(maas) from calisanlar2 where isyeri=marka_isim) as en_yuksek_maas,
(select min(maas) from calisanlar2 where isyeri=marka_isim) as en_dusuk_maas
from markalar;

--VIEW KULLANIMI

/*
Yaptığımız sorguları hafızaya alır ve tekrar bizden istenen sorgulama yerine 
VIEW'e atadığımız ismi SELECT komutuyla çağırırız.
*/

CREATE VIEW maxminmaas
AS
select marka_isim,calisan_sayisi, 
(select max(maas) from calisanlar2 where isyeri=marka_isim) as en_yuksek_maas,
(select min(maas) from calisanlar2 where isyeri=marka_isim) as en_dusuk_maas
from markalar;

CREATE VIEW summaas
AS
SELECT marka_isim,calisan_sayisi,
(select sum(maas)as toplam_maas from calisanlar2 where marka_isim=isyeri)
FROM markalar;

select * from maxminmaas;
SELECT * FROM summaas;

--EXISTS CONDITION

CREATE TABLE mart
(
urun_id int,
musteri_isim varchar(50), 
urun_isim varchar(50)
);

CREATE TABLE nisan 
(
urun_id int ,
musteri_isim varchar(50), 
urun_isim varchar(50)
);

INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

SELECT *FROM mart;
select * from nisan;

/*
MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.
*/

select urun_id,musteri_isim from mart
where exists 
(select urun_id from nisan where mart.urun_id=nisan.urun_id)

/*
Her iki ayda birden satılan URUN_ISIM'lerini ve bu ürünleri nisan ayında 
satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
*/

SELECT urun_isim,musteri_isim FROM nisan
WHERE exists (select urun_isim from mart where mart.urun_isim=nisan.urun_isim)

-- DML --> UPDATE 

CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);

CREATE TABLE urunler -- child
(
ted_vergino int, 
urun_id int, 
urun_isim VARCHAR(50), 
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) 
REFERENCES tedarikciler(vergi_no)
on delete cascade
);

INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');

INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');
  
select *from tedarikciler;
select * from urunler;

-- vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.

UPDATE tedarikciler SET firma_ismi='Vestel' WHERE vergi_no=102;

-- vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.

--1. yol
UPDATE tedarikciler SET firma_ismi='Casper' WHERE vergi_no=101;
UPDATE tedarikciler SET irtibat_ismi='Ali Veli' WHERE vergi_no=101;
--2.yol
UPDATE tedarikciler SET firma_ismi='Casper',irtibat_ismi='Ali Veli' WHERE vergi_no=101;

-- urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.
UPDATE urunler SET urun_isim='Telefon' WHERE urun_isim='Phone';

-- urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.
UPDATE urunler SET urun_id = urun_id+1 WHERE urun_id > 1004;

-- urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak güncelleyiniz.
UPDATE urunler SET urun_id = urun_id + ted_vergino;

select *from tedarikciler;
select * from urunler

/* 
 urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci tablosunda irtibat_ismi 
'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz.
*/

UPDATE urunler
SET urun_isim=(select firma_ismi from tedarikciler where irtibat_ismi='Adam Eve')
where musteri_isim='Ali Bak'

/*
Urunler tablosunda laptop satin alan musterilerin ismini, 
firma_ismi Apple’in irtibat_isim'i ile degistirin.
*/

UPDATE urunler
SET musteri_isim=
(select irtibat_ismi from tedarikciler where firma_ismi='Apple')
 where urun_isim='Laptop'



