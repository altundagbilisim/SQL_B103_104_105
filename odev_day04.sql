--ÖDEV
-- Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.
SELECT * FROM markalar
select * from calisanlar2

select marka_id,calisan_sayisi from markalar
where  marka_isim in (select isyeri from calisanlar2 where sehir='Ankara')
