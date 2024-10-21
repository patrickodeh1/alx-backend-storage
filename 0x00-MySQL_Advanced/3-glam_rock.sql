-- SQL script to list all bands with Glam rock
-- SQL script to list all bands with Glam rock
SELECT 
    name AS band_name, 
    CASE 
        WHEN split IS NOT NULL AND split > 0 THEN split - formed  -- Band has split
        ELSE 2022 - formed  -- Band is still active (assumed current year is 2022)
    END AS lifespan
FROM 
    metal_bands 
WHERE 
    main_style = 'Glam rock'
ORDER BY 
    lifespan DESC;
