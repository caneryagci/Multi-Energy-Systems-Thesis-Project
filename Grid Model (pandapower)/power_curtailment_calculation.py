# -*- coding: utf-8 -*-
"""
Created on Sat May  2 14:37:52 2020

@author: Caner
"""
import pandas as pd
import pandapower as pp
net = pp.create_empty_network()

#create buses
bus1 = pp.create_bus(net, vn_kv=220., min_vm_pu=1.0, max_vm_pu=1.02)
bus2 = pp.create_bus(net, vn_kv=110., min_vm_pu=1.0, max_vm_pu=1.02)
bus3 = pp.create_bus(net, vn_kv=110., min_vm_pu=1.0, max_vm_pu=1.02)
bus4 = pp.create_bus(net, vn_kv=110., min_vm_pu=1.0, max_vm_pu=1.02)

#create 220/110 kV transformer
pp.create_transformer(net, bus1, bus2, std_type="100 MVA 220/110 kV", max_loading_percent=100)

#create 110 kV lines
pp.create_line(net, bus2, bus3, length_km=70., std_type='149-AL1/24-ST1A 110.0', max_loading_percent=100)
pp.create_line(net, bus3, bus4, length_km=50., std_type='149-AL1/24-ST1A 110.0', max_loading_percent=100)
pp.create_line(net, bus4, bus2, length_km=40., std_type='149-AL1/24-ST1A 110.0', max_loading_percent=100)

#create loads
pp.create_load(net, bus2, p_mw=60, controllable=False)
pp.create_load(net, bus3, p_mw=70, controllable=False)
pp.create_load(net, bus4, p_mw=10, controllable=False)

#create generators
eg = pp.create_ext_grid(net, bus1)
g0 = pp.create_gen(net, bus3, p_mw=80, min_p_mw=0, max_p_mw=80,  vm_pu=1.01, controllable=True)
g1 = pp.create_gen(net, bus4, p_mw=100, min_p_mw=0, max_p_mw=100, vm_pu=1.01, controllable=True)

pp.create_poly_cost(net, 0, 'gen', cp1_eur_per_mw=-1)
#To create a gen with costs of 1€/MW between 0 and 20 MW and 2€/MW between 20 and 30:
#pp.create_pwl_cost(net, 0, 'gen', [[0, 20, 1], [20, 30, 2]])
pp.create_poly_cost(net, 1, 'gen', cp1_eur_per_mw=-1)
pp.create_poly_cost(net, 0, 'ext_grid', cp1_eur_per_mw=0)

#Maximizing Generation
#pp.create_poly_cost(net, 0, 'sgen', cp1_eur_per_mw=-1)
#pp.create_poly_cost(net, 0, 'gen', cp1_eur_per_mw=-1)
#pp.create_pwl_cost(net, 0, "sgen", [[net.sgen.min_p_mw.at[0], net.sgen.max_p_mw.at[0], -1]])
#pp.create_pwl_cost(net, 0, "gen", [[net.gen.min_p_mw.at[0], net.gen.max_p_mw.at[0], -1]])

#Minimizing Load
#pp.create_poly_cost(net, 0, 'load', cp1_eur_per_mw=1)
#pp.create_poly_cost(net, 0, 'storage', cp1_eur_per_mw=1)
#pp.create_pwl_cost(net, 0, "load", [[net.load.min_p_mw.at[0], net.load.max_p_mw.at[0], 1]])
#pp.create_pwl_cost(net, 0, "storage", [[net.storage.min_p_mw.at[0], net.storage.max_p_mw.at[0], 1]])



pd.concat([net.res_gen.p_mw, net.gen.min_p_mw, net.gen.max_p_mw], axis=1)
pd.concat([net.line.max_loading_percent, net.res_line.loading_percent], axis=1)
pd.concat([net.trafo.max_loading_percent, net.res_trafo.loading_percent], axis=1)
pd.concat([net.res_bus.vm_pu, net.bus.min_vm_pu, net.bus.max_vm_pu], axis=1)

pp.runopp(net, verbose=True)
print(net.res_bus)