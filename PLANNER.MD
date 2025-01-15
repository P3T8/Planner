
# TimeTable Adatbázis Dokumentáció

## Bevezetés

A **TimeTable** egy iskolai órarend-kezelő adatbázis, amely tanárok, tantárgyak, osztályok és órarendek nyilvántartására szolgál.  
A célja, hogy az oktatási intézmények könnyedén kezelhessék az órarendet, az órák állapotát (elmarad, helyettesített, van), 
és a kapcsolódó adatokat egy jól strukturált adatbázisban tárolják.

### Kinek szól ez a program?

Ez a rendszer kifejezetten az oktatási intézmények, például középiskolák számára készült, 
de alkalmazható magántanárok vagy más oktatási szolgáltatók számára is.

---

## Adatbázis felépítése

### Tábla leírások és kód

#### 1. **Tanárok tábla**
Ez a tábla a tanárok nevét és elérhetőségeit tárolja.

```sql
CREATE TABLE Tanarok (
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- Egyedi azonosító a tanároknak
    Nev VARCHAR(100) NOT NULL, -- Tanár neve
    Email VARCHAR(100) NOT NULL -- Tanár email címe
);
```
- **Fejlesztési lehetőség**: Érdemes a tanárok elérhetőségeihez további adatokat (telefonszám, cím) hozzáadni.

#### 2. **Tantárgyak tábla**
A tantárgyak listáját és azok tanárait tartalmazza.

```sql
CREATE TABLE Tantargyak (
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- Egyedi azonosító a tantárgyaknak
    Nev VARCHAR(100) NOT NULL, -- Tantárgy neve
    TanarID INT UNSIGNED, -- Kapcsolat a tanárokkal
    FOREIGN KEY (TanarID) REFERENCES Tanarok(ID) ON DELETE CASCADE -- Külső kulcs a Tanarok táblához
);
```
- **Fejlesztési lehetőség**: Több tanárt is hozzá lehessen rendelni egy tantárgyhoz (pl. csoportos órák esetén).

#### 3. **Osztályok tábla**
Az osztályokat és évfolyamokat tartja nyilván.

```sql
CREATE TABLE Osztalyok (
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- Egyedi azonosító az osztályoknak
    Nev VARCHAR(50) NOT NULL, -- Osztály neve
    Evfolyam INT NOT NULL -- Évfolyam száma
);
```
- **Fejlesztési lehetőség**: Az osztályokhoz órarendeket vagy tanulók listáját is hozzá lehetne kötni.

#### 4. **Óra állapot tábla**
Az órák állapotát jelöli (elmarad, helyettesített, van).

```sql
CREATE TABLE Allapot (
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- Egyedi azonosító az állapotoknak
    Nev ENUM('elmarad', 'helyettesített', 'van') NOT NULL, -- Az állapot típusa
    Megjegyzes TEXT -- Opcionális magyarázat
);
```
- **Fejlesztési lehetőség**: További állapotok bevezetése, például „késik” vagy „vizsga”.

#### 5. **Órarend tábla**
Az órarend elemei, amelyek összekapcsolják az osztályokat, tantárgyakat és tanárokat az adott időpontokkal.

```sql
CREATE TABLE Orarend (
    ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, -- Egyedi azonosító az órarendi bejegyzéseknek
    OsztalyID INT UNSIGNED, -- Kapcsolat az osztályokkal
    TantargyID INT UNSIGNED, -- Kapcsolat a tantárgyakkal
    TanarID INT UNSIGNED, -- Kapcsolat a tanárokkal
    Nap ENUM('hetfo', 'kedd', 'szerda', 'csutortok', 'pentek') NOT NULL, -- Az óra napja
    OraKezdes TIME NOT NULL, -- Óra kezdete
    OraVege TIME NOT NULL, -- Óra vége
    AllapotID INT UNSIGNED, -- Kapcsolat az óra állapotával
    FOREIGN KEY (OsztalyID) REFERENCES Osztalyok(ID) ON DELETE CASCADE,
    FOREIGN KEY (TantargyID) REFERENCES Tantargyak(ID) ON DELETE CASCADE,
    FOREIGN KEY (TanarID) REFERENCES Tanarok(ID) ON DELETE CASCADE,
    FOREIGN KEY (AllapotID) REFERENCES Allapot(ID) ON DELETE CASCADE
);
```
- **Fejlesztési lehetőség**: Hozzáadható a termek nyilvántartása, hogy a teremfoglalások is kezelhetők legyenek.

---

## Fejlesztési lehetőségek összefoglalása

1. **Több tanár hozzárendelése egy tantárgyhoz.**
2. **Tanulók nyilvántartása és az osztályokhoz való rendelése.**
3. **Termek kezelése az órarendben.**
4. **További állapotok bevezetése az órákhoz (pl. „vizsga” vagy „késik”).**
5. **Többnyelvű támogatás (pl. angol és magyar nyelvű adatok).**
6. **Interfész létrehozása az adatbázis használatához egy webalkalmazásban.**

---

Ez a dokumentáció segít megérteni a TimeTable adatbázis szerkezetét, és alapot ad a további fejlesztésekhez.
