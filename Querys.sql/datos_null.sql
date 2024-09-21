-- Para la tabla hosts

SELECT  
SUM (CASE WHEN host_id IS NULL THEN 1 ELSE 0 END) AS null_host_id,
SUM (CASE WHEN host_name IS NULL THEN 1 ELSE 0 END) AS null_host_name,
FROM `airbnb-436116.alojamiento.hosts`

-- Para la tabla reviews

SELECT  
SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS null_id,
SUM(CASE WHEN host_id IS NULL THEN 1 ELSE 0 END) AS null_hostid,
SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS null_price,
SUM(CASE WHEN number_of_reviews IS NULL THEN 1 ELSE 0 END) AS null_num_reviews,
SUM(CASE WHEN last_review IS NULL THEN 1 ELSE 0 END) AS null_last_reviews,
SUM(CASE WHEN reviews_per_month IS NULL THEN 1 ELSE 0 END) AS null_reviews_per_month,
SUM(CASE WHEN calculated_host_listings_count IS NULL THEN 1 ELSE 0 END) AS null_host_count,
SUM(CASE WHEN availability_365 IS NULL THEN 1 ELSE 0 END) AS null_availability
FROM `airbnb-436116.alojamiento.reviews` 

-- Para la tabla rooms

SELECT  
SUM( CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS null_id,
SUM( CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS null_name,
SUM( CASE WHEN neighbourhood IS NULL THEN 1 ELSE 0 END) AS null_neighbourhood,
SUM( CASE WHEN neighbourhood_group IS NULL THEN 1 ELSE 0 END) AS null_neighbourhood_group,
SUM( CASE WHEN latitude IS NULL THEN 1 ELSE 0 END) AS null_latitud,
SUM( CASE WHEN longitude IS NULL THEN 1 ELSE 0 END) AS null_longitude,
SUM( CASE WHEN room_type IS NULL THEN 1 ELSE 0 END) AS null_room_type,
SUM( CASE WHEN minimum_nights IS NULL THEN 1 ELSE 0 END) AS null_minimum_nights,
FROM `airbnb-436116.alojamiento.rooms` 
