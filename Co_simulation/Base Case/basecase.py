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
my_world = World(stop_time=86400, logging = True, clean_up = False, interpolate_results=False, exchange = 900)

simulators_dir = r'C:\Users\Caner\Desktop\Multi-Energy-Systems-Thesis-Project\Co_simulation\Base Case'
p2h_loc = os.path.join(simulators_dir, 'P2H.pth_model_B_cosim.fmu')
p2g_loc = os.path.join(simulators_dir, 'Hydrogen.ptg_model_B_cosim.fmu')
grid_loc = os.path.join(simulators_dir, 'gridModel_basecase.p')


my_world.add_powerflow('grid1', grid_loc, inputs = ['Power2Heat.P'], outputs=['Bus 0.V', 'Bus 1.V', 'Bus 2.V', 'WF.P', 'PV.P',
                       'Electrical.P', 'Power2Heat.P', 'Power2Gas.P'], step_size=100)


my_world.add_fmu(fmu_name = 'p2g', fmu_loc = p2g_loc, step_size = 10, inputs = ['gas_demand','T_ambient'], 
                 outputs=[ 'electrolyser_detailed1.Pelec','lcoh.cost','gas_demand','electrolyser_detailed1.electrochemical.efficiency2','storage2.S_storage'], variable=False, validate=False)

my_world.add_fmu(fmu_name = 'p2h', fmu_loc = p2h_loc, step_size = 10, inputs = ['heat_demand','T_ambient'], 
                 outputs=[ 'hp2.Pelec','lcodh.cost','heat_demand','hp2.COP','storage.S'], variable=False, validate=False)

my_world.add_csv('data', os.path.join(simulators_dir, 'data.csv'))

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
               'data.ptg_demand':'p2g.gas_demand',
               'data.pth_demand':'p2h.heat_demand',
               'data.T_amb_pth':'p2h.T_ambient',
               'data.T_amb_ptg':'p2g.T_ambient',
               'p2g.electrolyser_detailed1.Pelec':'grid1.Power2Gas.P',
               'p2h.hp2.Pelec':'grid1.Power2Heat.P'
               }

my_world.add_connections(connections)

res = my_world.simulate()
#from fmpy import *
#res = simulate_fmu(p2g_loc, stop_time = 1000, output=["staticgen.Pgen","lcoh.cost"])
#res = simulate_fmu(p2h_loc, stop_time = 1000, output=["staticgen.Pgen","lcoh.cost"])
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
plt.savefig('RES_P.png')


bus0= res['grid1'].loc[:,'grid1.Bus 0.V']
bus1= res['grid1'].loc[:,'grid1.Bus 1.V']
bus2= res['grid1'].loc[:,'grid1.Bus 2.V']
time = res['grid1'].loc[:,'time']
fig10, ax10 = plt.subplots(figsize=(8,6))
ax10.plot(time, bus0, 'black', linewidth=1, label = 'Slack Bus')
ax10.plot(time, bus1, 'blue', linewidth=1, label = 'Bus 2')
ax10.plot(time, bus2, 'green', linewidth=1, label = 'Bus 3')
ax10.set_ylabel("Bus Voltage [V]", fontsize='large')
ax10.set_xlabel("Time [s]", fontsize='large')
ax10.legend(fontsize='small')
#plt.show()
plt.savefig('Bus_voltage.png')

electrolyser_load = res['grid1'].loc[:,'grid1.Power2Gas.P']
heatpump_load = res['grid1'].loc[:,'grid1.Power2Heat.P']
electrical_load = res['grid1'].loc[:,'grid1.Electrical.P']
time = res['grid1'].loc[:,'time']
fig1, ax1 = plt.subplots(figsize=(8,6))
ax1.plot(time, electrolyser_load, 'red', linewidth=1, label='P2G(MW)')
ax1.plot(time, heatpump_load, 'yellow', linewidth=1, label='P2H(MW)')
ax1.plot(time, electrical_load, 'green', linewidth=1, label='Base Load(MW)')
ax1.plot(time, wind_farm, 'black', linewidth=1, label = 'WF(MW)')
ax1.plot(time, pv_farm, 'blue', linewidth=1, label = 'PV(MW)')
ax1.set_ylabel("Power [MW]", fontsize='large')
ax1.set_xlabel("Time [s]", fontsize='large')
ax1.legend(fontsize='small')
plt.show()
plt.savefig('MES_P.png')

t = res['p2g'].time
power_load = res['p2g'].loc[:,'p2g.electrolyser_detailed1.Pelec']
fig2, ax2 = plt.subplots(figsize=(8,6))
ax2.plot(t, power_load, c='r', linewidth=1, label='PtG Load [MW]')
ax2.legend(fontsize='small', loc='upper left')
ax2.set_xlabel("Time [h]", fontsize='large')
ax2.set_ylabel('$PtG P_load$ [$MW$]', fontsize='large')
plt.show()
plt.savefig('electrolyser_P.png')

