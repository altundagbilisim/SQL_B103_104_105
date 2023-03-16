--JOINS

CREATE TABLE sirketler 
(
sirket_id int, 
sirket_isim varchar(20)
);

CREATE TABLE siparisler 
(
siparis_id int, 
sirket_id int, 
siparis_tarihi date
);

INSERT INTO sirketler VALUES(100, 'Toyota'); 
INSERT INTO sirketler VALUES(101, 'Honda'); 
INSERT INTO sirketler VALUES(102, 'Ford'); 
INSERT INTO sirketler VALUES(103, 'Hyundai');

INSERT INTO siparisler VALUES(11, 101,'17-Apr-2020');
INSERT INTO siparisler VALUES(22, 102,'18-Apr-2020');
INSERT INTO siparisler VALUES(33, 103,'19-Apr-2020');
INSERT INTO siparisler VALUES(44, 104,'20-Apr-2020');
INSERT INTO siparisler VALUES(55, 105,'21-Apr-2020');

SELECT * FROM sirketler;
SELECT * FROM siparisler;

--Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve 
--siparis_tarihleri ile yeni bir tablo olusturun

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler INNER JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id;

--LEFT JOIN

--Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve 
--siparis_tarihleri ile yeni bir tablo olusturun

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM sirketler LEFT JOIN siparisler
ON sirketler.sirket_id=siparisler.sirket_id;

--RIGHT JOIN

SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM siparisler LEFT JOIN sirketler
ON sirketler.sirket_id=siparisler.sirket_id;

--FULL JOIN
SELECT sirketler.sirket_isim,siparisler.siparis_id,siparisler.siparis_tarihi
FROM siparisler FULL JOIN sirketler
ON sirketler.sirket_id=siparisler.sirket_id;

--SELF JOIN
drop table personel cascade

CREATE TABLE personel
(
id int,
isim varchar(20), 
title varchar(60), 
yonetici_id int
);
INSERT INTO personel VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel VALUES(3, 'Ayse Gul', 'QA Lead', 4); 
INSERT INTO personel VALUES(4, 'Fatma Can', 'CEO', 5);

SELECT * FROM personel;


--Her personelin yanina yonetici ismini yazdiran bir tablo olusturun
SELECT p1.isim AS personel_ismi,p2.isim AS yonetici_ismi
FROM personel p1 INNER JOIN personel p2
ON p1.yonetici_id=p2.id;

--LIKE CONDITION 
CREATE TABLE musteriler 
(
id int UNIQUE,
isim varchar(50) NOT NULL,
gelir int
);
INSERT INTO musteriler (id, isim, gelir) VALUES (1001, 'Ali', 62000); 
INSERT INTO musteriler (id, isim, gelir) VALUES (1002, 'Ayse', 57500); 
INSERT INTO musteriler (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1004, 'Fatma', 42000); 
INSERT INTO musteriler (id, isim, gelir) VALUES (1005, 'Kasim', 44000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1006, 'ahmet', 82000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1007, 'erhan', 92000); 



--Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin
/*
LIKE kullanımında kucuk-buyuk harf gozetmeksizin sonuç almak istersek ILIKE kullanırız.
LIKE yerine ~~sembollerini kullanabiliriz. Eğer büyük küçük harf gözetmeksizin kullanmak istersek ~~* sembollerini kullanırız.
*/
SELECT * FROM musteriler WHERE isim LIKE 'A%';
SELECT * FROM musteriler WHERE isim ~~ 'A%';

SELECT * FROM musteriler WHERE isim ILIKE 'A%';
SELECT * FROM musteriler WHERE isim ~~* 'A%';

--Ismi e harfi ile biten musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
SELECT isim,gelir FROM musteriler WHERE isim ~~ '%e';

--Isminin icinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
SELECT isim,gelir FROM musteriler WHERE isim like '%er%'

--Ismi 5 harfli olup son 4 harfi atma olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT *FROM musteriler where isim ~~ '_atma'

--Ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler where isim like '_a%'

--Ucuncu harfi s olan musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler where isim like '__s%'

--Ucuncu harfi s olan ismi 4 harfli musterilerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM musteriler WHERE isim LIKE '__s_';

--REGEXP LIKE

CREATE TABLE kelimeler 
(
id int UNIQUE,
kelime varchar(50) NOT NULL, 
Harf_sayisi int
);
INSERT INTO kelimeler VALUES (1001, 'hot', 3); 
INSERT INTO kelimeler VALUES (1002, 'hat', 3); 
INSERT INTO kelimeler VALUES (1003, 'hit', 3); 
INSERT INTO kelimeler VALUES (1004, 'hbt', 3); 
INSERT INTO kelimeler VALUES (1008, 'hct', 3); 
INSERT INTO kelimeler VALUES (1005, 'adem', 4); 
INSERT INTO kelimeler VALUES (1006, 'selim', 5); 
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);
INSERT INTO kelimeler VALUES (1009, 'hAt', 5); 


SELECT * FROM kelimeler;

--Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini yazdiranQUERY yazin
select *from kelimeler where kelime ~* 'h[ai]t';

-- Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin
select*from kelimeler where kelime ~* 'h[a-k]t';

--a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~*'^[as]';

-- m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime ~*'[mf]$';

--NOT LIKE

--ilk harfi h olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime NOT LIKE 'h%';

-- a harfi icermeyen kelimelerin tum bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime NOT LIKE '%a%';

--UPPER -- LOWER -- INITCAP

--kelimeler tablosundaki kelime sütunundaki verileri önce büyük harf, sonra küçük harf ve ilk harfleri 
--büyük harf olacak şekilde yazdıralım.

SELECT UPPER (kelime) as kelime FROM kelimeler; --büyük yazar
SELECT LOWER(kelime) as kelime FROM kelimeler; --küçük yazar
SELECT INITCAP (kelime) as kelime FROM kelimeler; --ilk harfleri büyük yazar

--musteriler tablosundan bütün isimleri büyük harf yapınız.
select upper(isim) from musteriler;

/*
eğer birden fazla sütundaki verileri büyük-küçük harf yapmak istersek 
*/
select lower(title),upper (isim) from personel;




