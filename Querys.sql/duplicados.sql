-- Únicamente se encontraron en la tabla de hosts

WITH HostCounts AS (
  SELECT 
    host_id,
    COUNT(*) AS count
  FROM `airbnb-436116.alojamiento.hosts`
  WHERE host_name IS NOT NULL
  GROUP BY host_id
)

SELECT
  h.*
FROM `airbnb-436116.alojamiento.hosts` h
JOIN HostCounts hc
ON h.host_id = hc.host_id
WHERE hc.count = 1
