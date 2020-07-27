# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 20:29:37 2020

@author: Caner
"""

# -*- coding: utf-8 -*-
"""
Created on Mon Jul 27 14:22:06 2020

@author: Caner
"""
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np





df = pd.read_csv(r'C:\Users\Caner\Desktop\Python Figures\exportedVariablesELEC.csv')
df.to_excel("outputELEC.xlsx") 