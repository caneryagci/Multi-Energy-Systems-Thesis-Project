% Parameters of Weibull distribution of wind speed
k=2.02; %Shape parameter in p.u.
lambda=11; %Scale parameter in m/s
%Parameters of wind power plant
Pwpp=180; %Max. MW of the wind power plant
wsin=3; % Cut in wind speed in (m/s)
wsr=12; %Rated wind speed in (m/s)
wsout=20; % Cut-off wind speed in (m/s)
wpcoshphi=1; %Operation at unit power factor
P_0 = -50; %MW
Q_0 = 5;    %MVar
V_0 = 1;    %p.u.
V = 0.95;   %p.u.
S_b = 100; %MVA
alphap = 0;
alphaq = 0;
 
%% Step 2: Generate random variation wind power of nodal load demand
N=10000; %Amount of random samples to be generated
%Wind power
ws_rand = wblrnd(lambda,k,N,1); %Random wind speed following Weibull distribution
%ws_rand = [1:1:30]; % For Power curve drawing
Pwpp_act=zeros(size(ws_rand));
for i=1:length(ws_rand) %Consideration of power curve
if ws_rand(i)<wsin
Pwpp_act(i)=0;
elseif ws_rand(i)>wsin && ws_rand(i)<=wsr
Pwpp_act(i)=Pwpp*(ws_rand(i)^3-wsin^3)/(wsr^3-wsin^3);
elseif ws_rand(i)>wsr && ws_rand(i)<wsout
Pwpp_act(i)=Pwpp;
elseif ws_rand(i)>wsout
Pwpp_act(i)=0;
end
end

scaling = -Pwpp_act / P_0;
a = V / V_0;
P = scaling * (P_0 / S_b) * a ^ alphap *-S_b;
Q = scaling * (Q_0 / S_b) * a ^ alphaq *-S_b;


%% Plot
plot(ws_rand,Pwpp_act,'LineWidth',1.5);
 grid on;
 grid minor;
% legend('E_total','Erev_0','Location','northeast');
 xlabel('Wind Speed');
 ylabel('Power Output (MW)');
 %ylim([0 200]);
 %xlim([0 40]);

plot(Q);
xlim([0 40]);