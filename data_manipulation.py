# -*- coding: utf-8 -*-
"""
Created on Mon Nov 16 17:11:37 2020

@author: Tomi Räsänen, Erik Husgafvel
"""

import pandas as pd
import numpy as np

columns_names = ["iso_code", "country", "year" ,"co2"]

name_of_country = ["URY", "PER", "CUB", "USA",  "ISL", "FIN", "FRA", "GRC", "MAR", 
                   "ZAF", "CMR", "SAU", "IND", "MNG", "HKG", "JPN", "SGP", "NZL", "FJI"
]

data_ = pd.read_csv("owid-co2-data.csv")

data_f = pd.DataFrame(columns = data_.columns)


for i in range(len(name_of_country)):
    data_f = data_f.append(data_.loc[(data_['iso_code'] == name_of_country[i]) 
                                     & (data_['year'] >= 1950)])

data_f_2 = data_f[columns_names]

# To use data the most comfortable way, we will place countries as columns 
# (groups) and years as rows

grouped_data = pd.DataFrame()
for i in range(len(name_of_country)):
    h = data_f_2.loc[data_f_2['iso_code'] == name_of_country[i]]
    
    #Different countries have different row indexes in original data, 
    # which has to be changed to the same.
    h.index = np.arange(0, len(h))
    
    grouped_data.insert(i,name_of_country[i],h['co2'])

grouped_data.to_csv('data_co2.csv', index = False)