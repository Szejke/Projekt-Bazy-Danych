load data
infile 'Marka_autobusu.csv'
into table Marka
replace
fields terminated by ','
(ID,Nazwa)