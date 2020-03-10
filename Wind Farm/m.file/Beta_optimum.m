c1= 0.5;
c2=116;
c3=0.4;
c4=5;
c5=21;
c6=0;

cp01=0.1;
cp02=0.2;
cp03=0.3;
cp35=0.35;

n=80;

lambda = zeros(n,1);
lambda01 = zeros(n,1);
lambda02 = zeros(n,1);
lambda03 = zeros(n,1);
lambda35 = zeros(n,1);
beta_01 = zeros(n,1);
beta_02 = zeros(n,1);
beta_03 = zeros(n,1);
beta_35 = zeros(n,1);

for i= 1 :1: n
    lambda(i)=i/5;
    
    lambda01(i) = 1 / (1 / (lambda(i) + 0.08*cp01+(1.e-15)) - 0.035 / (cp01 ^ 3 + 1));    
    beta_01(i) = c1 * (c2 / lambda01(i) - c3 * cp01 - c4) * exp(-c5 / lambda01(i)) + c6 * lambda01(i);
    
    lambda02(i) = 1 / (1 / (lambda(i) + 0.08*cp5+(1.e-15)) - 0.035 / (cp5 ^ 3 + 1));    
    beta_02(i) = c1 * (c2 / lambda02(i) - c3 * cp5 - c4) * exp(-c5 / lambda02(i)) + c6 * lambda02(i);
    
    lambda03(i) = 1 / (1 / (lambda(i) + 0.08*cp03+(1.e-15)) - 0.035 / (cp03 ^ 3 + 1));    
    beta_03(i) = c1 * (c2 / lambda03(i) - c3 * cp03 - c4) * exp(-c5 / lambda03(i)) + c6 * lambda03(i);
    
    lambda35(i) = 1 / (1 / (lambda(i) + 0.08*cp35+(1.e-15)) - 0.035 / (cp35 ^ 3 + 1));    
    beta_35(i) = c1 * (c2 / lambda35(i) - c3 * cp35 - c4) * exp(-c5 / lambda35(i)) + c6 * lambda35(i);
end

%% Plot
plot(lambda,beta_01,lambda,beta_02,lambda,beta_03,lambda,beta_35,'LineWidth',1.5);
grid on;
grid minor;
title('Beta vs. Lambda');
%yline(1.755,'-.b','y = 1.755V','LineWidth',2);
legend('Cp=0.1','Cp=0.2','Cp=0.3','Cp=0.35','Location','northeast');
xlabel('Tip Speed Ratio');
ylabel('Pitch Angle Beta');
%ylim([-0.1 0.4]);
%xlim([0 3]);