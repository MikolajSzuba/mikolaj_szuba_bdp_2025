\c firma;

CREATE TABLE ksiegowosc.pracownicy (
    id_pracownika SERIAL PRIMARY KEY,
    imie VARCHAR(30) NOT NULL,
    nazwisko VARCHAR(40) NOT NULL,
    adres VARCHAR(100),
    telefon VARCHAR(15)
);
COMMENT ON TABLE ksiegowosc.pracownicy IS 'Dane pracowników.';

CREATE TABLE ksiegowosc.godziny (
    id_godziny SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    liczba_godzin DECIMAL(5,2) NOT NULL CHECK (liczba_godzin >= 0),
    id_pracownika INT NOT NULL REFERENCES ksiegowosc.pracownicy(id_pracownika) ON DELETE CASCADE
);
COMMENT ON TABLE ksiegowosc.godziny IS 'Ewidencja przepracowanych godzin przez pracowników';
CREATE TABLE ksiegowosc.pensja (
    id_pensji SERIAL PRIMARY KEY,
    stanowisko VARCHAR(100) NOT NULL,
    kwota DECIMAL(10,2) NOT NULL CHECK (kwota>=0)
);
COMMENT ON TABLE ksiegowosc.pensja IS 'Pensje przypisane do stanowisk';

CREATE TABLE ksiegowosc.premia (
    id_premii SERIAL PRIMARY KEY,
    rodzaj VARCHAR(100),
    kwota DECIMAL(10,2) 
);
COMMENT ON TABLE ksiegowosc.premia IS 'Dane o premiach';


CREATE TABLE ksiegowosc.wynagrodzenie (
    id_wynagrodzenia SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    id_pracownika INT REFERENCES ksiegowosc.pracownicy(id_pracownika) ON DELETE CASCADE,
    id_godziny INT REFERENCES ksiegowosc.godziny(id_godziny) ON DELETE CASCADE,
    id_pensji INT REFERENCES ksiegowosc.pensja(id_pensji) ON DELETE CASCADE,
    id_premii INT REFERENCES ksiegowosc.premia(id_premii) ON DELETE CASCADE
);



