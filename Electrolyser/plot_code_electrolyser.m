
%% Parameters
F = 96.487; % Faraday constant kj/V (96485 C/mol)
T = 80+273.15; %Kelvin
A = 12.25; % membrane area(cm^2)
thickness = 178e-6; %thickness of the membrane (micro meter)
conductivity = 0.0165e2; %conductivity of the membrane (S*cm^-1)*1e2 [becomes nonlinear due to bubble overvoltage effect for higher current densities than 1.5A]
    %T = zeros(125,1);
    I_cell = zeros(125,1);
    j =zeros(125,1);
    Erev_0 = zeros(125,1); % V
    Erev_0_T25 = zeros(125,1);
    Erev_0_T50 = zeros(125,1);
    E_ohm = zeros(125,1);
    E_act =  zeros(125,1);
    E_loss = zeros(125,1);
    E_total = zeros(125,1);
    efficiency = zeros(125,1);
    P_in = zeros(125,1);

%% Input hydrogen production rate from control
%H_flow = 1.2462e-7* I_cell; %m3/s
%h_flow = 7.477*I_cell; % ml/min

%H_flow = 6.231000000000000e-08; % m3/s %1.869300000000000e-07;


%% Calculate I_cell / j_cell
%I_cell = H_flow/(1.2462e-7);
%j =(I_cell/A)*1e4; % current density A*cm^-2*1e4

%% Calculate E_cell and E_loss
%Erev_0 = 1.449 - (0.0006139*T) - (4.592e-7 * (T^2)) + (1.46e-10*T^3); % V

%E_ohm = (thickness*j)/conductivity ; %V % This one is only useful until 1.5 A then conductivity becomes non-linear
%R_ohm = E_ohm/I_cell;

%E_act =  0.0514*I_cell + 0.2798; %V
%R_act = E_act/I_cell;

%E_mass = 0;
%R_mass = E_mass/I_cell;

%E_loss = E_act + E_ohm + E_mass;
%E_total = Erev_0 + E_loss;

%% Calculate effficiency and Pin
%efficiency = (1.48/E_total)*100; % percentage
%P_in = I_cell * E_total;

for i= 1 :1: 125
    T = 80+273.15;
    T_25 = 25+273.15;
    T_50 = 50+273.15;
    %T(i) = 20+(0.7*i);
    
    H_flow = (i*0.1e-8)+(5.7e-8);
    %H_flow = 6.5e-8;
    
    I_cell(i) = H_flow/(1.2462e-7);
    j(i) =(I_cell(i)/A)*1e4; % current density A*cm^-2*1e4
    
    Erev_0(i) = 1.449 - (0.0006139*T) - (4.592e-7 * (T^2)) + (1.46e-10*T^3); % V
    Erev_0_T25(i) = 1.449 - (0.0006139*T_25) - (4.592e-7 * (T_25^2)) + (1.46e-10*T_25^3); % V
    Erev_0_T50(i) = 1.449 - (0.0006139*T_50) - (4.592e-7 * (T_50^2)) + (1.46e-10*T_50^3); % V
    %Erev_0(i) = 1.449 - (0.0006139*T(i)) - (4.592e-7 * (T(i)^2)) + (1.46e-10*T(i)^3); % V
    
    E_ohm(i) = (thickness*j(i))/conductivity ;
    E_act(i) =  0.0514*I_cell(i) + 0.2798;
    E_loss(i) = E_act(i) + E_ohm(i);
    E_total(i) = Erev_0(i) + E_loss(i);
    efficiency(i) = (1.48/E_total(i))*100; % percentage
    P_in(i) = I_cell(i) * E_total(i);
end

%% Current sweep
plot(j,E_total,j,Erev_0,j,Erev_0_T25,j,Erev_0_T50,'LineWidth',1.5);
grid on;
grid minor;
title('Simple(Linear) Model');
legend('Ecell(total)','Erev@25C','Erev@50C','Erev@80C','Location','northeast');
xlabel('Current Density(A.m-2)');
ylabel('Cell Voltage(V)');
ylim([1 2]);
xlim([400 1200]);

%% Temperature sweep (change commented lines inside the for loop + "T")
% plot(T,E_total,T,Erev_0,'LineWidth',1.5);
% grid on;
% grid minor;
% legend('E_total','Erev_0','Location','northeast');
% xlabel('Temperature');
% ylabel('Cell Voltage');
% ylim([1.2 2]);
% xlim([20 110]);