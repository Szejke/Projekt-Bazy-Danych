load data
infile 'D:\BD projekt.GIT\CSV CTL\Marka_autobusu.csv'
into table Marka
replace
fields terminated by ','
(ID,Nazwa)