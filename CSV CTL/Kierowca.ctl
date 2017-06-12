load data
infile 'Kierowca.csv'
into table Kierowca
replace
fields terminated by ','
(ID,Imie,Nazwisko)