clc;
clear;
close all;
addpath(genpath(pwd));
rng(1993); % For repeatable results

original = [1e-4;5e-4;1.2e-3;2.2e-2];
reproduction_fourTags = [0.00257638888888889,0.00254861111111111,0.00193055555555556,0.00203472222222222];
reproduction_threeTags = [0.00142934782608696,0.00228804347826087,0.000880434782608696];
reproduction_twoTags = [0.000785714285714286,0.000468750000000000];
reproduction_oneTags = [0];

reproduction = [mean(reproduction_oneTags);mean(reproduction_twoTags);mean(reproduction_threeTags);mean(reproduction_fourTags)];

%% plot
vals_BER = [original,reproduction];
vals_BER(vals_BER<1e-4) = 1e-4;

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
ax.YScale = 'log';
ax.XTick = 1:4;
ax.XTickLabel = {'1','2','3','4'};
ylabel('BER','FontSize',14,'FontName','Times New Roman');
xlabel('Number of concurrent tags','FontSize',14,'FontName','Times New Roman');
hold on
plot(x,vals_BER(:,2),'Marker',lineMarker{2},'MarkerSize',markersize,'LineWidth',linewidth,'color',colors{2},'MarkerFaceColor',colors{2});
ax.YLim = [1e-4 1e0];
legend('Published result','Reproduced result','FontSize',10.5,'FontName','Times New Roman','Location','best','NumColumns',1,'Interpreter','latex');
