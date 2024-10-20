--  script that lists all bands with Glam rock
SELECT
	band_name,
	CASE
		WHEN formed IS NOT NULL AND (split IS NULL OR split >= formed)
		THEN COALESCE(split, 2022) - formed
		ELSE NULL
	END AS lifespan
FROM
	metal_bands
WHERE
	style = 'Glam rock'
ORDER BY
	lifespan DESC;
