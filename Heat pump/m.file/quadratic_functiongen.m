T_evaporation_column50 = [-20	-16	-12	-8	-4	0	4	8	12	16	20 24];
COP_column50 = [3.393099424	3.64291794	3.926798755	4.250081937	4.625137979	5.060373378	5.574988762	6.195732437	6.945196273	7.866000124	9.056418283	10.58993107
];
T_evaporation50 = T_evaporation_column50.'; % column to row
COP50 = COP_column50.';
%sftool(T_evaporation,COP)
%cftool(T_evaporation50,COP50)



T_evaporation_column70 = [-20	-16	-12	-8	-4	0	4	8	12	16	20 24 28 32 36 40 44];
COP_column70 = [2.417389383	2.558560619	2.714989005	2.888740475	3.083673749	3.301278771	3.547635763	3.829891762	4.151348256	4.519518933	4.955983562	5.461793879	6.073643944	6.817751091	7.745397528	8.901360368	10.44456037

];
T_evaporation70 = T_evaporation_column70.'; % column to row
COP70 = COP_column70.';
%sftool(T_evaporation,COP)
%cftool(T_evaporation70,COP70)


T_evaporation_column40 = [-30	-25	-20	-15	-10	-5	0	5	10];
COP_column40 = [2.517389383	2.718560619	3.014989005	3.508740475	3.883673749	4.601278771	5.647635763	6.829891762	7.97482];
T_evaporation40 = T_evaporation_column40.'; % column to row
COP40 = COP_column40.';
%sftool(T_evaporation,COP)
%cftool(T_evaporation40,COP40)

x=fittedmodel40;
y=fittedmodel70;
z=fittedmodel50;

figure
plot(z,'b');
ylim([0 10])
xlim([-20 20])
grid('on')
xlabel('{T_{evaporation} °C}','FontSize',15)
ylabel('COP','FontSize',15)
legend('COP, {T_{condenser}= 50°C}','Location','southeast','FontSize',8)
set(gca,'FontSize',10)
set(gcf, 'PaperPosition', [0 0 14 6]); 
set(gcf, 'PaperSize', [14 6]); %Set the paper to have width 5 and height 5
saveas(gcf,'COPvsTeva50.pdf')
system('pdfcrop COPvsTeva50.pdf COPvsTeva50.pdf');

set(gca,'FontSize',7)
set(gcf, 'PaperPosition', [0 0 6 6]); 
set(gcf, 'PaperSize', [6 6]); %Set the paper to have width 5 and height 5
saveas(gcf,'COPvsTeva500.pdf')
system('pdfcrop COPvsTeva500.pdf COPvsTeva500.pdf');


figure
plot(y,'b');
ylim([0 10])
grid('on')
xlabel('{T_{evaporation} °C}','FontSize',15)
ylabel('COP','FontSize',15)
legend('COP, {T_{condenser}= 70°C}','Location','southeast','FontSize',8)
set(gca,'FontSize',10)
set(gcf, 'PaperPosition', [0 0 14 6]); 
set(gcf, 'PaperSize', [14 6]); %Set the paper to have width 5 and height 5
saveas(gcf,'COPvsTeva70.pdf')
system('pdfcrop COPvsTeva70.pdf COPvsTeva70.pdf');
set(gca,'FontSize',7)
set(gcf, 'PaperPosition', [0 0 6 6]); 
set(gcf, 'PaperSize', [6 6]); %Set the paper to have width 5 and height 5
saveas(gcf,'COPvsTeva700.pdf')
system('pdfcrop COPvsTeva700.pdf COPvsTeva700.pdf');

figure
plot(x,'b');
ylim([0 10])
xlim([-30 10])
grid('on')
xticks([-30 -20 -10 0 10])
yticks([0 2 4 6 8 10])
xlabel('{Evaporating temperature (°C)}','FontSize',15)
ylabel('COP','FontSize',15)
legend('R134a, {T_{condenser}= 40°C}','Location','southeast','FontSize',8)
set(gca,'FontSize',10)
set(gcf, 'PaperPosition', [0 0 14 6]); 
set(gcf, 'PaperSize', [14 6]); %Set the paper to have width 5 and height 5
saveas(gcf,'COPvsTeva40.pdf')
system('pdfcrop COPvsTeva40.pdf COPvsTeva40.pdf');
set(gca,'FontSize',10)
set(gcf, 'PaperPosition', [0 0 11 9]); 
set(gcf, 'PaperSize', [11 9]); %Set the paper to have width 5 and height 5
saveas(gcf,'COPvsTeva400.pdf')
system('pdfcrop COPvsTeva400.pdf COPvsTeva400.pdf');

