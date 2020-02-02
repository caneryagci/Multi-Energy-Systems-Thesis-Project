%% Curve fitting
% open "sftool" for 2-D curve fitting. Find COP(Tamb,Tsource/sink) equations' coefficients. 

%LWC_column = [30 30 30 30 30 30 30 30 30 35 35 35 35 35 35 35 35 35 40 40 40 40 40 40 40 40 40 45 45 45 45 45 45 45 50 50 50 50 50 50 55 55 55 55 55]; %Leaving Water Condensor temperature [°C]
%Tamb_column = [-20 -15 -10 -5 0 5 10 15 20 -20 -15 -10 -5 0 5 10 15 20 -20 -15 -10 -5 0 5 10 15 20 -10 -5 0 5 10 15 20 -5 0 5 10 15 20 0 5 10 15 20];
%HC_column = [8.35 9.38 11.5 13 14.4 16.3 18.5 20 22.5 8.31 9.33 11.3 12.7 14.1 16 18.1 19.5 22 8.27 9.28 11.1 12.5 13.8 15.6 17.6 19 21.4 10.9 12.2 13.5 15.2 17.2 18.5 20.8 12 13.1 14.8 16.7 18 20.3 11.9 13.4 15.1 16.6 18.7]; % kW
%PI_column = [3.25 3.33 3.42 3.46 3.48 3.50 3.51 3.51 3.50 3.54 3.63 3.73 3.78 3.81 3.83 3.85 3.86 3.85 3.89 3.98 4.1 4.15 4.19 4.22 4.24 4.25 4.25 4.52 4.58 4.62 4.66 4.69 4.69 4.70 5.06 5.11 5.15 5.18 5.20 5.21 5.35 5.40 5.44 5.75 5.77]; % kW

%LWC = LWC_column.'; % column to row
%Tamb = Tamb_column.';

%PI_column = PI_column.'; %Power input [kW], measured acc. Eurovent 6/C/003-2006 [kW]
%HC_column = HC_column.'; % Heating capacity at maximum operating frequency, measured acc. Eurovent 6/C/003-2006 [kW]
%COP = HC_column./PI_column; % Coefficient of performance

%% Plotting

T = zeros(25,1);
COP_30 = zeros(25,1);
COP_40 = zeros(25,1);
COP_50 = zeros(25,1);

for i= 1 :1: 25
    Tamb = i-15;
    LWC_high = 50;
    LWC_mid = 40;
    LWC_low = 30;
    
    COP_30(i) = 7.505 + 0.1655*Tamb + 0.0006427*(Tamb^2) - 0.002327*Tamb*LWC_low - 0.1289*LWC_low + 0.0006111*(LWC_low^2);% coefficient of performance
    COP_40(i) = 7.505 + 0.1655*Tamb + 0.0006427*(Tamb^2) - 0.002327*Tamb*LWC_mid - 0.1289*LWC_mid + 0.0006111*(LWC_mid^2);% coefficient of performance
    COP_50(i) = 7.505 + 0.1655*Tamb + 0.0006427*(Tamb^2) - 0.002327*Tamb*LWC_high - 0.1289*LWC_high + 0.0006111*(LWC_high^2);% coefficient of performance
    T(i)= Tamb;
end

%% Current sweep
plot(T,COP_30,T,COP_40,T,COP_50,'LineWidth',1.5);
grid on;
grid minor;
legend('COP @30C','COP @40C','COP @50C','Location','northeast');
xlabel('T ambient(Celcius)');
ylabel('COP @ Leaving Water Condensor temperature ');
ylim([1 6]);
xlim([-15 15]);