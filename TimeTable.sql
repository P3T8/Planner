
-- Adatbázis újralétrehozása: ha már létezik, töröljük
DROP DATABASE IF EXISTS TimeTable;
CREATE DATABASE TimeTable;
USE TimeTable;

-- Tantárgyak tábla
CREATE TABLE Tantargyak (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nev VARCHAR(100) NOT NULL,
    TanarID INT,
    FOREIGN KEY (TanarID) REFERENCES Tanarok(ID)
);

-- Tanárok tábla
CREATE TABLE Tanarok (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nev VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

-- Osztályok tábla
CREATE TABLE Osztalyok (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nev VARCHAR(50) NOT NULL,
    Evfolyam INT NOT NULL
);

-- Óra állapot tábla
CREATE TABLE Allapot (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nev ENUM('elmarad', 'helyettesített', 'van') NOT NULL,
    Megjegyzes TEXT
);

-- Órarend tábla
CREATE TABLE Orarend (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    OsztalyID INT,
    TantargyID INT,
    TanarID INT,
    Nap ENUM('hetfo', 'kedd', 'szerda', 'csutortok', 'pentek') NOT NULL,
    OraKezdes TIME NOT NULL,
    OraVege TIME NOT NULL,
    AllapotID INT,
    FOREIGN KEY (OsztalyID) REFERENCES Osztalyok(ID),
    FOREIGN KEY (TantargyID) REFERENCES Tantargyak(ID),
    FOREIGN KEY (TanarID) REFERENCES Tanarok(ID),
    FOREIGN KEY (AllapotID) REFERENCES Allapot(ID)
);
