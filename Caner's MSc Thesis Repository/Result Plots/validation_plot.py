# -*- coding: utf-8 -*-
"""
Created on Tue Aug  4 03:38:07 2020

@author: Caner
"""

import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

T=333.15
seconds = np.arange(0,691200,43200)
hours = np.arange(0,204,12)
jcell= np.arange(0,1.75,0.25)
vcell = np.arange(1.5,2.0,0.1)
fig0,ax = plt.subplots()
df = pd.read_csv(r'C:\Users\Caner\Desktop\Multi-Energy-Systems-Thesis-Project\Figures\Python Figures\V_cell_Jcell.csv')
df.plot(x='electrolyser_detailed.electrochemical.jcell', y='electrolyser_detailed.electrochemical.Vcell', ax=ax, yticks=vcell, xticks=jcell, figsize=(12,5),fontsize=20, color='b')
ax.set_xlabel('Current density [$A/cm^2$]', fontsize=25)
ax.set_ylabel('Cell voltage [V]', fontsize=25)  
ax.legend(["T = 50$°C$, $P_{an}$ = 35 bar"],fontsize=20, loc = 'upper left');
ax.grid('on')
ax.set_xlim(0,1.5)
plt.savefig('Vcellvs.Jcell.png')
plt.savefig('Vcellvs.Jcell.pdf',bbox_inches='tight', pad_inches=0.2)