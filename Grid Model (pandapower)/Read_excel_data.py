# -*- coding: utf-8 -*-
"""
Created on Fri May  1 19:12:53 2020

@author: Caner
"""
import pandas as pd
import pandapower as pp

net = pp.create_empty_network()

df = pd.read_excel("Grid_model.xlsx",sheet_name="bus", index_col=0)
#print(df)
for idx in df.index:
    pp.create_bus(net, vn_kv=df.at[idx,"vn_kv"])
#print(net.bus)
    
df = pd.read_excel("Grid_model.xlsx",sheet_name="load", index_col=0)
for idx in df.index:
    pp.create_load(net, bus=df.at[idx,"bus"], p_mw=df.at[idx, "p"])
#print(net.load)
    
df = pd.read_excel("Grid_model.xlsx",sheet_name="slack", index_col=0)
for idx in df.index:
    pp.create_ext_grid(net, bus=df.at[idx,"bus"], vm_pu=df.at[idx, "vm_pu"], va_degree=df.at[idx,"va_degree"])
#print(net.ext_grid)

df = pd.read_excel("Grid_model.xlsx",sheet_name="line", index_col=0)
for idx in df.index:
    pp.create_line_from_parameters(net, *df.loc[idx,:])
#print(net.line)
    
df = pd.read_excel("Grid_model.xlsx",sheet_name="trafo", index_col=0)
for idx in df.index:
    pp.create_transformer(net, hv_bus=df.at[idx,"hv_bus"], lv_bus=df.at[idx, "lv_bus"],std_type=df.at[idx,"std_type"])
#print(net.trafo)

pp.runpp(net)
print(net.res_bus)