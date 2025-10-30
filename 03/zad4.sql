\c cw3_db

INSERT INTO obiekty (nazwa, geom)
SELECT
  'obiekt7' AS nazwa,
  ST_Collect(
    (SELECT geom FROM obiekty WHERE nazwa = 'obiekt3'),
    (SELECT geom FROM obiekty WHERE nazwa = 'obiekt4')
  ) AS geom;
