\c cw3_db;

WITH g3 AS (
  SELECT geom FROM obiekty WHERE nazwa = 'obiekt3'
),
g4 AS (
  SELECT geom FROM obiekty WHERE nazwa = 'obiekt4'
),
shortest AS (
  SELECT ST_ShortestLine(g3.geom, g4.geom) AS geom
  FROM g3, g4
),
buf AS (
  SELECT ST_Buffer(geom, 5) AS geom
  FROM shortest
)
SELECT ST_Area(geom) AS pole_bufora
FROM buf;