# -*- coding: utf-8 -*-
"""
Created on Tue Jul 21 14:52:14 2020

@author: Caner
"""

from fmpy import *
p2g_loc = os.path.join(simulators_dir, 'Hydrogen.P2G_basecase.fmu')
res = simulate_fmu(p2g_loc, stop_time = 1000, output=["staticgen.Pgen","lcoh.cost"])
res