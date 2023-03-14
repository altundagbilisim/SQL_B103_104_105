--GROUP BY KOMUTU
CREATE TABLE personel
(id int, 
isim char(50), 
sehir varchar(50), 
maas int,
sirket varchar(20));

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz',    'Istanbul', 5500, 'Honda'); 
INSERT INTO personel VALUES(234567890, 'Veli Sahin',    'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara',   3500, 'Honda'); 
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir',    6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara',   7000, 'Tofas'); 
INSERT INTO personel VALUES(456789012, 'Veli Sahin',    'Ankara',   4500, 'Ford'); 
INSERT INTO personel VALUES(123456710, 'Hatice Sahin',  'Bursa',    4500, 'Honda');

--Isme gore toplam maasları bulun;
select isim ,sum(maas) from personel 
group by isim

--Personel tablosundaki isimleri gruplayınız
select isim from personel 
group by isim

--sehre gore toplam personel sayısını bulun
select sehir,count (isim) as calisan_sayisi from personel 
group by sehir

--HAVING KULLANIMI

/*
Having Komutu yalnızca Group By kpmutu ile kullanılır.
Eğer gruplamadan sonra bir şart varsa having komutu kullanılır.
*/
--Her şirketin MIN maaşlarını eğer 4000'den buyukse goster

SELECT*FROM personel;

SELECT sirket,min(maas) as en_dusuk_maas FROM personel
GROUP BY sirket
HAVING min(maas)>4000;

--Ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi ve toplam maasi gosteren sorgu yaziniz
SELECT isim, sum(maas) as toplam_maas FROM personel
GROUP  BY isim
HAVING SUM (maas)>10000;

-- Eger bir sehirde calisan personel sayisi 1’den coksa sehir ismini ve personel sayisini veren sorgu yaziniz
SELECT sehir, COUNT(isim) AS toplam_personel_sayisi FROM personel
GROUP BY sehir
HAVING COUNT(isim)>1

--Eger bir sehirde alinan MAX maas 5000’den dusukse sehir ismini ve MAX maasi veren sorgu yaziniz

SELECT sehir,max(maas)FROM personel
GROUP BY sehir
HAVING max(maas)<5000

--UNION OPERATOR

-- Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan sehirleri gosteren sorguyu yaziniz
SELECT isim AS isimler_ve_sehirler,maas FROM personel
WHERE maas>4000

UNION

SELECT sehir,maas FROM personel
WHERE maas>5000

-- Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini bir tabloda gosteren sorgu yaziniz
SELECT isim AS isim_ve_sehir ,maas FROM personel WHERE isim='Mehmet Ozturk'
UNION
SELECT sehir,maas FROM personel WHERE sehir='Istanbul'
ORDER BY maas DESC--buyukten kucuge sıralar

DROP TABLE if exists personel

CREATE TABLE personel
(
id int,
isim varchar(50), 
sehir varchar(50), 
maas int, 
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
)


CREATE TABLE personel_bilgi (
id int,
tel char(10) UNIQUE , 
cocuk_sayisi int,
CONSTRAINT personel_bilgi_fk FOREIGN KEY 
(id) REFERENCES personel(id)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz',    'Istanbul', 5500, 'Honda'); 
INSERT INTO personel VALUES(234567890, 'Veli Sahin',    'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara',   3500, 'Honda'); 
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir',    6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara',   7000, 'Tofas'); 
INSERT INTO personel VALUES(456715012, 'Veli Sahin',    'Ankara',   4500, 'Ford'); 
INSERT INTO personel VALUES(123456710, 'Hatice Sahin',  'Bursa',    4500, 'Honda');

INSERT INTO personel_bilgi VALUES(123456789, '5302345678', 5); 
INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

select * from personel
select* from personel_bilgi

--id’si 123456789 olan personelin Personel tablosundan sehir ve maasini, personel_bilgi tablosundan da tel ve cocuk sayisini yazdirin

SELECT sehir AS sehir_ve_tel, maas AS maas_ve_cocuksayisi FROM personel WHERE id=123456789
UNION
SELECT tel,cocuk_sayisi FROM personel_bilgi WHERE id=123456789

--UNION ALL
/*
Union tekrarlı verileri teke düşürür ve bize o şekilde sonuç verir
Union All ise tekrarlı verilerle birlikte tüm sorguları getirir.
*/

-- Personel tablosundada maasi 5000’den az olan tum isimleri ve maaslari bulunuz.
SELECT isim,maas FROM personel WHERE maas<5000
UNION ALL
SELECT isim,maas FROM personel WHERE maas<5000 

order by maas asc--kücükten büyüğe sıraladım.

select * from personel
select* from personel_bilgi

--INTERSECT KOMUTU

/*
Farklı iki tablodaki ortak verileri INTERSECT komutu ile getirebiliriz.
*/

--Personel talosundan Istanbul veya Ankara'da calisanlarin id'lerini yazdirin
--Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
SELECT id FROM personel WHERE sehir IN('Istanbul','Ankara')
INTERSECT
SELECT id FROM personel_bilgi WHERE cocuk_sayisi IN(2,3)

--Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
SELECT isim FROM personel WHERE sirket='Honda'
INTERSECT
SELECT isim FROM personel WHERE sirket='Ford'
INTERSECT
SELECT isim FROM personel WHERE sirket='Tofas'

--EXCEPT KOMUTU

--5000'den maası az olup Honda'da calismayanlari yazdırın
SELECT isim,sirket FROM personel WHERE maas<5000
EXCEPT
SELECT isim,sirket FROM personel WHERE sirket='Honda'
