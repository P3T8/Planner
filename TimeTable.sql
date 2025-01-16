-- Adatbázis újralétrehozása: ha már létezik, töröljük
DROP DATABASE IF EXISTS TimeTable;
CREATE DATABASE TimeTable;
USE TimeTable;

-- Tanárok tábla
CREATE TABLE Tanarok (
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nev VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL
);

-- Tantárgyak tábla
CREATE TABLE Tantargyak (
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nev VARCHAR(100) NOT NULL
);

-- Osztályok tábla
CREATE TABLE Osztalyok (
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nev VARCHAR(50) NOT NULL,
    Evfolyam INT NOT NULL
);

-- Óra állapot tábla
CREATE TABLE Allapot (
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Nev ENUM('elmarad', 'helyettesített', 'van') NOT NULL,
    Megjegyzes TEXT
);

-- Órarend tábla
CREATE TABLE Orarend (
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    OsztalyID INT UNSIGNED,
    TantargyID INT UNSIGNED,
    TanarID INT UNSIGNED,
    Nap ENUM('hetfo', 'kedd', 'szerda', 'csutortok', 'pentek') NOT NULL,
    OraKezdes TIME NOT NULL,
    OraVege TIME NOT NULL,
    AllapotID INT UNSIGNED,
    FOREIGN KEY (OsztalyID) REFERENCES Osztalyok(ID) ON DELETE CASCADE,
    FOREIGN KEY (TantargyID) REFERENCES Tantargyak(ID) ON DELETE CASCADE,
    FOREIGN KEY (TanarID) REFERENCES Tanarok(ID) ON DELETE CASCADE,
    FOREIGN KEY (AllapotID) REFERENCES Allapot(ID) ON DELETE CASCADE
);

-- Tanárok adatok feltöltése
INSERT INTO Tanarok (Nev, Email) VALUES
('Kiss Péter', 'kiss.peter@example.com'),
('Nagy Ágnes', 'nagy.agnes@example.com'),
('Tóth László', 'toth.laszlo@example.com');

-- Tantárgyak adatok feltöltése
INSERT INTO Tantargyak (Nev) VALUES
('Matematika'),
('Fizika'),
('Biológia'),
('Kémia');

-- Osztályok adatok feltöltése
INSERT INTO Osztalyok (Nev, Evfolyam) VALUES
('10.A', 10),
('11.B', 11),
('12.C', 12);

-- Óra állapot adatok feltöltése
INSERT INTO Allapot (Nev, Megjegyzes) VALUES
('van', 'Óra megtartva'),
('elmarad', 'Betegség miatt elmarad'),
('helyettesített', 'Másik tanár helyettesítette');

-- Órarend adatok feltöltése
INSERT INTO Orarend (OsztalyID, TantargyID, TanarID, Nap, OraKezdes, OraVege, AllapotID) VALUES
(1, 1, 1, 'hetfo', '08:00:00', '08:45:00', 1),
(1, 2, 2, 'hetfo', '09:00:00', '09:45:00', 3),
(2, 3, 3, 'kedd', '10:00:00', '10:45:00', 1),
(3, 4, 1, 'szerda', '11:00:00', '11:45:00', 2),
(2, 2, 2, 'csutortok', '08:00:00', '08:45:00', 1);
