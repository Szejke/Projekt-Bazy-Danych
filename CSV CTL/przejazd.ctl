load data
infile 'przejazd.csv'
into table Przejazd
replace
fields terminated by ','
(ID,Kierowca_ID,Autobus_ID,Data_przejazdu_ID,Linia_ID,Przebyta_odleglosc,Cena_przejazdu,Oblozenie,Ilosc_osob)