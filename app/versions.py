import pickle

import pandas as pd
import numpy, sklearn, pandas

model_name = 'pipeline_pca_std_rf'
model_version = 2

versions = {
    'numpy': numpy.__version__,
    'sklearn': sklearn.__version__, 
    'pandas': pandas.__version__,
    'model_version': model_version,
    'model_name': model_name
}
# print(versions)

model_versions = pickle.load(open('model/versions.pickle', 'rb'))
# print(model_versions)

assert model_versions == versions