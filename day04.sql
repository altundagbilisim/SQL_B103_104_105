--ALIASES
CREATE TABLE calisanlar4 
(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50) );

INSERT INTO calisanlar4 VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO calisanlar4 VALUES(234567890, 'Veli Cem', 'Ankara'); 
INSERT INTO calisanlar4 VALUES(345678901, 'Mine Bulut', 'Izmir');

SELECT * FROM calisanlar4;

select calisan_id as id from calisanlar4;

--Eğer iki sütunun verilerini birleştirmek istersek concat sembolu || kullanırız.

--1.yol
select calisan_id as id,calisan_isim ||' '|| calisan_dogdugu_sehir as calisan_bilgisi from calisanlar4;
--2.yol
SELECT calisan_id AS id, concat (calisan_isim,' ',calisan_dogdugu_sehir) AS calisan_bilgisi FROM calisanlar4;

--IS NULL CONDITION
CREATE TABLE insanlar
(
ssn char(9),
name varchar(50), 
adres varchar(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara'); 
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir'); 
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

SELECT * FROM insanlar;

--name sütununda null değerleri listeleyelim
SELECT name FROM insanlar WHERE name IS NULL;

--Insanlar tablosunda null sadece null olmayan değerleri listeleyiniz.
select name from insanlar where name is not null

--Insanlar tablosunda null değer almış verielri no name olarak değiştiriniz.
update insanlar
set name='no name'
where name is null;

--ORDER BY KOMUTU
/*
Tablolardaki verileri sıralamak için ORDER BY komutu kullanırız
Büyükten küçüğe veya küçükten büyüğe sıralama yapabiliriz.
Default olarak küçükten büyüğe sıralama yapar.
Eğer Büyükten Küçüğe sıralamak istersek ORDER BY komutundan sonra DESC komutunu kullanırız.
*/


CREATE TABLE insanlar2
(
ssn char(9),
isim varchar(50),
soyisim varchar(50), adres
varchar(50)
);

INSERT INTO insanlar2 VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar2 VALUES(234567890, 'Veli','Cem', 'Ankara'); 
INSERT INTO insanlar2 VALUES(345678901, 'Mine','Bulut', 'Ankara'); 
INSERT INTO insanlar2 VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar2 VALUES (344678901, 'Mine','Yasa', 'Ankara'); 
INSERT INTO insanlar2 VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

select * from insanlar2;

--Insanlar tablosundaki datalari adres’e gore siralayin 
SELECT * FROM insanlar2 order by adres;
SELECT * FROM insanlar2 order by soyisim;

--Insanlar tablosundaki ismi Mine olanalrı SSN sıralı olarak listeleyin 
select *from insanlar2 where isim = 'Mine' order by ssn

/*
NOT : Order By komutundan sonra field ismi yerine field(sütun) numarasi da kullanilabilir
Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin
*/

select *from insanlar2 where soyisim='Bulut' ORDER BY 4

--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
select * from insanlar2 order by 4 desc

--Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin 
SELECT * FROM insanlar2 ORDER BY isim ASC, soyisim DESC;

--İsim ve soyisim degerlerini soyisim kelime uzunluklarına göre sıralayınız.
/*
Eğer sütun uzunluğuna göre sıralamak istersek LENGTH komutu kullanırız.
Ve yine uzunluğu büyükten küçüğe sıralamak istersek sonuna DESC komutunu ekleriz
*/

SELECT isim,soyisim FROM insanlar2 ORDER BY LENGTH (soyisim) DESC;

--Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız
SELECT isim||' '|| soyisim AS isim_soyisim FROM insanlar2 ORDER BY LENGTH (isim||soyisim);
SELECT isim||' '|| soyisim AS isim_soyisim FROM insanlar2 ORDER BY LENGTH (isim)+ LENGTH (soyisim);
SELECT CONCAT (isim,' ',soyisim) AS isim_soyisim FROM insanlar2 ORDER BY LENGTH (isim) + LENGTH (soyisim);
SELECT CONCAT (isim,' ',soyisim) AS isim_soyisim FROM insanlar2 ORDER BY LENGTH (CONCAT (isim,soyisim));

--GRUP BY KOMUTU

CREATE TABLE manav
(
isim varchar(50), 
Urun_adi varchar(50), 
Urun_miktar int
);

INSERT INTO manav VALUES( 'Ali',   'Elma',  5);
INSERT INTO manav VALUES( 'Ayse',  'Armut', 3);
INSERT INTO manav VALUES( 'Veli',  'Elma',  2); 
INSERT INTO manav VALUES( 'Hasan', 'Uzum',  4); 
INSERT INTO manav VALUES( 'Ali',   'Armut', 2); 
INSERT INTO manav VALUES( 'Ayse',  'Elma',  3); 
INSERT INTO manav VALUES( 'Veli',  'Uzum',  5); 
INSERT INTO manav VALUES( 'Ali',   'Armut', 2); 
INSERT INTO manav VALUES( 'Veli',  'Elma',  3); 
INSERT INTO manav VALUES( 'Ayse',  'Uzum',  2);

SELECT * FROM manav;
 
--Isme gore alinan toplam urunleri listeleyiniz.
SELECT isim, SUM(urun_miktar) AS Alinan_Toplam_Meyve FROM manav 
GROUP BY isim;

--Isme gore alinan toplam urunleri bulun ve urunleri buyuktan kucuge listeleyin
SELECT isim, SUM(urun_miktar) AS Alinan_Toplam_Meyve FROM manav 
GROUP BY isim
ORDER BY Alinan_Toplam_Meyve DESC;

--Urun ismine gore urunu alan toplam kisi sayısını listeleyiniz.
SELECT urun_adi,COUNT(isim) FROM manav
GROUP BY urun_adi;

--Isime gore aldığı urun miktarını listeleyiniz 
SELECT isim,COUNT(urun_adi) FROM manav
GROUP BY isim;






