\c cw2_db;
SELECT SUM(ST_Length(geometry)) AS total_road_length
FROM mapa.roads;