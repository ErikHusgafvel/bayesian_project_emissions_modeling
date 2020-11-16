# -*- coding: utf-8 -*-
"""
Created on Mon Nov 16 17:11:37 2020

@author: Tomi
"""

import pandas as pd

columns_names = ["iso_code", "country", "year" ,"co2"]

name_of_country = ["URY", "PER", "CUB", "USA",  "ISL", "FIN", "FRA", "GRC", "MAR", 
                   "ZAF", "CMR", "SAU", "IND", "MNG", "HKG", "JPN", "SGP", "NZL", "FJI"
]

data_ = pd.read_csv("owid-co2-data.csv")

data_f = pd.DataFrame(columns = data_.columns)


for i in range(len(name_of_country)):
    data_f = data_f.append(data_.loc[data_['iso_code'] == name_of_country[i]])

data_f_2 = data_f[columns_names]
data_f_3 = data_f_2.loc[data_f_2['year'] >= 1950]