load data
infile 'autobus.csv'
into table Autobus
replace
fields terminated by ','
(ID,Model_ID,Rok_produkcji)