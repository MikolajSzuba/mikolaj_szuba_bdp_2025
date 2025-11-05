\c postgres

SET search_path TO karlsruhe, public;

DROP TABLE IF EXISTS t2019_kar_bridges;

CREATE TABLE t2019_kar_bridges AS
SELECT
    r.gid as railway_gid,
    w.gid as water_gid,
    ST_Intersection(r.geom, w.geom) AS geom
FROM t2019_kar_railways r
JOIN t2019_kar_water_lines w
  ON ST_Intersects(r.geom, w.geom)
WHERE ST_GeometryType(ST_Intersection(r.geom, w.geom)) = 'ST_Point';

SELECT COUNT(*) FROM t2019_kar_bridges;
SELECT * FROM t2019_kar_bridges LIMIT 10;