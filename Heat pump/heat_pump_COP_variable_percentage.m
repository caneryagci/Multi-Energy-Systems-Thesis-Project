%% Parameters
h2 = 114; %Wh/kg
h3 = 126; %Wh/kg
h4 = 69; %Wh/kg
T_flow = 90;
T_source = 50;

T = zeros(40,1);
COP = zeros (40,1);

%% Calculation
%COP = (h3-h4)/(h3-h2);

% if ((T_flow - 90)> 0)
%     COP = COP -(COP*0.025);
% elseif ((T_flow - 90)< 0)
%     COP = COP +(COP*0.025);
% else
% end
% 
% if ((T_source - 25)> 0)
%     COP = COP +(COP*0.027);
% elseif ((T_source - 25)< 0)
%     COP = COP -(COP*0.027);
% else
% end

for i= 1 :1: 40
    T_source = 50-i;
    
    COP(i) = (h3-h4)/(h3-h2);
    
   if ((T_flow - 90)> 0)
        COP(i) = COP(i) -(COP(i)*0.025*abs(T_flow-90));
    elseif ((T_flow - 90)< 0)
        COP(i) = COP(i) +(COP(i)*0.025*abs(T_flow-90));
   end

    if ((T_source - 25)> 0)
        COP(i) = COP(i) +(COP(i)*0.027*abs(T_source-25));
    elseif ((T_source - 25)< 0)
        COP(i) = COP(i) -(COP(i)*0.027*abs(T_source-25));
    end
    
    T(i)= T_source;
end

%% T_source sweep
plot(T,COP,'LineWidth',1.5);
grid on;
grid minor;
legend('COP','Location','northeast');
xlabel('T ambient(Celcius)');
ylabel('COP @ Leaving Water Condensor temperature ');
ylim([2 6]);
xlim([10 50]);