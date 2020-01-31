clear all;
E_0 = 1.23; %V
F = 96.487; %kj/V(96485 C/mol)
z = 2; %electrons
T = 25 + 273.15; % Kelvin
P = 1; %atm 
R = 8.314; % ideal gas constant (J/(mol·K))
partial_water = 1; % liquid water


delta_S_hydrogen = 130.68 ; %J/(mol.K)
delta_S_oxygen = 205.15 ;  %J/(mol.K)
delta_S_water = 69.95 ;  %J/(mol.K)



%%
% Delta_G_0 @80 celcius = 224.9 (kJ/mol) can be assumed by linear interpolation of Delta_G values for 300 and 400 Kelvin.
% Initialize Delta_G, then calculate E_0
% E_0= Delta_G_0 / (z* F);

Delta_G_0 = z* F* E_0; % Gibbs Free Energy (kJ/mol)
%%
Delta_S_0 = delta_S_hydrogen + (0.5*delta_S_oxygen)- delta_S_water; %Entropy J/(mol.K)

Delta_H_0 = Delta_G_0 + T * (Delta_S_0/1000); %kJ/mol

E_rev = Delta_H_0/(z*F); %V

partial_pressures = exp((E_rev - E_0)/((R*T)/(z*F)));

V_rev = E_0 + ((R*T)/(z*F))* log(partial_pressures); % Nernst equation

%V_rev = E_0 + ((R*T)/(z*F))* log((p_hydrogen* sqrt(p_oxygen))/partial_water); % Nernst equation

%E_total = E_rev + E_act + E_ohm + E_mass

%efficiency = (E_rev/E_total)*100 % percentage