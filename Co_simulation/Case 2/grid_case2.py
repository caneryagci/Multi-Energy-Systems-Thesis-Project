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
import tempfile
import numpy as np
from pandapower.timeseries.data_sources.frame_data import DFData
from pandapower.timeseries.output_writer import OutputWriter
from pandapower.timeseries.run_time_series import run_timeseries
from pandapower.control.controller.const_control import ConstControl

simulators_dir = r'C:\Users\Caner\Desktop\Multi-Energy-Systems-Thesis-Project\Co_simulation\Case 2'

def grid_net():
    
    net = pp.create_empty_network()
        
    min_vm_pu = 0.96
    max_vm_pu = 1.05
    
    Pmin_p2g=0
    Pmax_p2g=50
    Pmin_p2h=0
    Pmax_p2h=50
    Pmin_extgrid=-0.1
    Pmax_extgrid=0.1
    Pmax_WF = 100
    Pmax_PV = 100
    Pmin_PV = 0
    Pmin_WF = 0
    cost_ptg=-14
    cost_pth=-12

        
        #create buses
    bus1 = pp.create_bus(net, vn_kv=220., min_vm_pu=min_vm_pu, max_vm_pu=max_vm_pu, name ='Bus 0')
    bus2 = pp.create_bus(net, vn_kv=110., min_vm_pu=min_vm_pu, max_vm_pu=max_vm_pu, name ='Bus 1')
    bus3 = pp.create_bus(net, vn_kv=110., min_vm_pu=min_vm_pu, max_vm_pu=max_vm_pu, name ='Bus 2')
        
     #create 220/110 kV transformer
    pp.create_transformer(net, bus1, bus2, std_type="100 MVA 220/110 kV", max_loading_percent=100, parallel=1)
    #pp.create_transformer_from_parameters(net, bus1, bus2, sn_mva=20, vn_hv_kv=110, vn_lv_kv=33, vkr_percent=1, vk_percent=1, pfe_kw=1, i0_percent=1, shift_degree=0, tap_phase_shifter=False, in_service=True, name='Trafo', index=None, max_loading_percent=90, parallel=1, df=1.0)
    
        
        #create 110 kV lines
    pp.create_line(net, bus2, bus3, length_km=10., std_type='NAYY 4x120 SE', max_loading_percent=100)
        
        #create loads
    l1 = pp.create_load(net, bus3, p_mw=45, q_mvar=0, sn_mva=60, min_p_mw=23,max_p_mw=50, max_q_mvar=40, min_q_mvar=-40, scaling=1.0, in_service=True, controllable=True,name='Power2Gas',)
    l2 = pp.create_load(net, bus3, p_mw=45, q_mvar=0, sn_mva=60, min_p_mw=22,max_p_mw=50, max_q_mvar=40, min_q_mvar=-40, scaling=1.0, in_service=True, controllable=True,name='Power2Heat',)
    l3 = pp.create_load(net, bus3, p_mw=10, q_mvar=0, sn_mva=240, min_p_mw=0,max_p_mw=200, max_q_mvar=50, min_q_mvar=-50, scaling=1.0, in_service=True, controllable=True,name='Electrical')
    l4 = pp.create_load(net, bus3, p_mw=20, q_mvar=0, sn_mva=20, min_p_mw=0,max_p_mw=20, max_q_mvar=20, min_q_mvar=-20, scaling=1.0, in_service=True, controllable=False,name='Electrical_base')
            
        #create generators
    eg = pp.create_ext_grid(net, bus1,vm_pu=1.0, va_degree=0,min_p_mw=Pmin_extgrid, max_p_mw=Pmax_extgrid, name='external_grid')
    g0 = pp.create_sgen (net, bus3, p_mw=89, q_mvar=0,   sn_mva=110, name='WF', max_q_mvar=80, min_q_mvar=-80, min_p_mw=0, max_p_mw=100, scaling=1.0, type=None, controllable=False, in_service=True)
    g1 = pp.create_sgen(net, bus3, p_mw=0,  q_mvar=0,  sn_mva=110, name='PV', max_q_mvar=80, min_q_mvar=-80, min_p_mw=0, max_p_mw=100, scaling=1.0, type=None,  controllable=False, in_service=True)
    g2 = pp.create_sgen(net, bus3, p_mw=30,  q_mvar=0,  sn_mva=250, name='grid', max_q_mvar=80, min_q_mvar=-80, min_p_mw=0, max_p_mw=240, scaling=1.0, type=None,  controllable=True, in_service=True)
    
    pp.create_poly_cost(net, 0, 'load', cp1_eur_per_mw=-14)
    pp.create_poly_cost(net, 1, 'load', cp1_eur_per_mw=-12)
    pp.create_poly_cost(net, 2, 'load', cp1_eur_per_mw=1)
    #pp.create_poly_cost(net,0,'ext_grid',cp1_eur_per_mw=20) 
    pp.create_poly_cost(net, 0, 'sgen', cp1_eur_per_mw=3)
    pp.create_poly_cost(net, 1, 'sgen', cp1_eur_per_mw=3)
    pp.create_poly_cost(net, 2, 'sgen', cp1_eur_per_mw=20)
    
    pp.runopp(net, calculate_voltage_angles=False, verbose=True)
    return net

