
-- 1a WYSWIETLA ILE DANY KIEROWCA W DANYM ROKU ZROBIL KILOMETROW
SELECT 
	NVL(TO_CHAR(p.kierowca_id),'Wszyscy kierowcy')"ID Kierowcy",
	NVL(TO_CHAR(EXTRACT(YEAR FROM d.DATA)),'CA£OŒÆ') "ROK",
	sum(p.przebyta_odleglosc) "Pokonana odleglosc"
FROM 
	przejazd p,
	data_przejazdu d 
WHERE 
	p.data_przejazdu_id=d.ID
GROUP BY ROLLUP 
	(p.kierowca_id, EXTRACT(YEAR FROM d.DATA))
;

-- 1b WYSWIETLA ILE DANY AUTOBUS W DANYM ROKU ZROBIL KILOMETROW
SELECT 
	NVL(TO_CHAR(p.kierowca_id),'Wszyscy kierowcy')"ID Kierowcy", 
	NVL(TO_CHAR(EXTRACT(YEAR FROM d.DATA)),'CA£OŒÆ') "ROK", 
	sum(p.przebyta_odleglosc) "Pokonana odleglosc"
FROM 
	przejazd p,
	data_przejazdu d 
WHERE 
	p.data_przejazdu_id=d.ID
GROUP BY ROLLUP 
	(p.AUTOBUS_ID, EXTRACT(YEAR FROM d.DATA))

-- 2a WYSWIETLA ILE DANA LINIA W DANYM ROKU PRZYNIOSLA DOCHODU
SELECT 
	NVL(TO_CHAR(l.nazwa_linii),'Wszystkie linie') "NAZWA LINII",
	NVL(TO_CHAR(EXTRACT(YEAR FROM d.DATA)),'CA£OŒÆ') "ROK", 
	sum (p.cena_przejazdu) "DOCHÓD"
FROM 
	przejazd p, 
	linia l, 
	data_przejazdu d
WHERE 
	l.ID = p.linia_id
AND 
	d.ID = p.data_przejazdu_id
GROUP BY CUBE 
	(l.nazwa_linii, EXTRACT(YEAR FROM d.DATA))
;

-- 2b WYSWIETLA ILE DANY AUTOBUS W DANYM ROKU PRZYNIOSL DOCHODU

SELECT 
	NVL(TO_CHAR(p.AUTOBUS_ID),'Wszystkie autobusy'), 
	NVL(TO_CHAR(EXTRACT(YEAR FROM d.DATA)),'CA£OŒÆ') "ROK", 
	sum (p.cena_przejazdu) "DOCHÓD"
FROM 
	przejazd p,  
	data_przejazdu d
WHERE 
	d.ID = p.data_przejazdu_id
GROUP BY CUBE 
	(p.AUTOBUS_ID, EXTRACT(YEAR FROM d.DATA))
;

-- 3a WYSWIETLA ILE NA DANEJ LINII PRZEWIEZIONO OSOB W DANYM ROKU
SELECT 
	NVL(TO_CHAR(l.nazwa_linii),'Wszystkie linie')"NAZWA LINII",
	EXTRACT(YEAR FROM d.DATA) "ROK", 
	sum(ilosc_osob) "ILOSC OSOB"
FROM 
  przejazd p, 
  linia l, 
  data_przejazdu d
WHERE 
	p.linia_id = l.ID
GROUP BY GROUPING SETS(
	(l.nazwa_linii,EXTRACT(YEAR FROM d.DATA)), 
	(EXTRACT(YEAR FROM d.DATA)) 
)
;


-- 3b WYSWIETLA JAKA ODLEGLOSC POKONAL DANY AUTOBUS NA DANEJ LINII
SELECT 
	NVL(TO_CHAR(l.NAZWA_LINII),'Wszystkie linie') "NAZWA LINII",
	NVL(TO_CHAR(p.AUTOBUS_ID),'Wszystkie autobusy') "ID AUTOBUSU", 
	TO_CHAR(sum(p.PRZEBYTA_ODLEGLOSC)||'km') "PRZEBYTA ODLEGLOSC"
FROM 
  przejazd p, 
  linia l 
WHERE 
	p.linia_id = l.ID
GROUP BY GROUPING SETS(
	(p.autobus_id,l.nazwa_linii), 
	(l.nazwa_linii) 
)
;

-- 4a 
--ZYSK DANEJ LINII W DANYM ROKU
SELECT 
  l.nazwa_linii,
  EXTRACT(YEAR FROM d.DATA) "ROK",
  sum(p.cena_przejazdu) OVER (PARTITION BY p.linia_id ORDER BY EXTRACT(YEAR FROM d.DATA) RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) "ZYSK W DANYM ROKU"
FROM
  przejazd p,
  linia l,
  data_przejazdu d
WHERE
  p.linia_id = l.ID
AND
  p.data_przejazdu_id = d.ID
;


--4b
--zestawienie ilosci przejazdow dla danych kierowcow od pocz¹tku rozpoczêcia pracy
SELECT DISTINCT
	p.KIEROWCA_ID,
  k.IMIE,
  k.NAZWISKO,
  EXTRACT(YEAR FROM d.data)"ROK",
  COUNT(p.id) OVER (PARTITION BY p.KIEROWCA_ID ORDER BY EXTRACT(YEAR FROM d.data) RANGE BETWEEN UNBOUNDED PRECEDING and CURRENT row)
FROM
	przejazd p,
  kierowca k,
  data_przejazdu d
WHERE
  p.KIEROWCA_ID=k.ID
AND
  p.DATA_PRZEJAZDU_ID=d.ID
ORDER BY p.KIEROWCA_ID, ROK
;

--5a
--Ranking œrednej liczby pasa¿erów podró¿uj¹cych dan¹ lini¹
SELECT DISTINCT
  DENSE_RANK() OVER (ORDER BY AVG(p.ILOSC_OSOB) DESC) "Miejsce",
  ROUND(AVG(p.ILOSC_OSOB),0) "Œrednia liczba osób",
  l.NAZWA_LINII 
FROM
  PRZEJAZD p,
  linia l
WHERE
 l.ID=p.LINIA_ID 
group by 
  l.NAZWA_LINII;

-- 5b
--Ranking linii która przynios³a najwiêcej dochodu
  
SELECT DISTINCT
  DENSE_RANK() OVER (ORDER BY SUM(p.CENA_PRZEJAZDU) DESC) ,
  ROUND(SUM(p.CENA_PRZEJAZDU),0) ,
  l.NAZWA_LINII 
FROM
  PRZEJAZD p,
  linia l
WHERE
 l.ID=p.LINIA_ID 
group by 
  l.NAZWA_LINII
;

  
SELECT
  przejazd.ID ,
  przejazd.ilosc_osob,
  rank() OVER (PARTITION BY NULL ORDER BY sum(ilosc_osob) DESC) AS "miejsce"
FROM 
  przejazd
GROUP BY 
  przejazd.ID, 
  przejazd.ilosc_osob
;

