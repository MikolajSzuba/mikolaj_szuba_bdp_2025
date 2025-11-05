\c postgres

SET search_path TO karlsruhe, public;

SELECT 
    p.type,
    COUNT(*) AS poi_count
FROM t2019_kar_poi_table p
JOIN new_or_renovated_buildings b
    ON ST_DWithin(p.geom, b.geom, 500)
GROUP BY p.type
ORDER BY poi_count DESC;