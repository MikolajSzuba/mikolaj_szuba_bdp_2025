\c cw2_db
SELECT ST_distance(b.geometry,p.geometry)
FROM mapa.buildings b
JOIN mapa.poi p ON p.name = 'K'
WHERE b.name = 'BuildingC';