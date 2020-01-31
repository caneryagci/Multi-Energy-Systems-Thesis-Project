
%% Parameters
F = 96.487; % Faraday constant kj/V (96485 C/mol)
T = 80+273.15; %Kelvin
A = 12.25; % membrane area(cm^2)
thickness = 178e-6; %thickness of the membrane (micro meter)
conductivity = 0.0165e2; %conductivity of the membrane (S*cm^-1)*1e2 [becomes nonlinear due to bubble overvoltage effect for higher current densities than 1.5A]
%% Input hydrogen production rate from control
%H_flow = 1.2462e-7* I_cell; %m3/s
%h_flow = 7.477*I_cell; % ml/min

H_flow = 6.231000000000000e-08; % m3/s %1.869300000000000e-07;


%% Calculate I_cell / j_cell
I_cell = H_flow/(1.2462e-7);
j =(I_cell/A)*1e4; % current density A*cm^-2*1e4

%% Calculate E_cell and E_loss
Erev_0 = 1.449 - (0.0006139*T) - (4.592e-7 * (T^2)) + (1.46e-10*T^3); % V

E_ohm = (thickness*j)/conductivity ; %V % This one is only useful until 1.5 A then conductivity becomes non-linear
R_ohm = E_ohm/I_cell;

E_act =  0.0514*I_cell + 0.2798; %V
R_act = E_act/I_cell;

E_mass = 0;
R_mass = E_mass/I_cell;

E_loss = E_act + E_ohm + E_mass;
E_total = Erev_0 + E_loss;

%% Calculate effficiency and Pin
efficiency = (1.48/E_total)*100; % percentage

P_in = I_cell * E_total;

%open_system('Electrolyser_cell');
%for i= 6.2e-8 :1e-8: 19e-8
%   H_flow = i;      %K/W
%    sim('Electrolyser_cell');
 %   j(i) = j;
 %   junc_temp(i)= Tj(51,2);
 %   case_temp(i) = T_case(51,2);
 %   heatsink_t (i) = T_heatsink(51,2);
%end
%plot(resistance_h,junc_temp,resistance_h,case_temp,resistance_h,heatsink_t,resistance_h,ambient_t,'LineWidth',1.5);
%grid on;
%grid minor;
%legend('Tj','T case','T heatsink','T ambient','Location','northeast');
%xlabel('Current Density');
%ylabel('Cell Voltage');
%ylim([0 3]);
%xlim([200 1500]);