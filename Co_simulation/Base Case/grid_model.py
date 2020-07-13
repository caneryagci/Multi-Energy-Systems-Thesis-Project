# -*- coding: utf-8 -*-
"""
Created on Sun May  3 15:07:11 2020

@author: Caner
"""
import warnings
warnings.filterwarnings("ignore")
import os
import pandas as pd
import pandapower as pp
import matplotlib.pyplot as plt
import pandapower.toolbox as tb
from pandapower.plotting import simple_plot, simple_plotly, pf_res_plotly

net = pp.create_empty_network()
    
min_vm_pu = 0.99
max_vm_pu = 1.02

Pmin_p2g=0
Pmax_p2g=100
Pmin_p2h=0
Pmax_p2h=50
Pmin_extgrid=-10
Pmax_extgrid=10
Pmax_WF = 100
Pmax_PV = 100

    
    #create buses
bus1 = pp.create_bus(net, vn_kv=110., min_vm_pu=min_vm_pu, max_vm_pu=max_vm_pu, name ='Bus 0')
bus2 = pp.create_bus(net, vn_kv=20., min_vm_pu=min_vm_pu, max_vm_pu=max_vm_pu, name ='Bus 1')
bus3 = pp.create_bus(net, vn_kv=20., min_vm_pu=min_vm_pu, max_vm_pu=max_vm_pu, name ='Bus 2')
    
 #create 220/110 kV transformer
pp.create_transformer(net, bus1, bus2, std_type="63 MVA 110/20 kV", max_loading_percent=90)
    
    #create 110 kV lines
pp.create_line(net, bus2, bus3, length_km=20., std_type='NA2XS2Y 1x120 RM/25 12/20 kV', max_loading_percent=90)
    
    #create loads
l1 = pp.create_load(net, bus3, p_mw=10, q_mvar=0, sn_mva=50, min_p_mw=Pmin_p2g,max_p_mw=Pmax_p2g, max_q_mvar=10, min_q_mvar=-10, scaling=1.0, in_service=True, controllable=False,name='Power2Gas',)
l2 = pp.create_load(net, bus3, p_mw=50, q_mvar=0, sn_mva=50, min_p_mw=Pmin_p2h,max_p_mw=Pmax_p2h, max_q_mvar=10, min_q_mvar=-10, scaling=1.0, in_service=True, controllable=False,name='Power2Heat',)
l3 = pp.create_load(net, bus3, p_mw=100, q_mvar=0, sn_mva=100, min_p_mw=0,max_p_mw=100, max_q_mvar=80, min_q_mvar=-80, scaling=1.0, in_service=True, controllable=False,name='Electrical')
    
    #create generators
eg = pp.create_ext_grid(net, bus1,vm_pu=1.0, va_degree=0,min_p_mw=Pmin_extgrid, max_p_mw=Pmax_extgrid, name='External grid')
g0 = pp.create_sgen (net, bus3, p_mw=100, q_mvar=0,   sn_mva=100, name='WF', max_q_mvar=80, min_q_mvar=-80, min_p_mw=0, max_p_mw=Pmax_WF, scaling=1.0, type=None, controllable=True, in_service=True)
    #g1 = pp.create_gen(net, bus3, p_mw=100, min_p_mw=0, max_p_mw=100, vm_pu=1.01, controllable=True)
g1 = pp.create_sgen(net, bus3, p_mw=100,  q_mvar=0,  sn_mva=100, name='PV', max_q_mvar=80, min_q_mvar=-80, min_p_mw=0, max_p_mw=Pmax_PV, scaling=1.0, type=None,  controllable=True, in_service=True)
    
    
    #costeg = pp.create_poly_cost(net, 0, 'ext_grid', cp1_eur_per_mw=10)
    #costgen1 = pp.create_poly_cost(net, 0, 'gen', cp1_eur_per_mw=10)
    #costgen2 = pp.create_poly_cost(net, 1, 'gen', cp1_eur_per_mw=10)
    
   #Maximizing Generation
#pp.create_poly_cost(net,0,'ext_grid',cp1_eur_per_mw=2)   
#pp.create_poly_cost(net, 1, 'sgen', cp1_eur_per_mw=-1)
#pp.create_pwl_cost(net, 1, "sgen", [[net.sgen.min_p_mw.at[0], net.sgen.max_p_mw.at[0], -1]])
#pp.create_poly_cost(net, 0, 'sgen', cp1_eur_per_mw=-1)
#pp.create_pwl_cost(net, 0, "sgen", [[net.sgen.min_p_mw.at[0], net.sgen.max_p_mw.at[0], -1]])
    
    #Minimizing Load
#pp.create_poly_cost(net, 0, 'load', cp1_eur_per_mw=-1)
#pp.create_poly_cost(net, 1, 'load', cp1_eur_per_mw=-1)


#pp.create_poly_cost(net, 2, 'load', cp1_eur_per_mw=-2)
    #pp.create_pwl_cost(net, 0, "load", [[net.load.min_p_mw.at[0], net.load.max_p_mw.at[0], 1]])
    #pp.create_poly_cost(net, 0, 'storage', cp1_eur_per_mw=1)
    #pp.create_pwl_cost(net, 0, "storage", [[net.storage.min_p_mw.at[0], net.storage.max_p_mw.at[0], 1]])


pp.runopp(net, calculate_voltage_angles=False, verbose=True)
#pp.runpp(net)
#if __name__ == "__main__":
#    pp.diagnostic(net)

# save as pickle
simulators_dir = r'C:\Users\Caner\Desktop\Multi-Energy-Systems-Thesis-Project\Co_simulation\Base Case'
pp.to_pickle(net, os.path.join(simulators_dir, 'gridModel.p'))  # absolute path

print(net.res_bus)
print(net.res_sgen)
print(net.res_load)
print(net.res_ext_grid)
print(net.res_line)

#simple_plot(net)
