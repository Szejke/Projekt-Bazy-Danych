load data
infile 'data_przejazdu.csv'
into table Data_przejazdu
replace
fields terminated by ','
(ID,
Data DATE "dd-mm-yyyy"
)