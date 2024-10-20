--  script that lists all bands with Glam rock
SELECT
	band_name,
	CASE
		WHEN split IS NULL THEN - formed
		ELSE split - formed
	END AS lifespan
FROM
	metal_bands
WHERE
	style = 'Glam rock'
ORDER BY
	lifespan DESC;
