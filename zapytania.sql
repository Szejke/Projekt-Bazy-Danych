
--WYSWIETLA ILE DANY KIEROWCA W DANYM ROKU ZROBIL KILOMETROW
SELECT 
	p.kierowca_id, 
	EXTRACT(YEAR FROM d.DATA) "ROK", 
	sum(p.przebyta_odleglosc) "Pokonana odleglosc"
FROM 
	przejazd p,
	data_przejazdu d 
WHERE 
	p.data_przejazdu_id=d.ID
GROUP BY ROLLUP 
	(p.kierowca_id, EXTRACT(YEAR FROM d.DATA))
;

--WYSWIETLA ILE DANY AUTOBUS W DANYM ROKU ZROBIL KILOMETROW
SELECT 
	p.AUTOBUS_ID, 
	EXTRACT(YEAR FROM d.DATA) "ROK", 
	sum(p.przebyta_odleglosc) "Pokonana odleglosc"
FROM 
	przejazd p,
	data_przejazdu d 
WHERE 
	p.data_przejazdu_id=d.ID
GROUP BY ROLLUP 
	(p.AUTOBUS_ID, EXTRACT(YEAR FROM d.DATA))

--WYSWIETLA ILE DANA LINIA W DANYM ROKU PRZYNIOSLA DOCHODU
SELECT 
	l.nazwa_linii, 
	EXTRACT(YEAR FROM d.DATA) "ROK", 
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

--WYSWIETLA ILE DANY AUTOBUS W DANYM ROKU PRZYNIOSL DOCHODU

SELECT 
	p.AUTOBUS_ID, 
	EXTRACT(YEAR FROM d.DATA) "ROK", 
	sum (p.cena_przejazdu) "DOCHÓD"
FROM 
	przejazd p,  
	data_przejazdu d
WHERE 
	d.ID = p.data_przejazdu_id
GROUP BY CUBE 
	(p.AUTOBUS_ID, EXTRACT(YEAR FROM d.DATA))
;

--WYSWIETLA ILE NA DANEJ LINII PRZEWIEZIONO OSOB W DANYM ROKU
SELECT 
	l.nazwa_linii,
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


-- WYSWIETLA JAKA ODLEGLOSC POKONAL DANY AUTOBUS NA DANEJ LINII
SELECT 
	l.NAZWA_LINII,
	p.AUTOBUS_ID, 
	sum(p.PRZEBYTA_ODLEGLOSC) "PRZEBYTA ODLEGLOSC W km"
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



SELECT 
  l.nazwa_linii, 
  d.DATA ,
  p.ilosc_osob, 
  sum(ilosc_osob) OVER (PARTITION BY l.nazwa_linii) "SUMA ILOSC OSOB", 
  round(p.ilosc_osob*100 /  m.ilosc_miejsc  )||'%' "PROCENT ZAJETYCH MIEJSC",
  m.ilosc_miejsc 
FROM 
  przejazd p, 
  data_przejazdu d, 
  linia l, 
  autobus A, 
  MODEL m
WHERE 
  d.ID = p.data_przejazdu_id
AND 
  l.ID = p.linia_id
AND 
  A.ID = p.autobus_id
AND 
  m.ID = A.model_id
ORDER BY 
  l.nazwa_linii
;

SELECT 
  l.nazwa_linii,
  EXTRACT(YEAR FROM d.DATA) "ROK",
  p.cena_przejazdu,
  sum(p.cena_przejazdu) OVER (PARTITION BY p.linia_id ORDER BY EXTRACT(YEAR FROM d.DATA) RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) "ZYSK"
FROM
  przejazd p,
  linia l,
  data_przejazdu d
WHERE
  p.linia_id = l.ID
AND
  p.data_przejazdu_id = d.ID
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