load data
infile 'Linia.csv'
into table Linia
replace
fields terminated by ','
(ID,Nazwa_linii)