<h1 align="center">Airbnb (Business Intelligence project)</h1>

<p align='center'> The goal is to optimize room availability, maximize revenue, and enhance the user experience. </p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/f3d5bb67-84f2-4dab-a24c-3a4302bd092b" alt="Airbnb Project Image" width="400" height="300">
</p>



En un mundo donde la economía compartida y la hospitalidad convergen, plataformas como Airbnb han transformado la forma en que las personas buscan y ofrecen alojamientos. En este contexto, maximizar la eficiencia y la rentabilidad se ha vuelto esencial tanto para los anfitriones como para la propia plataforma. El presente proyecto se enfoca en la exploración y análisis de datos relacionados con la disponibilidad de habitaciones en Airbnb, utilizando herramientas y conceptos de Business Intelligence (BI) para desentrañar patrones, identificar oportunidades y mejorar la toma de decisiones estratégicas.

La diversidad de información generada por la interacción de anfitriones y huéspedes en la plataforma Airbnb crea un vasto conjunto de datos. Desde detalles sobre las propiedades, precios y ubicaciones, hasta la retroalimentación de los huéspedes, la riqueza de estos datos proporciona una oportunidad única para aplicar técnicas de BI. Al emplear estrategias de integración de datos y relaciones entre tablas, buscamos descubrir conocimientos profundos que permitan a los anfitriones y a Airbnb en sí, optimizar la disponibilidad de habitaciones, maximizar los ingresos y mejorar la experiencia del usuario.

Este análisis exploratorio utilizará técnicas avanzadas de BI para visualizar tendencias, identificar patrones y comprender los factores que influyen en la ocupación de los alojamientos. Desde la temporada alta hasta las preferencias regionales, se examinarán diversos aspectos para desentrañar información valiosa. El objetivo final es proporcionar una base sólida para la toma de decisiones informada, permitiendo a los interesados tomar medidas estratégicas para mejorar la eficiencia operativa y la rentabilidad en el dinámico ecosistema de Airbnb.


## Tablas iniciales 🙌

**Tabla rooms (Dimensión):**
id: un identificador único para cada habitación.
name: el nombre del anuncio de Airbnb
neighbourhood: acrónimo del barrio en el que se encuentra el anuncio de Airbnb neighbourhoodgroup: barrio en el que se encuentra el anuncio de Airbnb
latitude: la coordenada de latitud del anuncio de Airbnb
longitude: la coordenada de longitud del anuncio de Airbnb
roomtype: el tipo de habitación que ofrece el anuncio de Airbnb
minimum_nights: el número mínimo de noches necesarias para reservar el anuncio de Airbnb

**Tabla hosts (Dimensión):**
hostid : un identificador único para cada host.
hostname: el nombre del anfitrión del anuncio de Airbnb

**Tabla reviews (Hechos):**
id: un identificador único para cada habitación.
hostid : un identificador único para cada host.
price: el precio por noche del anuncio de Airbnb
numberofreviews: el número total de reseñas que ha recibido el anuncio de Airbnb
lastreview: la fecha de la última reseña que recibió el anuncio de Airbnb
reviewspermonth: El número promedio de reseñas que recibe el anuncio de Airbnb por mes
calculatedhostlistingscount: el número total de listados que tiene el anfitrión
availability365: la cantidad de días que el anuncio de Airbnb está disponible para reservar en un año

# Procesar y preparar base de datos

**Duplicados:** Se gestionaron los duplicados únicamente en la tabla de hosts, ya que contenía las variables host_id y host_name. En las demás tablas no se identificaron duplicados relevantes que requirieran tratamiento. Dado que estamos trabajando con reseñas, es de esperar que el host_id se repita, ya que un mismo lugar puede ser alquilado varias veces. De manera similar, el id del usuario puede repetirse, ya que un mismo cliente puede haber hecho reservas en varios lugares de Airbnb. Además, no contamos con la variable de fecha de reservación para verificar si se trata de la misma fecha, cliente y habitación.

