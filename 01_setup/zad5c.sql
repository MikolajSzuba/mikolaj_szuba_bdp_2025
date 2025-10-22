\c firma

SELECT id_pracownika
FROM  ksiegowosc.wynagrodzenie w
JOIN ksiegowosc.pensja p ON w.id_pensji = p.id_pensji
LEFT JOIN ksiegowosc.premia pr ON w.id_premii = pr.id_premii
WHERE p.kwota >2000 AND (pr.kwota IS NULL);