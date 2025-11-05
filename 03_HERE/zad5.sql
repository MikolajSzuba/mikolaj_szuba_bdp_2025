\c postgres

SET search_path TO karlsruhe, public;

ALTER TABLE input_points
ALTER COLUMN geom TYPE geometry(Point, 31466)
USING ST_Transform(geom, 31466);

SELECT id, ST_AsText(geom) FROM input_points;