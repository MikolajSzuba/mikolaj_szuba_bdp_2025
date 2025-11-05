\c postgres

SET search_path TO karlsruhe, public;

DROP TABLE IF EXISTS streets_reprojected;

ALTER TABLE t2019_kar_streets
ALTER COLUMN geom TYPE geometry(MultiLineString, 25832)
USING ST_SetSRID(geom, 25832);

CREATE TABLE streets_reprojected AS
SELECT
    *,
    ST_Transform(geom, 31466) AS geom_transformed
FROM t2019_kar_streets;

SELECT COUNT(*) FROM streets_reprojected;