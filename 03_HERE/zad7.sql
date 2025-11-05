\c postgres

SET search_path TO karlsruhe, public;

SELECT COUNT(*)
FROM t2019_kar_poi_table
JOIN t2019_kar_land_use_a
  ON ST_DWithin(t2019_kar_poi_table.geom, t2019_kar_land_use_a.geom, 300)
WHERE t2019_kar_poi_table.type = 'Sporting Goods Store'
  AND t2019_kar_land_use_a.type = 'Park (City/County)';