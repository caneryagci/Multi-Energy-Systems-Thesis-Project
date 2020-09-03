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

simulators_dir = r'C:\Users\Caner\Desktop\Multi-Energy-Systems-Thesis-Project\Co_simulation\Case 2'
p2h_loc = os.path.join(simulators_dir, 'P2H.pth_model_B_cosim.fmu')
p2g_loc = os.path.join(simulators_dir, 'Hydrogen.ptg_model_B_cosim.fmu')
grid_loc = os.path.join(simulators_dir, 'gridModel_case2.p')


my_world.add_powerflow('grid1', grid_loc, inputs = ['WF.P', 'WF.max_p_mw', 'PV.P', 'PV.max_p_mw','Power2Heat.P','Power2Gas.P','Power2Gas.max_p_mw','Power2Gas.min_p_mw','Power2Gas.cp1_eur_per_mw','Power2Heat.max_p_mw','Power2Heat.min_p_mw','Power2Heat.cp1_eur_per_mw'], outputs=['Bus 0.V', 'Bus 1.V', 'Bus 2.V', 'WF.P', 'PV.P',
                       'Electrical.P', 'Power2Heat.P', 'Power2Gas.P','grid.P','grid.Q','Electrical.Q' ], step_size=300)


my_world.add_fmu(fmu_name = 'p2g', fmu_loc = p2g_loc, step_size = 3, inputs = ['gas_demand','T_ambient'], 
                 outputs=[ 'electrolyser_detailed1.Pelec','lcoh.cost','gas_demand','electrolyser_detailed1.electrochemical.efficiency2','storage2.S_storage','controller_P2G3.Pmin','controller_P2G3.Pmax'], variable=False, validate=False)

my_world.add_fmu(fmu_name = 'p2h', fmu_loc = p2h_loc, step_size = 3, inputs = ['heat_demand','T_ambient'], 
                 outputs=[ 'hp2.Pelec','lcodh.cost','heat_demand','hp2.COP','storage.S','controller_APL.Pmin','controller_APL.Pmax'], variable=False, validate=False)

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
               'data.WF':'grid1.WF.P',
               'data.PV':'grid1.PV.P',
               'data.WF_max':'grid1.WF.max_p_mw',
               'data.PV_max':'grid1.PV.max_p_mw',           
               'data.ptg_demand':'p2g.gas_demand',
               'data.pth_demand':'p2h.heat_demand',
               'data.T_amb_pth':'p2h.T_ambient',
               'data.T_amb_ptg':'p2g.T_ambient',
               'p2g.electrolyser_detailed1.Pelec':'grid1.Power2Gas.P',
               'p2h.hp2.Pelec':'grid1.Power2Heat.P',
               'p2g.controller_P2G3.Pmin': 'grid1.Power2Gas.min_p_mw',
               'p2g.controller_P2G3.Pmax': 'grid1.Power2Gas.max_p_mw',
               'p2g.lcoh.cost':'grid1.Power2Gas.cp1_eur_per_mw',
               'p2h.controller_APL.Pmin': 'grid1.Power2Heat.min_p_mw',
               'p2h.controller_APL.Pmax': 'grid1.Power2Heat.max_p_mw',
               'p2h.lcodh.cost':'grid1.Power2Heat.cp1_eur_per_mw',               
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

seconds = np.arange(0,90000,7200)
hours = np.arange(0,26,2)

electrolyser_load1 = res['grid1'].loc[:,'grid1.Power2Gas.P']
heatpump_load1 = res['grid1'].loc[:,'grid1.Power2Heat.P']
wind_farm1= res['grid1'].loc[:,'grid1.WF.P']
pv_farm1= res['grid1'].loc[:,'grid1.PV.P']
time = res['grid1'].loc[:,'time']
total_gen = wind_farm1+pv_farm1
total_load = heatpump_load1 + electrolyser_load1 + 20
flexible_demand = total_load - total_gen
fig20, ax20 = plt.subplots(figsize=(12,6))
ax20.plot(time, flexible_demand, 'red', linewidth=1, label = 'Flexible demand of MES')
#ax20=plt.xticks(seconds)
ax20.set_xticks(seconds) 
ax20.grid('on')
ax20.set_xticklabels(hours)
#ax20.set_xticklabels(hours)
#ax20.axvline(86400, color='y', linestyle='--')
#ax20.axvline(172800, color='y', linestyle='--')
#ax20.axvline(259200, color='y', linestyle='--')
#ax20.axvline(345600, color='y', linestyle='--')
#ax20.axvline(432000, color='y', linestyle='--')
#ax20.axvline(518400, color='y', linestyle='--')
#ax20.axvline(604800, color='y', linestyle='--')
#ax20.axvline(691200, color='y', linestyle='--')
ax20.set_ylabel("Active Power [MW]", fontsize=15)
ax20.set_xlabel("Time [h]", fontsize=15)
ax20.legend(fontsize=15)
#plt.show()
plt.savefig('flexible demand of MES.png')
plt.savefig('flexible_capacity_basecase.pdf',bbox_inches='tight', pad_inches=0.01)



wind_farm= res['grid1'].loc[:,'grid1.WF.P']
pv_farm= res['grid1'].loc[:,'grid1.PV.P']
grid= res['grid1'].loc[:,'grid1.grid.P']
time = res['grid1'].loc[:,'time']
fig0, ax0 = plt.subplots(figsize=(8,6))
ax0.plot(time, wind_farm, 'black', linewidth=1, label = 'WF (MW)')
ax0.plot(time, pv_farm, 'blue', linewidth=1, label = 'PV (MW)')
ax0.plot(time, grid, 'red', linewidth=1, label = 'Grid (MW)')
ax0.set_ylabel("Active Power [MW]", fontsize='large')
ax0.set_xlabel("Time [s]", fontsize='large')
ax0.legend(fontsize='small')
#plt.show()
plt.savefig('RES_P.png')


Electrical_Q= res['grid1'].loc[:,'grid1.Electrical.Q']
grid_Q= res['grid1'].loc[:,'grid1.grid.Q']
Q_result = Electrical_Q-grid_Q
time = res['grid1'].loc[:,'time']
fig8, ax8 = plt.subplots(figsize=(8,6))
#ax8.plot(time, Electrical_Q, 'black', linewidth=1, label = 'Electrical (MVar)')
#ax8.plot(time, grid_Q, 'red', linewidth=1, label = 'Grid (MVar)')
ax8.plot(time, Q_result, 'blue', linewidth=1, label = 'Reactive power injected to bus 3 (MVar)')
ax8.set_ylabel("Reactive Power [MVar]", fontsize='large')
ax8.set_xlabel("Time [s]", fontsize='large')
ax8.legend(fontsize='small')
#plt.show()
plt.savefig('MES_Q.png')



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
ax1.plot(time, electrical_load, 'green', linewidth=1, label='Excess RE (MW)')
ax1.plot(time, wind_farm, 'black', linewidth=1, label = 'WF(MW)')
ax1.plot(time, pv_farm, 'blue', linewidth=1, label = 'PV(MW)')
ax1.set_ylabel("Power [MW]", fontsize='large')
ax1.set_xlabel("Time [s]", fontsize='large')
ax1.legend(fontsize='small',loc='lower right')
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