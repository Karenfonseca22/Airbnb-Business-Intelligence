-- Para tabla de hosts

SELECT 
  host_id
FROM `airbnb-436116.alojamiento.hosts`
WHERE REGEXP_CONTAINS(host_id, r'[A-Za-z]')

-- Para tabla de reviews

SELECT
  host_id,
  id,
  price,
  number_of_reviews,
  last_review,
  reviews_per_month,
  calculated_host_listings_count,
  availability_365
FROM
  `airbnb-436116.alojamiento.reviews`
WHERE
  REGEXP_CONTAINS(host_id, r'[A-Za-z]')
  OR REGEXP_CONTAINS(id, r'[A-Za-z]')
  OR SAFE_CAST(price AS STRING) IS NULL
  OR REGEXP_CONTAINS(CAST(number_of_reviews AS STRING), r'[A-Za-z]')
  OR ( SAFE_CAST(last_review AS STRING) IS NOT NULL
    AND SAFE_CAST(last_review AS STRING) != CAST(FLOOR(SAFE_CAST(last_review AS FLOAT64)) AS STRING) )
  OR REGEXP_CONTAINS(CAST(reviews_per_month AS STRING), r'[A-Za-z]')
  OR REGEXP_CONTAINS(CAST(calculated_host_listings_count AS STRING), r'[A-Za-z]')
  OR REGEXP_CONTAINS(CAST(availability_365 AS STRING), r'[A-Za-z]')

-- Para tabla de rooms

SELECT
  id,
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
  REGEXP_CONTAINS(id, r'[A-Za-z]')
  OR REGEXP_CONTAINS(neighbourhood, r'[0-9]')
  OR REGEXP_CONTAINS(neighbourhood_group, r'[0-9]')
  OR REGEXP_CONTAINS(CAST(latitude AS STRING), r'[A-Za-z]')
  OR REGEXP_CONTAINS(CAST(longitude AS STRING), r'[A-Za-z]')
  OR REGEXP_CONTAINS(room_type, r'[0-9]')
  OR REGEXP_CONTAINS(CAST(minimum_nights AS STRING), r'[A-Za-z]')
