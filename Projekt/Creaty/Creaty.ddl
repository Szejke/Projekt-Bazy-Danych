-- Generated by Oracle SQL Developer Data Modeler 4.1.5.907
--   at:        2017-03-29 13:52:23 CEST
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g




CREATE TABLE Autobus
  (
    ID             NUMBER NOT NULL ,
    Model_ID       NUMBER NOT NULL ,
    Model_Marka_ID NUMBER NOT NULL
  ) ;
ALTER TABLE Autobus ADD CONSTRAINT Autobus_PK PRIMARY KEY ( ID ) ;


CREATE TABLE Bilet
  ( ID NUMBER NOT NULL , Rodzaj_biletu_ID NUMBER NOT NULL
  ) ;
ALTER TABLE Bilet ADD CONSTRAINT Bilet_PK PRIMARY KEY ( ID ) ;


CREATE TABLE Data_przejazdu
  ( ID NUMBER NOT NULL , Data DATE
  ) ;
ALTER TABLE Data_przejazdu ADD CONSTRAINT Data_przejazdu_PK PRIMARY KEY ( ID ) ;


CREATE TABLE Kierowca
  (
    ID       NUMBER NOT NULL ,
    Imie     VARCHAR2 (30) ,
    Nazwisko VARCHAR2 (30)
  ) ;
ALTER TABLE Kierowca ADD CONSTRAINT Kierowca_PK PRIMARY KEY ( ID ) ;


CREATE TABLE Marka
  ( ID NUMBER NOT NULL , Nazwa VARCHAR2 (30)
  ) ;
ALTER TABLE Marka ADD CONSTRAINT Marka_PK PRIMARY KEY ( ID ) ;


CREATE TABLE Miejscow
  (
    ID             NUMBER NOT NULL ,
    Nazwa          VARCHAR2 (30) ,
    Wojew_Wojew_ID NUMBER NOT NULL
  ) ;
ALTER TABLE Miejscow ADD CONSTRAINT Miejscow_PK PRIMARY KEY ( ID ) ;


CREATE TABLE Model
  (
    ID           NUMBER NOT NULL ,
    Nazwa        VARCHAR2 (30) ,
    Ilosc_Miejsc NUMBER ,
    Marka_ID     NUMBER NOT NULL
  ) ;
ALTER TABLE Model ADD CONSTRAINT Model_PK PRIMARY KEY ( ID, Marka_ID ) ;


CREATE TABLE Przejazd
  (
    ID                 NUMBER NOT NULL ,
    Kierowca_ID        NUMBER NOT NULL ,
    Autobus_ID         NUMBER NOT NULL ,
    Data_przejazdu_ID  NUMBER NOT NULL ,
    Przy_koncowy_ID    NUMBER NOT NULL ,
    Przy_poczatkowy_ID NUMBER NOT NULL ,
    Bilet_ID           NUMBER NOT NULL
  ) ;
ALTER TABLE Przejazd ADD CHECK ( Przy_poczatkowy_ID BETWEEN 1 AND 999999) ;
ALTER TABLE Przejazd ADD CONSTRAINT Przejazd_PK PRIMARY KEY ( ID ) ;


CREATE TABLE Przy_koncowy
  (
    ID            NUMBER NOT NULL ,
    Przystanek_ID NUMBER NOT NULL
  ) ;
ALTER TABLE Przy_koncowy ADD CONSTRAINT Przy_koncowy_PK PRIMARY KEY ( ID ) ;


CREATE TABLE Przy_poczatkowy
  (
    ID            NUMBER NOT NULL ,
    Przystanek_ID NUMBER NOT NULL
  ) ;
ALTER TABLE Przy_poczatkowy ADD CHECK ( ID BETWEEN 1 AND 999999) ;
ALTER TABLE Przy_poczatkowy ADD CONSTRAINT Przy_poczatkowy_PK PRIMARY KEY ( ID ) ;


CREATE TABLE Przystanek
  (
    ID          NUMBER NOT NULL ,
    Nazwa       VARCHAR2 (30) ,
    Miejscow_ID NUMBER NOT NULL ,
    Ulica       VARCHAR2 (30)
  ) ;
