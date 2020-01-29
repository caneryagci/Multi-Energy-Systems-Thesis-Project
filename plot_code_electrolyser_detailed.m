V_0 = 1.48; %V
A = 12.25; % membrane area(cm^2)
T = 80 + 273.15; % Kelvin
beta_A = 0.5;
beta_C = 0.5; 
v_Ae = 2;
v_Ce = -2;
L_B = 178e-4; %thickness of the membrane (cm)
R_I = 0; %MEA interfacial resistance (ohm.cm-2)
F = 96485; % Faraday constant kj/V (96485 C/mol);
R = 8.314; % ideal gas constant (J/(mol·K))
E_u = 14e3; % j.mol-1 water viscosity activation energy
E_A = 76e3; % j.mol-1
E_C = 4.3; %kj.mol-1
lambda = 20;
r = 30; %V_B/V_w=537/18=30 the ratio of membrane partial molar volume of polymer electrolyte to that of water.
delta = 1.65;
e_B0 = 1.8;
e_B = (lambda)/(lambda+r);
K_a = exp((-52300/R)*((1/T)-(1/298))); %maybe 52.300(?)dissociation equilibrium constant for acid sites
beta = ((lambda+1)-sqrt(((lambda+1)^2)-4*lambda*(1-(1/K_a))))/(2*(1-(1/K_a)));

    n_h2 = zeros(200,1);
    I = zeros(200,1);
    j = zeros(200,1);
    V = zeros(200,1);
    i_A0 = zeros(200,1);
    i_C0 = zeros(200,1);
    P_in = zeros(200,1); 



%%
%n_h2 = 5.2e-6*1; %molar hydrogen production rate (moles.s-1.cm-2)(n_h2 =i/2F)

%sigma_B = (e_B-e_B0)^1.5*(349.8/(1+delta))*exp(-(E_u/R)*((1/T)-(1/298)))*(1/(18*lambda))*beta;
sigma_B = 0.14; %S/cm

%I = 2*F*n_h2; %A.cm-2, The current density and the molar hydrogen production rate relation
%i= I/A; %Total cell current
%% The exchange current densities for the anode and the cathode reactions, and the limiting current densities for the two electrodes
%i_AL = 2; % A.cm-2
%i_CL = 2; % A.cm-2
phi_I = 0.75; %the fraction of metal catalyst surface in contact with the ionomer, forming the three-phase interface, or TPI
m_MA = 1e-3; %the catalyst leading
m_MC = 0.3e-3; %the catalyst leading

rho_Pt = 21.45; %Platinum density (g.cm-3)(Cathode)
rho_Ir = 22.56; %Iridium density (g.cm-3)(Anode)

d_MA = 2.7e-9;%nm %the supported or unsupported catalyst crystallite diameter
d_MC = 2.9e-9;%nm %the supported or unsupported catalyst crystallite diameter

%gama_MA = phi_I * m_MA*6/(rho_Ir*d_MA);
%gama_MC = phi_I * m_MC*6/(rho_Pt*d_MC);
gama_M = 150; %roughness factor

%i_A0 = gama_M * exp(-(E_A/R)*((1/T)-(1/298))) *5e-12; % A.cm-2
%i_C0 = gama_M * exp(-(E_C/R)*((1/T)-(1/298))) *1e-3; % A.cm-2

%i_A0 = 1e-12; %Pt %Anode exchange current density
%i_A0 = 1e-7; %Pt-Ir A/cm2
%i_A0 = gama_MA * exp(-(E_A/R)*((1/T)-(1/298))) *5e-12; % A.cm-2

%i_C0 = 1e-3; % cathode exchange current density A/cm2
%i_C0 = gama_MC * exp(-(E_C/R)*((1/T)-(1/298))) *1e-3; % A.cm-2

%%
%V = V_0+((R*T)/(F))*asinh(0.5*(i/i_A0))+((R*T)/(F))* asinh(0.5*(i/i_C0))+ i*(L_B/sigma_B)+i*R_I;
%V = V_0+((R*T)/(beta_A*F))*asinh(0.5*((i/i_A0)/(1-(i/i_AL))))-((R*T)/(beta_C*v_Ce*F))* asinh(0.5*((i/i_C0)/(1-(i/i_CL))))+ i*(L_B/sigma_B)+i*R_I;

%P_in = V*I;



for i= 1 :1: 200
    n_h2(i) = 5.2e-6*(0.01*i);   
    I(i) = 2*F*n_h2(i);
    j(i)= I(i)/A;
    i_A0(i) = gama_M * exp(-(E_A/R)*((1/T)-(1/298))) *5e-12; % A.cm-2
    i_C0(i) = gama_M * exp(-(E_C/R)*((1/T)-(1/298))) *1e-3; % A.cm-2
    V(i) = V_0+((R*T)/(F))*asinh(0.5*(j(i)/i_A0(i)))+((R*T)/(F))* asinh(0.5*(j(i)/i_C0(i)))+ j(i)*(L_B/sigma_B)+j(i)*R_I;
    P_in(i) = V(i)*I(i);
end

%% Current sweep
plot(I,V,I,P_in,'LineWidth',1.5);
grid on;
grid minor;
legend('E_total(V)','P_in(W)','Location','northeast');
xlabel('Current Density(A.m-2)');
ylabel('Cell Voltage(V)');
ylim([0 4]);
xlim([0 2]);