net = grid_net()

    #costeg = pp.create_poly_cost(net, 0, 'ext_grid', cp1_eur_per_mw=10)
    #costgen1 = pp.create_poly_cost(net, 0, 'gen', cp1_eur_per_mw=10)
    #costgen2 = pp.create_poly_cost(net, 1, 'gen', cp1_eur_per_mw=10)
    
   #Maximizing Generation
#pp.create_poly_cost(net,0,'ext_grid',cp1_eur_per_mw=20)   

#pp.create_pwl_cost(net, 1, "sgen", [[net.sgen.min_p_mw.at[0], net.sgen.max_p_mw.at[0], -1]])

#pp.create_pwl_cost(net, 0, "sgen", [[net.sgen.min_p_mw.at[0], net.sgen.max_p_mw.at[0], -1]])
    
    #Minimizing Load
#pp.create_poly_cost(net, 0, 'load', cp1_eur_per_mw=1)
#pp.create_poly_cost(net, 1, 'load', cp1_eur_per_mw=-14)


#pp.create_poly_cost(net, 2, 'load', cp1_eur_per_mw=-2)
    #pp.create_pwl_cost(net, 0, "load", [[net.load.min_p_mw.at[0], net.load.max_p_mw.at[0], 1]])
    #pp.create_poly_cost(net, 0, 'storage', cp1_eur_per_mw=1)
    #pp.create_pwl_cost(net, 0, "storage", [[net.storage.min_p_mw.at[0], net.storage.max_p_mw.at[0], 1]])

#pp.runopp(net, calculate_voltage_angles=False, verbose=True)
#pp.runpp(net)
#if __name__ == "__main__":
#    pp.diagnostic(net)

#df = pd.read_excel("multi_timeseries.xlsx",index_col=0)
#ds = DFData(df)
#ConstControl(net, 'sgen',"max_p_mw", element_index=net.sgen.index,  data_source=ds, profile_name=["Wind","PV"])

#ow = OutputWriter(net, time_steps=None, output_path="./results/", output_file_type=".xlsx")
#ow.log_variable("res_sgen","p_mw")
#ow.log_variable("res_line","loading_percent")
# starting the timeseries simulation 
#run_timeseries(net, time_steps=None)

#Results
#df = pd.read_excel("./results/res_sgen/max_p_mw.xlsx",index_col=0)
#df.plot()
#plt.show()





# save as pickle
pp.to_pickle(net, os.path.join(simulators_dir, 'gridModel_case2.p'))  # absolute path

print(net.res_bus)
print(net.res_sgen)
print(net.res_load)
print(net.res_ext_grid)
print(net.res_line)

#simple_plot(net)
