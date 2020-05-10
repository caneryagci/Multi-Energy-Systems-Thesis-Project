# -*- coding: utf-8 -*-
"""
Created on Mon May  4 17:17:52 2020

@author: Caner
"""
import os
import pandas as pd
import pandapower as pp
simulators_dir = r'D:\Modelica Libraries\Digvijay Co-sim'
net1 = pp.from_pickle(os.path.join(simulators_dir, 'gridModel.p')) #absolute pathD:\Modelica Libraries\Digvijay Co-sim
#net2 = pp.from_pickle("gridModel.p") #relative path
print(net)
print(net.res_gen)
print(net.res_load)
print(net.res_ext_grid)
simple_plot(net)