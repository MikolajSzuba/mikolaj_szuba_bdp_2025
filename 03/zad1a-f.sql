\c cw3_db;

INSERT INTO obiekty (nazwa, geom) VALUES
('obiekt1', ST_GeomFromText('POINT(10 20)')),
('obiekt2', ST_GeomFromText('LINESTRING(0 0, 10 10, 20 0)')),
('obiekt3', ST_GeomFromText('POLYGON((0 0, 10 0, 10 10, 0 10, 0 0))')),
('obiekt4', ST_GeomFromText('MULTIPOINT(5 5, 15 15, 25 5)')),
('obiekt5', ST_GeomFromText('POINT Z(1 2 3)')),
('obiekt6', ST_GeomFromText('GEOMETRYCOLLECTION(POINT(2 3), LINESTRING(2 3, 4 5))'));