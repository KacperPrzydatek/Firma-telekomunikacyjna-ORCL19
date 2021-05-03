/*
Created: 2021-04-25
Modified: 2021-04-26
Model: Logical model
Database: Oracle 19c
*/


-- Create tables section -------------------------------------------------

-- Table Firma

CREATE TABLE "Firma"(
  "ID_firmy" Integer NOT NULL,
  "Nazwa" Varchar2(50 ) NOT NULL,
  "Data_zalozenia" Date NOT NULL,
  "NIP" Varchar2(11 ) NOT NULL,
  "Nr_telefonu" Varchar2(9 ) NOT NULL,
  "Strona_www" Varchar2(300 )
)
/

-- Add keys for table Firma

ALTER TABLE "Firma" ADD CONSTRAINT "Firma_PK" PRIMARY KEY ("ID_firmy")
/

-- Table Oddzial

CREATE TABLE "Oddzial"(
  "ID_oddzialu" Integer NOT NULL,
  "Nr_telefonu" Varchar2(9 ) NOT NULL,
  "ID_firmy" Integer NOT NULL,
  "ID_adresu" Integer
)
/

-- Create indexes for table Oddzial

CREATE INDEX "IX_Firma_ma_oddzial" ON "Oddzial" ("ID_firmy")
/

CREATE INDEX "IX_Relationship2" ON "Oddzial" ("ID_adresu")
/

-- Add keys for table Oddzial

ALTER TABLE "Oddzial" ADD CONSTRAINT "Oddzial_PK" PRIMARY KEY ("ID_oddzialu")
/

-- Table Biuro

CREATE TABLE "Biuro"(
  "Liczba_segmentow" Integer NOT NULL,
  "Liczba_miejsc_pracy" Integer NOT NULL,
  "ID_oddzialu" Integer NOT NULL
)
/

-- Add keys for table Biuro

ALTER TABLE "Biuro" ADD CONSTRAINT "Unique_Identifier1" PRIMARY KEY ("ID_oddzialu")
/

-- Table Hangar_techniczny

CREATE TABLE "Hangar_techniczny"(
  "Powierzchnia" Integer NOT NULL,
  "Liczba_pojazdow" Integer,
  "ID_oddzialu" Integer NOT NULL
)
/

-- Add keys for table Hangar_techniczny

ALTER TABLE "Hangar_techniczny" ADD CONSTRAINT "Unique_Identifier2" PRIMARY KEY ("ID_oddzialu")
/

-- Table Usluga

CREATE TABLE "Usluga"(
  "ID_uslugi" Integer NOT NULL,
  "Typ_uslugi" Varchar2(300 ) NOT NULL
        CHECK (Usluga_telekomunikacyjna IN ('Internet_300Mbps', 'Internet_900Mbps', 'Internet_ADSL_120_20')),
  "Cena_uslugi" Number(10,2) NOT NULL,
  "ID_firmy" Integer NOT NULL
)
/

-- Create indexes for table Usluga

CREATE INDEX "IX_Zapewnia" ON "Usluga" ("ID_firmy")
/

-- Add keys for table Usluga

ALTER TABLE "Usluga" ADD CONSTRAINT "Usluga_PK" PRIMARY KEY ("ID_uslugi")
/

-- Table Pracownik

CREATE TABLE "Pracownik"(
  "ID_pracownika" Integer NOT NULL,
  "Imie" Varchar2(50 ) NOT NULL,
  "Drugie_imie" Varchar2(50 ),
  "Nazwisko" Varchar2(50 ) NOT NULL,
  "PESEL" Varchar2(11 ),
  "Plec" Varchar2(30 ) NOT NULL
        CONSTRAINT "CheckConstraintA1" CHECK (Plec IN ('Kobieta', 'Mezczyzna'))
        CHECK (Plec IN ('Kobieta', 'Mezczyzna')),
  "Nr_telefonu" Varchar2(9 ) NOT NULL,
  "Zarobki_brutto" Number(10,2) NOT NULL,
  "Data_zatrudnienia" Date NOT NULL,
  "ID_firmy" Integer NOT NULL,
  "ID_oddzialu" Integer NOT NULL,
  "ID_adresu" Integer
)
/

