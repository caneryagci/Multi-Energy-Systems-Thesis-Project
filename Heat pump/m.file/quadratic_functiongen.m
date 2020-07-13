T_evaporation_column = [-20 -16 -12 -8	-4 0 4 8 12	16 20 24 28 32]; %R134a Evaporator temperature [°C]
COP_column = [2.446523661 2.592221915 2.754034717 2.93422615 3.137168656 3.364901652 3.623766134 3.921731792 4.262871005 4.655942783 5.12526591 5.673682343 6.343725271 7.168602058];


T_evaporation = T_evaporation_column.'; % column to row
COP = COP_column.';
%sftool(T_evaporation,COP)
%cftool(T_evaporation,COP)