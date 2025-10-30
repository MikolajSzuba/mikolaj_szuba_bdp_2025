\c cw3_db

SELECT
  nazwa,
  ST_GeometryType(geom)        AS typ,
  ST_Area(ST_Buffer(geom, 5)) AS pole_bufora
FROM obiekty
WHERE NOT ST_HasArc(geom);

SELECT
  SUM(ST_Area(ST_Buffer(geom, 5))) AS suma_pol_buforow
FROM obiekty
WHERE NOT ST_HasArc(geom);
