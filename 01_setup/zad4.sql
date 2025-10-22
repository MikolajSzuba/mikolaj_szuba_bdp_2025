\c firma;
-- Pracownicy
INSERT INTO ksiegowosc.pracownicy (imie, nazwisko, adres, telefon) VALUES
('Jan', 'Nowak', 'Warszawa', '111-111-111'),
('Anna', 'Kowalska', 'Kraków', '222-222-222'),
('Jakub', 'Wiśniewski', 'Łódź', '333-333-333'),
('Joanna', 'Nowicka', 'Gdańsk', '444-444-444'),
('Piotr', 'Lewandowski', 'Poznań', '555-555-555'),
('Julia', 'Kamińska', 'Wrocław', '666-666-666'),
('Marcin', 'Zieliński', 'Szczecin', '777-777-777'),
('Katarzyna', 'Wojciechowska', 'Lublin', '888-888-888'),
('Paweł', 'Kozłowski', 'Bydgoszcz', '999-999-999'),
('Tomasz', 'Jankowski', 'Rzeszów', '101-101-101');

-- Pensja
INSERT INTO ksiegowosc.pensja (stanowisko, kwota) VALUES
('Kierownik', 4500),
('Specjalista', 3200),
('Asystent', 2000),
('Księgowy', 2800),
('Magazynier', 2200),
('Sekretarka', 1900),
('Sprzedawca', 2500),
('Technik', 3100),
('Staźysta', 1500),
('Dyrektor', 7000);

-- Premia
INSERT INTO ksiegowosc.premia (rodzaj, kwota) VALUES
('Roczna', 500),
('Uznaniowa', 300),
('Świąteczna', 700),
('Brak', NULL),
('Roczna', 600),
('Brak', NULL),
('Brak', NULL),
('Świąteczna', 800),
('Uznaniowa', 200),
('Brak', NULL);

-- Godziny
INSERT INTO ksiegowosc.godziny (data, liczba_godzin, id_pracownika) VALUES
('2025-10-01', 168, 1),
('2025-10-01', 155, 2),
('2025-10-01', 172, 3),
('2025-10-01', 160, 4),
('2025-10-01', 180, 5),
('2025-10-01', 158, 6),
('2025-10-01', 190, 7),
('2025-10-01', 150, 8),
('2025-10-01', 162, 9),
('2025-10-01', 175, 10);

-- Wynagrodzenie
INSERT INTO ksiegowosc.wynagrodzenie (data, id_pracownika, id_godziny, id_pensji, id_premii) VALUES
('2025-10-31', 1, 1, 2, 1),
('2025-10-31', 2, 2, 3, 4),
('2025-10-31', 3, 3, 4, 2),
('2025-10-31', 4, 4, 5, 3),
('2025-10-31', 5, 5, 1, 1),
('2025-10-31', 6, 6, 7, 6),
('2025-10-31', 7, 7, 8, 7),
('2025-10-31', 8, 8, 9, 8),
('2025-10-31', 9, 9, 6, 9),
('2025-10-31', 10, 10, 10, 10);