ALTER TABLE Przystanek ADD CONSTRAINT Przystanek_PK PRIMARY KEY ( ID ) ;


CREATE TABLE Rodzaj_biletu
  (
    ID             NUMBER NOT NULL ,
    Nazwa          VARCHAR2 (30) ,
    Procent_zni�ki NUMBER
  ) ;
ALTER TABLE Rodzaj_biletu ADD CONSTRAINT Rodzaj_biletu_PK PRIMARY KEY ( ID ) ;


CREATE TABLE Wojew
  (
    ID       NUMBER ,
    Nazwa    VARCHAR2 (30) ,
    Wojew_ID NUMBER NOT NULL
  ) ;
ALTER TABLE Wojew ADD CONSTRAINT Wojew_PK PRIMARY KEY ( Wojew_ID ) ;


ALTER TABLE Autobus ADD CONSTRAINT Autobus_Model_FK FOREIGN KEY ( Model_ID, Model_Marka_ID ) REFERENCES Model ( ID, Marka_ID ) ;

ALTER TABLE Bilet ADD CONSTRAINT Bilet_Rodzaj_biletu_FK FOREIGN KEY ( Rodzaj_biletu_ID ) REFERENCES Rodzaj_biletu ( ID ) ;

ALTER TABLE Miejscow ADD CONSTRAINT Miejscow_Wojew_FK FOREIGN KEY ( Wojew_Wojew_ID ) REFERENCES Wojew ( Wojew_ID ) ;

ALTER TABLE Model ADD CONSTRAINT Model_Marka_FK FOREIGN KEY ( Marka_ID ) REFERENCES Marka ( ID ) ;

ALTER TABLE Przejazd ADD CONSTRAINT Przejazd_Autobus_FK FOREIGN KEY ( Autobus_ID ) REFERENCES Autobus ( ID ) ;

ALTER TABLE Przejazd ADD CONSTRAINT Przejazd_Bilet_FK FOREIGN KEY ( Bilet_ID ) REFERENCES Bilet ( ID ) ;

ALTER TABLE Przejazd ADD CONSTRAINT Przejazd_Data_przejazdu_FK FOREIGN KEY ( Data_przejazdu_ID ) REFERENCES Data_przejazdu ( ID ) ;

ALTER TABLE Przejazd ADD CONSTRAINT Przejazd_Kierowca_FK FOREIGN KEY ( Kierowca_ID ) REFERENCES Kierowca ( ID ) ;

ALTER TABLE Przejazd ADD CONSTRAINT Przejazd_Przy_koncowy_FK FOREIGN KEY ( Przy_koncowy_ID ) REFERENCES Przy_koncowy ( ID ) ;

ALTER TABLE Przejazd ADD CONSTRAINT Przejazd_Przy_poczatkowy_FK FOREIGN KEY ( Przy_poczatkowy_ID ) REFERENCES Przy_poczatkowy ( ID ) ;

ALTER TABLE Przy_koncowy ADD CONSTRAINT Przy_koncowy_Przystanek_FK FOREIGN KEY ( Przystanek_ID ) REFERENCES Przystanek ( ID ) ;

ALTER TABLE Przy_poczatkowy ADD CONSTRAINT Przy_poczatkowy_Przystanek_FK FOREIGN KEY ( Przystanek_ID ) REFERENCES Przystanek ( ID ) ;

ALTER TABLE Przystanek ADD CONSTRAINT Przystanek_Miejscow_FK FOREIGN KEY ( Miejscow_ID ) REFERENCES Miejscow ( ID ) ;

CREATE SEQUENCE Wojew_Wojew_ID_SEQ START WITH 1 NOCACHE ORDER ;
CREATE OR REPLACE TRIGGER Wojew_Wojew_ID_TRG BEFORE
  INSERT ON Wojew FOR EACH ROW WHEN (NEW.Wojew_ID IS NULL) BEGIN :NEW.Wojew_ID := Wojew_Wojew_ID_SEQ.NEXTVAL;
END;
/


-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            13
-- CREATE INDEX                             0
-- ALTER TABLE                             28
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           1
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          1
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
