SELECT
  CAST(id AS STRING) AS id,
  CAST(host_id AS STRING) AS host_id,
  price,
  number_of_reviews,
  last_review,
  --- Se hace imputación con el valor 0.71 ya que descubrimos que es la mediana de esta variable, y tiene una distribución no normal
  IFNULL(reviews_per_month, 0.71) AS reviews_per_month,
  calculated_host_listings_count,
  availability_365
FROM
  `airbnb-436116.alojamiento.reviews`
WHERE
  NOT REGEXP_CONTAINS(CAST(host_id AS STRING), r'[^0-9]')  -- Permitir solo números
  AND NOT REGEXP_CONTAINS(CAST(id AS STRING), r'[^0-9]')  -- Permitir solo números
  AND NOT REGEXP_CONTAINS(CAST(number_of_reviews AS STRING), r'[^0-9]');  -- Permitir solo números
