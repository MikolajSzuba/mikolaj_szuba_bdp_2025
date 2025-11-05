\c postgres

SET search_path TO karlsruhe, public;

WITH line_transformed AS (
    SELECT ST_Transform(ST_MakeLine(geom ORDER BY id), 31466) AS geom_line
    FROM input_points
)
SELECT 
    MIN(sn.gid) as gid,
    ST_AsText(ST_SnapToGrid(ST_Transform(sn.geom, 31466), 5)) as location,
    MIN(ST_Distance(ST_Transform(sn.geom, 31466), line.geom_line)) as distance_meters,
    COUNT(*) as nodes_count
FROM t2019_kar_street_node sn
JOIN line_transformed line
  ON ST_DWithin(ST_Transform(sn.geom, 31466), line.geom_line, 200)
GROUP BY ST_SnapToGrid(ST_Transform(sn.geom, 31466), 5)
ORDER BY distance_meters;

WITH line_transformed AS (
    SELECT ST_Transform(ST_MakeLine(geom ORDER BY id), 31466) AS geom_line
    FROM input_points
)
SELECT COUNT(DISTINCT ST_SnapToGrid(ST_Transform(sn.geom, 31466), 5)) as liczba_skrzyzowan
FROM t2019_kar_street_node sn
JOIN line_transformed line
  ON ST_DWithin(ST_Transform(sn.geom, 31466), line.geom_line, 200);