\c cw2_db

SELECT 
    ST_Area(
        ST_Difference(
            b1.geometry,
            ST_Buffer(b2.geometry, 0.5)
        )
    ) AS area_outside_buffer
FROM mapa.buildings b1, mapa.buildings b2
WHERE b1.name = 'BuildingC' AND b2.name = 'BuildingB';