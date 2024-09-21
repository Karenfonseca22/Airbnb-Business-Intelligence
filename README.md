<h1 align="center">Airbnb (Business Intelligence project)</h1>

<p align='center'> The goal is to optimize room availability, maximize revenue, and enhance the user experience. </p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/f3d5bb67-84f2-4dab-a24c-3a4302bd092b" alt="Airbnb Project Image" width="600" height="400">
</p>



En un mundo donde la economía compartida y la hospitalidad convergen, plataformas como Airbnb han transformado la forma en que las personas buscan y ofrecen alojamientos. En este contexto, maximizar la eficiencia y la rentabilidad se ha vuelto esencial tanto para los anfitriones como para la propia plataforma. El presente proyecto se enfoca en la exploración y análisis de datos relacionados con la disponibilidad de habitaciones en Airbnb, utilizando herramientas y conceptos de Business Intelligence (BI) para desentrañar patrones, identificar oportunidades y mejorar la toma de decisiones estratégicas.

La diversidad de información generada por la interacción de anfitriones y huéspedes en la plataforma Airbnb crea un vasto conjunto de datos. Desde detalles sobre las propiedades, precios y ubicaciones, hasta la retroalimentación de los huéspedes, la riqueza de estos datos proporciona una oportunidad única para aplicar técnicas de BI. Al emplear estrategias de integración de datos y relaciones entre tablas, buscamos descubrir conocimientos profundos que permitan a los anfitriones y a Airbnb en sí, optimizar la disponibilidad de habitaciones, maximizar los ingresos y mejorar la experiencia del usuario.

Este análisis exploratorio utilizará técnicas avanzadas de BI para visualizar tendencias, identificar patrones y comprender los factores que influyen en la ocupación de los alojamientos. Desde la temporada alta hasta las preferencias regionales, se examinarán diversos aspectos para desentrañar información valiosa. El objetivo final es proporcionar una base sólida para la toma de decisiones informada, permitiendo a los interesados tomar medidas estratégicas para mejorar la eficiencia operativa y la rentabilidad en el dinámico ecosistema de Airbnb.

🙌

## Tablas iniciales

Tabla rooms (Dimensión):
id: un identificador único para cada habitación.
name: el nombre del anuncio de Airbnb
neighbourhood: acrónimo del barrio en el que se encuentra el anuncio de Airbnb neighbourhoodgroup: barrio en el que se encuentra el anuncio de Airbnb
latitude: la coordenada de latitud del anuncio de Airbnb
longitude: la coordenada de longitud del anuncio de Airbnb
roomtype: el tipo de habitación que ofrece el anuncio de Airbnb
minimum_nights: el número mínimo de noches necesarias para reservar el anuncio de Airbnb

Tabla hosts (Dimensión):
hostid : un identificador único para cada host.
hostname: el nombre del anfitrión del anuncio de Airbnb

Tabla reviews (Hechos):
id: un identificador único para cada habitación.
hostid : un identificador único para cada host.
price: el precio por noche del anuncio de Airbnb
numberofreviews: el número total de reseñas que ha recibido el anuncio de Airbnb
lastreview: la fecha de la última reseña que recibió el anuncio de Airbnb
reviewspermonth: El número promedio de reseñas que recibe el anuncio de Airbnb por mes
calculatedhostlistingscount: el número total de listados que tiene el anfitrión
availability365: la cantidad de días que el anuncio de Airbnb está disponible para reservar en un año

# Procesar y preparar base de datos

- Para la tabla de hosts:

- Para la tabla de reviews:
- 
Se encontraron nulos en la variable de number_of_reviews (20), last_review (10039), reviews_per_month (10019), availability_365 (156), sin embargo no se van a eliminar en el procesamiento y limpieza de datos.

Siendo esta una hora de reseñas, es algo esperado que se repita el host_id ya que se puede alquilar el mismo lugar muchas veces, de la misma manera el id, ya que el usuario puede haber estado en airbnb y hacer reservación en varios lugares y no tenemos la variable de fecha de reservación para verificar que haya sido la misma fecha, el mismo cliente y la misma habitación.

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