-- Create indexes for table Pracownik

CREATE INDEX "IX_Zatrudnia" ON "Pracownik" ("ID_firmy")
/

CREATE INDEX "IX_Przynalezy" ON "Pracownik" ("ID_oddzialu")
/

CREATE INDEX "IX_Relationship1" ON "Pracownik" ("ID_adresu")
/

-- Add keys for table Pracownik

ALTER TABLE "Pracownik" ADD CONSTRAINT "Pracownik_PK" PRIMARY KEY ("ID_pracownika")
/

-- Table Monter

CREATE TABLE "Monter"(
  "Nr_licencji" Integer NOT NULL,
  "Prawo_jazdy" Char(1 ) NOT NULL,
  "ID_pracownika" Integer NOT NULL
)
/

-- Add keys for table Monter

ALTER TABLE "Monter" ADD CONSTRAINT "Unique_Identifier5" PRIMARY KEY ("ID_pracownika")
/

-- Table Pracownik_biurowy

CREATE TABLE "Pracownik_biurowy"(
  "Nr_stanowiska" Integer NOT NULL,
  "Nr_pietra" Integer,
  "ID_pracownika" Integer NOT NULL
)
/

-- Add keys for table Pracownik_biurowy

ALTER TABLE "Pracownik_biurowy" ADD CONSTRAINT "Unique_Identifier6" PRIMARY KEY ("ID_pracownika")
/

-- Table Klient

CREATE TABLE "Klient"(
  "ID_klienta" Integer NOT NULL,
  "Imie" Varchar2(50 ) NOT NULL,
  "Drugie_imie" Varchar2(50 ),
  "Nazwisko" Varchar2(50 ) NOT NULL,
  "PESEL" Varchar2(11 ),
  "Plec" Varchar2(30 ) NOT NULL
        CHECK (Plec IN ('Kobieta', 'Mezczyzna')),
  "Nr_telefonu" Varchar2(9 ) NOT NULL,
  "ID_firmy" Integer NOT NULL,
  "ID_adresu" Integer
)
/

-- Create indexes for table Klient

CREATE INDEX "IX_Firma_ma_klienta" ON "Klient" ("ID_firmy")
/

CREATE INDEX "IX_Relationship4" ON "Klient" ("ID_adresu")
/

-- Add keys for table Klient

ALTER TABLE "Klient" ADD CONSTRAINT "Klient_PK" PRIMARY KEY ("ID_klienta")
/

-- Table Punkt_komunikacyjny

CREATE TABLE "Punkt_komunikacyjny"(
  "ID_punktu" Integer NOT NULL,
  "ID_firmy" Integer NOT NULL,
  "ID_adresu" Integer
)
/

-- Create indexes for table Punkt_komunikacyjny

CREATE INDEX "IX_Firma_ma_punkt" ON "Punkt_komunikacyjny" ("ID_firmy")
/

CREATE INDEX "IX_Relationship3" ON "Punkt_komunikacyjny" ("ID_adresu")
/

-- Add keys for table Punkt_komunikacyjny

ALTER TABLE "Punkt_komunikacyjny" ADD CONSTRAINT "Punkt_komunikacyjny_PK" PRIMARY KEY ("ID_punktu")
/

-- Table Antena

CREATE TABLE "Antena"(
  "Wysokosc_NPM" Integer NOT NULL,
  "Zasieg" Integer NOT NULL,
  "Wzmocnienie" Integer NOT NULL,
  "ID_punktu" Integer NOT NULL
)
/

-- Add keys for table Antena

ALTER TABLE "Antena" ADD CONSTRAINT "Unique_Identifier7" PRIMARY KEY ("ID_punktu")
/

-- Table Wezel_komutacyjny

CREATE TABLE "Wezel_komutacyjny"(
  "Liczba_portow" Integer NOT NULL,
  "Wersja_oprogramowania" Varchar2(40 ) NOT NULL,
  "ID_punktu" Integer NOT NULL
)
/

