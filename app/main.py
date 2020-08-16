import versions
from prediction import predict

from typing import Optional, Dict

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

import logging

logging.basicConfig(filename='req.log')

data_logger = logging.getLogger('DataLogger')
data_logger.setLevel(logging.INFO)

file_handler = logging.FileHandler('data.log', )

data_logger.addHandler(file_handler)

@app.get("/")
def ping():
    return "pong"

@app.post('/predict')
def do_predict(json_data: Dict):
    speed = json_data['speed']
    age = json_data['age']
    miles = json_data['miles']

    predicted_category, probabilities = predict(speed, age, miles)

    response = {
        'category': predicted_category,
        'prediction': probabilities,
    }

    dataset = {
        'out': response,
        'in': {
            'speed': speed, 'age': age, 'miles': miles
        }
    }

    data_logger.info(dataset)
    return response
