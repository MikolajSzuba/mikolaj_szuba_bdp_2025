\c firma

SELECT p.imie, p.nazwisko, g.liczba_godzin AS nadgodziny
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.godziny g ON p.id_pracownika = g.id_pracownika
WHERE g.liczba_godzin >160;