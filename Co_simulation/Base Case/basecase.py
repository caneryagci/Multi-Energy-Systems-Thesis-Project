# -*- coding: utf-8 -*-
"""
Created on Jun  28 17:54:47 2020

@author: Caner
"""
import os
import sys
from pathlib import Path
home = str(Path.home())
from energysim import World
import numpy as np, pandas as pd

#og = ['Bus 0.V', 'Bus 1.V', 'Bus 12.V']
#cost = -100
my_world = World(stop_time=1800, logging = True, clean_up = False, interpolate_results=False, exchange = 300)

simulators_dir = r'C:\Users\Caner\Desktop\Multi-Energy-Systems-Thesis-Project\Co_simulation\Base Case'

p2g_loc = os.path.join(simulators_dir, 'Hydrogen.P2G_basecase.fmu')
grid_loc = os.path.join(simulators_dir, 'gridModel.p')
#electrolyser_loc = os.path.join(simulators_dir, 'electrolyser_1800.fmu')

my_world.add_powerflow('grid1', grid_loc, inputs = ['Power2Gas.P'], outputs=['Bus 0.V', 'Bus 1.V', 'Bus 2.V', 'WF.P', 'PV.P',
                       'Electrical.P', 'Power2Heat.P', 'Power2Gas.P'], step_size=3)


my_world.add_fmu(fmu_name = 'p2g', fmu_loc = p2g_loc, step_size = 3, inputs = ['gas_demand'], 
                 outputs=[ 'staticgen.Pgen','lcoh.cost','gas_demand'], variable=False, validate=False)

my_world.add_csv('gas_data', os.path.join(simulators_dir, 'ptg.csv'))

#my_world.add_signal('Emergency', [1])
#my_world.add_signal('cprice', [-1])


#options = {'init':{'p2g':(['gas_demand'],[0.00378603]),'grid1':(['Power2Gas.P'],[10])}}
            
            #'modify_signal': {'fmu1.output':[2], #multiplies by 2
             #                 'fmu2.output':[1/1e6, 0.5]} #multiplies by 1/1e6 #and adds 0.5
                              

#my_world.options(options)

connections = {#'cprice.y':'controller.C',  #data to fmu
               #'wind_data.speed': 'controller.v',  #data to fmu, controller
               #'wind_data.power': 'grid1.wind12.P',
               #'wind_data.power2': 'grid1.wind1.P',
               #'controller.y':'grid1.Electrolyser.P',    #scaling factors given to grid1
               #'Emergency.y':'controller.E_c',  #emergency controller signal = 1
               #'grid1.wind12.P':'controller.P',  #generated wind power to controller
               'gas_data.demand':'p2g.gas_demand',
               'p2g.staticgen.Pgen':'grid1.Power2Gas.P'
               }

my_world.add_connections(connections)

res = my_world.simulate()
#from fmpy import *
#res = simulate_fmu(p2g_loc, stop_time = 1000, output=["staticgen.Pgen","lcoh.cost"])
#res = simulate_fmu(p2g_loc)
#res
#windcsv = os.path.join(os.path.join(home, simulators_dir), 'diff_win.csv')
#import pandas as pd
#d = pd.read_csv(windcsv)
#def a(x):
#    const = 18/12.5**3
#    return min(18, const*x**3)

#def a1(x):
#    const = 18/12.5**3
#    return min(18, const*x**3)-10
#forecasted_power_12 = d.speed.apply(a)
#forecasted_bus_exchange_12 = d.speed.apply(a1)
#forecasted_power_1 = d.speed.apply(a2)
#forecasted_bus_exchange_1 = d.speed.apply(a3)


import matplotlib.pyplot as plt

wind_farm= res['grid1'].loc[:,'grid1.WF.P']
pv_farm= res['grid1'].loc[:,'grid1.PV.P']
time = res['grid1'].loc[:,'time']
fig0, ax0 = plt.subplots(figsize=(8,6))
ax0.plot(time, wind_farm, 'black', linewidth=1, label = 'WF(MW)')
ax0.plot(time, pv_farm, 'blue', linewidth=1, label = 'PV(MW)')
ax0.set_ylabel("Power [MW]", fontsize='large')
ax0.set_xlabel("Time [s]", fontsize='large')
ax0.legend(fontsize='small')
#plt.show()

electrolyser_load = res['grid1'].loc[:,'grid1.Power2Gas.P']
time = res['grid1'].loc[:,'time']
fig0, ax0 = plt.subplots(figsize=(8,6))
ax0.plot(time, electrolyser_load, 'red', linewidth=1, label='P2G(MW)')
ax0.set_ylabel("Power [MW]", fontsize='large')
ax0.set_xlabel("Time [s]", fontsize='large')
ax0.legend(fontsize='small')
#plt.show()

t = res['p2g'].time
power_load = res['p2g'].loc[:,'p2g.staticgen.Pgen']
fig4, ax4 = plt.subplots(figsize=(8,6))
ax4.plot(t, power_load, c='r', linewidth=1, label='Load_power')
ax4.legend(fontsize='small', loc='upper left')
ax4.set_xlabel("Time [h]", fontsize='large')
ax4.set_ylabel('$P_load$ [$MW$]', fontsize='large')
plt.show()

t = res['p2g'].time
gas_demand= res['p2g'].loc[:,'p2g.gas_demand']
fig5, ax5 = plt.subplots(figsize=(8,6))
ax5.plot(t, gas_demand, c='r', linewidth=1, label='Gas_demand')
ax5.legend(fontsize='small', loc='upper left')
ax5.set_xlabel("Time [h]", fontsize='large')
ax5.set_ylabel('Demand [m^3/s]', fontsize='large')
plt.show()

t = res['p2g'].time
lcoh = res['p2g'].loc[:,'p2g.lcoh.cost']
fig6, ax6 = plt.subplots(figsize=(8,6))
ax6.plot(t, lcoh, c='black', linewidth=1, label = "Cost")
ax6.legend(fontsize='small', loc='upper left')
ax6.set_xlabel("Time [h]", fontsize='large')
ax6.set_ylabel('$Cost$ [$EUR/kW$]', fontsize='large')
plt.show()