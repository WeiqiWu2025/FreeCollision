clc;
clear;
close all;
addpath(genpath(pwd));
rng(1993); % For repeatable results

original = [100;99.03;97.08;95.45];
reproduction_twoTags = [0.997000000000000,0.998500000000000];
reproduction_threeTags = [0.989000000000000,0.988000000000000,0.988500000000000];
reproduction_fourTags = [0.973000000000000,0.975000000000000,0.976000000000000,0.972500000000000];

reproduction = [1;mean(reproduction_twoTags);mean(reproduction_threeTags);mean(reproduction_fourTags)].*100;

%% plot
vals_BER = [original,reproduction];

colors = {[69/255 123/255 157/255],[202/255 55/255 83/255],[128/255 128/255 128/255],[153 153 204]./255,[132/255 165/255 157/255],[229,152,155]/255,[247,237,226]/255,[246,189,96]/255};
lineStyles = {'-','--','-.',':'};
lineMarker = {'square','o','^','pentagram','diamond','*','h','o','+','x'};
markersize = 8;
linewidth = 1.5;

x =1:1:4;

%%%** plot BER **%%%
figure(1)
plot(x,vals_BER(:,1),'Marker',lineMarker{1},'MarkerSize',markersize,'LineWidth',linewidth,'color',colors{1},'MarkerFaceColor',colors{1});
grid on
set(gcf,'unit','centimeters','position',[3 5 16 6]);
ax = gca;
ax.FontSize = 12;
ax.FontName = 'Times New Roman';
ax.XTick = 1:4;
ax.XTickLabel = {'1','2','3','4'};
ylabel('Successful decoding rate (%)','FontSize',12,'FontName','Times New Roman');
xlabel('Number of concurrent tags','FontSize',14,'FontName','Times New Roman');
hold on
plot(x,vals_BER(:,2),'Marker',lineMarker{2},'MarkerSize',markersize,'LineWidth',linewidth,'color',colors{2},'MarkerFaceColor',colors{2});
ax.YLim = [50 100];
legend('Published result','Reproduced result','FontSize',10.5,'FontName','Times New Roman','Location','best','NumColumns',1,'Interpreter','latex');