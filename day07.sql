--DISTINCT KULLANIMI

CREATE TABLE musteri_urun 
(
urun_id int, 
musteri_isim varchar(50),
urun_isim varchar(50) 
);
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

SELECT *FROM musteri_urun;

--musteri urun tablosundan urun isimlerini tekrarsız (grup) listeleyiniz

--DISTINCT COZUMU
SELECT DISTINCT (urun_isim) FROM musteri_urun;

--GROUP BY COZUMU
select urun_isim from musteri_urun group by urun_isim;

--Tabloda kaç farklı meyve vardır?
select urun_isim,count (urun_isim) from musteri_urun
group by urun_isim;

select urun_isim,count (DISTINCT urun_isim) from musteri_urun
group by urun_isim;

--FETCH NEXT (SAYI) -- ROW ONLY -- OFFSET --LIMIT

--Musteri urun tablosundan ilk üç kaydı listeleyiniz.

SELECT * FROM musteri_urun ORDER BY urun_id
FETCH NEXT 3 ROW ONLY

--LIMIT
SELECT * FROM musteri_urun ORDER BY urun_id 
limit 3

--Musteri urun tablosundan ilk kaydı listeleyiniz.
SELECT * FROM musteri_urun ORDER BY urun_id
limit 1;

--Musteri urun tablosundan son 3 kaydı listeleyiniz.
SELECT * FROM musteri_urun ORDER BY urun_id DESC limit 3;

CREATE TABLE maas1
(
id int, 
musteri_isim varchar(50),
maas int,
Primary Key (id,musteri_isim)
);

INSERT INTO maas VALUES (10, 'Ali', 5000); 
INSERT INTO maas VALUES (10, 'Ali', 7500); 
INSERT INTO maas VALUES (20, 'Veli', 10000); 
INSERT INTO maas VALUES (30, 'Ayse', 9000); 
INSERT INTO maas VALUES (20, 'Ali', 6500); 
INSERT INTO maas VALUES (10, 'Adem', 8000); 
INSERT INTO maas VALUES (40, 'Veli', 8500); 
INSERT INTO maas VALUES (20, 'Elif', 5500);

--Maas tablosundan en yuksek maas alan musteriyi listeleyiniz.
SELECT * FROM maas ORDER BY maas DESC limit 1;

--Maas tablosundan en yuksek ikinci maası lısteleyınız
select * from maas order by maas desc limit 1 offset 1
/*
OFFSET ==> Satır atlamak istediğimizde offset komutunu kullanırız.
*/

SELECT * FROM maas ORDER BY maas DESC
OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY;

--Maas tablosundan en dusuk dorduncu ve yedinci maasi listeleyiniz.
select * from maas order by maas desc offset 3 limit 2;

--DDL -- ALTER TABLE STATEMENT 
drop table personel-- Tabloyu ortadan kaldırır.

CREATE TABLE personel 
(
id int,
isim varchar(50), 
sehir varchar(50), 
maas int, 
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas'); 
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford'); 
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

--ADD DEFAULT ile tabloya bir field ekleme.

ALTER TABLE personel 
ADD ulke varchar(30);

ALTER TABLE personel
add zipcode varchar(30);

ALTER TABLE personel
ADD adres varchar(50)DEFAULT 'Turkiye'; --DEFAULT dediğimiz zaman oluşturduğumuz sütuna belirttiğimiz veriyi tum satırlara girer.

--DROP tablodan sütun silme

ALTER TABLE personel
DROP COLUMN zipcode;

ALTER TABLE personel
DROP adres, drop sirket;--iki sütunu birden sildik.

ALTER TABLE personel
DROP adres;

--RENAME COLUMN sütun adi degistirme
SELECT * FROM personel;

alter table personel
rename column sehir to il;

--RENAME tablo adı degistirme

ALTER TABLE personel
rename to isciler;

SELECT * FROM isciler;

--TYPE/SET (modify) sütunların özelliklerini degistirme

ALTER TABLE isciler
ALTER COLUMN il TYPE varchar(30),
ALTER COLUMN maas SET NOT NULL;

--String ==> int'e donusturmek veya int ==> String'e donusturmek

ALTER TABLE isciler
ALTER COLUMN maas
TYPE varchar(30) USING(maas::varchar(30));

--TRANSACTION(BEGIN-SAVEPOINT-ROLLBACK-COMMIT)
/*
Transaction başlatmak için BEGIN komutu kullanmamız gerekir ve Transaction'ı sonlandırmak için
COMMIT komutunu çalıştırmalıyız.
*/

CREATE TABLE ogrenciler2
(
id serial,--Serial data turu otomatik olarak 1 den baslayarak sıralı olarak sayı ataması yapar
	      --INSERT INTO ile tabloya veri eklerken serial data türünü kullandığım veri değeri yerine DEFAULT yazarız
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real 
);

BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);

savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);

savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);

ROLLBACK to y;

COMMIT;

SELECT * FROM ogrenciler2;

delete from ogrenciler2;
drop table ogrenciler2;
