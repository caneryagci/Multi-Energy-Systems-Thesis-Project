# -*- coding: utf-8 -*-
"""
Created on Fri May  1 19:34:56 2020

@author: Caner
"""
import os
import numpy as np
import pandas as pd
import pandapower as pp
from pandapower.timeseries.data_sources.frame_data import DFData
import pandapower.networks as nw
import matplotlib.pyplot as plt
from pandapower.control.controller.const_control import ConstControl
from pandapower.timeseries.run_time_series import run_timeseries
from pandapower.timeseries.output_writer import OutputWriter
 
# load a pandapower network
net = nw.example_simple()

net.gen.drop(net.gen.index, inplace=True)
pp.create_sgen(net,5, p_mw=1,name='sgen1')


# load your timeseries file (here .xlsx file)

df = pd.read_excel("multi_timeseries.xlsx",index_col=0)
#df.loc[:,['Wind','PV','residential']].plot()
#df.plot()
#plt.show()
# create the data source from it
ds = DFData(df)
#print(df)

# initialising ConstControl controller to update values of the regenerative generators ("sgen" elements)
# the element_index specifies which elements to update (here all sgens in the net since net.sgen.index is passed)
# the controlled variable is "p_mw"
# the profile_name are the columns in the csv file (here this is also equal to the sgen indices 0-N )
ConstControl(net, 'sgen',"p_mw", element_index=net.sgen.index,  data_source=ds, profile_name=["Wind","PV"])
ConstControl(net, 'load',"p_mw", element_index=net.load.index,  data_source=ds, profile_name=["residential"])


ow = OutputWriter(net, time_steps=None, output_path="./results/", output_file_type=".xlsx")
ow.log_variable("res_bus","vm_pu")
ow.log_variable("res_line","loading_percent")
# starting the timeseries simulation 
run_timeseries(net, time_steps=None)

#Results
df = pd.read_excel("./results/res_line/loading_percent.xlsx",index_col=0)
df.plot()
plt.show()


