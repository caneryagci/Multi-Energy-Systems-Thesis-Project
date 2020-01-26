V_0 = 1.48; %V
A = 12.25; % membrane area(cm^2)
T = 25 + 273.15; % Kelvin
beta_A = 0.5;
beta_C = 0.5; 
v_Ae = 3;
v_Ce = -1;
L_B = 175e-4; %thickness of the membrane (cm)
R_I = 0; %MEA interfacial resistance (ohm.cm-2)
F = 96485; % Faraday constant kj/V (96485 C/mol);
R = 8.314; % ideal gas constant (J/(mol·K))
E_u = 14; % kj.mol-1 water viscosity activation energy
E_A = 76; % kj.mol-1
E_C = 4.3; %kj.mol-1
lambda = 20;
r = 30; %V_B/V_w=537/18=30 the ratio of membrane partial molar volume of polymer electrolyte to that of water.
delta = 1.65;
e_B0 = 1.8;
e_B = (lambda)/(lambda+r);
K_a = exp((-52300/R)*((1/T)-(1/298))); %maybe 52.300(?)dissociation equilibrium constant for acid sites
beta = ((lambda+1)-sqrt(((lambda+1)^2)-4*lambda*(1-(1/K_a))))/(2*(1-(1/K_a)));

n_h2 = 5.1822e-10*1; %molar hydrogen production rate (moles.s-1.cm-2)(n_h2 =i/2F)

sigma_B = (e_B-e_B0)^1.5*(349.8/(1+delta))*exp(-(E_u/R)*((1/T)-(1/298)))*(1/(18*lambda))*beta;

i = 2*F*n_h2; %A.cm-2, The current density and the molar hydrogen production rate relation

%% The exchange current densities for the anode and the cathode reactions, and the limiting current densities for the two electrodes
%i_AL = 2; % A.cm-2
%i_CL = 2; % A.cm-2
phi_I = 0.75; %the fraction of metal catalyst surface in contact with the ionomer, forming the three-phase interface, or TPI
m_MA = 1e-3; %the catalyst leading
m_MC = 0.3e-3; %the catalyst leading

rho_Pt = 21.45; %Platinum density (g.cm-3)(Cathode)
rho_Ir = 22.56; %Iridium density (g.cm-3)(Anode)

d_MA = 2.7;%nm %the supported or unsupported catalyst crystallite diameter
d_MC = 2.9;%nm %the supported or unsupported catalyst crystallite diameter

gama_MA = phi_I * m_MA*6/(rho_Ir*d_MA);
gama_MC = phi_I * m_MC*6/(rho_Pt*d_MC);
i_A0 = gama_MA * exp(-(E_A/R)*((1/T)-(1/298))) *5e-12; % A.cm-2
i_C0 = gama_MC * exp(-(E_C/R)*((1/T)-(1/298))) *1e-3; % A.cm-2

%%
V = V_0+((R*T)/(beta_A*F))*asinh(0.5*(i/i_A0))-((R*T)/(beta_C*v_Ce*F))* asinh(0.5*(i/i_C0))+ i*(L_B/sigma_B)+i*R_I;
%V = V_0+((R*T)/(beta_A*F))*asinh(0.5*((i/i_A0)/(1-(i/i_AL))))-((R*T)/(beta_C*v_Ce*F))* asinh(0.5*((i/i_C0)/(1-(i/i_CL))))+ i*(L_B/sigma_B)+i*R_I;















