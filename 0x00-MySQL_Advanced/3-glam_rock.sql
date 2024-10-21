-- SQL script to list all bands with Glam rock
SELECT 
    name AS band_name, 
    CASE 
        WHEN split IS NOT NULL THEN split - formed  -- Band has split
        ELSE 2020 - formed  -- Band is still active, using 2020 as the current year
    END AS lifespan
FROM 
    metal_bands
WHERE 
    main_style LIKE '%Glam rock%'
ORDER BY 
    lifespan DESC;
