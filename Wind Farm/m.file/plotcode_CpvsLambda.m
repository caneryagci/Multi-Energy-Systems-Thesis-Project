c1= 0.5;
c2=116;
c3=0.4;
c4=5;
c5=21;
c6=0;
beta=1;
beta5=5;
beta10=10;
beta25=25;
n=80;
lambda = zeros(n,1);
lambda1 = zeros(n,1);
lambda5 = zeros(n,1);
lambda10 = zeros(n,1);
lambda25 = zeros(n,1);
cp = zeros(n,1);
cp5 = zeros(n,1);
cp10 = zeros(n,1);
cp25 = zeros(n,1);

for i= 1 :1: n
    lambda(i)=i/5;
    
    lambda1(i) = 1 / (1 / (lambda(i) + 0.08*beta+(1.e-15)) - 0.035 / (beta ^ 3 + 1));    
    cp(i) = c1 * (c2 / lambda1(i) - c3 * beta - c4) * exp(-c5 / lambda1(i)) + c6 * lambda1(i);
    
    lambda5(i) = 1 / (1 / (lambda(i) + 0.08*beta5+(1.e-15)) - 0.035 / (beta5 ^ 3 + 1));    
    cp5(i) = c1 * (c2 / lambda5(i) - c3 * beta5 - c4) * exp(-c5 / lambda5(i)) + c6 * lambda5(i);
    
    lambda10(i) = 1 / (1 / (lambda(i) + 0.08*beta10+(1.e-15)) - 0.035 / (beta10 ^ 3 + 1));    
    cp10(i) = c1 * (c2 / lambda10(i) - c3 * beta10 - c4) * exp(-c5 / lambda10(i)) + c6 * lambda10(i);
    
    lambda25(i) = 1 / (1 / (lambda(i) + 0.08*beta25+(1.e-15)) - 0.035 / (beta25 ^ 3 + 1));    
    cp25(i) = c1 * (c2 / lambda25(i) - c3 * beta25 - c4) * exp(-c5 / lambda25(i)) + c6 * lambda25(i);
end

%% Plot
plot(lambda,cp,lambda,cp5,lambda,cp10,lambda,cp25,'LineWidth',1.5);
grid on;
grid minor;
title('Cp vs. Lambda');
%yline(1.755,'-.b','y = 1.755V','LineWidth',2);
legend('Beta=1','Beta=5','Beta=10','Beta=25','Location','northeast');
xlabel('Tip Speed Ratio');
ylabel('Performance Coefficient Cp');
ylim([-0.1 0.4]);
%xlim([0 3]);