--IN2090 oblig2

--DEL 1

--Oppgave 2a
SELECT navn
FROM Planet 
WHERE stjerne = 'Proxima Centauri';
--Svar: 2 planeter

--Oppgave 2b
SELECT DISTINCT oppdaget
FROM Planet
WHERE stjerne = 'TRAPPIST-1' OR stjerne = 'Kepler-154';
--Svar: 4 rader.

--Oppgave 2c
SELECT COUNT(navn)
FROM Planet
WHERE masse IS NULL;
--Svar: 3424

--Oppgave 2d
SELECT navn, masse
FROM Planet
WHERE oppdaget = '2020' AND masse >
    (SELECT AVG(masse)
    FROM Planet);
--Svar: 19 rader

--Oppgave 2e
SELECT max(oppdaget) - min(oppdaget) AS Oppgave2e
FROM Planet;
--Svar: 34

--Oppgace 3a
SELECT navn AS Mulige_hjemplaneter_modell_a
FROM Planet INNER JOIN Materie ON navn = planet
WHERE masse > 3 AND masse < 10 AND molekyl = 'H2O';
--svar: 6 rader

--Oppgave 3b
SELECT DISTINCT p.navn AS Mulige_hjemplaneter_modell_b
FROM Planet AS p 
    INNER JOIN Materie AS m ON m.planet = p.navn
    INNER JOIN Stjerne AS s ON p.stjerne = s.navn
WHERE molekyl LIKE '%H%' AND s.avstand < s.masse*12;
--svar: 2 planeter

--Oppgave 3c
--SELECT p1.navn, p1.stjerne, p1.masse, p2.navn, p2.stjerne, p2.masse, s.avstand, s.masse AS stjerne_masse
SELECT p1.navn AS Mulige_hjemplaneter_modell_c
FROM Planet AS p1
    INNER JOIN Planet AS p2 ON p1.stjerne = p2.stjerne AND p1.navn != p2.navn
    INNER JOIN Stjerne AS s ON p1.stjerne = s.navn
WHERE p1.masse > 10 AND p2.masse > 10 AND s.avstand < 50;
--svar: 4 planeter

/*
Oppgave 4
Her har Nils brukt NATURAL JOIN, det fungerer ikke siden da forsoker sql
aa joine der Planet.navn = Stjerne.navn og de er aldri like.
Han boer heller bruke INNER JOIN paa Stjerne og joine der stjerne.navn = planet.stjerne.
*/
SELECT oppdaget AS Oppgave4_planet_oppdaget
FROM planet 
    INNER JOIN stjerne ON stjerne.navn = planet.stjerne
WHERE avstand > 8000;

--DEL 2 

--Oppgave 5a
INSERT INTO Stjerne
VALUES ('Sola', 0, 1);

--Oppgave5b
INSERT INTO Planet
VALUES ('Jorda', 0.003146, NULL, 'Sola');

--Oppgave 6
CREATE TABLE observasjon(
    oberservasjons_id SERIAL PRIMARY KEY, --Tenker at det her er praktisk aa bruke SERIAL saa garanterer man aa faa neste unike heltall.
    tidspunkt timestamp NOT NULL,
    planet text NOT NULL REFERENCES Planet(navn), -- Maa det defineres hvilket skjema ogsaa?
    kommentar text DEFAULT NULL --Tranger det aa staa default null her?
);