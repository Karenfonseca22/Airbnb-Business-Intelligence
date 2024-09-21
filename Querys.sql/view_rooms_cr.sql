-- Vista creada apartir de la original de rooms, con correcciones de nulos, duplicados y caracteres especiales.

SELECT
  CAST(id AS STRING) AS id,
  name,
  neighbourhood,
  neighbourhood_group,
  latitude,
  longitude,
  room_type,
  minimum_nights
FROM
  `airbnb-436116.alojamiento.rooms`
WHERE
  NOT REGEXP_CONTAINS(CAST(id AS STRING), r'[^0-9]')  -- Permitir solo números
  AND NOT REGEXP_CONTAINS(neighbourhood, r'[^A-Za-z]')  -- Permitir solo letras
  AND NOT REGEXP_CONTAINS(neighbourhood_group, r'[^A-Za-z]')  -- Permitir solo letras
