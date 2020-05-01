# -*- coding: utf-8 -*-
"""
Created on Fri May  1 13:05:40 2020

@author: Caner
"""

import pandapower.networks as nw
from pandapower.plotting import simple_plot, simple_plotly, pf_res_plotly

net = nw.mv_oberrhein()
print(net)
print(net.res_bus)
#simple_plotly(net)
#pf_res_plotly(net)