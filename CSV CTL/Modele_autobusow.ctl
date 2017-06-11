load data
infile 'D:\BD projekt.GIT\CSV CTL\Modele_autobusow.csv'
into table Model
replace
fields terminated by ','
(ID,Nazwa,Ilosc_Miejsc,Marka_ID)