t = res['p2g'].time
gas_demand= res['p2g'].loc[:,'p2g.gas_demand']
fig3, ax3 = plt.subplots(figsize=(8,6))
ax3.plot(t, gas_demand, c='r', linewidth=1, label='Gas_demand')
ax3.legend(fontsize='small', loc='upper left')
ax3.set_xlabel("Time [h]", fontsize='large')
ax3.set_ylabel('Hydrogen Demand [m^3/s]', fontsize='large')
plt.show()
plt.savefig('gas_demand.png')

t = res['p2g'].time
lcoh = res['p2g'].loc[:,'p2g.lcoh.cost']
fig4, ax4 = plt.subplots(figsize=(8,6))
ax4.plot(t, lcoh, c='black', linewidth=1, label = "Cost")
ax4.legend(fontsize='small', loc='upper left')
ax4.set_xlabel("Time [h]", fontsize='large')
ax4.set_ylabel('$Cost$ [$EUR/kW$]', fontsize='large')
plt.show()
plt.savefig('ptg_cost.png')

t = res['p2g'].time
efficiency= res['p2g'].loc[:,'p2g.electrolyser_detailed1.electrochemical.efficiency2']
fig9, ax9 = plt.subplots(figsize=(8,6))
ax9.plot(t, efficiency, c='black', linewidth=1, label = "Efficiency")
ax9.legend(fontsize='small', loc='upper left')
ax9.set_xlabel("Time [h]", fontsize='large')
ax9.set_ylabel('$Efficiency$', fontsize='large')
plt.show()
plt.savefig('electrolyser_efficiency.png')

t = res['p2g'].time
S_ptg= res['p2g'].loc[:,'p2g.storage2.S_storage']
fig12, ax12 = plt.subplots(figsize=(8,6))
ax12.plot(t, S_ptg, c='black', linewidth=1, label = "S PtG")
ax12.legend(fontsize='small', loc='upper left')
ax12.set_xlabel("Time [h]", fontsize='large')
ax12.set_ylabel('$Storage PtG$', fontsize='large')
plt.show()
plt.savefig('ptg_S.png')

t = res['p2h'].time
lcodh = res['p2h'].loc[:,'p2h.lcodh.cost']
fig5, ax5 = plt.subplots(figsize=(8,6))
ax5.plot(t, lcodh, c='black', linewidth=1, label = "Cost")
ax5.legend(fontsize='small', loc='upper left')
ax5.set_xlabel("Time [h]", fontsize='large')
ax5.set_ylabel('$Cost$ [$EUR/kW$]', fontsize='large')
plt.show()
plt.savefig('pth_cost.png')

t = res['p2h'].time
heat_demand= res['p2h'].loc[:,'p2h.heat_demand']
fig6, ax6 = plt.subplots(figsize=(8,6))
ax6.plot(t, heat_demand, c='r', linewidth=1, label='Heat_demand')
ax6.legend(fontsize='small', loc='upper left')
ax6.set_xlabel("Time [h]", fontsize='large')
ax6.set_ylabel('Demand [m^3/s]', fontsize='large')
plt.show()
plt.savefig('heat_demand.png')

t = res['p2h'].time
power_load = res['p2h'].loc[:,'p2h.hp2.Pelec']
fig7, ax7 = plt.subplots(figsize=(8,6))
ax7.plot(t, power_load, c='r', linewidth=1, label='PtH Load [MW]')
ax7.legend(fontsize='small', loc='upper left')
ax7.set_xlabel("Time [h]", fontsize='large')
ax7.set_ylabel('$P_load$ [$MW$]', fontsize='large')
plt.show()
plt.savefig('heatpump_P.png')

t = res['p2h'].time
COP = res['p2h'].loc[:,'p2h.hp2.COP']
fig8, ax8 = plt.subplots(figsize=(8,6))
ax8.plot(t, COP, c='r', linewidth=1, label='COP')
ax8.legend(fontsize='small', loc='upper left')
ax8.set_xlabel("Time [h]", fontsize='large')
ax8.set_ylabel('$COP$ ', fontsize='large')
plt.show()
plt.savefig('heatpump_COP.png')

t = res['p2h'].time
S_pth = res['p2h'].loc[:,'p2h.storage.S']
fig11, ax11 = plt.subplots(figsize=(8,6))
ax11.plot(t, S_pth, c='r', linewidth=1, label='S[m3]')
ax11.legend(fontsize='small', loc='upper left')
ax11.set_xlabel("Time [h]", fontsize='large')
ax11.set_ylabel('$Storage PtH$ ', fontsize='large')
plt.show()
plt.savefig('heatpump_S.png')