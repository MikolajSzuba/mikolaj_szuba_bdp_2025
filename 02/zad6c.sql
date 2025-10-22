\c cw2_db;

SELECT name,
    ST_Area(geometry) AS area
FROM mapa.buildings
ORDER BY name ASC;