-- Add keys for table Wezel_komutacyjny

ALTER TABLE "Wezel_komutacyjny" ADD CONSTRAINT "Unique_Identifier8" PRIMARY KEY ("ID_punktu")
/

-- Table Umowa

CREATE TABLE "Umowa"(
  "ID_uslugi" Integer NOT NULL,
  "ID_klienta" Integer NOT NULL,
  "Data_zawarcia_umowy" Date NOT NULL,
  "Data_zakonczenia_umowy" Date NOT NULL
)
/

-- Table Adresy

CREATE TABLE "Adresy"(
  "ID_adresu" Integer NOT NULL,
  "Ulica" Char(50 ) NOT NULL,
  "Miasto" Char(50 ) NOT NULL,
  "Kod_pocztowy" Char(5 ) NOT NULL
)
/

-- Add keys for table Adresy

ALTER TABLE "Adresy" ADD CONSTRAINT "PK_Adresy" PRIMARY KEY ("ID_adresu")
/

-- Table Uslugi_do_punktow_MN

CREATE TABLE "Uslugi_do_punktow_MN"(
  "ID_punktu" Integer NOT NULL,
  "ID_uslugi" Integer NOT NULL
)
/

-- Add keys for table Uslugi_do_punktow_MN

ALTER TABLE "Uslugi_do_punktow_MN" ADD CONSTRAINT "PK_Uslugi_do_punktow_MN" PRIMARY KEY ("ID_punktu","ID_uslugi")
/


-- Create foreign keys (relationships) section ------------------------------------------------- 

ALTER TABLE "Oddzial" ADD CONSTRAINT "Firma_ma_oddzial" FOREIGN KEY ("ID_firmy") REFERENCES "Firma" ("ID_firmy")
/



ALTER TABLE "Pracownik" ADD CONSTRAINT "Zatrudnia" FOREIGN KEY ("ID_firmy") REFERENCES "Firma" ("ID_firmy")
/



ALTER TABLE "Punkt_komunikacyjny" ADD CONSTRAINT "Firma_ma_punkt" FOREIGN KEY ("ID_firmy") REFERENCES "Firma" ("ID_firmy")
/



ALTER TABLE "Usluga" ADD CONSTRAINT "Firma_zapewnia_usluge" FOREIGN KEY ("ID_firmy") REFERENCES "Firma" ("ID_firmy")
/



ALTER TABLE "Klient" ADD CONSTRAINT "Firma_ma_klienta" FOREIGN KEY ("ID_firmy") REFERENCES "Firma" ("ID_firmy")
/



ALTER TABLE "Pracownik" ADD CONSTRAINT "Przynalezy" FOREIGN KEY ("ID_oddzialu") REFERENCES "Oddzial" ("ID_oddzialu")
/



ALTER TABLE "Pracownik" ADD CONSTRAINT "Adres_pracownika" FOREIGN KEY ("ID_adresu") REFERENCES "Adresy" ("ID_adresu")
/



ALTER TABLE "Oddzial" ADD CONSTRAINT "Adres_oddzialu" FOREIGN KEY ("ID_adresu") REFERENCES "Adresy" ("ID_adresu")
/



ALTER TABLE "Punkt_komunikacyjny" ADD CONSTRAINT "Adres_punktuKom" FOREIGN KEY ("ID_adresu") REFERENCES "Adresy" ("ID_adresu")
/



ALTER TABLE "Klient" ADD CONSTRAINT "Adres_klienta" FOREIGN KEY ("ID_adresu") REFERENCES "Adresy" ("ID_adresu")
/



ALTER TABLE "Uslugi_do_punktow_MN" ADD CONSTRAINT "Dekompozycja_punktow_do_uslug" FOREIGN KEY ("ID_punktu") REFERENCES "Punkt_komunikacyjny" ("ID_punktu")
/



ALTER TABLE "Uslugi_do_punktow_MN" ADD CONSTRAINT "Dekompozycja_uslug_do_punktow" FOREIGN KEY ("ID_uslugi") REFERENCES "Usluga" ("ID_uslugi")
/





