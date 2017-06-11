load data
infile 'D:\BD projekt.GIT\CSV CTL\Kierowca.csv'
into table Linia
replace
fields terminated by ','
(ID,Nazwa_linii)