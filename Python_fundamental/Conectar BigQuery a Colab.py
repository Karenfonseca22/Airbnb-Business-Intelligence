!pip install google-auth google-auth-oauthlib google-auth-httplib2 google-api-python-client pandas-gbq

from google.colab import auth
auth.authenticate_user()

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# Reemplaza con tu ID de proyecto y el nombre de la tabla
project_id = 'airbnb-436116'  # Asegúrate de que este sea tu ID de proyecto real
dataset_id = 'alojamiento'  # Nombre del conjunto de datos
table_id_1 = 'reviews_cr'  # Nombre de la tabla 1

# Consulta SQL para seleccionar los datos de la tabla
query1 = f'SELECT * FROM `{project_id}.{dataset_id}.{table_id_1}`'  # Corrección en la construcción de la consulta


df_reviews_cr = pd.read_gbq(query1, project_id = project_id)
# Mostrar las primeras filas del DataFrame
display(df_reviews_cr)
