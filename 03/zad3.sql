\c cw3_db
WITH mp AS (
  SELECT geom FROM obiekty WHERE nazwa = 'obiekt4'
),
pts AS (  -- unikalne punkty
  SELECT DISTINCT ST_AsText((dp).geom) AS pt_wkt
  FROM mp, LATERAL ST_DumpPoints(mp.geom) dp
),
cnt AS (
  SELECT COUNT(*) AS n FROM pts
),
hull AS (  -- otoczka wypukła
  SELECT ST_ConvexHull((SELECT geom FROM mp)) AS geom
)
SELECT
  (SELECT n >= 3 FROM cnt)                                AS has_3_distinct_points,
  ST_GeometryType((SELECT geom FROM hull)) = 'ST_Polygon' AS not_colinear,
  ST_Area((SELECT geom FROM hull)) > 0                    AS positive_area,
  ST_AsText((SELECT geom FROM hull))                      AS hull_wkt;


UPDATE obiekty o
SET geom = ST_ConvexHull(o.geom)
WHERE o.nazwa = 'obiekt4'
  -- ≥ 3 różne punkty
  AND (
    SELECT COUNT(*) FROM (
      SELECT DISTINCT ST_AsText((dp).geom)
      FROM ST_DumpPoints(o.geom) dp
    ) s
  ) >= 3
  -- punkty nie są współliniowe → convex hull to POLYGON o polu > 0
  AND ST_GeometryType(ST_ConvexHull(o.geom)) = 'ST_Polygon'
  AND ST_Area(ST_ConvexHull(o.geom)) > 0;

SELECT nazwa,
       ST_GeometryType(geom) AS geom_type,
       ST_IsValid(geom)      AS is_valid,
       ST_IsSimple(geom)     AS is_simple,
       ST_Area(geom)         AS area,
       ST_AsText(geom)       AS wkt
FROM obiekty
WHERE nazwa = 'obiekt4';