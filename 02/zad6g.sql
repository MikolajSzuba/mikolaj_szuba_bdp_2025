\c cw2_db;
SELECT 
    name,
    ST_Y(ST_Centroid(geometry)) AS centroid_y
FROM mapa.buildings
WHERE ST_Y(ST_Centroid(geometry)) > 4.5;