\c cw2_db;
SELECT
    name,
    ST_Perimeter(geometry) AS perimeter
FROM mapa.buildings
ORDER BY ST_Area(geometry) DESC
LIMIT 2;