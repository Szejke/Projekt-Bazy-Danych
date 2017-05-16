load data
infile 'D:\BD projekt.GIT\CSV CTL\Kierowca.csv'
into table Kierowca
replace
fields terminated by ','
(ID,Imie,Nazwisko)