load data
infile 'D:\BD projekt.GIT\CSV CTL\autobus.csv'
into table Autobus
replace
fields terminated by ','
(ID,Model_ID,Rok_produkcji)