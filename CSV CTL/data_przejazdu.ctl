load data
infile 'D:\BD projekt.GIT\CSV CTL\data_przejazdu.csv'
into table Data_przejazdu
replace
fields terminated by ','
(ID,
Data DATE "dd-mm-yyyy"
)