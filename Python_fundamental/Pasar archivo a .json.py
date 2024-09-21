--- Pasar de .csv a .json

import pandas as pd

# Convertir el archivo reviews.csv a JSON
csv_file_path_reviews = 'reviews.csv'
json_file_path_reviews = 'reviews.json'
df_reviews = pd.read_csv(csv_file_path_reviews)
df_reviews.to_json(json_file_path_reviews, orient='records', lines=True)
print(f'Archivo JSON guardado en: {json_file_path_reviews}')

# Convertir el archivo rooms.csv a JSON
csv_file_path_rooms = 'rooms.csv'
json_file_path_rooms = 'rooms.json'
df_rooms = pd.read_csv(csv_file_path_rooms)
df_rooms.to_json(json_file_path_rooms, orient='records', lines=True)
print(f'Archivo JSON guardado en: {json_file_path_rooms}')