**Valores null:** Se encontraron nulos en la variable de number_of_reviews (20), last_review (10039), reviews_per_month (10019), availability_365 (156), sin embargo no se van a eliminar en el procesamiento y limpieza de datos. Se hizo imputación para la variable reviews_per_month, debido a su distribución se imputo con la mediana.

![image](https://github.com/user-attachments/assets/ff277dc4-8323-4737-8d53-c0f7ed9bf8dd)

**Caracteres especiales:** En todas las tablas habian datos desordenados y discrepantes. Se limpiaron, comprobando y verificando en BigQuery. Este es un ejemplo de formula para remover caracteres especiales:

```SQL
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

```

# Tablas a Power BI

![image](https://github.com/user-attachments/assets/393511e8-6c3b-41e0-817c-3d506e5a85e0) 

Se estableció una relación de uno a varios entre las tablas de dimensión y la tabla de hechos. Las tablas de dimensión son *hosts* y *rooms*, mientras que la tabla de hechos es *reviews*, ya que esta contiene tanto el *id* como el *id_host*, lo que permite establecer las relaciones entre ellas.


# Formulas DAX

- **Total habitación (Precio y número de días disponibles en un año) (Como columna)**

```DAX
Ingresos_Potenciales = [price] * [availability_365]
```

- **Cálculo de Reservas Anuales por Barrio (Como columna)**

Esta es la fórmula DAX utilizada para calcular el número total de reservas que un barrio podría recibir en un año:

```DAX
Total_Reservas_Por_Barrio = 
CALCULATE(
    SUMX(
        rooms_cr,
        365 / rooms_cr[minimum_nights]
    ),
    ALLEXCEPT(rooms_cr, rooms_cr[neighbourhoodgroup])
)

```

- **Porcentaje de Habitaciones por Barrio (Como medida)** 

Esta es la fórmula DAX utilizada para calcular el porcentaje de habitaciones disponibles por barrio:

```DAX
Porcentaje_Habitaciones_Disponibles = 
VAR TotalHabitacionesBarrio = 
    COUNT(rooms_cr[id])
VAR HabitacionesDisponiblesBarrio = 
    CALCULATE(
        COUNT(rooms_cr[id]),
        reviews_cr[availability_365] > 0
    )
RETURN
    DIVIDE(HabitacionesDisponiblesBarrio, TotalHabitacionesBarrio, 0) * 100

  ```

# Analisis exploratorio



# Conclusiones

**1. Las zonas o barrios con mayor cantidad de hosts (usuarios en la plataforma) estan en Williamsbug, Harlem, Bushwick, Midtown, Greenpoint, Chelsea.**

![image](https://github.com/user-attachments/assets/b938e541-49dd-40a5-a3e7-74801cf74f19)

**2. Junio es el mes con mas reseñas y el tipo de habitación que mas obtiene es el private room.**

![image](https://github.com/user-attachments/assets/aee34ba9-b709-4b16-9f31-b8473389ecc9)

**3. El tipo de habitación más costoso es el entire home/apt seguido del private room. Sin embargo, hay muchas más habitaciones disponibles del tipo entire home/apt en comparación con private room.**

 ![image](https://github.com/user-attachments/assets/1edee789-8275-4bd5-a60b-71ad106f0d76)

**4. Hay una relación entre el porcentaje de habitaciones disponibles anualmente y las reseñas por mes, es decir entre mas habitaciones disponibles, mas reseñas**

![image](https://github.com/user-attachments/assets/594cfd60-a1be-4040-805c-afdd2e8c24b9)

**5. Existe un equilibrio entre la cantidad de habitaciones disponibles en Manhattan y el precio por noche, lo que lo convierte en una zona rentable. Por otro lado, el Bronx es la zona con menos habitaciones disponibles y menores ingresos.**

![image](https://github.com/user-attachments/assets/5f6cd8ff-f830-42ca-a343-5afaeda1febb)








