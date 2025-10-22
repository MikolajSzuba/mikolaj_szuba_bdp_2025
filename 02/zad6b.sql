\c cw2_db;
SELECT
    name,
    ST_AsText(geometry) AS geom_wkt,
    ST_Area(geometry) AS area,
    ST_Perimeter(geometry) AS perimeter
FROM mapa.buildings
WHERE name ='BuildingA';