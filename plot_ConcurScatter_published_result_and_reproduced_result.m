clc;
clear;
close all;
addpath(genpath(pwd));
rng(1993); % For repeatable results

original = [6.8e-4;8.2e-4;1.8e-3];
    
reproduction_fourTags = [0,0.00694444444444444,0,0.0138888888888889];
reproduction_threeTags = [0,0,0.00250836120401338];
reproduction_twoTags = [0,0.000892857142857143];

reproduction = [mean(reproduction_twoTags);mean(reproduction_threeTags);mean(reproduction_fourTags)];

%% plot
vals_BER = [original,reproduction];
vals_BER(vals_BER<1e-4) = 1e-4;

colors = {[69/255 123/255 157/255],[202/255 55/255 83/255],[128/255 128/255 128/255],[153 153 204]./255,[132/255 165/255 157/255],[229,152,155]/255,[247,237,226]/255,[246,189,96]/255};
lineStyles = {'-','--','-.',':'};
lineMarker = {'square','o','^','pentagram','diamond','*','h','o','+','x'};
markersize = 8;
linewidth = 1.5;

x =2:1:4;

%%%** plot BER **%%%
figure(1)
plot(x,vals_BER(:,1),'Marker',lineMarker{1},'MarkerSize',markersize,'LineWidth',linewidth,'color',colors{1},'MarkerFaceColor',colors{1});
grid on
set(gcf,'unit','centimeters','position',[3 5 10 6]);
ax = gca;
ax.FontSize = 12;
ax.FontName = 'Times New Roman';
ax.YLim = [1e-4 1e0];
ax.YScale = 'log';
ax.XTick = 1:4;
ax.XTickLabel = {'1','2','3','4'};
ylabel('BER','FontSize',14,'FontName','Times New Roman');
xlabel('Number of concurrent tags','FontSize',14,'FontName','Times New Roman');
hold on
plot(x,vals_BER(:,2),'Marker',lineMarker{2},'MarkerSize',markersize,'LineWidth',linewidth,'color',colors{2},'MarkerFaceColor',colors{2});
legend('Published result','Reproduced result','FontSize',10.5,'FontName','Times New Roman','Location','best','NumColumns',1,'Interpreter','latex');
