# -*- coding: utf-8 -*-
"""
Created on Mon May  4 17:54:47 2020

@author: Caner
"""
import os
import sys
from pathlib import Path
home = str(Path.home())
from energysim import World
import numpy as np

#og = ['Bus 0.V', 'Bus 1.V', 'Bus 12.V']
#cost = -100
my_world = World(stop_time=3600*1., logging = True, clean_up = True, interpolate_results=False, exchange = 60)

simulators_dir = r'D:\Modelica Libraries\Digvijay Co-sim'

controller_loc = os.path.join(simulators_dir, 'controller.fmu')
grid_loc = os.path.join(simulators_dir, 'gridModel.p')
electrolyser_loc = os.path.join(simulators_dir, 'electrolyser_1800.fmu')

my_world.add_powerflow('grid1', grid_loc, inputs = ['wind12.P', 'Electrolyser.P'], outputs=['Bus 0.V', 'Bus 1.V', 'Bus 12.V', 
                       'wind1.P', 'wind12.P', 'Electrolyser.P'], step_size=3)

my_world.add_fmu(fmu_name = 'controller', fmu_loc = controller_loc, step_size = 3, 
                 inputs = ['v', 'P', 'E_c', 'C'], outputs=['y', 'gain1.y', 'load_should_be', 'new_load_should_be', 
                          'p_forecasted', 'C', 'power_delta'], validate=False)
my_world.add_fmu(fmu_name = 'electrolyser', fmu_loc = electrolyser_loc, step_size = 3, inputs = ['p'], 
                 outputs=['y1', 'y2', 'p', 'integrator1.y'], variable=True, validate=False)

my_world.add_csv('wind_data', os.path.join(simulators_dir, 'diff_win.csv'))

my_world.add_signal('Emergency', [1])
my_world.add_signal('cprice', [-1])

options = {'init':{'controller':(['v', 'E_c', 'C', 'P', 'C_max'], [14, 1, -1, -18, -100]),  #0.34
                   'electrolyser':(['p'], [10])},
            }

my_world.options(options)

connections = {'cprice.y':'controller.C',  #data to fmu
               'wind_data.speed': 'controller.v',  #data to fmu, controller
               'wind_data.power': 'grid1.wind12.P',
               'wind_data.power2': 'grid1.wind1.P',
               'controller.y':'grid1.Electrolyser.P',    #scaling factors given to grid1
               'Emergency.y':'controller.E_c',  #emergency controller signal = 1
               'grid1.wind12.P':'controller.P',  #generated wind power to controller
               'grid1.Electrolyser.P':'electrolyser.p',
               }

my_world.add_connections(connections)

res = my_world.simulate()

windcsv = os.path.join(os.path.join(home, simulators_dir), 'diff_win.csv')
import pandas as pd
d = pd.read_csv(windcsv)
def a(x):
    const = 18/12.5**3
    return min(18, const*x**3)

def a1(x):
    const = 18/12.5**3
    return min(18, const*x**3)-10

def a2(x):
    const = 21/12.5**3
    return min(21, const*x**3)

def a3(x):
    const = 21/12.5**3
    return min(21, const*x**3) - 14.994 - 4.845

import matplotlib.pyplot as plt

forecasted_power_12 = d.speed.apply(a)
forecasted_bus_exchange_12 = d.speed.apply(a1)
forecasted_power_1 = d.speed.apply(a2)
forecasted_bus_exchange_1 = d.speed.apply(a3)

electrolyser_load = res['grid1'].loc[:,'grid1.Electrolyser.P']
wind_with_elect= res['grid1'].loc[:,'grid1.wind12.P']*-1
wind_without_elect= res['grid1'].loc[:,'grid1.wind1.P']*-1
bus_ex_12 = wind_with_elect - electrolyser_load
bus_ex_1 = wind_without_elect - 14.994 - 4.845
time = res['grid1'].loc[:,'time']

#Power exchange comparison bus 1 and 12
fig0, ax0 = plt.subplots(1)
ax0.plot(time, bus_ex_12, 'red', linewidth=1, label='Power Exchange Bus 12')
ax0.plot(time, wind_without_elect, 'black', linewidth=1, label = 'Power Exchange Bus 1')
ax0.set_ylabel("Power [MW]", fontsize='large')
ax0.set_xlabel("Time [h]", fontsize='large')
ax0.legend(fontsize='small')


fig, axs = plt.subplots(3, figsize=(8,6))
axs[0].plot(time, bus_ex_12, 'red', linewidth=1, label='Power Exchange')
axs[0].step(d.time, forecasted_bus_exchange_12, 'black', linewidth=1, linestyle = 'dashed', where= 'post', label='Forecasted Power Exchange')
axs[0].set_ylabel("Power [MW]", fontsize='large')
axs[0].set_xticks([])
axs[0].legend(fontsize='small')

#Bus 12 actual vs forecasted wind production
axs[1].plot(time, wind_with_elect, 'red', linewidth=1, label='Actual Wind Power Produced')
axs[1].step(d.time, forecasted_power_12, 'black', linewidth=1, linestyle = 'dashed', where='post', label='Forecasted Wind Production')
axs[1].set_ylabel("Power [MW]", fontsize='large')
axs[1].set_xticks([])
axs[1].legend(fontsize='small')

#Bus 12 Electrolyser load setpoints
axs[2].plot(time, electrolyser_load, 'black', linewidth=1, label='Electrolyser Load Power')
axs[2].set_xticks([x for x in range(15*97*60) if x%3600 == 0])
axs[2].set_xticklabels(list(range(24))+[0])
axs[2].set_xlabel("Time [h]", fontsize='large')
axs[2].set_ylabel("Power [MW]", fontsize='large')
axs[2].legend(fontsize='small')
plt.show()


#electrolyser behaviour with step size highlights
t = res['electrolyser'].time
hydrogen = res['electrolyser'].loc[:,'electrolyser.y2']
o2 = res['electrolyser'].loc[:,'electrolyser.y1']
fig4, ax4 = plt.subplots(figsize=(8,6))
ax4.plot(t, hydrogen, c='r', linewidth=1, label='Hydrogen rate')
ax4.plot(t, o2, c='black', linewidth=1, label = "Oxygen rate")
ax4.legend(fontsize='small', loc='upper left')
ax4.set_xlabel("Time [h]", fontsize='large')
ax4.set_ylabel('$H_2$ [$m^3$/s]', fontsize='large')
plt.show()

#voltage behavior
t = res['grid1'].time
b1v = res['grid1'].loc[:,'grid1.Bus 1.V']
b12v = res['grid1'].loc[:,'grid1.Bus 12.V']
fig5, ax5 = plt.subplots(figsize=(8,6))
ax5.plot(t, b1v, c='r', linewidth=1, label='Voltage at Uncontrolled Bus 1')
ax5.plot(t, b12v, c='black', linewidth=1, label = "Voltage at Controlled Bus 12")
ax5.legend(fontsize='small', loc='upper left')
ax5.set_xlabel("Time [h]", fontsize='large')
ax5.set_ylabel('Voltage [p.u.]', fontsize='large')
plt.show()

