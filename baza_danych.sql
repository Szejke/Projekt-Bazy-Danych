CREATE TABLE Autobus
 ( 
	ID 					NUMBER NOT NULL ,
	Model_ID 			NUMBER NOT NULL
 ) ;
ALTER TABLE Autobus ADD CONSTRAINT Autobus_PK PRIMARY KEY ( ID ) ;

CREATE TABLE Data_przejazdu
( 
	ID 					NUMBER NOT NULL ,
	Data 				DATE
) ;
ALTER TABLE Data_przejazdu ADD CONSTRAINT Data_przejazdu_PK PRIMARY KEY ( ID ) ;


CREATE TABLE Kierowca
(
    ID       			NUMBER NOT NULL ,
    Imie     			VARCHAR2 (30) ,
    Nazwisko 			VARCHAR2 (30)
) ;
ALTER TABLE Kierowca ADD CONSTRAINT Kierowca_PK PRIMARY KEY ( ID ) ;


CREATE TABLE Linia
( 
	ID 					NUMBER NOT NULL , 
	Nazwa_linii 		VARCHAR2 (20)
) ;
ALTER TABLE Linia ADD CONSTRAINT Linia_PK PRIMARY KEY ( ID ) ;


CREATE TABLE Marka
( 
	ID 					NUMBER NOT NULL ,
	Nazwa 				VARCHAR2 (30)
) ;
ALTER TABLE Marka ADD CONSTRAINT Marka_PK PRIMARY KEY ( ID ) ;


CREATE TABLE Model
(
    ID           		NUMBER NOT NULL ,
    Marka_ID     		NUMBER NOT NULL ,
    Ilosc_Miejsc 		NUMBER ,
    Nazwa        		VARCHAR2 (30)
) ;
ALTER TABLE Model ADD CONSTRAINT Model_PK PRIMARY KEY ( ID ) ;


CREATE TABLE Przejazd
  (
    ID                 NUMBER NOT NULL ,
    Kierowca_ID        NUMBER NOT NULL ,
    Autobus_ID         NUMBER NOT NULL ,
    Data_przejazdu_ID  NUMBER NOT NULL ,
    Rodzaj_Biletu_ID   NUMBER NOT NULL ,
    Linia_ID           NUMBER NOT NULL ,
    Przebyta_odleglosc NUMBER ,
    Cena_przejazdu     NUMBER ,
    Oblozenie          NUMBER ,
    Ilosc_osob         NUMBER
  ) ;
ALTER TABLE Przejazd ADD CONSTRAINT Przejazd_PK PRIMARY KEY ( ID ) ;


CREATE TABLE Rodzaj_biletu
  (
    ID             		NUMBER NOT NULL ,
    Nazwa          		VARCHAR2 (30) ,
    Procent_zniżki 		NUMBER NOT NULL
  ) ;
ALTER TABLE Rodzaj_biletu ADD CONSTRAINT Rodzaj_biletu_PK PRIMARY KEY ( ID ) ;


ALTER TABLE Autobus ADD CONSTRAINT Autobus_Model_FK FOREIGN KEY ( Model_ID ) REFERENCES Model ( ID ) ;

ALTER TABLE Model ADD CONSTRAINT Model_Marka_FK FOREIGN KEY ( Marka_ID ) REFERENCES Marka ( ID ) ;

ALTER TABLE Przejazd ADD CONSTRAINT Przejazd_Autobus_FK FOREIGN KEY ( Autobus_ID ) REFERENCES Autobus ( ID ) ;

ALTER TABLE Przejazd ADD CONSTRAINT Przejazd_R_Bilet_FK FOREIGN KEY ( Rodzaj_Biletu_ID ) REFERENCES Rodzaj_Biletu ( ID ) ;

ALTER TABLE Przejazd ADD CONSTRAINT Przejazd_Data_przejazdu_FK FOREIGN KEY ( Data_przejazdu_ID ) REFERENCES Data_przejazdu ( ID ) ;

ALTER TABLE Przejazd ADD CONSTRAINT Przejazd_Kierowca_FK FOREIGN KEY ( Kierowca_ID ) REFERENCES Kierowca ( ID ) ;

ALTER TABLE Przejazd ADD CONSTRAINT Przejazd_Linia_FK FOREIGN KEY ( Linia_ID ) REFERENCES Linia ( ID ) ;
