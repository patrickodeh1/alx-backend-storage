-- SQL script to list all bands with Glam rock
SELECT 
    name AS band_name, 
    IFNULL(YEAR('2022') - formed, 0) - IFNULL(YEAR('2022') - split, 0) AS lifespan
FROM 
    metal_bands 
WHERE 
    main_style = 'Glam rock'
ORDER BY 
    lifespan DESC;
