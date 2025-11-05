\c postgres

CREATE SCHEMA IF NOT EXISTS karlsruhe;

SET search_path TO karlsruhe, public;

SELECT 'T2018_KAR_BUILDINGS' as table_name, COUNT(*) as count FROM karlsruhe.t2018_kar_buildings
UNION ALL
SELECT 'T2019_KAR_BUILDINGS', COUNT(*) FROM karlsruhe.t2019_kar_buildings;

\c postgres

CREATE SCHEMA IF NOT EXISTS karlsruhe;
SET search_path TO karlsruhe, public;

CREATE TABLE IF NOT EXISTS new_or_renovated_buildings AS 
SELECT 
    b2019.gid,
    b2019.geom,
    CASE
        WHEN b2018.gid IS NULL THEN 'nowy' 
        WHEN ST_Area(ST_SymDifference(b2019.geom, b2018.geom)) > 1 THEN 'zmieniony'
    END AS status
FROM t2019_kar_buildings b2019
LEFT JOIN t2018_kar_buildings b2018
    ON b2019.gid = b2018.gid
WHERE b2018.gid IS NULL 
   OR ST_Area(ST_SymDifference(b2019.geom, b2018.geom)) > 5;

SELECT COUNT(*) FROM new_or_renovated_buildings;

CREATE INDEX IF NOT EXISTS idx_new_buildings_geom 
ON karlsruhe.new_or_renovated_buildings USING GIST(geom);

SELECT COUNT(*) as liczba_nowych_lub_wyremontowanych_budynkow 
FROM karlsruhe.new_or_renovated_buildings;

SELECT gid, ST_AsText(geom) as geometry 
FROM karlsruhe.new_or_renovated_buildings 
LIMIT 10;