\c firma

SELECT *
FROM ksiegowosc.pracownicy
WHERE imie LIKE '%a' AND
(nazwisko ILIKE '%n%');